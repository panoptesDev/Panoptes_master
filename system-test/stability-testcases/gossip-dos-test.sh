#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"
PANOPTES_ROOT="$(cd ../..; pwd)"

logDir="$PWD"/logs
rm -rf "$logDir"
mkdir "$logDir"

panoptesInstallDataDir=$PWD/releases
panoptesInstallGlobalOpts=(
  --data-dir "$panoptesInstallDataDir"
  --config "$panoptesInstallDataDir"/config.yml
  --no-modify-path
)

# Install all the panoptes versions
bootstrapInstall() {
  declare v=$1
  if [[ ! -h $panoptesInstallDataDir/active_release ]]; then
    sh "$PANOPTES_ROOT"/install/panoptes-install-init.sh "$v" "${panoptesInstallGlobalOpts[@]}"
  fi
  export PATH="$panoptesInstallDataDir/active_release/bin/:$PATH"
}

bootstrapInstall "edge"
panoptes-install-init --version
panoptes-install-init edge
panoptes-gossip --version
panoptes-dos --version

killall panoptes-gossip || true
panoptes-gossip spy --gossip-port 8001 > "$logDir"/gossip.log 2>&1 &
panoptesGossipPid=$!
echo "panoptes-gossip pid: $panoptesGossipPid"
sleep 5
panoptes-dos --mode gossip --data-type random --data-size 1232 &
dosPid=$!
echo "panoptes-dos pid: $dosPid"

pass=true

SECONDS=
while ((SECONDS < 600)); do
  if ! kill -0 $panoptesGossipPid; then
    echo "panoptes-gossip is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  if ! kill -0 $dosPid; then
    echo "panoptes-dos is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  sleep 1
done

kill $panoptesGossipPid || true
kill $dosPid || true
wait || true

$pass && echo Pass

#!/usr/bin/env bash

set -x
! tmux list-sessions || tmux kill-session
declare sudo=
if sudo true; then
  sudo="sudo -n"
fi

echo "pwd: $(pwd)"
for pid in panoptes/*.pid; do
  pgid=$(ps opgid= "$(cat "$pid")" | tr -d '[:space:]')
  if [[ -n $pgid ]]; then
    $sudo kill -- -"$pgid"
  fi
done
if [[ -f panoptes/netem.cfg ]]; then
  panoptes/scripts/netem.sh delete < panoptes/netem.cfg
  rm -f panoptes/netem.cfg
fi
panoptes/scripts/net-shaper.sh cleanup
for pattern in validator.sh boostrap-leader.sh panoptes- remote- iftop validator client node; do
  echo "killing $pattern"
  pkill -f $pattern
done

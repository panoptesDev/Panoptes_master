#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")"

# shellcheck source=net/scripts/panoptes-user-authorized_keys.sh
source panoptes-user-authorized_keys.sh

# panoptes-user-authorized_keys.sh defines the public keys for users that should
# automatically be granted access to ALL datacenter nodes.
for i in "${!PANOPTES_USERS[@]}"; do
  echo "environment=\"PANOPTES_USER=${PANOPTES_USERS[i]}\" ${PANOPTES_PUBKEYS[i]}"
done


#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

[[ -d /home/panoptes/.ssh ]] || exit 1

if [[ ${#PANOPTES_PUBKEYS[@]} -eq 0 ]]; then
  echo "Warning: source panoptes-user-authorized_keys.sh first"
fi

# panoptes-user-authorized_keys.sh defines the public keys for users that should
# automatically be granted access to ALL testnets
for key in "${PANOPTES_PUBKEYS[@]}"; do
  echo "$key" >> /panoptes-scratch/authorized_keys
done

sudo -u panoptes bash -c "
  cat /panoptes-scratch/authorized_keys >> /home/panoptes/.ssh/authorized_keys
"

#!/usr/bin/env bash
set -o errexit; set -o nounset; set -o pipefail

systemctl stop salt-minion
systemctl disable salt-minion

rm -vf /srv/salt
rm -vf /srv/pillar
rm -vf /srv/salt/files

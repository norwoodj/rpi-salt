#!/usr/bin/env bash
set -o errexit; set -o nounset; set -o pipefail

BOOTSTRAP_SCRIPT_URL="https://github.com/saltstack/salt-bootstrap/releases/latest/download/bootstrap-salt.sh"

# Install the salt-minion binary if it doesn't already exist
if ! hash salt-minion; then
	apt update
	apt install patchelf
	curl -L "${BOOTSTRAP_SCRIPT_URL}" | sh
fi

# In masterless mode we don't need the salt-minion service running
if ! systemctl is-enabled salt-minion; then
	systemctl disable salt-minion
fi

# Setup the salt-minion to run masterless
sed -i 's|#file_client: remote|file_client: local|g' /etc/salt/minion

# Setup the salt-minion to run remote git states
if ! grep gitfs_remotes /etc/salt/minion > /dev/null; then
	salt-pip install pygit2
	cat >> /etc/salt/minion <<EOF

fileserver_backend:
  - git
  - roots
gitfs_remotes:
  - https://github.com/saltstack-formulas/users-formula.git
EOF
fi

# Symlink the state tree into place
ln -svf $(pwd)/salt /srv/salt
ln -svf $(pwd)/pillar /srv/pillar

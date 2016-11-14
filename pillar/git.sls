{% from 'templates/authorized-keys.jinja' import authorized_keys_by_user %}

git:
  version: '2.10.2'

users:
  git:
    shell: '/usr/bin/git-shell'
    ssh_auth_sources: {{ authorized_keys_by_user['git'] }}

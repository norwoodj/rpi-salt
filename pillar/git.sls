{% from 'templates/authorized-keys.jinja' import authorized_keys_by_user %}

users:
  git:
    ssh_auth_sources: {{ authorized_keys_by_user['git'] }}

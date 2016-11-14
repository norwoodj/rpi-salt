{% from 'templates/git-authorized-keys.jinja' import keys %}

users:
  git:
    ssh_auth_sources: {{ keys }}

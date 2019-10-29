git:
  version: '2.10.2'

users:
  git:
    groups:
      - ssh
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: '/usr/bin/git-shell'
    ssh_auth_sources:
      - "salt://files/ssh_keys/veintitres.id_ecdsa.pub"

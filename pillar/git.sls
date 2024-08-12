git:
  version: '2.10.2'

users:
  git:
    groups:
      - ssh
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: '/usr/bin/git-shell'
    ssh_auth_sources:
      - salt://files/ssh_keys/cf.id_ed25519.pub
      - salt://files/ssh_keys/veintitres.id_ed25519.pub
      - salt://files/ssh_keys/veintitres-mac.id_ed25519.pub

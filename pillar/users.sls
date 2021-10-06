users:
  veintitres:
    groups:
      - docker
      - ssh
    password: "*" # http://arlimus.github.io/articles/usepam/
    shell: /usr/bin/zsh
    ssh_auth_sources:
      - salt://files/ssh_keys/veintitres.id_ecdsa.pub
      - salt://files/ssh_keys/veintitres-cf.id_ecdsa.pub
    sudouser: True
    sudo_rules:
      - "ALL=(root) NOPASSWD:ALL"

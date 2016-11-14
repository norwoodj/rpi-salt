users:
  veintitres:
    groups:
      - docker
    ssh_auth_sources:
      - salt://files/ssh_keys/veintitres.id_rsa.pub
    sudouser: True
    sudo_rules:
      - ALL=(root) NOPASSWD:ALL

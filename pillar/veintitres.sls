# Only create the main user on raspberry pis. My personal machines will already
# have this user
users:
  veintitres:
    groups:
      - ssh
      - systemd-journal
    password: "*" # http://arlimus.github.io/articles/usepam/
    shell: /usr/bin/zsh
    ssh_auth_sources:
      - salt://files/ssh_keys/veintitres-mac.id_ed25519.pub
      - salt://files/ssh_keys/veintitres-iphone.id_ed25519.pub
    sudouser: True
    sudo_rules:
      - "ALL=(root) NOPASSWD:ALL"

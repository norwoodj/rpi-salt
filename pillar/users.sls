{% from "templates/authorized-keys.jinja" import authorized_keys_by_user %}

users:
  veintitres:
    groups:
      - docker
      - ssh
    password: "*" # http://arlimus.github.io/articles/usepam/
    ssh_auth_sources: {{ authorized_keys_by_user["veintitres"] }}
    shell: "/usr/bin/zsh"
    sudouser: True
    sudo_rules:
      - "ALL=(root) NOPASSWD:ALL"

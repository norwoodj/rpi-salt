base:
  '*':
    - users.sudo
    - users
    - openssh
    - openssh.config
    - remove-pirate
    - motd
    - kubernetes

  '*git*':
    - git

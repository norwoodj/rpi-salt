base:
  '*':
    - users.sudo
    - users
    - openssh
    - openssh.config
    - remove-pirate
    - motd

  '*git*':
    - git

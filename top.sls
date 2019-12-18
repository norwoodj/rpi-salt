base:
  '*':
    - packages
    - users
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pi
    - motd
    - stupidchess

  '*elb*':
    - rpi-loadbalancer

  '*git*':
    - build-tools
    - git-access

  '*mdb*':
    - mongo

  '*mon*':
    - monitoring

  '*sql*':
    - mariadb

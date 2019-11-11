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
    - nginx-load-balancer

  '*git*':
    - build-tools
    - git-access

  '*mdb*':
    - mongo

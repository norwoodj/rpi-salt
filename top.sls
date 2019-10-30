base:
  '*':
    - packages
    - users
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pi
    - motd
    - stupidchess-nginx

  '*elb*':
    - nginx-load-balancer

  '*git*':
    - git-access

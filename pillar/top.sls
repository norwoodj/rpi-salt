base:
  '*':
    - users
    - sshd
    - oh-my-zsh
    - stupidchess
    - hashbash

  '*elb*':
    - rpi-loadbalancer

  '*git*':
    - git

  '*mdb*':
    - mongo

  '*mon*':
    - grafana

  '*sql*':
    - postgres

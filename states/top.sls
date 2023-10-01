base:
  "*":
    - packages
    - users
    - network
    - prometheus
    - grafana
    - mongo
    - postgres
    - rabbitmq
    - nginx
    - tunnels
    - bolas
    - hashbash
    - stupidchess
    - rpi-loadbalancer
    - logrotate

  "0p0":
    - remove-pi
    - git-access
    - oh-my-zsh
    - openssh
    - openssh.config
    - build-tools
    - go
    - node
    - rust

base:
  "*":
    - packages
    - dns
    - node-exporter
    - nginx-log-exporter
    - process-exporter
    - users
    - network
    - prometheus
    - grafana
    - mongo
    - postgres
    - rabbitmq
    - nginx
    - bolas
    - hashbash
    - stupidchess
    - rpi-loadbalancer

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
    - tunnels

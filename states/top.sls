base:
  "*":
    - users
    - git-access
    - network
    - grafana
    - prometheus
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
    - oh-my-zsh
    - openssh
    - openssh.config
    - packages
    - build-tools

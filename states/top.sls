base:
  "0p0":
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pi
    - git-access
    - network
    - grafana
    - prometheus
    - mongo
    - postgres
    - rabbitmq
    - nginx
    - hashbash
    - stupidchess
    - rpi-loadbalancer
    - nginx-log-exporters

  "*":
    - packages
    - users
    - build-tools

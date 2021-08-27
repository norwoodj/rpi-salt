base:
  "*":
    - packages
    - users
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pi
    - motd
    - build-tools
    - git-access

  "*p*":
    - grafana
    - mongo
    - postgres
    - prometheus
    - rabbitmq
    - rpi-loadbalancer

  "*s*":
    - hashbash
    - nginx-log-exporters
    - stupidchess

base:
  "*":
    - packages
    - users
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pi
    - motd
    - stupidchess
    - hashbash
    - nginx-log-exporters

  "*elb*":
    - rpi-loadbalancer

  "*git*":
    - build-tools
    - git-access

  "*mdb*":
    - mongo

  "*mon*":
    - grafana
    - prometheus

  "*rmq*":
    - rabbitmq

  "*sql*":
    - postgres

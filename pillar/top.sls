base:
  "*":
    - users
    - sshd
    - oh-my-zsh
    - stupidchess
    - hashbash
    - nginx-log-exporters

  "*elb*":
    - rpi-loadbalancer

  "*git*":
    - git

  "*mdb*":
    - mongo

  "*mon*":
    - grafana

  "*rmq*":
    - rabbitmq

  "*sql*":
    - postgres

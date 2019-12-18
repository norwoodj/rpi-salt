rabbitmq:
  pkg.installed:
    - pkgs:
        - rabbitmq-server

  cmd.run:
    - name: rabbitmq-plugins enable rabbitmq_management

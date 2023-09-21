rabbitmq-setup:
  pkg.installed:
    - pkgs:
        - rabbitmq-server

  cmd.run:
    - name: rabbitmq-plugins enable rabbitmq_management

rabbitmq-users:
  file.managed:
    - name: /tmp/rabbitmq-users.sh
    - source: salt://files/script/rabbitmq-users.sh
    - template: jinja
    - context:
        admin_password: {{ pillar["rabbitmq"]["admin_password"] }}
        vhosts: {{ pillar["rabbitmq"]["vhosts"] }}

  cmd.run:
    - name: |
        chmod +x /tmp/rabbitmq-users.sh
        /tmp/rabbitmq-users.sh

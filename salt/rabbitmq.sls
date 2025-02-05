rabbitmq-server:
  pkg.installed: []
  service.running:
    - watch:
        - file: /etc/rabbitmq/rabbitmq.conf
        - pkg: rabbitmq-server

enable-management:
  cmd.run:
    - name: rabbitmq-plugins enable rabbitmq_management

/etc/rabbitmq/rabbitmq.conf:
  file.managed:
    - source: salt://files/etc/rabbitmq/rabbitmq.conf
    - user: rabbitmq
    - group: rabbitmq
    - mode: 644
    - template: jinja
    - context:
        rabbitmq_aqmp_port: {{ pillar.port_by_service.tcp.rabbitmq_aqmp }}
        rabbitmq_management_port: {{ pillar.port_by_service.tcp.rabbitmq_management }}
        rabbitmq_metrics_host: {{ pillar.network.instance_ip }}
        rabbitmq_metrics_port: {{ pillar.port_by_service.tcp.rabbitmq_metrics }}

rabbitmq-users:
  file.managed:
    - name: /tmp/rabbitmq-users.sh
    - source: salt://files/script/rabbitmq-users.sh
    - mode: 744
    - template: jinja
    - context:
        admin_password: {{ pillar.rabbitmq.admin_password }}
        vhosts: {{ pillar.rabbitmq.vhosts }}

  cmd.run:
    - name: |
        chmod +x /tmp/rabbitmq-users.sh
        /tmp/rabbitmq-users.sh

enable-prometheus:
  cmd.run:
    - name: rabbitmq-plugins enable rabbitmq_prometheus

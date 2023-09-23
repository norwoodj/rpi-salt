rabbitmq-server:
  pkg.installed: []
  service.running:
    - watch:
        - file: /etc/rabbitmq/rabbitmq.conf
        - pkg: rabbitmq-server

enable-management:
  cmd.run:
    - name: rabbitmq-plugins enable rabbitmq_management

# This is to allow the management server to bind to port 80
allow-priveleged-ports:
  cmd.run:
    - name: setcap 'cap_net_bind_service=+ep' /usr/lib/erlang/erts-12.2.1/bin/beam.smp

/etc/rabbitmq/rabbitmq.conf:
  file.managed:
    - source: salt://files/etc/rabbitmq/rabbitmq.conf
    - user: rabbitmq
    - group: rabbitmq
    - mode: 644
    - template: jinja
    - context:
        bind_ip: {{ pillar.ips_by_service.rabbitmq }}

rabbitmq-users:
  file.managed:
    - name: /tmp/rabbitmq-users.sh
    - source: salt://files/script/rabbitmq-users.sh
    - template: jinja
    - context:
        admin_password: {{ pillar.rabbitmq.admin_password }}
        vhosts: {{ pillar.rabbitmq.vhosts }}

  cmd.run:
    - name: |
        chmod +x /tmp/rabbitmq-users.sh
        /tmp/rabbitmq-users.sh

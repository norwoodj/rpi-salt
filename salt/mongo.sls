mongodb-org-repo-key:
  cmd.run:
    - name: |
        curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc |
        sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
    - creates: /usr/share/keyrings/mongodb-server-8.0.gpg

mongodb-org-repo:
  pkgrepo.managed:
    - name: deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse
    - file: /etc/apt/sources.list.d/mongodb-org.list
    - require_in:
      - pkg: mongodb-org-server
      - pkg: mongocli

mongodb-org-server:
  pkg.installed:
    - version: {{ pillar.mongo.version }}

mongocli:
  pkg.installed: []

/data/mongodb:
  file.directory:
    - user: mongodb
    - group: mongodb
    - mode: 770
    - makedirs: true

/etc/mongod.conf:
  file.managed:
    - source: salt://files/etc/mongod.conf
    - user: mongodb
    - group: mongodb
    - mode: 644
    - template: jinja
    - context:
        bind_host: 0.0.0.0
        bind_port: {{ pillar.port_by_service.tcp.mongodb }}
        unix_socket_directory: {{ pillar.mongo.unix_socket_directory }}

prometheus-mongodb-exporter:
  pkg.installed: []

  service.running:
    - enable: true
    - watch:
        - pkg: prometheus-mongodb-exporter
        - file: /etc/default/prometheus-mongodb-exporter

/etc/default/prometheus-mongodb-exporter:
  file.managed:
    - source: salt://files/etc/default/prometheus-mongodb-exporter
    - user: prometheus
    - group: prometheus
    - mode: 644
    - template: jinja
    - context:
        ca_username: {{ pillar.mongo.ca_username }}
        ca_password: {{ pillar.mongo.ca_password }}
        mongodb_address: mongodb:{{ pillar.port_by_service.tcp.mongodb }}
        listen_address: metrics:{{ pillar.port_by_service.tcp.mongodb_exporter }}

/lib/systemd/system/mongod.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: MongoDB Database Server
        Documentation: https://docs.mongodb.org/manual
        After:
          - network-online.target
        Wants: network-online.target
        User: mongodb
        Group: mongodb
        EnvironmentFile: -/etc/default/mongod
        Environment:
          - MONGODB_CONFIG_OVERRIDE_NOFORK=1
          - GLIBC_TUNABLES=glibc.pthread.rseq=0
        ExecStart: /usr/bin/mongod --config /etc/mongod.conf
        RuntimeDirectory: mongodb

        # Recommended limits for mongod as specified in
        # https://docs.mongodb.com/manual/reference/ulimit/#recommended-ulimit-settings
        LimitFSIZE: infinity
        LimitCPU: infinity
        LimitAS: infinity
        LimitNOFILE: 64000
        LimitNPROC: 64000
        LimitMEMLOCK: infinity
        TasksMax: infinity
        TasksAccounting: false

mongod:
  service.running:
    - enable: true
    - watch:
        - pkg: mongodb-org-server
        - file: /etc/mongod.conf
        - file: /lib/systemd/system/mongod.service

/tmp/mongo-create-ca.js:
  file.managed:
    - source: salt://files/script/mongo-create-ca.js
    - template: jinja
    - context:
        ca_username: {{ pillar.mongo.ca_username }}
        ca_password: {{ pillar.mongo.ca_password }}

create-ca:
  cmd.run:
    # Must be run against localhost to utilize the localhost exception
    # https://www.mongodb.com/docs/manual/core/localhost-exception
    - name: mongo --host localhost admin /tmp/mongo-create-ca.js || true

/tmp/mongo-create-users.js:
  file.managed:
    - source: salt://files/script/mongo-create-users.js
    - template: jinja
    - context:
        users: {{ pillar.mongo.users }}

create-users:
  cmd.run:
    - name: mongo -u admin -p '{{ pillar.mongo.ca_password }}' --host mongodb admin /tmp/mongo-create-users.js

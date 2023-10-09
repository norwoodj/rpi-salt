focal-security-repo:
  pkgrepo.managed:
    - name: deb http://ports.ubuntu.com focal-security main
    - humanname: focal-security
    - file: /etc/apt/sources.list.d/focal-security.list
    - require_in:
      - pkg: libssl1.1

mongodb-org-repo:
  pkgrepo.managed:
    - name: deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse
    - humanname: mongodb-org
    - file: /etc/apt/sources.list.d/mongodb-org-4.4.list
    - require_in:
      - pkg: mongodb-org-server
      - pkg: mongodb-org-shell
    - gpgcheck: 1
    - key_url: https://www.mongodb.org/static/pgp/server-4.4.asc

"libssl1.1":
  pkg.installed: []

mongodb-org-server:
  pkg.installed:
    - version: {{ pillar.mongo.version }}

mongodb-org-shell:
  pkg.installed:
    - version: {{ pillar.mongo.version }}

/data/mongodb:
  file.directory:
    - user: mongodb
    - group: mongodb
    - mode: 640
    - makedirs: true

/etc/mongod.conf:
  file.managed:
    - source: salt://files/etc/mongod.conf
    - user: mongodb
    - group: mongodb
    - mode: 644
    - template: jinja
    - context:
        bind_host: mongodb
        unix_socket_directory: {{ pillar.mongo.unix_socket_directory }}

prometheus-mongodb-exporter:
  pkg.installed: []

  service.running:
    - enable: true
    - watch:
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
    - name: mongo --host mongodb admin /tmp/mongo-create-ca.js || true

/tmp/mongo-create-users.js:
  file.managed:
    - source: salt://files/script/mongo-create-users.js
    - template: jinja
    - context:
        users: {{ pillar.mongo.users }}

create-users:
  cmd.run:
    - name: mongo -u admin -p '{{ pillar.mongo.ca_password }}' --host mongodb admin /tmp/mongo-create-users.js

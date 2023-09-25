"libssl1.1":
  pkgrepo.managed:
    - name: deb http://security.ubuntu.com/ubuntu focal-security main
    - humanname: focal-security
    - file: /etc/apt/sources.list.d/focal-security.list
    - require_in:
      - pkg: libssl1.1
    - gpgcheck: 1
    - gpg: http://security.ubuntu.com/ubuntu/dists/focal-security/Release.gpg

  pkg.installed: []

mongodb-org:
  pkgrepo.managed:
    - name: deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse
    - humanname: mongodb-org
    - file: /etc/apt/sources.list.d/mongodb-org-4.4.list
    - require_in:
      - pkg: mongodb-org
    - gpgcheck: 1
    - key_url: https://www.mongodb.org/static/pgp/server-4.4.asc

  pkg.installed:
    - version: {{ pillar.mongo.version }}

/data/mongodb:
  file.directory:
    - user: mongodb
    - group: mongodb
    - mode: 744
    - makedirs: True

/etc/mongod.conf:
  file.managed:
    - source: salt://files/etc/mongod.conf
    - template: jinja
    - context:
        bind_host: mongodb
        unix_socket_directory: {{ pillar.mongo.unix_socket_directory }}

prometheus-mongodb-exporter:
  pkg.installed: []

/etc/default/prometheus-mongodb-exporter:
  file.managed:
    - source: salt://files/etc/default/prometheus-mongodb-exporter
    - template: jinja
    - context:
        ca_password: {{ pillar.mongo.ca_password }}

mongod:
  service.running:
    - enable: True
    - watch:
        - file: /etc/mongod.conf

/tmp/mongo-create-ca.js:
  file.managed:
    - source: salt://files/script/mongo-create-ca.js
    - template: jinja
    - context:
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
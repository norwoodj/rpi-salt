mongo:
  pkg.installed:
    - pkgs:
        - curl
        - mongodb
        - prometheus-mongodb-exporter
        - p7zip-full

  file.managed:
    - name: /etc/mongodb.conf
    - source: salt://files/etc/mongodb.conf

  cmd.run:
    - name: |
        rm -rvf mongodb-2.6.4-arm.7z mongodb
        curl -O http://facat.github.io/mongodb-2.6.4-arm.7z
        7z x mongodb-2.6.4-arm.7z
        cp -v mongodb/bin/mongod /usr/bin/mongod

mongo-exporter-config:
  file.managed:
    - name: /etc/default/prometheus-mongodb-exporter
    - source: salt://files/etc/default/prometheus-mongodb-exporter
    - template: jinja
    - context:
        ca_password: {{ pillar["mongo"]["ca-password"] }}


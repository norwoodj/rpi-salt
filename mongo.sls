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

mongo-exporter-config:
  file.managed:
    - name: /etc/default/prometheus-mongodb-exporter
    - source: salt://files/etc/default/prometheus-mongodb-exporter
    - template: jinja
    - context:
        ca_password: {{ pillar["mongo"]["ca-password"] }}


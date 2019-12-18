mongo:
  pkg.installed:
    - pkgs:
        - mongodb
        - prometheus-mongodb-exporter

  file.managed:
    - name: /etc/mongodb.conf
    - source: salt://files/etc/mongodb.conf

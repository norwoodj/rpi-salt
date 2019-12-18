mariadb:
  pkg.installed:
    - pkgs:
        - mariadb-server
        - prometheus-mysqld-exporter

  file.managed:
    - name: /etc/default/prometheus-mysqld-exporter
    - source: salt://files/etc/default/prometheus-mysqld-exporter

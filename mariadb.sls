mariadb:
  pkg.installed:
    - pkgs:
        - mariadb-server
        - prometheus-mysqld-exporter

  file.managed:
    - name: /etc/default/prometheus-mysqld-exporter
    - source: salt://files/etc/default/prometheus-mysqld-exporter

mariadb.config:
  file.managed:
    - name: /etc/mysql/mariadb.conf.d/50-server.cnf
    - source: salt://files/etc/mysql/mariadb.conf.d/50-server.cnf

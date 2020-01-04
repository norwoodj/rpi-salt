postgres:
  pkg.installed:
    - pkgs:
        - postgresql
        - prometheus-postgres-exporter

postgres-config:
  file.managed:
    - name: /etc/postgresql/11/main/postgresql.conf
    - source: salt://files/etc/postgresql/11/main/postgresql.conf

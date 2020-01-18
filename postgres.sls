postgres:
  pkg.installed:
    - pkgs:
        - postgresql
        - prometheus-postgres-exporter

postgres-config:
  file.managed:
    - name: /etc/postgresql/11/main/postgresql.conf
    - source: salt://files/etc/postgresql/11/main/postgresql.conf

postgres-exporter-config:
  file.managed:
    - name: /etc/default/prometheus-postgres-exporter
    - source: salt://files/etc/default/prometheus-postgres-exporter

postgres-exporter-user:
  file.managed:
    - name: /tmp/postgres-exporter.sql
    - source: salt://files/sql/postgres-exporter.sql
    - template: jinja
    - context:
        db_password: {{ pillar["postgres"]["exporter"]["password"] }}

  cmd.run:
    - name: psql --file=/tmp/postgres-exporter.sql
    - runas: postgres

postgres-app-users:
  file.managed:
    - name: /tmp/app-users.sql
    - source: salt://files/sql/app-users.sql
    - template: jinja
    - context:
        app_users: {{ pillar["postgres"]["app-users"] }}

  cmd.run:
    - name: psql --file=/tmp/app-users.sql
    - runas: postgres

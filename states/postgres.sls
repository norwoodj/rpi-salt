postgresql:
  pkg.installed:
    - version: {{ pillar.postgres.version }}

  service.running:
    - watch:
      - file: /etc/postgresql/14/main/postgresql.conf
      - file: /etc/postgresql/14/main/pg_hba.conf

postgresql-conf:
  file.managed:
    - name: /etc/postgresql/14/main/postgresql.conf
    - source: salt://files/etc/postgresql/14/main/postgresql.conf

postgresql-net-conf:
  file.managed:
    - name: /etc/postgresql/14/main/pg_hba.conf
    - source: salt://files/etc/postgresql/14/main/pg_hba.conf

prometheus-postgres-exporter:
  pkg.installed: []

  file.managed:
    - name: /etc/default/prometheus-postgres-exporter
    - source: salt://files/etc/default/prometheus-postgres-exporter
    - template: jinja
    - context:
        db_password: {{ pillar.postgres.exporter.password }}

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
        app_users: {{ pillar.postgres.app_users }}

  cmd.run:
    - name: psql --file=/tmp/app-users.sql
    - runas: postgres

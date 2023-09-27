postgresql:
  pkg.installed:
    - version: {{ pillar.postgres.version }}

  service.running:
    - enable: true
    - watch:
      - pkg: postgresql
      - file: /etc/postgresql/14/main/postgresql.conf
      - file: /etc/postgresql/14/main/pg_hba.conf

/etc/postgresql/14/main/postgresql.conf:
  file.managed:
    - source: salt://files/etc/postgresql/14/main/postgresql.conf
    - template: jinja
    - context:
        bind_host: {{ pillar.postgres.bind_host }}
        unix_socket_directory: {{ pillar.postgres.unix_socket_directory }}

/etc/postgresql/14/main/pg_hba.conf:
  file.managed:
    - source: salt://files/etc/postgresql/14/main/pg_hba.conf
    - template: jinja
    - context:
        instance_ip: {{ pillar.network.instance_ip }}

prometheus-postgres-exporter:
  pkg.installed: []

  service.running:
    - enable: true
    - watch:
      - pkg: prometheus-postgres-exporter
      - file: /etc/default/prometheus-postgres-exporter

/etc/default/prometheus-postgres-exporter:
  file.managed:
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
        db_password: {{ pillar.postgres.exporter.password }}

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

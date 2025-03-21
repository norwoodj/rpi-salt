postgresql:
  pkg.installed:
    - version: {{ pillar.postgres.apt_version }}

  service.running:
    - enable: true
    - watch:
      - pkg: postgresql
      - file: /etc/postgresql/{{ pillar.postgres.major_version }}/main/postgresql.conf
      - file: /etc/postgresql/{{ pillar.postgres.major_version }}/main/pg_hba.conf

/etc/postgresql/{{ pillar.postgres.major_version }}/main/postgresql.conf:
  file.managed:
    - source: salt://files/etc/postgresql/main/postgresql.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - template: jinja
    - context:
        bind_port: {{ pillar.port_by_service.tcp.postgres }}
        unix_socket_directory: {{ pillar.postgres.unix_socket_directory }}

/etc/postgresql/{{ pillar.postgres.major_version }}/main/pg_hba.conf:
  file.managed:
    - source: salt://files/etc/postgresql/main/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - template: jinja
    - context:
        instance_ip: {{ pillar.network.instance_ip }}
        tailscale_cidr: {{ pillar.network.tailscale_cidr }}

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
    - user: prometheus
    - group: prometheus
    - mode: 644
    - template: jinja
    - context:
        db_password: {{ pillar.postgres.exporter.password }}
        listen_address: metrics:{{ pillar.port_by_service.tcp.postgres_exporter }}
        postgres_port: {{ pillar.port_by_service.tcp.postgres }}

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
        databases: {{ pillar.postgres.databases }}

  cmd.run:
    - name: psql --file=/tmp/app-users.sql
    - runas: postgres

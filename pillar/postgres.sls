postgres:
  major_version: 16
  apt_version: 16+257build1.1

  app_users:
    hashbash-rw:
      database: hashbash
    grafana-rw:
      database: grafana

  bind_host: 0.0.0.0
  unix_socket_directory: /run/postgresql

postgres:
  major_version: 16
  apt_version: 16+257build1.1

  databases:
    grafana:
      rw_users: {}

    hashbash:
      rw_users: {}

  bind_host: 0.0.0.0
  unix_socket_directory: /run/postgresql

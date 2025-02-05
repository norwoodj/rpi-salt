postgres:
  major_version: 16
  apt_version: 16+257build1.1

  databases:
    grafana:
      rw_users: {}

    hashbash:
      rw_users: {}

  unix_socket_directory: /run/postgresql

postgres:
  version: 14+238

  app_users:
    hashbash-rw:
      database: hashbash

  bind_host: postgres
  unix_socket_directory: /run/postgresql

mongo:
  # Any higher than this introduces a new machine instruction to the various
  # mongo binaries that is not implemented on raspberry pi, causing them to
  # crash
  version: 4.4.18

  unix_socket_directory: /run/mongodb

  ca_username: admin
  users:
    stupidchess-rw:
      database: stupidchess

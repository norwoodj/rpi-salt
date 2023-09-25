grafana:
  admin_password: password
  secret_key: please-change-me

mongo:
  ca_password: password
  users:
    stupidchess-rw:
      password: best-game-ever
 
stupidchess:
  flask_app_secret_key: obviously-replace-this

rabbitmq:
  admin_password: password
  vhosts:
    hashbash:
      hashbash-rw: best-day-ever

postgres:
  app_users:
    hashbash-rw:
      password: best-day-ever

  exporter:
    password: postgres-exporter-password

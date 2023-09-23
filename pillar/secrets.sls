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
      - username: hashbash-rw
        password: best-day-ever

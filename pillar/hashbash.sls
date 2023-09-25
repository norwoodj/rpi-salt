#!yaml|gpg

hashbash:
  backend_version: 21.1027.0
  nginx_version: 2023.9.0


users:
  hashbash:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

hashbash:
  backend_version: 2023.10.1
  nginx_version: 2024.6.0

users:
  hashbash:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

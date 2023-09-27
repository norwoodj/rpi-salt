hashbash:
  backend_version: 2023.9.2
  nginx_version: 2023.9.2

users:
  hashbash:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin

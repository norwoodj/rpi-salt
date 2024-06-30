stupidchess:
  nginx_version: 2024.6.0
  uwsgi_version: 2023.10.1

users:
  stupidchess:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

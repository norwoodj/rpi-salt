stupidchess:
  nginx_version: 2024.8.0
  uwsgi_version: 2025.2.1

users:
  stupidchess:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

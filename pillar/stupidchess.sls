stupidchess:
  nginx_version: 2024.7.1
  uwsgi_version: 2024.7.0

users:
  stupidchess:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

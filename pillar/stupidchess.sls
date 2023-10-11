stupidchess:
  nginx_version: 2023.10.0
  uwsgi_version: 2023.10.0

users:
  stupidchess:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

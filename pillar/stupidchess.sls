stupidchess:
  nginx-version: 2023.9.0
  uwsgi-version: 2023.9.0

users:
  stupidchess:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - nginx

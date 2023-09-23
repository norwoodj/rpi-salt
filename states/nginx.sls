nginx:
  group.present: []
  pkg.installed: []

/var/log/nginx:
  file.directory:
    - user: root
    - group: nginx
    - mode: 775
    - makedirs: True

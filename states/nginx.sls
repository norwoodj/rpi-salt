nginx:
  group.present: []
  pkg.installed: []

# This is to allow nginx applications, run by non-root users,
# to bind to port 80
allow-priveleged-ports:
  cmd.run:
  - name: setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx

/var/log/nginx:
  file.directory:
    - user: root
    - group: nginx
    - mode: 775
    - makedirs: True

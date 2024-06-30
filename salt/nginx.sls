nginx:
  pkg.installed: []
  service.disabled: []

# This is to allow nginx applications, run by non-root users,
# to bind to port 80
allow-priveleged-ports:
  cmd.run:
    - name: setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx

# And this is because my applications randomly seem to fail
# unless I get the log permissions just so, because nginx
# apparently inherently tries to open certain files on startup
# or config test, I don't know
/var/log/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 774
    - recurse:
        - user
        - group
        - mode

/var/lib/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 774
    - recurse:
        - user
        - group
        - mode

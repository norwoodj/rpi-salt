rpi-loadbalancer:
  version: 21.1007.0

users:
  loadbalancer:
    password: '*' # http://arlimus.github.io/articles/usepam/
    home: /opt/rpi-loadbalancer
    homedir_owner: loadbalancer
    shell: /sbin/nologin

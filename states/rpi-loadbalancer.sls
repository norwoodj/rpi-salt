/etc/rpi-loadbalancer/nginx.conf:
  file.managed:
    - source: salt://files/etc/rpi-loadbalancer/nginx.conf
    - makedirs: true
    - template: jinja
    - context:
        internal_base_domain: {{ pillar.network.internal_base_domain }}

/lib/systemd/system/rpi-loadbalancer.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: Raspberry Pi frontline nginx instance code
        Type: forking
        PIDFile: /run/rpi-loadbalancer/nginx.pid
        ExecStartPre: /usr/sbin/nginx -t -c /etc/rpi-loadbalancer/nginx.conf
        ExecStart: /usr/sbin/nginx -c /etc/rpi-loadbalancer/nginx.conf
        ExecReload: /usr/sbin/nginx -c /etc/rpi-loadbalancer/nginx.conf -s reload
        ExecStop: /bin/kill -s QUIT $MAINPID
        User: rpi-loadbalancer
        Group: rpi-loadbalancer
        LogsDirectory: rpi-loadbalancer
        RuntimeDirectory: rpi-loadbalancer
        PrivateTmp: true

rpi-loadbalancer:
  service.running:
    - enable: true
    - reload: true
    - watch:
        - file: /etc/rpi-loadbalancer/nginx.conf
        - file: /lib/systemd/system/rpi-loadbalancer.service

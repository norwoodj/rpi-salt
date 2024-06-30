stupidchess-uwsgi:
  pkg.installed:
    - sources:
        - stupidchess-uwsgi: https://github.com/norwoodj/stupidchess-backend/releases/download/{{ pillar.stupidchess.uwsgi_version }}/stupidchess-uwsgi_{{ pillar.stupidchess.uwsgi_version }}_{{ grains.osarch }}.deb

  service.running:
    - enable: true
    - watch:
        - file: /etc/stupidchess/config/flask-app-secret-key
        - file: /etc/stupidchess/config/mongo-password
        - file: /etc/stupidchess/config/RPI.yaml
        - file: /lib/systemd/system/stupidchess-uwsgi.service
        - file: /lib/systemd/system/stupidchess-uwsgi.socket
        - pkg: stupidchess-uwsgi

stupidchess-nginx:
  pkg.installed:
    - sources:
        - stupidchess-nginx: https://github.com/norwoodj/stupidchess-frontend/releases/download/{{ pillar.stupidchess.nginx_version }}/stupidchess-nginx_{{ pillar.stupidchess.nginx_version }}_{{ grains.osarch }}.deb

  service.running:
    - enable: true
    - reload: true
    - watch:
        - file: /lib/systemd/system/stupidchess-nginx.service
        - pkg: stupidchess-nginx

/etc/stupidchess/config/RPI.yaml:
  file.managed:
    - source: salt://files/etc/stupidchess/config/RPI.yaml
    - user: stupidchess
    - group: stupidchess
    - mode: 644
    - template: jinja
    - context:
        mongo_host: mongodb

/etc/stupidchess/config/flask-app-secret-key:
   file.managed:
     - contents: {{ pillar.stupidchess.flask_app_secret_key }}
     - user: stupidchess
     - group: stupidchess
     - mode: 400

/etc/stupidchess/config/mongo-password:
  file.managed:
    - contents: {{ pillar.mongo.users["stupidchess-rw"].password }}
    - user: stupidchess
    - group: stupidchess
    - mode: 400

/lib/systemd/system/stupidchess-uwsgi.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        After:
          - network.target
        PartOf: stupidchess-uwsgi.service
        Description: stupidchess uwsgi socket
        FileDescriptorName: stupidchess-uwsgi
        ListenStream:
          - /run/stupidchess/uwsgi.sock
        SocketMode: 660
        SocketUser: stupidchess
        SocketGroup: stupidchess

/lib/systemd/system/stupidchess-uwsgi.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: stupidchess uwsgi server
        Requires:
          - stupidchess-uwsgi.socket
        After:
          - mongod.service
        Environment:
          - JCONFIGURE_ACTIVE_PROFILES=RPI
          - JCONFIGURE_CONFIG_DIRECTORIES=/etc/stupidchess/config
          - SECRETS_VOLUME_PATH=/etc/stupidchess/config
        ExecStart: /opt/venvs/stupidchess-uwsgi/bin/uwsgi --ini /etc/stupidchess/uwsgi.ini
        User: stupidchess
        Group: stupidchess
        Sockets:
          - stupidchess-uwsgi.socket
        RuntimeDirectory: stupidchess

/lib/systemd/system/stupidchess-nginx.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        After:
          - network.target
        Description: stupidchess nginx and frontend code
        Type: forking
        PIDFile: /run/stupidchess-nginx/nginx.pid
        ExecStartPre: /usr/sbin/nginx -t -c /etc/stupidchess/nginx.conf
        ExecStart: /usr/sbin/nginx -c /etc/stupidchess/nginx.conf
        ExecReload: /usr/sbin/nginx -c /etc/stupidchess/nginx.conf -s reload
        ExecStop: /bin/kill -s QUIT $MAINPID
        User: stupidchess
        Group: stupidchess
        LogsDirectory: stupidchess
        RuntimeDirectory: stupidchess-nginx
        PrivateTmp: true

/etc/stupidchess/nginx-log-exporter.hcl:
  file.managed:
    - source: salt://files/etc/stupidchess/nginx-log-exporter.hcl
    - user: stupidchess
    - group: stupidchess
    - mode: 644
    - template: jinja
    - context:
        listen_address: {{ pillar.network.instance_ip }}
        listen_port: {{ pillar.port_by_service.tcp.stupidchess_nginx_exporter }}
        syslog_listen_address: unix:///run/stupidchess-nginx-exporter/syslog.sock

/lib/systemd/system/stupidchess-nginx-exporter.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        ExecStart: prometheus-nginxlog-exporter -config-file /etc/stupidchess/nginx-log-exporter.hcl
        User: stupidchess
        Group: stupidchess
        KillSignal: SIGQUIT
        NotifyAccess: all
        RuntimeDirectory: stupidchess-nginx-exporter

stupidchess-nginx-exporter:
  service.running:
    - enable: true
    - watch:
        - file: /etc/stupidchess/nginx-log-exporter.hcl
        - file: /lib/systemd/system/stupidchess-nginx-exporter.service

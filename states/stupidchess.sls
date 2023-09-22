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

/lib/systemd/system/stupidchess-uwsgi-local.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        PartOf: stupidchess-uwsgi.service
        Description: stupidchess uwsgi socket
        Service: stupidchess-uwsgi.service
        FileDescriptorName: stupidchess-uwsgi-local
        ListenStream:
          - {{ pillar.ips_by_service.stupidchess }}:80
        SocketUser: stupidchess
        SocketGroup: stupidchess

/lib/systemd/system/stupidchess-uwsgi.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        PartOf: stupidchess-uwsgi.service
        Description: stupidchess uwsgi socket
        FileDescriptorName: stupidchess-uwsgi
        ListenStream:
          - /run/stupidchess/uwsgi.sock
        SocketUser: stupidchess
        SocketGroup: stupidchess

/lib/systemd/system/stupidchess-uwsgi.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: stupidchess uwsgi server
        After: syslog.target
        Requires:
          - stupidchess-uwsgi.socket
          - stupidchess-uwsgi-local.socket
        Environment:
          - JCONFIGURE_ACTIVE_PROFILES=RPI
          - JCONFIGURE_CONFIG_DIRECTORIES=/etc/stupidchess/config
          - SECRETS_VOLUME_PATH=/etc/stupidchess/config
        ExecStart: /opt/venvs/stupidchess-uwsgi/bin/uwsgi --ini /etc/stupidchess/uwsgi.ini
        User: stupidchess
        Group: stupidchess
        Sockets:
          - stupidchess-uwsgi
          - stupidchess-uwsgi-local
        RuntimeDirectory: stupidchess

stupidchess-uwsgi:
  service.running:
    - watch:
        - file: /lib/systemd/system/stupidchess-uwsgi.service

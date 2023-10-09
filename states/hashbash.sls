/etc/hashbash/hashbash.env:
  file.managed:
    - source: salt://files/etc/hashbash/hashbash.env
    - user: hashbash
    - group: hashbash
    - mode: 400
    - makedirs: true
    - template: jinja
    - context:
        postgres_password: {{ pillar.postgres.app_users["hashbash-rw"].password }}
        rabbitmq_password: {{ pillar.rabbitmq.vhosts.hashbash["hashbash-rw"] }}

hashbash-backend:
  pkg.installed:
    - sources:
        - hashbash-backend: https://github.com/norwoodj/hashbash-backend-go/releases/download/{{ pillar.hashbash.backend_version }}/hashbash-backend_{{ pillar.hashbash.backend_version }}_{{ grains.osarch }}.deb

hashbash-nginx:
  pkg.installed:
    - sources:
        - hashbash-nginx: https://github.com/norwoodj/hashbash-frontend/releases/download/{{ pillar.hashbash.nginx_version }}/hashbash-nginx_{{ pillar.hashbash.nginx_version }}_{{ grains.osarch }}.deb

  service.running:
    - enable: true
    - reload: true
    - watch:
        - pkg: hashbash-nginx
        - file: /lib/systemd/system/hashbash-nginx.service

/lib/systemd/system/hashbash-engine-management.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        Description: hashbash engine management listener
        PartOf: hashbash-engine.service
        ListenStream:
          - {{ pillar.network.instance_ip }}:{{ pillar.port_by_service.tcp.hashbash_engine_metrics }}
        BindIPv6Only: both
        FileDescriptorName: hashbash-engine-management
        Service: hashbash-engine.service

/lib/systemd/system/hashbash-engine.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        After: 
          - postgresql.service
          - rabbitmq-server.service
        Description: hashbash engine service
        Requires:
          - hashbash-engine-management.socket
          - postgresql.service
        ExecStart: hashbash-engine
        RestartSec: 10s
        User: hashbash
        Group: hashbash
        EnvironmentFile: /etc/hashbash/hashbash.env
        Environment:
          - HASHBASH_MANAGEMENT_NAME=hashbash-engine-management
        Sockets:
          - hashbash-engine-management.socket

/lib/systemd/system/hashbash-webapp-management.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        Description: hashbash webapp management listener
        PartOf: hashbash-webapp.service
        ListenStream:
          - {{ pillar.network.instance_ip }}:{{ pillar.port_by_service.tcp.hashbash_webapp_metrics }}
        BindIPv6Only: both
        FileDescriptorName: hashbash-webapp-management
        Service: hashbash-webapp.service

/lib/systemd/system/hashbash-webapp.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        Description: hashbash webapp management listener
        PartOf: hashbash-webapp.service
        ListenStream:
          - /run/hashbash/webapp.sock
        FileDescriptorName: hashbash-webapp
        Service: hashbash-webapp.service
        SocketMode: 660
        SocketUser: hashbash
        SocketGroup: hashbash

/lib/systemd/system/hashbash-webapp.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        After:
          - postgresql.service
          - rabbitmq-server.service
        Description: hashbash webapp service
        Requires:
          - hashbash-webapp.socket
          - hashbash-webapp-management.socket
          - postgresql.service
        RestartSec: 10s
        ExecStart: hashbash-webapp
        Type: simple
        EnvironmentFile: /etc/hashbash/hashbash.env
        Environment:
          - HASHBASH_HTTP_NAME=hashbash-webapp
          - HASHBASH_MANAGEMENT_NAME=hashbash-webapp-management
        Sockets:
          - hashbash-webapp.socket
          - hashbash-webapp-management.socket
        RuntimeDirectory: hashbash
        User: hashbash
        Group: hashbash

/lib/systemd/system/hashbash-nginx.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: hashbash nginx and frontend code
        Type: forking
        PIDFile: /run/hashbash-nginx/nginx.pid
        ExecStartPre: /usr/sbin/nginx -t -c /etc/hashbash/nginx.conf
        ExecStart: /usr/sbin/nginx -c /etc/hashbash/nginx.conf
        ExecReload: /usr/sbin/nginx -c /etc/hashbash/nginx.conf -s reload
        ExecStop: /bin/kill -s QUIT $MAINPID
        User: hashbash
        Group: hashbash
        LogsDirectory: hashbash
        RuntimeDirectory: hashbash-nginx
        PrivateTmp: true

hashbash-engine:
  service.running:
    - enable: true
    - watch:
        - pkg: hashbash-backend
        - file: /lib/systemd/system/hashbash-engine-management.socket
        - file: /lib/systemd/system/hashbash-engine.service
        - file: /etc/hashbash/hashbash.env

hashbash-webapp:
  service.running:
    - enable: true
    - watch:
        - pkg: hashbash-backend
        - file: /lib/systemd/system/hashbash-webapp-management.socket
        - file: /lib/systemd/system/hashbash-webapp.socket
        - file: /lib/systemd/system/hashbash-webapp.service
        - file: /etc/hashbash/hashbash.env

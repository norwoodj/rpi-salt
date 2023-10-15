bolas:
  pkg.installed:
    - sources:
        - bolas: https://github.com/norwoodj/bolas/releases/download/{{ pillar.bolas.version }}/bolas_{{ pillar.bolas.version }}_{{ grains.osarch }}.deb

  service.running:
    - enable: true
    - watch:
        - pkg: bolas
        - file: /etc/default/bolas
        - file: /lib/systemd/system/bolas.service
        - file: /lib/systemd/system/bolas.socket
        - file: /lib/systemd/system/bolas-management.socket

/etc/default/bolas:
  file.managed:
    - source: salt://files/etc/default/bolas
    - user: bolas
    - group: bolas
    - mode: 644

/lib/systemd/system/bolas.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        PartOf: bolas.service
        Service: bolas.service
        Description: bolas application socket
        FileDescriptorName: bolas
        ListenStream:
          - /run/bolas/bolas.sock
        SocketMode: 660
        SocketUser: bolas
        SocketGroup: bolas

/lib/systemd/system/bolas-management.socket:
  file.managed:
    - source: salt://files/systemd/template.socket
    - template: jinja
    - context:
        PartOf: bolas.service
        Service: bolas.service
        Description: bolas management socket
        FileDescriptorName: bolas-management
        ListenStream:
          - {{ pillar.network.instance_ip }}:{{ pillar.port_by_service.tcp.bolas_management }}
        BindIPv6Only: both

/lib/systemd/system/bolas.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: bolas server
        Requires:
          - bolas.socket
          - bolas-management.socket
        EnvironmentFile: /etc/default/bolas
        ExecStart: bolas
        User: bolas
        Group: bolas
        Sockets:
          - bolas.socket
          - bolas-management.socket
        RuntimeDirectory: bolas

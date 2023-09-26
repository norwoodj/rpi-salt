bolas:
  pkg.installed:
    - sources:
        - bolas: https://github.com/norwoodj/bolas/releases/download/{{ pillar.bolas.version }}/bolas_{{ pillar.bolas.version }}_{{ grains.osarch }}.deb

  service.running:
    - watch:
        - pkg: bolas
        - file: /etc/default/bolas
        - file: /lib/systemd/system/bolas.service
        - file: /lib/systemd/system/bolas.service

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
        Description: bolas http socket
        FileDescriptorName: bolas
        ListenStream:
          - /run/bolas/bolas.sock
        SocketUser: bolas
        SocketGroup: bolas

/lib/systemd/system/bolas.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: bolas server
        Requires:
          - bolas.socket
        EnvironmentFile: /etc/default/bolas
        ExecStart: bolas $ARGS
        User: bolas
        Group: bolas
        Sockets:
          - bolas.socket
        RuntimeDirectory: bolas

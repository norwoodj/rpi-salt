bolas:
  pkg.installed:
    - sources:
        - bolas: https://github.com/norwoodj/bolas/releases/download/{{ pillar.bolas.version }}/bolas_{{ pillar.bolas.version }}_{{ grains.osarch }}.deb

  service.running:
    - enable: true
    - watch:
        - pkg: bolas
        - file: /etc/bolas/config.yaml
        - file: /lib/systemd/system/bolas.service
        - file: /lib/systemd/system/bolas.socket

/etc/bolas/config.yaml:
  file.managed:
    - source: salt://files/etc/bolas/config.yaml
    - user: bolas
    - group: bolas
    - mode: 644
    - template: jinja
    - context:
        bolas_telemetry_addr: {{ pillar.network.instance_ip }}:{{ pillar.port_by_service.tcp.bolas_telemetry }}

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

/lib/systemd/system/bolas.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: bolas server
        Requires:
          - bolas.socket
        ExecStart: bolas --config /etc/bolas/config.yaml
        User: bolas
        Group: bolas
        Sockets:
          - bolas.socket
        RuntimeDirectory: bolas

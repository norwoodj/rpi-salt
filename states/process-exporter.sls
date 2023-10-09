process-exporter:
  pkg.installed:
    - sources:
        - process-exporter: https://github.com/ncabatoff/process-exporter/releases/download/v{{ pillar.process_exporter.version }}/process-exporter_{{ pillar.process_exporter.version }}_linux_{{ grains.osarch }}.deb

  service.running:
    - enable: true
    - watch:
        - file: /etc/default/process-exporter
        - pkg: process-exporter

/etc/default/process-exporter:
  file.managed:
    - source: salt://files/etc/default/process-exporter
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        listen_address: metrics:{{ pillar.port_by_service.tcp.process_exporter }}

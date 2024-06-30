prometheus-node-exporter:
  pkg.installed: []

  service.running:
    - enable: true
    - watch:
        - file: /etc/default/prometheus-node-exporter
        - pkg: prometheus-node-exporter

/etc/default/prometheus-node-exporter:
  file.managed:
    - source: salt://files/etc/default/prometheus-node-exporter
    - user: prometheus
    - group: prometheus
    - mode: 644
    - template: jinja
    - context:
        listen_address: metrics:{{ pillar.port_by_service.tcp.node_exporter }}


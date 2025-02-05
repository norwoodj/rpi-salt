prometheus:
  pkg.installed: []

  service.running:
    - watch:
        - pkg: prometheus
        - file: /etc/prometheus/prometheus.yml
        - file: /etc/default/prometheus

/etc/default/prometheus:
  file.managed:
    - source: salt://files/etc/default/prometheus
    - user: prometheus
    - group: prometheus
    - template: jinja
    - context:
        listen_address: ":{{ pillar.port_by_service.tcp.prometheus }}"
        retention_time: {{ pillar.prometheus.retention_time }}

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://files/etc/prometheus/prometheus.yaml
    - user: prometheus
    - group: prometheus
    - template: jinja
    - context:
        metrics_host: metrics
        ports: {{ pillar.port_by_service.tcp }}

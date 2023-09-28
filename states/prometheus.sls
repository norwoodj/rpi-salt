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
    - template: jinja
    - context:
        prometheus_host: prometheus
        retention_time: {{ pillar.prometheus.retention_time }}

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://files/etc/prometheus/prometheus.yaml

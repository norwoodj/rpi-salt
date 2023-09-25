prometheus:
  pkg.installed: []

  service.running:
    - watch:
        - pkg: prometheus
        - file: /etc/prometheus/prometheus.yml

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://files/etc/prometheus/prometheus.yaml

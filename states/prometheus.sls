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

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://files/etc/prometheus/prometheus.yaml

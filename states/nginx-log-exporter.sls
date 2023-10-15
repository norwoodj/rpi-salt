prometheus-nginxlog-exporter:
  pkg.installed:
    - sources:
        - prometheus-nginxlog-exporter: https://github.com/martin-helmich/prometheus-nginxlog-exporter/releases/download/v{{ pillar.nginx_log_exporter.version }}/prometheus-nginxlog-exporter_{{ pillar.nginx_log_exporter.version }}_linux_{{ grains.osarch }}.deb

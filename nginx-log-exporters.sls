prometheus-nginxlog-exporter:
  pkg.installed:
    - sources:
        - prometheus-nginxlog-exporter: https://github.com/norwoodj/rpi-salt/releases/download/{{ pillar["prometheus-nginxlog-exporter"]["version"] }}/nginx-log-exporters_{{ pillar["prometheus-nginxlog-exporter"]["version"] }}_armhf.deb

/lib/systemd/system/hashbash-nginx-exporter.service:
  file.managed:
    - source: salt://files/systemd/hashbash-nginx-exporter.service

/lib/systemd/system/stupidchess-nginx-exporter.service:
  file.managed:
    - source: salt://files/systemd/stupidchess-nginx-exporter.service

/opt/prometheus-nginxlog-exporter/hashbash-nginx-exporter.hcl:
  file.managed:
    - source: salt://files/opt/prometheus-nginxlog-exporter/hashbash-nginx-exporter.hcl

/opt/prometheus-nginxlog-exporter/stupidchess-nginx-exporter.hcl:
  file.managed:
    - source: salt://files/opt/prometheus-nginxlog-exporter/stupidchess-nginx-exporter.hcl

hashbash-nginx-exporter:
  service.running:
    - enable: true

stupidchess-nginx-exporter:
  service.running:
    - enable: true

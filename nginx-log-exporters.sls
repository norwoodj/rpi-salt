prometheus-nginxlog-exporter:
  pkg.installed:
    - sources:
        - prometheus-nginxlog-exporter: https://github.com/norwoodj/rpi-salt/releases/download/{{ pillar["prometheus-nginxlog-exporter"]["version"] }}/prometheus-nginxlog-exporter_{{ pillar["prometheus-nginxlog-exporter"]["version"] }}_armhf.deb

/lib/systemd/system/hashbash-nginx-exporter.service:
  file.managed:
    - source: salt://files/systemd/hashbash-nginx-exporter.service

/lib/systemd/system/stupidchess-nginx-exporter.service:
  file.managed:
    - source: salt://files/systemd/stupidchess-nginx-exporter.service

/etc/prometheus-nginxlog-exporter/hashbash-nginx-exporter.hcl:
  file.managed:
    - source: salt://files/etc/prometheus-nginxlog-exporter/hashbash-nginx-exporter.hcl
    - makedirs: true

/etc/prometheus-nginxlog-exporter/stupidchess-nginx-exporter.hcl:
  file.managed:
    - source: salt://files/etc/prometheus-nginxlog-exporter/stupidchess-nginx-exporter.hcl
    - makedirs: true

hashbash-nginx-exporter:
  service.running:
    - enable: true
    - reload: true

stupidchess-nginx-exporter:
  service.running:
    - enable: true
    - reload: true

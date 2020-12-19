nginx-log-exporters:
  pkg.installed:
    - sources:
        - nginx-log-exporters: https://github.com/norwoodj/rpi-salt/releases/download/{{ pillar["nginx-log-exporters"]["version"] }}/nginx-log-exporters_{{ pillar["nginx-log-exporters"]["version"] }}_armhf.deb

hashbash-nginx-exporter:
  service.running:
    - enable: true

stupidchess-nginx-exporter:
  service.running:
    - enable: true

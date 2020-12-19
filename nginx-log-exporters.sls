install-stupidchess:
  pkg.installed:
    - sources:
        - nginx-log-exporters: https://github.com/norwoodj/rpi-salt/releases/download/{{ pillar["nginx-log-exporters"]["version"] }}/nginx-log-exporters_{{ pillar["nginx-log-exporters"]["version"] }}_armhf.deb

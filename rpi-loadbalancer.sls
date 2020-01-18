install-rpi-loadbalancer:
  pkg.installed:
      - sources:
          - rpi-loadbalancer: https://github.com/norwoodj/rpi-loadbalancer/releases/download/{{ pillar["rpi-loadbalancer"]["version"] }}/rpi-loadbalancer_{{ pillar["rpi-loadbalancer"]["version"] }}_armhf.deb

rpi-loadbalancer:
  service.running:
    - enable: true

  cmd.run:
    - name: chown -R nobody:nogroup /var/lib/nginx

install-rpi-loadbalancer:
  pkg.installed:
      - sources:
          - rpi-loadbalancer: https://github.com/norwoodj/rpi-loadbalancer/releases/download/19.1207.0/rpi-loadbalancer_19.1207.0_armhf.deb

rpi-loadbalancer:
  service.running:
    - enable: true

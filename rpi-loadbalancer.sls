install-rpi-loadbalancer:
  pkg.installed:
      - sources:
          - rpi-loadbalancer: https://github.com/norwoodj/rpi-loadbalancer/releases/download/19.1205.1/rpi-loadbalancer_19.1205.1_armhf.deb

rpi-loadbalancer:
  service.running:
    - enable: true

install-stupidchess-nginx:
  pkg.installed:
      - sources:
          - stupidchess-nginx: salt://files/packages/stupidchess-nginx-19.1030.deb

stupidchess-nginx:
  service.running:
    - enable: true

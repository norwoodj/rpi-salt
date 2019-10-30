install-stupidchess-nginx:
  pkg.installed:
      - sources:
          - stupidchess-nginx: salt://files/packages/stupidchess-nginx-0.1.deb

stupidchess-nginx:
  service.running:
    - enable: true

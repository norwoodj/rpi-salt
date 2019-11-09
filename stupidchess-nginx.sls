install-stupidchess-nginx:
  pkg.installed:
      - sources:
          - stupidchess-nginx: https://github.com/norwoodj/stupidchess-frontend/releases/download/19.1109.0/stupidchess-nginx-19.1109.0.deb

stupidchess-nginx:
  service.running:
    - enable: true

install-nginx-load-balancer:
  pkg.installed:
      - sources:
          - nginx-load-balancer: https://github.com/norwoodj/stupidchess-frontend/releases/download/19.1109.0/nginx-load-balancer-19.1109.0.deb

nginx-load-balancer:
  service.running:
    - enable: true

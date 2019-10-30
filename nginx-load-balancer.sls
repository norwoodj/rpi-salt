install-nginx-load-balancer:
  pkg.installed:
      - sources:
          - nginx-load-balancer: salt://files/packages/nginx-load-balancer-19.1030.deb

nginx-load-balancer:
  service.running:
    - enable: true

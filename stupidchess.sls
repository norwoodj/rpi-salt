install-stupidchess:
  pkg.installed:
      - sources:
          - stupidchess-nginx: https://github.com/norwoodj/stupidchess-frontend/releases/download/19.1207.0/stupidchess-nginx_19.1207.0_armhf.deb
          - stupidchess-uwsgi: https://github.com/norwoodj/stupidchess-backend/releases/download/19.1205.1/stupidchess-uwsgi_19.1205.1_armhf.deb

stupidchess-app-secret-key:
  file.managed:
    - name: /opt/stupidchess/secrets/flask-app-secret-key
    - contents: {{ pillar["stupidchess"]["flask-app-secret-key"] }}
    - makedirs: true

stupidchess-mongo-password:
  file.managed:
    - name: /opt/stupidchess/secrets/mongo-password
    - contents: {{ pillar["stupidchess"]["mongo-password"] }}
    - makedirs: true

stupidchess-nginx:
  service.running:
    - enable: true

stupidchess-uwsgi:
  service.running:
    - enable: true

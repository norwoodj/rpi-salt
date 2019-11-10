install-stupidchess:
  pkg.installed:
      - sources:
          - stupidchess-deployment: https://github.com/norwoodj/stupidchess-backend/releases/download/19.1110.3/stupidchess-deployment-19.1110.3.deb
          - stupidchess-nginx: https://github.com/norwoodj/stupidchess-frontend/releases/download/19.1109.0/stupidchess-nginx-19.1109.0.deb
          - stupidchess-uwsgi: https://github.com/norwoodj/stupidchess-backend/releases/download/19.1110.3/stupidchess_19.1110.3_armhf.deb

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

install-stupidchess:
  pkg.installed:
    - sources:
        - stupidchess-nginx: https://github.com/norwoodj/stupidchess-frontend/releases/download/{{ pillar["stupidchess"]["nginx-version"] }}/stupidchess-nginx_{{ pillar["stupidchess"]["nginx-version"] }}_armhf.deb
        - stupidchess-uwsgi: https://github.com/norwoodj/stupidchess-backend/releases/download/{{ pillar["stupidchess"]["uwsgi-version"] }}/stupidchess-uwsgi_{{ pillar["stupidchess"]["uwsgi-version"] }}_armhf.deb

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

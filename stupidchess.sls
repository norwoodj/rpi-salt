/run/stupidchess:
  file.directory:
    - user: stupidchess
    - group: stupidchess

/var/log/stupidchess:
  file.directory:
    - user: stupidchess
    - group: stupidchess

/opt/secrets/stupidchess:
  file.directory:
    - user: stupidchess
    - group: stupidchess

stupidchess-app-secret-key:
  file.managed:
    - name: /opt/secrets/stupidchess/flask-app-secret-key
    - contents: {{ pillar["stupidchess"]["flask-app-secret-key"] }}
    - user: stupidchess
    - group: stupidchess
    - mode: 400

stupidchess-mongo-password:
  file.managed:
    - name: /opt/secrets/stupidchess/mongo-password
    - contents: {{ pillar["stupidchess"]["mongo-password"] }}
    - user: stupidchess
    - group: stupidchess
    - mode: 400

install-stupidchess:
  pkg.installed:
    - sources:
        - stupidchess-nginx: https://github.com/norwoodj/stupidchess-frontend/releases/download/{{ pillar["stupidchess"]["nginx-version"] }}/stupidchess-nginx_{{ pillar["stupidchess"]["nginx-version"] }}_armhf.deb
        - stupidchess-uwsgi: https://github.com/norwoodj/stupidchess-backend/releases/download/{{ pillar["stupidchess"]["uwsgi-version"] }}/stupidchess-uwsgi_{{ pillar["stupidchess"]["uwsgi-version"] }}_armhf.deb

stupidchess-nginx:
  service.running:
    - enable: true

stupidchess-uwsgi:
  service.running:
    - enable: true

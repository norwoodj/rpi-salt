install-hashbash:
  pkg.installed:
    - sources:
        - hashbash-backend: https://github.com/norwoodj/hashbash-backend-go/releases/download/{{ pillar["hashbash"]["backend-version"] }}/hashbash-backend_{{ pillar["hashbash"]["backend-version"] }}_armhf.deb
        - hashbash-nginx: https://github.com/norwoodj/hashbash-frontend/releases/download/{{ pillar["hashbash"]["nginx-version"] }}/hashbash-nginx_{{ pillar["hashbash"]["nginx-version"] }}_armhf.deb

  file.managed:
    - name: /opt/hashbash/hashbash.env
    - source: salt://files/opt/hashbash/hashbash.env
    - makedirs: true
    - template: jinja
    - context:
        mysql_password: {{ pillar["hashbash"]["mysql-password"] }}
        rabbitmq_password: {{ pillar["hashbash"]["rabbitmq-password"] }}

hashbash-nginx:
  service.running:
    - enable: true

hashbash-engine:
  service.running:
    - enable: true

hashbash-webapp:
  service.running:
    - enable: true

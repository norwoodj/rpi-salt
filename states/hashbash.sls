/var/log/hashbash:
  file.directory:
    - user: hashbash
    - group: hashbash

/opt/secrets/hashbash:
  file.directory:
    - user: hashbash
    - group: hashbash

/opt/secrets/hashbash/hashbash.env:
  file.managed:
    - source: salt://files/opt/hashbash/hashbash.env
    - user: hashbash
    - group: hashbash
    - mode: 400
    - template: jinja
    - context:
        postgres_password: {{ pillar["hashbash"]["postgres-password"] }}
        rabbitmq_password: {{ pillar["hashbash"]["rabbitmq-password"] }}

install-hashbash:
  pkg.installed:
    - sources:
        - hashbash-backend: https://github.com/norwoodj/hashbash-backend-go/releases/download/{{ pillar["hashbash"]["backend-version"] }}/hashbash-backend_{{ pillar["hashbash"]["backend-version"] }}_armhf.deb
        - hashbash-nginx: https://github.com/norwoodj/hashbash-frontend/releases/download/{{ pillar["hashbash"]["nginx-version"] }}/hashbash-nginx_{{ pillar["hashbash"]["nginx-version"] }}_armhf.deb

hashbash-nginx:
  service.running:
    - enable: true

hashbash-engine:
  service.running:
    - enable: true

hashbash-webapp:
  service.running:
    - enable: true

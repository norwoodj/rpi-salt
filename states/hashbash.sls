/etc/hashbash/hashbash.env:
  file.managed:
    - source: salt://files/etc/hashbash/hashbash.env
    - user: hashbash
    - group: hashbash
    - mode: 400
    - template: jinja
    - context:
        postgres_password: {{ pillar.postgres.app_users["hashbash-rw"] }}
        rabbitmq_password: {{ pillar.rabbitmq.vhosts.hashbash["hashbash-rw"] }}

install-hashbash:
  pkg.installed:
    - sources:
        - hashbash-backend: https://github.com/norwoodj/hashbash-backend-go/releases/download/{{ pillar.hashbash.backend_version }}/hashbash-backend_{{ pillar.hashbash.backend_version }}_{{ grains.osarch }}.deb
        - hashbash-nginx: https://github.com/norwoodj/hashbash-frontend/releases/download/{{ pillar.hashbash.nginx_version }}/hashbash-nginx_{{ pillar.hashbash.nginx_version }}_{{ grains.osarch }}.deb

hashbash-nginx:
  service.running:
    - enable: true

hashbash-engine:
  service.running:
    - enable: true

hashbash-webapp:
  service.running:
    - enable: true

grafana:
  cmd.run:
    - name: |
        wget https://dl.grafana.com/oss/release/grafana-rpi_6.5.2_armhf.deb
        sudo dpkg -i grafana-rpi_6.5.2_armhf.deb
    - creates: /etc/grafana/grafana.ini

/etc/grafana/grafana.ini:
  file.managed:
    - source: salt://files/etc/grafana/grafana.ini
    - template: jinja
    - context:
        admin_password: {{ pillar.grafana.admin_password }}
        secret_key: {{ pillar.grafana.secret_key }}
        dashboards_directory: {{ pillar.grafana.secret_key }}

grafana-server:
  service.running:
    - enable: true

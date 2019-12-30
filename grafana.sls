grafana:
  cmd.run:
    - name: |
        wget https://dl.grafana.com/oss/release/grafana-rpi_6.5.2_armhf.deb
        sudo dpkg -i grafana-rpi_6.5.2_armhf.deb
    - creates: /etc/grafana/grafana.ini

  file.managed:
    - name: /etc/grafana/grafana.ini
    - source: salt://files/etc/grafana/grafana.ini
    - template: jinja
    - context:
        admin-password: {{ pillar["grafana"]["admin-password"] }}
        secret-key: {{ pillar["grafana"]["secret-key"] }}

  file.directory:
    - name: /etc/grafana/dashboards
    - user: grafana
    - group: grafana
    - mode: 644

  file.recurse:
    - name: /etc/grafana/dashboards
    - source: salt://files/etc/grafana/dashboards
    - user: grafana
    - group: grafana
    - file_mode: "0644"

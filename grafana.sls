grafana:
  cmd.run:
    - name: |
        wget https://dl.grafana.com/oss/release/grafana-rpi_6.5.2_armhf.deb
        sudo dpkg -i grafana-rpi_6.5.2_armhf.deb
    - creates: /etc/grafana.ini

  file.managed:
    - name: /etc/grafana.ini
    - source: salt://files/etc/grafana.ini

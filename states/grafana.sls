grafana:
  pkgrepo.managed:
    - name: deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main
    - humanname: grafana-oss
    - key_url: https://apt.grafana.com/gpg.key
    - aptkey: false
    - file: /etc/apt/sources.list.d/grafana.list
    - require_in:
      - pkg: grafana
    - gpgcheck: 1

  pkg.installed: []

/etc/grafana/dashboards:
  file.recurse:
    - source: salt://files/etc/grafana/dashboards
    - makedirs: true
    - user: grafana
    - group: grafana
    - file_mode: 644
    - recurse:
        - user
        - group

/etc/grafana/provisioning/dashboards/provider.yaml:
  file.managed:
    - source: salt://files/etc/grafana/provisioning/dashboards/provider.yaml
    - makedirs: true
    - user: grafana
    - group: grafana
    - mode: 644
    - template: jinja
    - context:
        dashboards_directory: /etc/grafana/dashboards

/etc/grafana/provisioning/datasources/prometheus.yaml:
  file.managed:
    - source: salt://files/etc/grafana/provisioning/datasources/prometheus.yaml
    - makedirs: true
    - user: grafana
    - group: grafana
    - mode: 644
    - template: jinja
    - context:
        prometheus_host: prometheus

/etc/grafana/grafana.ini:
  file.managed:
    - source: salt://files/etc/grafana/grafana.ini
    - user: grafana
    - group: grafana
    - mode: 644
    - template: jinja
    - context:
        admin_password: {{ pillar.grafana.admin_password }}
        secret_key: {{ pillar.grafana.secret_key }}

grafana-server:
  service.running:
    - enable: true
    - watch:
        - pkg: grafana
        - file: /etc/grafana/grafana.ini
        - file: /etc/grafana/dashboards
        - file: /etc/grafana/provisioning/dashboards/provider.yaml
        - file: /etc/grafana/provisioning/datasources/prometheus.yaml

treemap-plugin:
  cmd.run:
    - name: grafana-cli plugins install marcusolsson-treemap-panel
    - creates: /var/lib/grafana/plugins/marcusolsson-treemap-panel
    - runas: grafana

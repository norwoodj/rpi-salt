prometheus:
  pkg.installed: []

  service.running:
    - watch:
        - pkg: prometheus
        - file: /etc/prometheus/prometheus.yml
        - file: /etc/default/prometheus

/etc/default/prometheus:
  file.managed:
    - source: salt://files/etc/default/prometheus
    - user: prometheus
    - group: prometheus
    - template: jinja
    - context:
        listen_address: ":{{ pillar.port_by_service.tcp.prometheus }}"
        retention_time: {{ pillar.prometheus.retention_time }}

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://files/etc/prometheus/prometheus.yaml
    - user: prometheus
    - group: prometheus
    - template: jinja
    - context:
        metrics_host: metrics
        scrape_jobs:
          bolas: {{ pillar.port_by_service.tcp.bolas_telemetry }}
          hashbash-engine: {{ pillar.port_by_service.tcp.hashbash_engine_management }}
          hashbash-nginx: {{ pillar.port_by_service.tcp.hashbash_nginx_exporter }}
          hashbash-webapp: {{ pillar.port_by_service.tcp.hashbash_webapp_management }}
          mongodb-exporter: {{ pillar.port_by_service.tcp.mongodb_exporter }}
          node-exporter: {{ pillar.port_by_service.tcp.node_exporter }}
          postgres-exporter: {{ pillar.port_by_service.tcp.postgres_exporter }}
          process-exporter: {{ pillar.port_by_service.tcp.process_exporter }}
          prometheus: {{ pillar.port_by_service.tcp.prometheus }}
          rabbitmq: {{ pillar.port_by_service.tcp.rabbitmq_metrics }}
          stupidchess-nginx: {{ pillar.port_by_service.tcp.stupidchess_nginx_exporter }}
          tunnel: {{ pillar.port_by_service.tcp.tunnel_metrics }}

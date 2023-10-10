cloudflared:
  pkg.installed:
    - sources:
        - cloudflared: https://github.com/cloudflare/cloudflared/releases/download/{{ pillar.tunnels.version }}/cloudflared-linux-{{ grains.osarch }}.deb

{%- set tunnel_services = [] %}
{%- for tunnel_id in pillar.tunnels.instances.keys() %}
  {%- do tunnel_services.append("tunnel-{}.service".format(tunnel_id)) %}
{%- endfor %}

{%- for tunnel_id, config in pillar.tunnels.instances.items() %}

/etc/cloudflared/{{ tunnel_id }}-credentials.json:
  file.managed:
    - source: salt://files/cloudflared/tunnel-credentials.json
    - template: jinja
    - makedirs: true
    - user: tunnel
    - group: tunnel
    - mode: 400
    - context:
        account_tag: {{ pillar.tunnels.account_tag }}
        tunnel_id: {{ tunnel_id }}
        tunnel_secret: {{ config.secret }}

/etc/cloudflared/{{ tunnel_id }}.yaml:
  file.managed:
    - source: salt://files/cloudflared/tunnel.yaml
    - template: jinja
    - user: tunnel
    - group: tunnel
    - makedirs: true
    - context:
        credentials_file: /etc/cloudflared/{{ tunnel_id }}-credentials.json
        metrics_addr: metrics:{{ pillar.port_by_service.tcp.tunnel_metrics }}
        tunnel_id: {{ tunnel_id }}
        private_network: {{ config.private_network }}
{%- if config.hostnames is defined %}
        hostnames:
  {%- for hostname, service in config.hostnames.items() %}
          {{ "{}.{}".format(hostname, pillar.network.public_base_domain) | yaml_dquote }}: {{ service }}
  {%- endfor %}
{%- endif %}

/lib/systemd/system/tunnel-{{ tunnel_id }}.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: cloudflared tunnel {{ tunnel_id }}
        After:
          - network.target
        TimeoutStartSec: 0
        Type: notify
        User: tunnel
        Group: tunnel
        ExecStart: /usr/bin/cloudflared --config /etc/cloudflared/{{ tunnel_id }}.yaml tunnel run
        Restart: on-failure
        RestartSec: 5s

tunnel-{{ tunnel_id }}.service:
  service.running:
    - enable: true
    - watch:
        - file: /etc/cloudflared/{{ tunnel_id }}.yaml
        - file: /etc/cloudflared/{{ tunnel_id }}-credentials.json
        - file: /lib/systemd/system/tunnel-{{ tunnel_id }}.service

{%- endfor %}

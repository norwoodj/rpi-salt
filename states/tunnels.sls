cloudflared:
  pkg.installed:
    - sources:
        - cloudflared: https://github.com/cloudflare/cloudflared/releases/download/{{ pillar.tunnels.version }}/cloudflared-linux-{{ grains.osarch }}.deb

{%- set tunnel_services = [] %}
{%- for tunnel_id in pillar.tunnels.instances.keys() %}
  {%- do tunnel_services.append("tunnel-{}.service".format(tunnel_id)) %}
{%- endfor %}

/lib/systemd/system/cloudflared-update.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: Update cloudflared
        After:
          - network.target
        ExecStart: /bin/bash -c '/usr/bin/cloudflared update; code=$?; if [ $code -eq 11 ]; then systemctl restart {{ tunnel_services | join(" ") }}; exit 0; fi; exit $code'

/lib/systemd/system/cloudflared-update.timer:
  file.managed:
    - source: salt://files/systemd/template.timer
    - template: jinja
    - context:
        Description: Update cloudflared
        OnCalendar: daily
        WantedBy: timers.target

cloudflared-update.timer:
  service.running:
    - enable: true
    - watch:
        - file: /lib/systemd/system/cloudflared-update.service
        - file: /lib/systemd/system/cloudflared-update.timer

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
        metrics_addr: tunnel:2323
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
        ExecStart: /usr/bin/cloudflared --no-autoupdate --config /etc/cloudflared/{{ tunnel_id }}.yaml tunnel run
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

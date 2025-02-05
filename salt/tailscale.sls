include:
  - dns

tailscale-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu noble main
    - file: /etc/apt/sources.list.d/tailscale.list
    - keyurl: https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg
    - require_in:
      - pkg: tailscale

tailscale:
  pkg.installed: []

tailscaled:
  service.running:
    - enable: true

/etc/hosts-tailscale:
  file.managed:
    - source: salt://files/etc/hosts-tailscale
    - template: jinja
    - context:
        hostnames: {{ pillar.network.hosts }}

/etc/dnsmasq-tailscale.conf:
  file.managed:
    - source: salt://files/etc/dnsmasq-tailscale.conf
    - template: jinja
    - context:
        base_domain: {{ pillar.network.internal_base_domain }}
        listen_ip: {{ pillar.network.tailscale_ip }}
        listen_port: {{ pillar.port_by_service.udp.dnsmasq }}

/lib/systemd/system/dnsmasq-tailscale.service:
  file.managed:
    - source: salt://files/systemd/template.service
    - template: jinja
    - context:
        Description: dnsmasq - DNS server for tailscale-private addresses
        Requires:
          - network.target
        Wants: nss-lookup.target
        Before:
          - nss-lookup.target
        After:
          - network.target
        Type: forking
        RuntimeDirectory: dnsmasq-tailscale
        PIDFile: /run/dnsmasq-tailscale/dnsmasq.pid
        ExecStart: dnsmasq --conf-file=/etc/dnsmasq-tailscale.conf
        ExecReload: /bin/kill -HUP $MAINPID
        WantedBy: multi-user.target

dnsmasq-tailscale:
  service.running:
    - enable: true
    - watch:
        - pkg: dnsmasq
        - file: /etc/dnsmasq-tailscale.conf


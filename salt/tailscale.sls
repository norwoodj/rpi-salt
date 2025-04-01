# Here's how this works:
#
# I run a number of internal services on this server (grafana, prometheus, postgres, etc.) which
# each bind to all interfaces. In addition to tailscale, I install in this state a dnsmasq service
# which binds to 100.64.2.2:53 (the node IP within my tailnet for this server), and which resolves
# {service}.jmn23.internal for each of those services to 100.64.2.2.
#
# Therefore, when I enable tailscale on my laptop, and navigate to, say, grafana.jmn23.internal, 
# tailscale DNS settings cause that to be directed to the aforementioned dnsmasq service, via the
# wireguard tunnel between my laptop and this server, resolving to the tailnet IP of this node, and
# thus connecting my laptop and the running service.
#
# As an aside, if you look at the configuration in dns.sls and tunnels.sls, I have the same setup
# for cloudflare, except that the dnsmasq service for that purpose binds to 10.0.2.2:53 and resolves
# those same service names to 10.0.2.2. In this way, I can enable either cloudflare warp or tailscale
# on my laptop, and the same DNS names resolve to the correct IP address to be accessed via the
# active client
include:
  - dns

tailscale-repo-key:
  cmd.run:
    - name: >
        curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg
        > /usr/share/keyrings/tailscale-archive-keyring.gpg
    - creates: /usr/share/keyrings/tailscale-archive-keyring.gpg

tailscale-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu noble main
    - file: /etc/apt/sources.list.d/tailscale.list
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
        hostname: {{ grains.nodename }}
        hosts: {{ pillar.network.hosts }}
        tailscale_ip: {{ pillar.network.tailscale_ip }}

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
        After:
          - network.target
          - tailscaled.service
        Requires:
          - network.target
          - tailscaled.service
        Restart: on-failure
        RestartSec: 5s
        Type: forking
        ExecStart: dnsmasq --conf-file=/etc/dnsmasq-tailscale.conf
        ExecReload: /bin/kill -HUP $MAINPID
        WantedBy: multi-user.target

dnsmasq-tailscale:
  service.running:
    - enable: true
    - watch:
        - pkg: dnsmasq
        - file: /etc/dnsmasq-tailscale.conf
        - file: /etc/hosts-tailscale


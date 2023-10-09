dnsmasq:
  pkg.installed: []

  service.running:
    - enable: true
    - watch:
        - pkg: dnsmasq
        - file: /etc/dnsmasq.conf

/etc/dnsmasq.conf:
  file.managed:
    - source: salt://files/etc/dnsmasq.conf
    - template: jinja
    - context:
        listen_ip: {{ pillar.network.instance_ip }}
        listen_port: {{ pillar.port_by_service.udp.dnsmasq }}
        base_domain: {{ pillar.network.internal_base_domain }}

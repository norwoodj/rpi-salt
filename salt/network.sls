/lib/systemd/network/10-lo.network:
  file.managed:
    - source: salt://files/systemd/template.network
    - template: jinja
    - context:
        Match:
          Name: lo
        Network:
          Address: {{ pillar.network.instance_ip }}/32

systemd-networkd:
  service.running:
    - watch:
        - file: /lib/systemd/network/10-lo.network

add-instance-ip-hosts:
  host.present:
    - ip:
        - {{ pillar.network.instance_ip }}
    - names:
        - {{ grains.nodename }}
{%- for hostname in pillar.network.hosts %}
        - {{ hostname }}
{%- endfor %}


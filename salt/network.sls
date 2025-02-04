/etc/netplan/50-lo.yaml:
  file.managed:
    - source: salt://files/etc/netplan/50-lo.yaml
    - template: jinja
    - context:
        instance_ip: {{ pillar.network.instance_ip }}

/etc/netplan/50-eth0.yaml:
  file.managed:
    - source: salt://files/etc/netplan/50-eth0.yaml

add-instance-ip-hosts:
  host.present:
    - ip:
        - {{ pillar.network.instance_ip }}
    - names:
        - {{ grains.nodename }}
{%- for hostname in pillar.network.hosts %}
        - {{ hostname }}
{%- endfor %}


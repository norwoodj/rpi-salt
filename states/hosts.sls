{% for service, ip in pillar.ips_by_service.items() %}
{% set hostname = "{}.{}".format(service, pillar.hosts.base_internal_domain) %}
add-host-{{ hostname }}:
  host.present:
    - ip:
      - {{ ip }}
    - names:
      - {{ hostname }}
{% endfor %}

{% import_yaml "ports.yaml" as ports %}

service_by_port:
  tcp: {{ ports.tcp | yaml }}
  udp: {{ ports.udp | yaml }}

port_by_service:
  tcp:
{%- for p, s in ports.tcp.items() %}
    {{ s }}: {{ p }}
{%- endfor %}

  udp:
{%- for p, s in ports.udp.items() %}
    {{ s }}: {{ p }}
{%- endfor %}

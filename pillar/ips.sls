{% import_yaml "ips.yaml" as ips -%}

ips_by_service:
{%- for ip, services in ips.items() %}
  {%- for s in services %}
    {{ s | quote }}: {{ ip | quote }}
  {%- endfor %}
{%- endfor %}

services_by_ip: {{ ips | yaml}}

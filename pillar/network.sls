# Here's the super over-engineered IP setup for these nodes.
# Super over-engineered because at the start I intend to have
# only one node running.
# 
# Every node will be named {datacenter}[p|s]{instance}
# "p" for primary "s" for secondary.
#
# Each instance will get an IP 10.{datacenter}.{instance}.0
# to bind services to. A private cloudflared tunnel will
# be used to route to private IPs
{% set name_regex = "([0-9]+)[ps]([0-9]+)" -%}
{%- set datacenter = grains.host | regex_replace(name_regex, "\\1") %}
{%- set instance = grains.host | regex_replace(name_regex, "\\2") %}
{%- set instance_ip = "10.{}.0.{}".format(datacenter, instance) %}

network:
  internal_base_domain: jmn23.internal
  public_base_domain: jmn23.com
  instance_ip: {{ instance_ip | yaml_dquote }}
  hosts:
    - bolas
    - grafana
    - hashbash
    - mongodb
    - node-exporter
    - postgres
    - prometheus
    - rabbitmq
    - rpi-loadbalancer
    - stupidchess

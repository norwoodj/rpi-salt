packages:
  pkg.installed:
    - pkgs:
        - prometheus

  file.managed:
    - name: /etc/prometheus/prometheus.yml
    - source: salt://files/etc/prometheus/prometheus.yaml

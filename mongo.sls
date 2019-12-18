mongo:
  pkg.installed:
    - pkgs:
        - mongodb

  file.managed:
    - name: /etc/mongodb.conf
    - source: salt://files/etc/mongodb.conf

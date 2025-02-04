nodejs:
  pkgrepo.managed:
    - name: deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_{{ pillar.node.version }}.x nodistro main
    - key_url: https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key
    - aptkey: false
    - file: /etc/apt/sources.list.d/nodejs.list
    - require_in:
      - pkg: nodejs

  pkg.installed: []

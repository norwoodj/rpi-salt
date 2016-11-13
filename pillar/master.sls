salt:
  install_packages: False

  master:
    fileserver_backend:
      - git
      - roots
    gitfs_remotes:
      - git://github.com/norwoodj/rpi-salt.git
      - git://github.com/saltstack-formulas/salt-formula.git
      - git://github.com/saltstack-formulas/users-formula.git
    file_roots:
      base:
        - /srv/salt
    pillar_roots:
      base:
        - /srv/pillar

  minion:
    master: localhost

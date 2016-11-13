salt:
  master:
    fileserver_backend:
      - git
      - roots
    gitfs_remotes:
      - git://github.com/norwoodj/rpi-salt.git
    file_roots:
      base:
        - /srv/salt
    pillar_roots:
      base:
        - /srv/pillar
  minion:
    master: localhost

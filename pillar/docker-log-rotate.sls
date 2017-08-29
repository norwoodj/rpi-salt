logrotate:
  jobs:
    docker:
      path:
        - /var/lib/docker/containers/*/*.log
      config:
        - daily
        - compress
        - size 1M
        - rotate 7
        - missingok
        - delaycompress
        - copytruncate

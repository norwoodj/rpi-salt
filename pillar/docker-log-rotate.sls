logrotate:
  jobs:
    docker:
      path:
        - /var/lib/docker/containers/*/*.log
      config:
        - daily
        - compress
        - rotate 7
        - missingok
        - delaycompress
        - copytruncate

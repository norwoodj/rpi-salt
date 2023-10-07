rpi-loadbalancer:
  upstreams:
    bolas:
      address: http://unix:/run/bolas/bolas.sock;
      extra_locations: |-
        location /ws {
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "Upgrade";

            proxy_pass http://unix:/run/bolas/bolas.sock;
        }

    grafana:
      address: http://unix:/run/grafana/grafana.sock;
    hashbash:
      address: http://unix:/run/hashbash-nginx/nginx.sock;
    prometheus:
      address: http://prometheus:9090;
    rabbitmq:
      address: http://rabbitmq:15672;
    stupidchess:
      address: http://unix:/run/stupidchess-nginx/nginx.sock;

users:
  rpi-loadbalancer:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - bolas
      - grafana
      - nginx

tunnels:
  version: 2023.8.2

  instances:
    4ee6f69e-b202-4be9-825d-803b306c4e9a:
      private_network: true
      hostnames:
        bolas: unix:/run/bolas/bolas.sock
        hashbash: unix:/run/hashbash-nginx/nginx.sock
        stupidchess: unix:/run/stupidchess-nginx/nginx.sock

users:
  tunnel:
    createhome: false
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
    groups:
      - bolas

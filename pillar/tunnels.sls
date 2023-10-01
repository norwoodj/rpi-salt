tunnels:
  version: 2023.8.2

  instances:
    9a4c0fd4-c83d-47a6-b9da-386ce712fcf0:
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

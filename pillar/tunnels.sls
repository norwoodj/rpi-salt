tunnels:
  version: 2023.8.2

  instances:
    12d87c41-7480-4870-acf3-5e56fb14aa90:
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

base:
  '*':
    - zsh
    - users
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pirate
    - motd
    - nfs.client

  '*git*':
    - git-access

  '*nfs*':
    - nfs.server

  '*kb*':
    - kubernetes-install

  '*kbm*':
    - kubernetes-master

  '*kbw*':
    - kubernetes-worker

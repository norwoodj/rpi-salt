base:
  '*':
    - zsh
    - users
    - oh-my-zsh
    - openssh
    - openssh.config
    - remove-pirate
    - motd

  '*git*':
    - git
    - git-access

  '*kb*':
    - kubernetes-install

  '*kbm*':
    - kubernetes-master

  '*kbw*':
    - kubernetes-worker

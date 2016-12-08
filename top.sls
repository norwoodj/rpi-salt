base:
  '*':
    - zsh
    - users
    - openssh
    - openssh.config
    - remove-pirate
    - motd

  '*kb*':
    - kubernetes-install

  '*kbm*':
    - kubernetes-master

  '*kbw*':
    - kubernetes-worker

  '*git*':
    - git
    - git-access

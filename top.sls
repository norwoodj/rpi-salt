base:
  '*':
    - zsh
    - users
    - oh-my-zsh
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

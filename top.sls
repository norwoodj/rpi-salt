base:
  '*':
    - users
    - openssh
    - openssh.config
    - remove-pirate
    - motd
    - kubernetes-install # JUST FOR TESTING

  '*kb*':
    - kubernetes-install

  '*kbm*':
    - kubernetes-master

  '*kbw*':
    - kubernetes-worker

  # JUST FOR TESTING
  '*sma*':
    - kubernetes-worker
  '*smi*':
    - kubernetes-master

  '*git*':
    - git
    - git-access

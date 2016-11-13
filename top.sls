base:
  '*sma*':
    - salt.master
    - salt.minion

  '*smi*':
    - minion

  '*':
    - users.sudo
    - users

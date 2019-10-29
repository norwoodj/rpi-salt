# Much of the configuration here comes from this article: https://stribika.github.io/2015/01/04/secure-secure-shell.html
sshd_config:
  Protocol: 2
  Port: 22
  PrintMotd: yes

  ServerKeyBits: 4096
  PermitRootLogin: no

  HostKey:
    - /etc/ssh/ssh_host_ed25519_key
    - /etc/ssh/ssh_host_rsa_key

  PubkeyAuthentication: yes

  UsePAM: no
  ChallengeResponseAuthentication: no
  HostbasedAuthentication: no
  PasswordAuthentication: no
  KerberosAuthentication: no
  GSSAPIAuthentication: no

  ClientAliveInterval: 300
  ClientAliveCountMax: 0

  TCPKeepAlive: yes
  AllowGroups: ssh

  SyslogFacility: AUTH
  LogLevel: INFO

  AllowTcpForwarding: no
  StrictModes: yes
  VerifyReverseMapping: yes
  X11Forwarding: no
  GatewayPorts: no
  IgnoreRhosts: yes

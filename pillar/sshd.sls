# Much of the configuration here comes from this article: https://stribika.github.io/2015/01/04/secure-secure-shell.html
sshd_config:
  Protocol: 2
  Port: 22

  ServerKeyBits: 4096
  PermitRootLogin: no

  HostKey:
    - /etc/ssh/ssh_host_ed25519_key
    - /etc/ssh/ssh_host_rsa_key

  KexAlgorithms: curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
  Ciphers: chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
  MACs: hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com

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
  UsePrivilegeSeparation: yes
  StrictModes: yes
  VerifyReverseMapping: yes
  X11Forwarding: no
  GatewayPorts: no
  IgnoreRhosts: yes

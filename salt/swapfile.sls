swapfile:
  cmd.run:
    - name: |
        [ -f /.swapfile ] || dd if=/dev/zero of=/.swapfile bs=1M count={{ pillar.swapfile.size_MB }}
        chmod 0600 /.swapfile
        mkswap /.swapfile
        echo '/.swapfile      none      swap     sw       0       0' >> /etc/fstab
        swapon -a
    - creates: /.swapfile

install-rust:
  cmd.run:
    - name: |
        curl --proto "=https" --tlsv1.3 https://sh.rustup.rs -sSfo /tmp/rustup.sh
        chmod +x /tmp/rustup.sh
        /tmp/rustup.sh -y
    - creates: /home/veintitres/.cargo
    - runas: veintitres

/home/veintitres/.zshrc.d/rust-path:
  file.managed:
    - source:
        - "salt://files/home/veintitres/zshrc.d/rust-path"
    - user: veintitres
    - group: veintitres
    - mode: "0644"
    - makedirs: true

/usr/bin/cargo:
  file.symlink:
    - target: /home/veintitres/.cargo/bin/cargo

install-go:
  cmd.run:
    - name: |
        curl -sL https://go.dev/dl/go{{ pillar.go.version }}.linux-{{ grains.osarch }}.tar.gz -o /tmp/go.tar.gz
        tar -C /usr/local -xzf /tmp/go.tar.gz
    - creates: /usr/local/go

/home/veintitres/.zshrc.d/go-path:
  file.managed:
    - source:
        - "salt://files/home/veintitres/zshrc.d/go-path"
    - user: veintitres
    - group: veintitres
    - mode: "0644"
    - makedirs: true
    - template: jinja
    - defaults:
        username: veintitres

/usr/bin/go:
  file.symlink:
    - target: /usr/local/go/bin/go

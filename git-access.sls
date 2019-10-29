add-shell-commands:
  file.recurse:
    - name: '/home/git/git-shell-commands'
    - source: salt://files/git-shell-commands
    - user: git
    - group: git
    - file_mode: 0550

generate-key:
  cmd.run:
    - name: |
        ssh-keygen -t ecdsa -b 521 -f /home/veintitres/.ssh/rpi_git.id_ecdsa -q -N ""
        echo "changed=yes comment='Generated new ecdsa key for veintitres to push to git'"
    - runas: veintitres
    - creates: '/home/veintitres/.ssh/rpi_git.id_ecdsa'
    - stateful: True

add-key-to-git:
  cmd.run:
    - name: 'cat /home/veintitres/.ssh/rpi_git.id_ecdsa.pub >> /home/git/.ssh/authorized_keys'
    - onchanges:
        - cmd: generate-key

setup-ssh-config:
  file.managed:
    - name: '/home/veintitres/.ssh/config'
    - source: 'salt://files/ssh/config'
    - template: jinja
    - context:
        hostname: {{ grains['id'] }}

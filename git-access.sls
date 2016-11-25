generate-key:
  cmd.run:
    - name: |
        ssh-keygen -b 4096 -f /home/veintitres/.ssh/rpi_git.id_rsa -q -N ""
        echo "changed=yes comment='Generated new rsa key for veintitres to push to git'"
    - runas: veintitres
    - creates: '/home/veintitres/.ssh/rpi_git.id_rsa'
    - stateful: True

add-key-to-git:
  cmd.run:
    - name: 'cat /home/veintitres/.ssh/rpi_git.id_rsa.pub >> /home/git/.ssh/authorized_keys'
    - onchanges:
        - cmd: generate-key

setup-ssh-config:
  file.managed:
    - name: '/home/veintitres/.ssh/config'
    - source: 'salt://files/ssh/config'
    - template: jinja
    - context:
        hostname: {{ grains['id'] }}

{% for u in pillar['oh-my-zsh'].users %}

install-oh-my-zsh:
  cmd.run:
    - name: sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    - creates: /home/{{ u }}/.oh-my-zsh
    - runas: {{ u }}
    - env:
      - HOME: /home/{{ u }}

/home/{{ u }}/.zshrc:
  file.managed:
    - source:
      - "salt://files/home/veintitres/zshrc"
    - user: {{ u }}
    - group: {{ u }}
    - mode: "0644"

{% endfor %}

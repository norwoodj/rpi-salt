git:
  pkg.installed:
    - pkgs:
      - libssl-dev
      - libcurl4-openssl-dev
      - build-essential
      - autoconf
      - gettext

  cmd.script:
    - name: salt://files/scripts/install-git.sh
    - args: '{{ pillar['git']['version'] }}'
    - unless: |
        hash git || exit 1
        required_version="{{ pillar['git']['version'] }}"
        required_major=`echo ${required_version} | awk -F . '{ print $1 }'`
        required_minor=`echo ${required_version} | awk -F . '{ print $2 }'`

        current_version=`git --version | sed 's|git version \(.*\)|\1|g'`
        current_major=`echo ${current_version} | awk -F . '{ print $1 }'`
        current_minor=`echo ${current_version} | awk -F . '{ print $2 }'`

        [ ${current_major} -gt ${required_major} ] || [ ${current_major} -eq ${required_major} -a ${current_minor} -ge ${required_minor} ]

  environ.setenv:
    - name: HOME
    - value: /home/git

  git.config_set:
    - name: receive.denyCurrentBranch
    - value: updateInstead
    - user: git
    - global: True

  file.recurse:
    - name: '/home/git/git-shell-commands'
    - source: salt://files/git-shell-commands
    - user: git
    - group: git
    - file_mode: 0550

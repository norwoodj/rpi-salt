git:
  pkg.installed:
    - pkgs:
      - libssl-dev
      - build-essential
      - autoconf
      - gettext

  cmd.script:
    - name: salt://files/scripts/install-git.sh
    - args: '{{ pillar['git']['version'] }}'
    - unless: |
        version=`git --version | sed 's|git version \(.*\)|\1|g'`
        major=`echo ${version} | awk -F . '{ print $1 }'`
        minor=`echo ${version} | awk -F . '{ print $2 }'`
        [ ${major} -gt 2 ] || [ ${minor} -gt 9 ]

  environ.setenv:
    - name: HOME
    - value: /home/git

  git.config_set:
    - name: receive.denyCurrentBranch
    - value: updateInstead
    - user: git
    - global: True

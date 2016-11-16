kubernetes-package-repo:
  pkgrepo.managed:
    - humanname: Kubernetes
    - name: 'deb http://apt.kubernetes.io/ kubernetes-xenial main'
    - file: /etc/apt/sources.list.d/kubernetes.list
    - gpgcheck: 1
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

kubernetes-packages-installed:
  pkg.installed:
    - pkgs:
        - kubeadm
        - kubectl
        - kubelet
        - kubernetes-cni

kubernetes-master-running:
  cmd.run:
    - name: 'kubeadm init'

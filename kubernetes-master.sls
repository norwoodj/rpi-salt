{% if pillar['kubernetes'] is defined and pillar.get('kubernetes', {})['token'] is defined %}
    {% set command = (
        'kubeadm init ' ~
        '  --api-external-dns-names=' ~ pillar['kubernetes']['cluster_extra_hostname'] ~
        '  --pod-network-cidr=10.244.0.0/16' ~
        '  --token=' ~ pillar['kubernetes']['token'] ~ ' ' ~
        '&& export ARCH=arm ' ~
        '&& curl -sSL "https://github.com/coreos/flannel/blob/master/Documentation/kube-flannel.yml?raw=true" | sed "s/amd64/${ARCH}/g" | kubectl create -f - ' ~
        '&& echo "changed=yes comment=\'Started Kubernetes Master\'"'
    )%}
{% else %}
    {% set command = 'echo "pillar[\'kubernetes\'][\'token\'] must be defined to initialize kubernetes master" && exit 1' %}
{% endif %}

kubernetes-master-running:
  cmd.run:
    - name: {{ command }}
    - unless: 'docker ps | grep kube'
    - stateful: True

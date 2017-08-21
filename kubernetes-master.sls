{% if pillar['kubernetes'] is defined and pillar.get('kubernetes', {})['token'] is defined %}
    {% set command = (
        'kubeadm init ' ~
        '  --apiserver-cert-extra-sans=' ~ pillar['kubernetes']['cluster_extra_hostnames'] | join(',') ~
        '  --pod-network-cidr=10.244.0.0/16' ~
        '  --token=' ~ pillar['kubernetes']['token'] ~ ' ' ~
        '&& curl -S "https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml" | sed "s|amd64|arm|g" | kubectl apply -f - ' ~
        '&& curl -S "https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml" | sed "s|amd64|arm|g" | kubectl apply -f -'
    )%}
{% else %}
    {% set command = 'echo "pillar[\'kubernetes\'][\'token\'] must be defined to initialize kubernetes master" && exit 1' %}
{% endif %}

kubernetes-master-running:
  cmd.run:
    - name: {{ command }}
    - unless: 'docker ps | grep kube'
    - stateful: True

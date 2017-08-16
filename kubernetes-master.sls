{% if pillar['kubernetes'] is defined and pillar.get('kubernetes', {})['token'] is defined %}
    {% set command = (
        'kubeadm init ' ~
        '  --apiserver-cert-extra-sans=' ~ pillar['kubernetes']['cluster_extra_hostnames'] | join(',') ~
        '  --token=' ~ pillar['kubernetes']['token'] ~ ' ' ~
        '&& export kubever=$(kubectl version | base64 | tr -d "\\n") ' ~
        '&& kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=${kubever}"'
    )%}
{% else %}
    {% set command = 'echo "pillar[\'kubernetes\'][\'token\'] must be defined to initialize kubernetes master" && exit 1' %}
{% endif %}

kubernetes-master-running:
  cmd.run:
    - name: {{ command }}
    - unless: 'docker ps | grep kube'
    - stateful: True

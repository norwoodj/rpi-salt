{% if pillar['kubernetes'] is defined and pillar.get('kubernetes', {})['token'] is defined %}
    {% set command = 'kubeadm join --token=' ~ pillar['kubernetes']['token'] ~ ' kubernetes' %}
{% else %}
    {% set command = 'echo "pillar[\'kubernetes\'][\'token\'] must be defined to initialize kubernetes worker" && exit 1' %}
{% endif %}

kubernetes-worker-running:
  cmd.run:
    - name: {{ command }}
    - unless: 'docker ps | grep kube'

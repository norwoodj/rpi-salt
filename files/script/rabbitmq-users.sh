#!/usr/bin/env bash

rabbitmqctl add_user mqadmin '{{ admin_password }}'
rabbitmqctl set_user_tags mqadmin administrator

{% for v, users in vhosts.items() %}
rabbitmqctl add_vhost '{{ v }}'

  {% for u in users %}
rabbitmqctl add_user '{{ u["username"] }}' '{{ u["password"] }}'
rabbitmqctl set_permissions -p '{{ v }}' '{{ u["username"] }}' ".*" ".*" ".*"
rabbitmqctl set_user_tags '{{ u["username"] }}' management
  {% endfor %}
{% endfor %}

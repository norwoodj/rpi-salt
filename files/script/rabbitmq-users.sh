#!/usr/bin/env bash

rabbitmqctl add_user mqadmin '{{ admin_password }}'
rabbitmqctl set_user_tags mqadmin administrator

{% for v, users in vhosts.items() %}
rabbitmqctl add_vhost '{{ v }}'

  {% for username, password in users.items() %}
rabbitmqctl add_user '{{ username }}' '{{ password }}'
rabbitmqctl set_permissions -p '{{ v }}' '{{ username }}' ".*" ".*" ".*"
rabbitmqctl set_user_tags '{{ username }}' management
  {% endfor %}
{% endfor %}

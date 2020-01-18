{% for u in app_users %}

CREATE DATABASE {{ u["database"] }};

CREATE USER "{{ u['username'] }}" WITH PASSWORD '{{ u["password"] }}';

GRANT ALL ON DATABASE {{ u["database"] }} TO "{{ u['username'] }}";

{% endfor %}

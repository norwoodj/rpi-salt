{% for db, config in databases.items() %}

CREATE DATABASE {{ db }};

  {% for username, password in config.rw_users.items() %}

CREATE USER "{{ username }}" WITH PASSWORD '{{ password }}';

GRANT ALL ON DATABASE {{ db }} TO "{{ username }}";

\c {{ db }}
GRANT ALL ON SCHEMA public TO "{{ username }}";

  {% endfor %}
{% endfor %}

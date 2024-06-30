{% for username, config in app_users.items() %}

CREATE DATABASE {{ config["database"] }};

CREATE USER "{{ username }}" WITH PASSWORD '{{ config["password"] }}';

GRANT ALL ON DATABASE {{ config["database"] }} TO "{{ username }}";

{% endfor %}

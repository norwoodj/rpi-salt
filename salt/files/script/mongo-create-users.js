{% for username, user_config in users.items() -%}
db = db.getSiblingDB("{{ user_config.database }}");

if (db.getUser("{{ username }}") == null) {
	db.createUser({
		user: "{{ username }}",
		pwd: "{{ user_config.password }}",
		roles: [
			{ role: "readWrite", db: "{{ user_config.database }}" }
		]
	});
} else {
	print("User {{ username }} already exists");
}

{% endfor %}

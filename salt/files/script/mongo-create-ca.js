db.createUser({
	user: "{{ ca_username }}",
	pwd: "{{ ca_password }}",
	roles: ["root"],
});

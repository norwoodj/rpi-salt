db.createUser({
	user: "{{ ca_username }}",
	pwd: "{{ ca_password }}",
	roles: [
		"dbAdminAnyDatabase",
		"readWriteAnyDatabase",
		"userAdminAnyDatabase",
	]
});

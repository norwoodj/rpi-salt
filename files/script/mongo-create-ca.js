db.createUser({
	user: "admin",
	pwd: "{{ ca_password }}",
	roles: [
		"dbAdminAnyDatabase",
		"readWriteAnyDatabase",
		"userAdminAnyDatabase",
	]
});

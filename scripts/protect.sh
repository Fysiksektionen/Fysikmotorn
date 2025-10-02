cd ..

# To protect from writing: Everyone can read (and possibly execute), only root and write
TO_WRITE_PROTECT=(
	# Scripts that are used in project-ops, and thus should not be modified by non-root users
	"scripts/gather_envs.sh"
	"scripts/start_docker.sh"
	"project-ops/exec.sh"
	"project-ops/logs.sh"
	"project-ops/start.sh"
	"project-ops/stop.sh"
)

# To protect fully: Only root can read, write and execute
TO_PROTECT=(
	# Sensetive service files
	"services/certbot/conf"

	"services/kons-count/server/service_account_auth_file.json"

	"services/f.kth.se/.env"
	"services/fysikalen.se/.env"
	"services/ffusion.se/.env"
	"services/fadderiet/.env"

	"services/f.kth.se/mariadb"
	"services/fysikalen.se/mariadb"
	"services/ffusion.se/mariadb"
	"services/fadderiet/mariadb"

	"services/cyberfohs/secretkey.txt"
	"services/cyberfohs/data"

	"services/bittan_test/bittan_test_postgres.env"
	"services/bittan_test/bittan_test_server.env"
	"services/bittan_test/postgres_data"
	"services/bittan_test/swish_certificates"
	"services/bittan_test/gmail_creds"

	"services/bittan_marke/bittan_marke_postgres.env"
	"services/bittan_marke/bittan_marke_server.env"
	"services/bittan_marke/postgres_data"
	"services/bittan_marke/swish_certificates"
	"services/bittan_marke/gmail_creds"
	"services/bittan_marke/logs"

	"services/bittan_fysikalen/bittan_fysikalen_postgres.env"
	"services/bittan_fysikalen/bittan_fysikalen_server.env"
	"services/bittan_fysikalen/postgres_data"
	"services/bittan_fysikalen/swish_certificates"
	"services/bittan_fysikalen/gmail_creds"
	"services/bittan_fysikalen/logs"
);

chmod o-w,o+r "${TO_WRITE_PROTECT[@]}"
chown root:root "${TO_WRITE_PROTECT[@]}"

chmod o-rwx "${TO_PROTECT[@]}"
chown root:root "${TO_PROTECT[@]}"

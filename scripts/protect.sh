cd ..

TO_PROTECT=(
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
);

chmod o-rwx "${TO_PROTECT[@]}"

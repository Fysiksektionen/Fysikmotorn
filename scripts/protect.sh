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
);

chmod o-rwx $TO_PROTECT

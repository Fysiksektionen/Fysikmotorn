source ./backup.sh
cd ..

FILES=( services/bittan_marke/bittan_marke_postgres.env services/bittan_marke/bittan_marke_server.env services/bittan_marke/postgres_data services/bittan_marke/swish_certificates services/bittan_marke/gmail_creds )
NAME="bittan_marke"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/bittan_marke/bittan_marke_postgres.env services/bittan_marke/bittan_marke_server.env services/bittan_marke/postgres_data services/bittan_marke/swish_certificates services/bittan_marke/gmail_creds
	;;
	*) echo "Did not choose option"; exit 1;;
esac;


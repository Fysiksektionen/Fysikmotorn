source ./backup.sh
cd ..

FILES=( services/bittan_fysikalen/bittan_fysikalen_postgres.env services/bittan_fysikalen/bittan_fysikalen_server.env services/bittan_fysikalen/postgres_data services/bittan_fysikalen/swish_certificates services/bittan_fysikalen/gmail_creds services/bittan_fysikalen/logs )
NAME="bittan_fysikalen"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/bittan_fysikalen/bittan_fysikalen_postgres.env services/bittan_fysikalen/bittan_fysikalen_server.env services/bittan_fysikalen/postgres_data services/bittan_fysikalen/swish_certificates services/bittan_fysikalen/gmail_creds services/bittan_fysikalen/logs
	;;
	*) echo "Did not choose option"; exit 1;;
esac;


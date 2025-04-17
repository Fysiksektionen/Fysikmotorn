source ./backup.sh
cd ..

FILES=( services/bittan_fysikalen/bittan_fysikalen_postgres.env services/bittan_fysikalen/bittan_fysikalen_server.env services/bittan_fysikalen/postgres_data services/bittan_fysikalen/swish_certificates services/bittan_fysikalen/gmail_creds services/bittan_fysikalen/logs )
NAME="bittan_fysikalen"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chmod -R o-rwx services/bittan_fysikalen/bittan_fysikalen_postgres.env services/bittan_fysikalen/bittan_fysikalen_server.env services/bittan_fysikalen/postgres_data services/bittan_fysikalen/swish_certificates services/bittan_fysikalen/gmail_creds services/bittan_fysikalen/logs
				chown root:root services/bittan_fysikalen/bittan_fysikalen_postgres.env services/bittan_fysikalen/bittan_fysikalen_server.env services/bittan_fysikalen/postgres_data services/bittan_fysikalen/swish_certificates services/bittan_fysikalen/gmail_creds services/bittan_fysikalen/logs
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;


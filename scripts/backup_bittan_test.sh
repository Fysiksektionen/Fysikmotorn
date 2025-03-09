source ./backup.sh
cd ..

FILES=( services/bittan_test/bittan_test_postgres.env services/bittan_test/bittan_test_server.env services/bittan_test/postgres_data services/bittan_test/swish_certificates services/bittan_test/gmail_creds )
NAME="bittan_test"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/bittan_test/bittan_test_postgres.env services/bittan_test/bittan_test_server.env services/bittan_test/postgres_data services/bittan_test/swish_certificates services/bittan_test/gmail_creds
	;;
	*) echo "Did not choose option"; exit 1;;
esac;


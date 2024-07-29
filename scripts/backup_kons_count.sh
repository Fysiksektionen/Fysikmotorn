source ./backup.sh
cd ..

FILES=( services/kons-count/redis/dump.rdb services/kons-count/server )
NAME="kons-count"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/kons-count/server/service_account_auth_file.json
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

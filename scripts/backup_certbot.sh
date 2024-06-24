source ./backup.sh
cd ..

FILES=( services/certbot/conf )
NAME="certbot"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R 600 $FILES
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

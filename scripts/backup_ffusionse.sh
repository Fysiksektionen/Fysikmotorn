source ./backup.sh
cd ..

FILES=( services/ffusion.se/mariadb services/ffusion.se/wordpress services/ffusion.se/.env )
NAME="ffusion.se"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/ffusion.se/mariadb services/ffusion.se/.env
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

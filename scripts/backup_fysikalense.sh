source ./backup.sh
cd ..

FILES=( services/fysikalen.se/mariadb services/fysikalen.se/wordpress services/fysikalen.se/.env )
NAME="fysikalen.se"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/fysikalen.se/mariadb services/fysikalen.se/.env
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

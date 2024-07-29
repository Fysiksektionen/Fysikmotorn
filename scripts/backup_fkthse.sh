source ./backup.sh
cd ..

FILES=( services/f.kth.se/mariadb services/f.kth.se/wordpress services/f.kth.se/.env )
NAME="f.kth.se"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/f.kth.se/mariadb services/f.kth.se/.env
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

source ./backup.sh
cd ..

FILES=( services/fadderiet/mariadb services/fadderiet/wordpress services/fadderiet/.env )
NAME="fadderiet"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R 770 services/fadderiet/mariadb services/fadderiet/.env
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

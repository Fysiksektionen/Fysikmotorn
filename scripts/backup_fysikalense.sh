source ./backup.sh
cd ..

FILES=( services/fysikalen.se/mariadb services/fysikalen.se/wordpress services/fysikalen.se/.env )
NAME="fysikalen.se"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chmod -R o-rwx services/fysikalen.se/mariadb services/fysikalen.se/.env
				chown root:root services/fysikalen.se/mariadb services/fysikalen.se/.env
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

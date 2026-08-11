source ./backup.sh
cd ..

FILES=( services/nyHemsida/mariadb services/nyHemsida/wordpress services/nyHemsida/.env )
NAME="nyHemsida"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chmod -R o-rwx services/nyHemsida/mariadb services/nyHemsida/.env
				chown root:root services/nyHemsida/mariadb services/nyHemsida/.env
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

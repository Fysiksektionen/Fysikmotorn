source ./backup.sh
cd ..

FILES=( services/f.kth.se/mariadb services/f.kth.se/wordpress services/f.kth.se/.env )
NAME="f.kth.se"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chmod -R o-rwx services/f.kth.se/mariadb services/f.kth.se/.env
				chown root:root services/f.kth.se/mariadb services/f.kth.se/.env
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

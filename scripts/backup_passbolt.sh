source ./backup.sh
cd ..

FILES=( services/passbolt/mariadb services/passbolt/gpg services/passbolt/jwt services/passbolt/images services/passbolt/.env )
NAME="passbolt"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chown -R root:root services/passbolt/.env services/passbolt/gpg services/passbolt/jwt services/passbolt/mariadb
				chmod -R o-rwx services/passbolt/.env services/passbolt/gpg services/passbolt/jwt services/passbolt/mariadb
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

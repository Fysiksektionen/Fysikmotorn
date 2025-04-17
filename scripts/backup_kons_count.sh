source ./backup.sh
cd ..

FILES=( services/kons-count/redis/dump.rdb services/kons-count/server )
NAME="kons-count"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chmod -R o-rwx services/kons-count/server/service_account_auth_file.json
				chown root:root services/kons-count/server/service_account_auth_file.json
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

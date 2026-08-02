#!/bin/bash
cd /Fysikmotorn/scripts/
source ./backup.sh
cd ..

FILES=( services/fn-crm/fn-crm-twenty-db-data services/fn-crm/fn-crm-twenty-server-local-data )
NAME="fn-crm"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		read -p "Do you really want to download a backup? This will remove current data. (y/n): " confirmation
		case $confirmation in
			y|yes)
				download_backup $NAME:$2 ${FILES[@]}
				chown 1000:1000 services/fn-crm/fn-crm-twenty-*
				chgrp fncrm services/fn-crm/fn-crm-twenty-*
			;;
			n|no)
				echo "Aborting."; exit 1;;
			*)
				echo "Invalid choice. Aborting."; exit 1;;
		esac
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

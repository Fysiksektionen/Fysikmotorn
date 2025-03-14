source ./backup.sh
cd ..

FILES=( services/cyberfohs/data services/cyberfohs/secretkey.txt services/cyberfohs/media )
NAME="cyberfohs"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
		chmod -R o-rwx services/cyberfohs/secretkey.txt services/cyberfohs/data
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

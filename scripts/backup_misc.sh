source ./backup.sh
cd ..

FILES=( services/misc/GoogleIDPMetadata.xml services/misc/f.png services/misc/logo.png services/misc/robots.txt )
NAME="misc"

case $1 in
	upload|u)
		upload_backup $NAME ${FILES[@]}
	;;
	download|d)
		download_backup $NAME:$2 ${FILES[@]}
	;;
	*) echo "Did not choose option"; exit 1;;
esac;

source ./backup.sh
cd ..

FILES=( services/google/GoogleIDPMetadata.xml )
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

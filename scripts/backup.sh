function upload_backup {
	local backup="$1:$(date "+%Y-%m-%d-%H-%M-%S")".tar.gz
	shift

	# echo "Archiving files"
	tar -czf /tmp/$backup $@ .env compose.yaml services/nginx/nginx.conf

	# echo "Uploading"
	rclone copyto -P /tmp/$backup Drive:$backup

	rm /tmp/$backup
}

function download_backup {
	if (echo $1 | grep -q ":." ); then
		local backup="$1.tar.gz"
	else
		local backup=$(rclone lsf Drive: | grep "^$1" | sort -r | head -n 1)

		if [ $backup == "" ]; then echo "No backup available"; exit 1; fi;
	fi;

	shift

	# echo "Removing old files"
	rm -r $@

	# echo "Downloading"
	rclone copyto -P Drive:$backup /tmp/$backup

	# echo "Extracting files"
	tar -xf /tmp/$backup $@

	rm /tmp/$backup
}

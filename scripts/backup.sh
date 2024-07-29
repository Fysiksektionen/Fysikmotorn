#! /bin/zsh

# This script manages backups of different datafiles and similar for the services. The files are backed up to chapters google drive using rclone (with the drive folder configured as "Drive")
#
# The parameters of the functions are:
# 	$1: The name of the service, used to label the backup. If a specific backup version is specified it will be downloaded, otherwise the latest available one will be used.
# 	$@: All following parameters are files that will be backed up
#
# The backup functions should always be used with the project root as working directory, as in the backup scripts.
#
# Note that the files mentioned in the parameters will be deleted when restoring the backup. Also note that symlinks are not followed by the archive or rm and the data through is threfore not neccesarily backed up, and the links the archive creates may not be valid on other machines.

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

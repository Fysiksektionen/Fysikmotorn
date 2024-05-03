function share_dir {
	local SHARED_GROUP=$1

	shift

	# Set sticky bit, so group is inherited from directory and not from user
	sudo chmod -R g+s $@

	# Change current permissions to be the same between user and group
	sudo chmod -R g=u $@

	# Change the group ownership to the correct group
	sudo chown -RH :$SHARED_GROUP $@
}

if test "$#" -ne 0; then
	share_dir $@
fi;

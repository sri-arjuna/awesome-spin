#!/bin/bash
#
# 	Make self sustainable:
#	* prepare skel
#	* prepare symlink
#	* sed scripts
#
	# S for search
	S="/home/sea/prjs/iso-awesome-sea"
	R="/root/spin_files"
	ln -s $R/make-iso /usr/bin/make-awesomewm
	cd $R
	echo "Prepare files in $R"
	for f in *;do
		echo "* $f"
		sleep 1
		grep "$S" $f && sed s,"$S","$R",g -i $f
	done

#!/bin/bash
#
# 	Make self sustainable:
#	* prepare skel
#	* prepare symlink
#	* sed scripts
#
	# S for search, since sea created them in the first place, I have to look for me ;)
	S="/home/sea/prjs/iso-awesome-sea"
	R="/root/spin_files"
	ln -s $R/make-iso.sh /usr/bin/make-awesomewm
	cd $R/ks
	echo "Prepare files in $R"
	for f in *;do
		echo "* $f"
		sleep 1
		grep "$S" $f && sed s,"$S","$R",g -i $f
	done

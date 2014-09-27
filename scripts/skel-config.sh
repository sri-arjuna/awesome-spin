#!/bin/bash
#
#	Copy fixed template
#
	cd /root/spin_files/skel
#	rm -f /etc/skel/.bashrc
	cp -fr *		/etc/skel
	cp -fr .[a-zA-Z]*	/etc/skel
	ln -sf /root/spin_files/make-iso.sh	/usr/bin/make-awesomewm
# The 'cd' is required for the other scripts to work
	cd ..

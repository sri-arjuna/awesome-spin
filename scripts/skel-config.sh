#!/bin/bash
#
#	Copy fixed template
#
	cd /root/spin_files/skel
	rm -f /etc/skel/.bashrc
	cp -fr *		/etc/skel
	cp -fr .[a-zA-Z]*	/etc/skel
#	cd .config
#6	cp -fr *		/etc/skel/.config

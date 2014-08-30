#!/bin/bash
#
#	Do install tui, so reporting is more visible
#
	echo
	echo "post2-chroot.ks"
#	echo ; sleep 3
#	sh -T /tmp/tui/install.sh <<EOF

#EOF
#
#	Sutra
#
	ln -s /usr/share/sutra/sutra /usr/bin/sutra
#
#	Scripts in bin
#
	cd /root/spin_files/scripts/bin
	cp * /usr/bin

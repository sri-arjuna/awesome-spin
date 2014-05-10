#!/bin/bash
#
#	Variables
#
	home=/home/sea
	CFG=$home/prjs/iso-awesome-sea/awesome.ks
	usr=${home##*/}
	TITLE="Sea's Awesome WM"
	FSLABEL=sea_awesome_wm
	RELEASEVER=rawhide
	TMPDIR=/mnt/$FSLABEL
	VERBOSE="-v"
#
#	Action
#
	cd $home
	time livecd-creator -c "$CFG" -t "$TITLE" -f $FSLABEL --releasever=$RELEASEVER --tmpdir="$TMPDIR" $VERBOSE
	RET=$?
	echo
	ls -lh --color=auto *iso && chown $usr:$usr *.iso
	echo
	cd "$OLDPWD"
	exit $RET

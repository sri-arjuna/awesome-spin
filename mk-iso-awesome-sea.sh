#!/bin/bash
#
#	Variables
#
	home=/home/sea
	CFG=$home/prjs/iso-awesome-sea/awesome.ks
	usr=${home##*/}
	TITLE="AwesomeWM by sea"
	FSLABEL=sea_awesome_wm
	RELEASEVER=rawhide
	TMPDIR=/mnt/$FSLABEL
	VERBOSE="-v"
#
#	Pre-clean temp dir
#
	[[ -d $TMPDIR ]] || mkdir -p $TMPDIR
	cd $TMPDIR
	if [ ! "" = "$(ls)" ]
	then	[ ! $(pwd) = "$TMPDIR" ] && echo "Wrong path" && exit 1
		echo "Cleaning up: $TMPDIR"
		umount $(find -type d)
		rm -fr * || exit 1
	fi
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

#!/bin/bash
#
#
#
	[[ ! 0 -eq $UID ]] && printf "$0 requires root access!\n" && exit 1
#
#	Get required apps
#
	which livecd-creator 2>/dev/zero 1>/dev/zero || \
		(printf "Installing required applications, please wait...\n";yum -q -y install livecd-tools spin-kickstarts)
#
#	Variables Fixed (external)
#
	. ./make-iso.conf
	usr=${home##*/}
	CFG=$SRC_DIR/$prj.ks
	if $make32
	then	pre="setarch i686"
		ARCH=32
	else	pre=""
		ARCH=64
	fi
#
#	Variables Dynamic
#
	[[ -z $1 ]] && \
		RELEASEVER=rawhide || \
		RELEASEVER=$1
	[[ $RELEASEVER = rawhide ]] && \
		CFG=${CFG/$prj.ks/$prj-rawhide.ks}
	FSLABEL=${DISTRO}_${RELEASEVER}_$prj_$ARCH
	TITLE="$DISTRO $RELEASEVER ($prj) by $usr"
	TMPDIR=/mnt/$FSLABEL
	VERBOSE="-v"
	printf "$TMPDIR" > /tmp/make-iso.tmp
	printf "$home"	 > /tmp/make-iso.home
	printf "$prjs"	 > /tmp/make-iso.prj
#
#	Pre-clean temp dir
#
	[[ -d "$TMPDIR" ]] || mkdir -p "$TMPDIR"
	cd "$TMPDIR"
	if [ ! "" = "$(ls)" ]
	then	[ ! $(pwd) = "$TMPDIR" ] && echo "Wrong path" && exit 1
		echo "Cleaning up: $TMPDIR"
		umount $(find -type d)
		rm -fr * || exit 1
	fi
#
#	Action
#
	clear
	
	printf "\n\n\tStart building \"$TITLE\"...\n\n"
	sleep 2
	cd "$SRC_DIR"
	
	
	time $pre livecd-creator -c "$CFG" -t "$TITLE" -f "$FSLABEL" --releasever=$RELEASEVER --tmpdir="$TMPDIR$ARCH" $VERBOSE
	RET=$?
	
	printf "\n\n"
	if [[ 0 -eq $RET ]]
	then 	mv "$FSLABEL.iso" "$home/"
		cd "$home"
		pwd
		chown $usr:$usr $FSLABEL.iso
		ls -lh --color=auto $FSLABEL.iso
	else	printf "Building of \"$TITLE\" failed.\n"
	fi
	printf "\n\n"
	cd "$OLDPWD"
	exit $RET

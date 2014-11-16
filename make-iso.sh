#!/bin/bash
#
#
#
	[[ ! 0 -eq $UID ]] && printf "$0 requires root access!\n" && exit 1
#
#	Get required apps
#
	which livecd-creator 2>/dev/zero 1>/dev/zero || \
		(printf "Installing required applications, please wait...\n";yum -q -y install livecd-tools spin-kickstarts git)
#
#	Variables Fixed (external)
#
	ofs="$IFS"
	IFS="\\$(printf '\076')"
	tDIR=$(ls -l "$0" | while read tmp link;do printf $(dirname "${link:1}");done)
#echo $tDIR
#exit
	. $tDIR/make-iso.conf
	. /etc/os-release 

	usr=${home##*/}
	CFG=$SRC_DIR/$prj.ks
	[[ x86_64 = $(uname -m) ]] && \
		ARCH=64 || \
		ARCH=32
	fs_string=$(uname -r)
	$make32 && \
		pre="time setarch linux32" && \
		[[ $ARCH = x86_64 ]] && \
		fs_string=${fs_string/$ARCH/i686} || \
		pre="time"
#
#	Variables Dynamic
#
	[[ -z $1 ]] && \
		RELEASEVER=$VERSION_ID || \
		RELEASEVER=$1
	[[ $RELEASEVER = rawhide ]] && \
		CFG=${CFG/$prj.ks/$prj-rawhide.ks}
	FSLABEL="AwesomeWM-$fs_string"
	TITLE="AwesomeWM-Spin (${RELEASEVER}/${ARCH}bit)"
	TMPDIR=/mnt/$FSLABEL
	VERBOSE="-v"

#
#	Pre-clean temp dir
#
	[[ -d "$TMPDIR" ]] || mkdir -p "$TMPDIR"
	cd "$TMPDIR"
	if [ ! "" = "$(ls)" ]
	then	[ ! $(pwd) = "$TMPDIR" ] && echo "Wrong path :: $(pwd)" && exit 1
		echo "Cleaning up: $TMPDIR"
		umount $(find -type d)
		rm -fr * || exit 1
	fi
#
#	Action
#
	clear
	
	printf "\n\n\tStart building \"$TITLE\"...\n\n"
	sleep 1.5
	cd "$SRC_DIR"
	
#	if $make32 && [ x86_64 = "" ] 
#	then	#setarch linux32
		#echo "---- $(uname -a)"
		#time setarch linux32 livecd-creator -c "$CFG" -t "$TITLE" -f "$FSLABEL" --releasever=$RELEASEVER --tmpdir="$TMPDIR" $VERBOSE
		cmd="$pre livecd-creator -c \"$CFG\" -t \"$TITLE\" -f \"$FSLABEL\" --releasever=$RELEASEVER --tmpdir=\"$TMPDIR\" $VERBOSE"
		#echo	$cmd
		#exit
		eval $cmd
		RET=$?
		#echo;	; exit
		#setarch linux64
		#echo "---- $(uname -a)"
#	else	time livecd-creator -c "$CFG" -t "$TITLE" -f "$FSLABEL" --releasever=$RELEASEVER --tmpdir="$TMPDIR" $VERBOSE
#		RET=$?
#	fi
	
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

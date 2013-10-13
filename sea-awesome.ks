# sea-awesome.ks
# Personalisierte Version des Fedora-LiveCD-Awesome
#
#
#	Region
#
	lang de_CH.UTF-8
	keyboard sg
	timezone Europe/Zurich
#
#	System
#
	auth --useshadow --enablemd5
	selinux --enforcing
	firewall --enabled --service=mdns
	xconfig --startxonboot
	part iso --size 2048
	part /boot --size 2048 --fstype ext4
	part / --size 16192 --fstype ext4
	part /home --size 131072 --fstype ext4
	part swap --size 16192 --fstype swap
#
#	Additional Repo's
#
	repo --name=sea --baseurl=http://sea.fedorapeople.org/repo
#
#	Include 'awesome-spin-template'
#
	%include /usr/share/spin-kickstarts/fedora-livecd-lxde.ks
#
#	Custom: Packages
#
%packages
	#
	#	Image-priorities
	#
	vicious
	tui
	script-tools*
	grub2-circled-*
	#
	#	Missing
	#
	acpi
	#
	#	Removals
	#
	-libqzeitgeist
	-irda-utils
	-xorg-x11-drv-nouveau
	-xorg-x11-drv-ati
	-xorg-x11-drv-wacom
	-w*fonts
	-@input-methods
	-ibus*
	-im-chooser
	-imsettings
	#-m317n-contrib
	-@printing
	#-atmel-firmware
	-b43-*
%end
#
#	Custom : no chroot
#
%post --nochroot
#!/bin/sh
	# Copy requires kickstarts files to build's /root
	alert() { echo -e "\n\n\t$1\n\t-------------\n\n";}
		home=$HOME
	dir_target=$(ls -d /var/tmp/img*|awk '{print $1}')
	umask 022 $dir_target
	dir_target="$dir_target/install_root/root"
	dir_src="$(ls $home/*awe*ks)"
	[[ ! -d $dir_target ]] && mkdir -p $dir_target
	cp $dir_src $dir_target
	alert: "kickstartfile	-->	cp $dir_src $dir_target"
%end
#
#	Custom : post
#
%post
#!/bin/sh
	alert() { echo -e "\n\n\t$1\n\t-------------\n\n";}
	
	theme=/usr/share/grub/themes/circled-nasa-horizon/theme.txt
	[[ " = "$(grep GRUB_THEME)" ]] && \
		echo "GRUG_THEME=\"$theme\"" >> /etc/default/grub || \
		sed s,"$(grep GRUB_THEME)","GRUB_THEME=\"$theme\"",g -i /etc/default/grub
	
	alert "Rebuild grub2"
	grub2-mkconfig -o /boot/grub2/grub.cfg
	alert "Rebuild plymouth"
	plymouth-set-default-theme solar -R
	
	alert "TRY : Hardcoded /etc/skel/.config/user-dirs.dirs"
	mkdir /etc/skel ; cd /etc/skel
	mkdir -p net/{dls,pub,web,fas/scm} \
		.priv/{notepad,templates,docs,cloud,prjs} \
		media/{img,snd,vids}
	cat > /etc/skel/.config/user-dirs.dirs << EOF
#\$HOME/.config/user-dirs.dirs
XDG_DESKTOP_DIR="\$HOME/.priv/notepad"
XDG_DOWNLOAD_DIR="\$HOME/net/dls"
XDG_PUBLICSHARE_DIR="\$HOME/net/pub"
XDG_MUSIC_DIR="\$HOME/media/snd"
XDG_PICTURES_DIR="\$HOME/media/img"
XDG_VIDEOS_DIR="\$HOME/media/vids"
XDG_TEMPLATES_DIR="\$HOME/.priv/templates"
XDG_DOCUMENTS_DIR="\$HOME/.priv/docs"
XDG_CLOUD_DIR="\$HOME/.priv/cloud"
XDG_PROJECTS_DIR="\$HOME/.priv/prjs"
XDG_WEB_DIR="\$HOME/net/web"
XDG_FAS_DIR="\$HOME/net/fas"
XDG_SCM_DIR="\$HOME/net/fas/scm"
EOF


























	cat > /etc/skel/.prompt-colored-status.sh << EOF
#!/bin/bash
#
#	Variables
#
	export esc="\033"
	export reset="${esc}[0m"
	export whitebg="${esc}[47m"
	export whitefont="${esc}[37m"
	export blackbg="${esc}[40m"
	export redfont="${esc}[31m"
	export redbg="${esc}[41m"
	export bluefont="${esc}[34m"
	export greenbg="${esc}[42m"
	export greenfont="${esc}[32m"
	export PROMPT_COMMAND='RET=$?;'
	export RET_VALUE='$(echo $RET)'
#
#	Color
#
	return_user_color() {
	# Returns white background and red font for root
	# Returns white background and blue font for users
		[ 0 -eq $UID ] && echo "${whitebg}${redfont}" || echo "${whitebg}${bluefont}"
	}
	rnd() { # MAX [ MIN=0 ]
	# Returns a random number up to MAX, 
	# or if provided, between MIN and MAX.
		[ -z $1 ] && echo "Usage: rnd MAXNUMBER [MINVALUE]" && \
				return 1 || max=$1
		[ -z $2 ] && min=0 || min=$2
		rnd=$RANDOM

		while [ $rnd -gt $max ] && [ ! $rnd -lt $min ]; do rnd=$(($RANDOM*$max/$RANDOM)) ; done
		echo $rnd
	}
	return_status_string() { # $?
	# returns random strings depending on provided numberic argument
	# expect either 0 or 1, outputs number only otherwise
		good=('+' ':)' '✔' )
		bad=('-' ':(' '✘' )
		num=$(rnd 2)
		
		if [ "$1" -eq 0 ]
		then	echo "${good[$num]}"
		elif [ "$1" -eq 1 ]
		then	echo "${bad[$num]}"
		else	echo "$1"
		fi
	}
	return_status_color() { # $?
	# returns the color values according to its return value
	#
		case "$1" in
		0)	echo -ne "${greenbg}${bluefont}"	;;
		1)	echo -ne "${redbg}${whitefont}"		;;
		*)	echo -ne "${whitebg}${bluefont}"	;;
		esac
	}
	export -f rnd return_user_color return_status_color return_status_string
	RET_RND='$(echo -e $(return_status_color $RET))$(echo -e $(return_status_string $RET))'
#
#	PS1
#
	export PS1="$RET_RND${reset} \w $(return_user_color)\\\$${reset} "	
EOF
%end

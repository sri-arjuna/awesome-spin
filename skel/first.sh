#!/bin/bash
# first.sh
# GNU General Public License (GPL) 2014 by Simon Arjuna Erat (sea) (erat.simon@gmail.com)
# Description:	Does some basic tweaking optimized for the AwesomeWM-Spin by me.
# ------------------------------------------------------
#
#	Variables
#
	. $HOME/.bashrc
	G=/etc/default/grub
	RESOLUTION=$(xrandr |grep \*|awk '{print $1}')
	FOLDERS="mmm/{pic,snd,vid} net/{dls,fas/$USER/public_html,web} notepad priv/{cloud,docs,templates} prjs "
#
#	Functions
#
	
#
#	Display & Action
#
	tui-title "AwesomeWM-Spin - First things"
	tui-echo "Creating folders"
	cd
	for F in $FOLDERS;do
		if [[ -d $F ]] 
		then	RET=4
		else	mkdir -p $F
			RET=$?
		fi
		tui-status $RET "Created $F"	
	done
	
	tui-echo "Update WIFI identifier"
	WIFI_NEW="$(ifconfig |grep ^w|awk '{print $1}')"
	# Only change if a wifi was found
	if [[ ! -z "$WIFI_NEW" ]]
	then	WIFI_OLD="wlp3s0"
		WIFI_NEW=${WIFI_NEW:0:-1}
		sed s,"$WIFI_OLD","$WIFI_NEW",g -i /etc/skel/.config/awesome/rc.lua
		sed s,"$WIFI_OLD","$WIFI_NEW",g -i $HOME/.config/awesome/rc.lua
		tui-status $? "Changed WIFI in rc.lua to $WIFI_NEW"
	fi
	
	tui-echo "Updating GTK Bookmarks"
	for F in $HOME/.gtk-bookmarks $HOME/.config/gtk-3.0/bookmarks
	do	sed s,\$HOME,$HOME,g -i $F
		sed s,\$USER,$USER,g -i $F
		tui-status $? "* Changed: $F"
	done
		
	tui-yesno "Enable passwordless sudo?" && \
		su -c "echo \"$USER ALL=(ALL)	NOPASSWD: ALL\" >> /etc/sudoers"
	tui-status $RET "Enabled passwordless sudo"
	
	tui-echo "Preparing LXDM"
	sudo tui-conf-set /etc/lxdm/lxdm.conf autologin $USER
	tui-status $? "Enabled auto login for $USER, expecting a single user system with harddisc encryption"
	
	tui-echo "Preparing GRUB"
	sudo tui-conf-set $G GRUB_TERMINAL_OUTPUT gfxterm
	tui-status $? "* Changed terminal output to gfxterm"
	
	#sudo su -c "echo GRUB_THEME=/boot/grub2/themes/circled-nasa-horizon/theme.txt >> $G"
	sudo tui-conf-set $G GRUB_THEME /boot/grub2/themes/circled-nasa-horizon/theme.txt
	tui-status $? "* Set theme circled-nasa-horizon"
	
	#sed s,GRUB_GFXMODE,GRUB_GFXMODE,g -i $G
	sudo tui-conf-set $G GRUB_GFXMODE $RESOLUTION
	tui-status $? "* Set resolution to $RESOLUTION"
	#GRUB_GFXMODE=1440x900x16
	#GRUB_GFXPAYLOAD_LINUX=keep 
	
	tui-echo "Rebuilding Grub"
	gupd
	
	tui-echo "Preparing  plymouth"
	sudo plymouth-set-default-theme solar -R
	tui-status $? "Changed boot animation to solar"
	
	sudo dracut-rebuild
	
	if tui-yesno "Change hostname ($(hostname))?"
	then	newhost=$(tui-read "Enter the new hostname:")
		sudo hostname $newhost
		sudo su -c "echo $newhost > /etc/hostname"
		tui-status $? "Hostname is: $(hostname)"
	fi
	
	if tui-yesno "Disable some services now? (asking one-by-one)"
	then	# Yes ask some services
		tui-title "Optimize for F21+"
		for S in rsyslog 
		do
			sudo systemctl disable $S.service
			tui-status $? "* Disabled $S"
		done
		
		tui-title "Optional (suggested)"
		for S in bluetooth livesys livesys-late ModemManager 
		do
			if tui-yesno "Disable: $S?"
			then	sudo systemctl disable $S.service
				RET=$?
			else	RET=4
			fi
			tui-status $RET "* Disabled $S"
		done
	fi
	
	tui-wait 10s
	rm -fr $0 && exit 0
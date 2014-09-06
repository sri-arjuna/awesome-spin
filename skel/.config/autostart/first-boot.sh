#!/bin/bash
#
#	This is done only once, and NOT for every new user
#
	alias tui-yesno=tui-bol-yesno
#
#	Sudo
#	
	U=$USER
	sleep 2
	WIFI_OLD="wlp3s0"
	WIFI_NEW="$(ifconfig |grep ^w|awk '{print $1}')"
	WIFI_NEW=${WIFI_NEW:0:-1}
	sed s,"$WIFI_OLD","$WIFI_NEW",g -i /etc/skel/.config/awesome/rc.lua
	tui-title "Machine Setup"
	tui-echo "You're now becoming passwordless sudo..."
	tui-echo "But therefor you must pass the root's password once."
	tui-yesno "You want that?" && su -c "echo '$U	ALL=(ALL)	NOPASSWD: ALL' >> /etc/sudoers"
	tui-status $? "You ($U) have now passwordless sudo!"
#
#	Hostname
#
	tui-echo "Your computer is named \"$(hostname)\"."
	tui-yesno "Do you want to change?" && sudo hostname $(tui-read "Enter the new hostname:")
	tui-status $? "Hostname is: $(hostname)"
#
#	Update LXDM
#
	# This is since its expected to have the disk encrypted, and password locks screensaver
	tui-printf "Setup autologin" "$WORK"
	sleep 1
	sudo su -c "sed s/autologin=liveuser/autologin=$U/g -i /etc/lxdm/lxdm.conf"
	tui-status $? "Setup autologin for $U"
#
#	Plymouth
#
	tui-printf "Changing plymouth startup screen to:" "solar" "$WORK"
	sudo plymouth-set-default-theme solar -R 1>/dev/zero 2>/dev/zero
	tui-status $? "Changed plymouth to: solar"
#
#	Grub
#
	tui-printf "Preparing grub" "$WORK"
	[ -f /etc/default/grub ] || touch /etc/default/grub
	theme=/usr/share/grub/themes/circled-nasa-spiral/theme.txt
	[[ "" = "$(grep GRUB_THEME /etc/default/grub)" ]] && \
		sudo su -c "echo 'GRUB_THEME=\"$theme\"' >> /etc/default/grub" || \
		sudo su -c "sed s,GRUB_THEME=.*,GRUB_THEME=\"$theme\",g -i /etc/default/grub"
	tui-status $? "Applied $(basename $theme)"
	
	sudo su -c "sed s,GRUB_TERMINAL_OUTPUT=console,GRUB_TERMINAL_OUTPUT=gfxterm,g -i /etc/default/grub"
	tui-status $? "Disabled forced console"
	
	sudo su -c "sed s,TIMEOUT=.*,TIMEOUT=10,g -i /etc/default/grub"
	tui-status $? "Changed timeout to 10"
	
	# Lets do an overkill :D
	str="GRUB_GFXMODE=1920x1080x32,1600x900x32,1280x720x32,1024x768x16,640x480x16"
	if grep ^GRUB_GFXMODE /etc/default/grub
	then	sudo su -c "sed s,GRUB_GFXMODE=.*,$str,g -i /etc/default/grub"
		RET=$?
	else	sudo su -c "echo '$str' >> /etc/default/grub"
		RET=$?
	fi
	tui-status $RET "Should support high res now"
	
	#sed s,"rhgb quiet","",g -i /etc/default/grub
	
	[ -f /boot/efi/EFI/fedora/grub.cfg ] && \
		grb_cfg=/boot/efi/EFI/fedora/grub.cfg || \
		grb_cfg=/boot/grub2/grub.cfg
	sudo grub2-mkconfig -o $grb_cfg
	#gupd
#
#	Remove after, no 2nd chance
#
	tmp_file1=/etc/skel/.config/autostart/first-boot.sh
	tmp_file2=$HOME/.config/autostart/first-boot.sh
	for f in $tmp_file1 $tmp_file2;	do
		nohup sudo su -c "rm -f $f"
	done

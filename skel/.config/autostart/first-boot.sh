#!/bin/bash
#
#	This is done only once, and NOT for every new user
#
	tui-title "First time Machine setup"
#
#	Sudo
#	
	tui-echo "Hello $USER, you're now becoming passwordless sudo..."
	tui-echo "But therefor you must pass the root's password once."
	tui-yesno "You want that?" && \
		su -c "echo '$USER	ALL=(ALL)	NOPASSWD: ALL' >> /etc/sudoers"
	tui-status $? "You ($USER) have now passwordless sudo!"
#
#	Hostname
#
	tui-echo "Your computer is named \"$(hostname)\"."
	tui-yesno "Do you want to change?" && \
		hostname $(tui-read "Enter the new hostname:")
	tui-status $? "Hostname is: $(hostname)"
#
#	Plymouth
#
	tui-echo "Changing plymouth startup screen to:" "solar" "$WORK"
	plymouth-set-default-theme solar -R
	tui-status $? "Changed plymouth to: solar"
#
#	Grub
#
	tui-echo "Preparing grub"
	[ -f /etc/default/grub ] || touch /etc/default/grub
	theme=/usr/share/grub/themes/circled-nasa-spiral/theme.txt
	[[ "" = "$(grep GRUB_THEME /etc/default/grub)" ]] && \
		echo "GRUG_THEME=\"$theme\"" >> /etc/default/grub || \
		sed s,GRUB_THEME=.*,"GRUB_THEME=\"$theme\"",g -i /etc/default/grub
	tui-status $? "Applied $(basename $theme)"
	
	sed s,"GRUB_TERMINAL_OUTPUT","#GRUB_TERMINAL_OUTPUT",g -i /etc/default/grub
	tui-status $? "Disabled forced console"
	
	sed s,"TIMEOUT=.*","TIMEOUT=10",g -i /etc/default/grub
	tui-status $? "Changed timeout to 10"
	
	# Lets do an overkill :D
	str="GRUB_GFXMODE=1920x1080x32,1600x900x32,1280x720x32,1024x768x16,640x480x16"
	if grep ^GRUB_GFXMODE /etc/default/grub
	then	sed s,"GRUB_GFXMODE=.*","$str",g -i /etc/default/grub
		tui-status $? "Should support high res now"
	else	echo "$str" >> /etc/default/grub
		tui-status $? "Should support high res now"
	fi
	
	#sed s,"rhgb quiet","",g -i /etc/default/grub
	
	[ -f /boot/efi/EFI/fedora/grub.cfg ] && \
		grb_cfg=/boot/efi/EFI/fedora/grub.cfg || \
		grb_cfg=/boot/grub2/grub.cfg
	#grub2-mkconfig -o $grb_cfg
	gupd
#
#	
#
	tmp_file1=/etc/skel/.config/autostart/first-boot.sh
	tmp_file2=$HOME/.config/autostart/first-boot.sh
	for f in $tmp_file1 $tmp_file2
	do
		nohup sleep 1 && sudo rm -f $f
	done

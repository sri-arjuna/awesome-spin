#!/bin/bash
#
# 	Customize... GRUB2 Theme & Plymouth
#
#	[ -f /etc/default/grub ] || touch /etc/default/grub
	#plymouth-set-default-theme solar -R
	#echo "GRUB_THEME=/usr/share/grub/themes/circled-nasa-sombrero/theme.txt" >> /etc/default/grub
#	theme=/usr/share/grub/themes/circled-nasa-spiral/theme.txt
#	[[ "" = "$(grep GRUB_THEME /etc/default/grub)" ]] && \
#		echo "GRUG_THEME=\"$theme\"" >> /etc/default/grub || \
#		sed s,GRUB_THEME=.*,"GRUB_THEME=\"$theme\"",g -i /etc/default/grub
#	sed s,"rhgb quiet","",g -i /etc/default/grub
#	sed s,"GRUB_TERMINAL_OUTPUT","#GRUB_TERMINAL_OUTPUT",g -i /etc/default/grub
#	[ -f /boot/efi/EFI/fedora/grub.cfg ] && \
#		grb_cfg=/boot/efi/EFI/fedora/grub.cfg || \
#		grb_cfg=/boot/grub2/grub.cfg
	#grub2-mkconfig -o $grb_cfg
	#plymouth-set-default-theme solar -R

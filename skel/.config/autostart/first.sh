#!/bin/bash
# Write default folder location to gtk bookmarks.
#
#	Variables
#
	GTK2=$HOME/.gtk-bookmarks
	GTK3=$HOME/.config/gtk-3.0/bookmarks
	CONTENT="file://$HOME/priv/docs Documents
file://$HOME/prjs Projects
file://$HOME/.local/bin Scripts
file://$HOME/net Internet
file://$HOME/mm Multimedia
file:///run/media/$USER/ Hub
file:///mnt Mounts"
#
# 	Action
#
	tui-title "First time setup"
	tui-printf "Prepare locations for filemanager" "$WORK"
	[ -f \$GTK3 ] && \\
		DEST=$GTK3 || \\
		DEST=$GTK2
	sleep 1
	printf "$CONTENT" > "$DEST"
	tui-status $? "Wrote locations to $DEST"
#
#	Update LXDM
#
	# This is since its expected to have the disk encrypted, and password locks screensaver
	tui-printf "Setup autologin" "$WORK"
	sleep 1
	sed s/"autologin=liveuser"/"autologin=$USER"/g -i /etc/lxdm/lxdm.conf
	#cp -fr /etc/skel/.bashrc $HOME/
	tui-status $? "Setup autologin for $USER"
#
#	Remove me after first run
#
	tui-printf "Remove unrequired startup entries" "$WORK"
	sleep 1
	sed s,"sh \$HOME/.config/autostart/first.sh","",g -i $HOME/.bashrc
	T=$HOME/.config/autostart/first-boot.sh
	[ -f $T ] && sh $T
	#sed s,"sh \$HOME/.config/autostart/first-boot.sh","",g -i $HOME/.bashrc
	nohup rm -f $HOME/.config/autostart/first.sh
	tui-status $? "Removed firsttime files"

#!/bin/bash
# Write default folder location to gtk bookmarks.
#
#	Variables
#
	.  tui
	WIFI_OLD="wlp3s0"
	WIFI_NEW="$(ifconfig |grep -i ^w|awk '{print $1}')"
	WIFI_NEW=${WIFI_NEW:0:(-1)}
	GTK2=$HOME/.gtk-bookmarks
	GTK3=$HOME/.config/gtk-3.0/bookmarks
	CONTENT="file://$HOME/notepad
file://$HOME/prjs Projects
file://$HOME/.local/bin Scripts
file://$HOME/priv/docs Documents
file://$HOME/net/dls Downloads
file://$HOME/mm/snd Audio
file://$HOME/mm/pics Images
file://$HOME/mm/vids Videos
file:///run/media/$USER/ HW-Hub
file:///mnt /Mounts"
#
# 	Action
#
	U=$USER
	#read -p "Press enter to start first time configuration..."
	#sleep 5
	tui-header "First time"
	tui-title "User setup"
	tui-echo "Hello $U"
	tui-echo "This is a one time setup..." "It wont come again..." "ever"
	tui-echo
	tui-title "First time setup"
	tui-printf "Prepare locations for filemanager" "$WORK"
	[ -f $GTK3 ] && \
		DEST=$GTK3 || \
		DEST=$GTK2
	sleep 1
	#printf "cat << EOF\n" > $TMP
	printf "$CONTENT" > $DEST #\nEOF" >> $TMP
	sed s,"\$HOME","$HOME",g -i $DEST
	sed s,"\$USER","$USER",g -i $DEST
	ifconfig |grep -q -i ^w && \
		sed s,"$WIFI_OLD","$WIFI_NEW",g -i $HOME/.config/awesome/rc.lua
	#source $TMP > "$DEST" 
	tui-status $? "Wrote locations to $DEST"
#
# 	But also start first time setup for the machine if required
#
	case $USER in
	liveuser)	tui-status 4 "Machine setup not required on liveimage"	;;
	*)		T="$HOME/.config/autostart/first-boot.sh"
			[ -f "$T" ] && sh "$T"
			tui-status $? "Executed first time machine script"
			;;
	esac
#
#	Remove me after first run
#	
	tui-printf "Remove unrequired startup entries" "$WORK"
	sed s,"sh \$HOME/.config/autostart/first.sh","",g -i $HOME/.bashrc
	sleep 1
	(nohup rm -f $HOME/.config/autostart/first.sh ; rm nohup.out) 2>/dev/zero
	tui-status $? "Removed firsttime files"

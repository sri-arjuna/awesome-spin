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
file://$HOME/notepad Notepad/Desktop
file://$HOME/net Internet
file://$HOME/mm Multimedia
file:///run/media/$USER/ Hub
file:///mnt Mounts"
#
# 	Action
#
	[ -f $GTK3 ] && \
		DEST=$GTK3 || \
		DEST=$GTK2
	printf "$CONTENT" > "$DEST"
	rm -f $0 &

#!/bin/bash
echo "file://$HOME/bin MyScripts
file://$HOME/notepad Notepad
file://$HOME/net Internet
file://$HOME/media Multimedia
file://$HOME/priv/prjs Projects
file:///run/media/$USER/ Hub
file:///mnt Mounts" > ~/.gtk-bookmarks
rm -f /etc/skel/.config/autostart/first.sh &

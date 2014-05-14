#
#	Install retrieved packages
#	Prepare custom /etc/skel files
#
%post
#!/bin/sh
#
#	Do install tui, so reporting is more visible
#
	echo "--	--	--	--		--"
	echo
	echo

	echo "		start chroot...		DEBUG"

	echo
	echo
	echo "--	--	--	--		--"

	sh -T /sea/tui/install.sh<<EOF

EOF
	cd /root/spin_files/skel/
	cp -R $(find) /etc/skel
	# Make self sustainable:
	ln -s /root/spin_files/mk-iso-awesome-sea /usr/bin
	S="/home/sea/prjs/iso-awesome-sea"
	R="/root/spin_files"
	
	# $This should change all values matching /home/sea/prjs to /root/spin_files
	cd $R
	for f in *;do
		grep -q "$S" $f && sed s,"$S","$R",g -i $f
	done
#
#	Customize... GRUB2 Theme & Plymouth
#
	touch /etc/default/grub
	theme=/usr/share/grub/themes/circled-nasa-spiral/theme.txt
	[[ "" = "$(grep GRUB_THEME /etc/default/grub)" ]] && \
		echo "GRUG_THEME=\"$theme\"" >> /etc/default/grub || \
		sed s,GRUB_THEME=.*,"GRUB_THEME=\"$theme\"",g -i /etc/default/grub
	
	[ -f /boot/efi/EFI/fedora/grub.cfg ] && \
		grb_cfg=/boot/efi/EFI/fedora/grub.cfg || \
		grb_cfg=/boot/grub2/grub.cfg
	#grub2-mkconfig -o $grb_cfg
	#plymouth-set-default-theme solar -R
#
#	Prepare tui-sutra
#
	ln -s /usr/share/sutra/sutra /usr/bin/sutra
#
#	XDG-User-Dirs
#	
	mkdir -p net/{dls,pub,web,fas/scm} \
		notepad \
		priv/{templates,docs,cloud} \
		mm/{img,snd,vids} \
		prjs
#
# 	LXDE and LXDM configuration
#

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/awesome
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
/usr/libexec/notification-daemon
FOE

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE 
[Preferred Applications]
WebBrowser=firefox.desktop
MailClient=thunderbird.desktop
FOE

# set up auto-login for liveuser
sed -i s/"# autologin=dgod"/"autologin=liveuser"/g /etc/lxdm/lxdm.conf

# Make awesome the default session, as Awesome is the only one, not required
# sed -i s,"session=/usr/bin/startlxde","session=/usr/bin/awesome",g /etc/lxdm/lxdm.conf

# Get a cool background
sed -i s,"bg=/usr/share/backgrounds/default.png","bg=/etc/skel/.config/awesome/img/background.jpg",g /etc/lxdm/lxdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/notepad
cp /usr/share/applications/liveinst.desktop /home/liveuser/notepad

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF
%end

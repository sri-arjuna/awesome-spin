#
#	Install retrieved packages
#
%post
#!/bin/sh
#
#	Do install tui, so reporting is more visible
#
	tui-header "post2-chroot.ks"
	sh -T /tmp/tui/install.sh > /dev/zero <<EOF

EOF
#
# 	Make self sustainable:
#	* prepare skel
#	* prepare symlink
#	* sed scripts
#
	# S for search
	S="/home/sea/prjs/iso-awesome-sea"
	R="/root/spin_files"
	ln -s $R/make-iso /usr/bin/make-awesome-iso
	cd $R
	for f in *;do
		echo "* $f"
		grep "$S" $f && sed s,"$S","$R",g -i $f
	done
#
#	Customize... GRUB2 Theme & Plymouth
#
	[ -f /etc/default/grub ] || touch /etc/default/grub
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
# 	LXDE and LXDM configuration
#
	echo "Writing LXDE & LXDM conf"
# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/awesome
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

# EOF Starts here
	echo "Writing livesys"
cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
/usr/libexec/notification-daemon
FOE

	echo "Writing prefered apps"
# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE 
[Preferred Applications]
WebBrowser=firefox.desktop
MailClient=thunderbird.desktop
FOE

	echo "SED'ing lxdm.conf"
# set up auto-login for liveuser
sed -i s/"# autologin=dgod"/"autologin=liveuser"/g /etc/lxdm/lxdm.conf

# Make awesome the default session, as Awesome is the only one, not required
 sed -i s,"session=/usr/bin/startlxde","session=/usr/bin/awesome",g /etc/lxdm/lxdm.conf

# Get a cool background
mv /usr/share/backgrounds/default.png /usr/share/backgrounds/default-fedora.png
ln -s /etc/skel/.config/awesome/img/background.jpg /usr/share/backgrounds/default.png
sed -i s,"bg=/usr/share/backgrounds/default.png","bg=/etc/skel/.config/awesome/img/background.jpg",g /etc/lxdm/lxdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/liveinst.desktop

# Remove language panel
sed -i s/"lang=1"/"lang=0"/g /etc/lxdm/lxdm.conf

	tui-title "selinux restorecon"
# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
#restorecon -R /home/liveuser

EOF
%end
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

	sh -T /sea/tui/install.sh
	cd /etc/skel
	tar -axf /root/spin_files/userdefaults.tar.gz 
#
#	Customize... GRUB2 Theme & Plymouth
#
	theme=/usr/share/grub/themes/circled-nasa-spiral/theme.txt
	[[ " = "$(grep GRUB_THEME)" ]] && \
		echo "GRUG_THEME=\"$theme\"" >> /etc/default/grub || \
		sed s,"$(grep GRUB_THEME)","GRUB_THEME=\"$theme\"",g -i /etc/default/grub
	
	[ -f /boot/efi/EFI/fedora/grub.cfg ] && \
		grb_cfg=/boot/efi/EFI/fedora/grub.cfg || \
		grb_cfg=/boot/grub2/grub.cfg
	#grub2-mkconfig -o $grb_cfg
	plymouth-set-default-theme solar -R
#
#	Prepare tui-sutra
#
	ln -s /usr/share/tui-sutra/sutra /usr/bin/sutra
#
#	XDG-User-Dirs
#	
	mkdir -p net/{dls,pub,web,fas/scm} \
		notepad \
		priv/{templates,docs,cloud} \
		mm/{img,snd,vids} \
		prjs


# LXDE and LXDM configuration

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
sed -i 's/# autologin=.*/autologin=liveuser/g' /etc/lxdm/lxdm.conf

# Make awesome the default session
sed -i 's/session=.*/session=/usr/bin/awesome/g' /etc/lxdm/lxdm.conf

# Get a cool background
sed -i 's/bg=.*/bg=/etc/skel/.config/awesome/img/background.jpg/g' /etc/lxdm/lxdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/notepad
cp /usr/share/applications/liveinst.desktop /home/liveuser/notepad

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF
%end

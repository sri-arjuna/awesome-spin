%post
#!/bin/bash
msg() { printf '\n\n\t_ %s _\n\n\n' "${@}" ; }
msg "POST - SKEL - START"
#
#	Copy fixed template
#
	set -x
	cd /root/spin_files/skel
#	rm -f /etc/skel/.bashrc
	cp -fr *		/etc/skel
	cp -fr .[a-zA-Z]*	/etc/skel
	ln -sf /root/spin_files/make-iso.sh	/usr/bin/make-awesomewm
	# The 'cd' is required for the other scripts to work
	cd ..
	pwd
	set +x
	
	echo
echo "(Over-)Writing livesys // post-livesys.sh"
echo

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
Editor=pluma.desktop
FOE

	echo "SED'ing lxdm.conf"
# set up auto-login for liveuser
usr=$(ls /home --hide=lost*)
usr=$(echo $usr|awk '{print $1}')
[[ ! -z "$usr" ]] && sed -i s/"# autologin=dgod"/"autologin=$usr"/g /etc/lxdm/lxdm.conf

# Make awesome the default session, as Awesome is the only one, not required
sed -i s,"session=/usr/bin/startlxde","session=/usr/bin/awesome",g /etc/lxdm/lxdm.conf

# Get a cool background
[ -f /usr/share/backgrounds/default-fedora.png ] || mv /usr/share/backgrounds/default.png /usr/share/backgrounds/default-fedora.png
ln -sf /etc/skel/.config/awesome/img/background.jpg /usr/share/backgrounds/default.png
sed -i s,"bg=/usr/share/backgrounds/default.png","bg=/etc/skel/.config/awesome/img/background.jpg",g /etc/lxdm/lxdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/liveinst.desktop

# Remove language panel
sed -i s/"lang=1"/"lang=0"/g /etc/lxdm/lxdm.conf
EOF

echo
echo "DONE post-livesys.sh"
echo
#
# 	This goes at the end after all other changes.
#
	echo
	echo "selinux restorecon"
	echo
	useradd -m liveuser
	passwod -d liveuser
	/bin/chown -R liveuser:liveuser /home/liveuser
	# Fails on build.. does it work without it?
	/usr/sbin/restorecon -R /home/liveuser
msg "POST - SKEL - END"
%end

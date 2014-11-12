#!/bin/bash
#
# 	LXDE and LXDM configuration
#
	echo "Writing LXDE & LXDM conf"
# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/awesome
DISPLAYMANAGER=/usr/sbin/lxdm
EOF
#
#	(re)Do customization outside of livesys script
#
	# set up auto-login for liveuser
	sed -i s/"# autologin=dgod"/"autologin=liveuser"/g /etc/lxdm/lxdm.conf

	# Get a cool background
	[[ -f /usr/share/backgrounds/default-fedora.png ]] || mv /usr/share/backgrounds/default.png /usr/share/backgrounds/default-fedora.png
	ln -sf /etc/skel/.config/awesome/img/background.jpg /usr/share/backgrounds/default.png
	sed -i s,"bg=/usr/share/backgrounds/default.png","bg=/etc/skel/.config/awesome/img/background.jpg",g /etc/lxdm/lxdm.conf

	# Remove language panel
	sed -i s/"lang=1"/"lang=0"/g /etc/lxdm/lxdm.conf

	# Make awesome the default session, as Awesome is the only one, not required
	sed -i s,"session=/usr/bin/startlxde","session=/usr/bin/awesome",g /etc/lxdm/lxdm.conf
#
#
	echo "
	
	DONE LXDM conf
	
	"

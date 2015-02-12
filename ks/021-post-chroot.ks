%post
#!/bin/bash
msg() { printf '\n\n\t_ %s _\n\n\n' "${@}" ; }
msg "POST - CHROOT - START"
	set -x
	if cd /root/spin_files/skel/
	then	ls *iso 2>/dev/zero && rm -fr *iso
		cp -r * /etc/skel
		cp -r .[a-zA-Z]* /etc/skel
		echo
	else	echo "
		could not enter /root/spin_files/skel
		beeing in $(pwd)
		"
	fi
	set +x
# The below is OBSELETE when using the awesome-kickstarts package	
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
	
	# For some reason , the repo did not get saved in early builds
	cat > /etc/yum.repos.d/rpmfusion-Free.repo << EOF
[rpmfusion-free]
name=rpmfusion-free
mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
enabled=1
gpgcheck=0
EOF

cat > /etc/yum.repos.d/rpmfusion-nonfree.repo << EOF
[rpmfusion-nonfree]
name=rpmfusion-nonfree
mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch
enabled=1
gpgcheck=0
EOF

	cat > /etc/yum.repos.d/sea-devel.repo << EOF
[FedoraPeople-sea]
name=sea's devel packages
baseurl=http://sea.fedorapeople.org/repo
enabled=1
gpgcheck=0
EOF
	cat > /etc/yum.repos.d/adobe-i386.repo << EOF
[adobe-i386]
name=adobe-linux-i386 
baseurl=http://linuxdownload.adobe.com/linux/i386/
enabled=0
gpgcheck=0
EOF

	cat > /etc/yum.repos.d/adobe-x86.repo << EOF
[adobe-x86]
name=adobe-linux-x86-experimental
baseurl=http://linuxdownload.adobe.com/linux/x86/
enabled=1
gpgcheck=0
EOF

	cat > /etc/yum.repos.d/spot-chromium.repo << EOF
[spot-chromium]
name=Chromium ($releasever)
baseurl=http://repos.fedorapeople.org/repos/spot/chromium-stable/fedora-$releasever/$basearch/
enabled=1
gpgcheck=0
EOF

msg "POST - CHROOT - END"
%end

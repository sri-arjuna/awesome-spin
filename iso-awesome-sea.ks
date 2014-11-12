# Based on: fedora-live-base.ks
#
#	System Settings
#
	lang de_CH.UTF-8
	keyboard ch
	timezone CET+0100

	auth --useshadow --enablemd5
	selinux --enforcing
	firewall --enabled --service=mdns
	firstboot --reconfig
	xconfig --startxonboot

	services --enabled=NetworkManager --disabled=network,sshd
#
#
#	Includes, order required
#	Default environment first
#
	%include 	/usr/share/spin-kickstarts/fedora-repo-not-rawhide.ks
#
#	Desktop Environment files
#
	%include	/usr/share/spin-kickstarts/fedora-livecd-lxde.ks
#
#
#	Custom Area
#
%post --nochroot
	# '/' is the root of your host machine
	echo TODO
%end
%post
	# '/' is the root of your virtual system image
	echo TODO
%end
%packages
#
# Basic GUI
#
	@core
	@hardware-support
	@standard
	@base-x

# Might be removable
	#dial-up
	@multimedia
#
# Required by LiveImage
#
	kernel
	memtest86+
	anaconda
	@anaconda-tools
	qemu-guest-agent
%end

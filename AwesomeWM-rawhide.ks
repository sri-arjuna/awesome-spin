# Based on: fedora-live-base.ks
#
# 	Change paths (/home/sea/...) to the files (where is awesome.ks?)
#	To recieve a working rawhide live spin, you must build it on a rawhide host!
#
#
#	Includes, order required
#	Default environment first
#
	%include 	ks/001-system-settings.ks
	%include 	/usr/share/spin-kickstarts/fedora-repo-rawhide.ks
	%include 	/usr/share/spin-kickstarts/fedora-live-minimization.ks
# AwesomeWM, here the customization begins
	%include 	ks/005-repo-sea.ks
	%include 	ks/006-repo-non-foss-rawhide.ks
	%include 	ks/008-pkgs-awesome.ks
	%include 	ks/009-pkgs-dev.ks
	%include 	ks/010-pkgs-nonfoss.ks
# Sytem changes
	%include 	ks/020-post-nochroot.ks
	%include 	ks/021-post-chroot.ks
	%include 	ks/022-post-skel.ks
	%include 	ks/999-post-fedora-template.ks
#
#
#	Packages
#	These are the very basic required to display anaconda
#	and have a functional live environment, even in a VM
#
#	The configuration for the custom spin, are in the other files
#
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



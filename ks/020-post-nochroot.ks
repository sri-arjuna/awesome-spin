#
#	Retrieve packages from the internet
#
%post --nochroot
#!/bin/sh
#
#	Variables
#
	URL="https://github.com/sri-arjuna"
	root="$INSTALL_ROOT"
	dir_src="$(pwd)"
	dir_target="$root/root/spin_files"
#	
# 	Next 2 are to copy the kickstart files
# 	to the folder 'spin_file' in root's home
#	
	[[ -d "$root/tmp" ]] || mkdir -p "$root/tmp"
	[[ -d "$dir_target" ]] || mkdir -p "$dir_target"
#
# 	Copy requires kickstarts files to the image's /root/spin_file
#
	# Prepare subfolder to be copied to /root/spin_files
	cd "${dir_src}"
	cp -fr	*	 	"$dir_target"
	cp -fr	.[a-zA-Z]* 	"$dir_target"
#
#	Retrieve 'my stuff'
#
	#git clone $URL/tui-sutra.git 		"$root/usr/share/sutra"
	#git clone $URL/vhs.git			"$root/usr/share/vhs"
	#git clone $URL/scripts.git		"$root/tmp/eh" 	&& 	mv "$root/"tmp/eh/bin/* $root/opt
	#git clone $URL/efi-helper.git		"$root/usr/share/efi-helper"
# Do symlinks
	#cd "$root/usr/bin"
	#ln -s /usr/share/vhs/vhs.sh		vhs
	#ln -s /usr/share/nas/nas.sh		nas
	#ln -s /usr/share/efi-helper/efi-helper.sh	efi-helper
#
#	User Configuration (/etc/skel)
#
	skel="$root/etc/skel"
	sleep 1
	git clone $URL/awesome-config.git 	"$skel/.config/awesome"
%end

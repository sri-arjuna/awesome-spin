#
#	Retrieve packages from the internet
#
%post --nochroot
#!/bin/sh
#
#	Variables
#
	mount_root=$(cat /tmp/make-iso.tmp)
	mount_old=/var/tmp/img
	home=$(cat /tmp/make-iso.home)
	prjs=$(cat /tmp/make-iso.prj)
	root="$(printf $(ls -d $mount_root/* | awk '{print $1}')|tr -d [:space:])/install_root"
	URL=https://github.com/sri-arjuna
#	
# 	Next 2 are to copy the kickstart files
# 	to the folder 'spin_file' in root's home
#	
	dir_target="$root/root/spin_files"
	dir_src=$prjs
	[[ -d $root/tmp ]] || mkdir -p $root/tmp
	[[ -d $dir_target ]] || mkdir -p $dir_target
#
# 	Copy requires kickstarts files to the image's /root/spin_file
#
	# Prepare subfolder to be copied to /root/spin_files
	cd "${prjs}"
	pwd
	sleep 3
	cp -fr	*	 	$dir_target
	cp -fr	.[a-zA-Z]* 	$dir_target
#
#	Retrieve 'my stuff'
#
	#git clone $URL/tui.git 			$root/tmp/tui
	sleep 1
	git clone $URL/tui-sutra.git 		$root/usr/share/sutra
	git clone $URL/vhs.git			$root/usr/share/vhs
	#git clone $URL/vhs.git			$root/usr/share/nas
	#git clone $URL/efi-helper.git		$root/usr/share/efi-helper
	cd "$root/usr/bin"
	ln -s /usr/share/vhs/vhs.sh		vhs
	#ln -s /usr/share/nas/nas.sh		nas
	#ln -s /usr/share/efi-helper/efi-helper.sh	efi-helper
	cd "$prjs"
#
#	User Configuration (/etc/skel)
#
	skel=$root/etc/skel
	sleep 1
	git clone $URL/awesome-config.git 	$skel/.config/awesome
	#git clone $URL/awesome-config.git 	$root/tmp/awesome
%end

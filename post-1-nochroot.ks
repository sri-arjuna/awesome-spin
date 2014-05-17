#
#	Retrieve packages from the internet
#
%post --nochroot
#!/bin/sh
#
#	Variables
#
	mount_root=/mnt/sea_awesome_wm
	mount_old=/var/tmp/img
	home=/home/sea
	prjs=$home/prjs/iso-awesome-sea
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
	# Prepare subfolder to be copied
	cd "${dir_src}"
	cp 	* 	$dir_target
#
#	Retrieve 'my stuff'
#
	git clone $URL/tui.git 			$root/tmp/tui
	sleep 1
	git clone $URL/tui-sutra.git 		$root/usr/share/sutra
#
#	Get vicious
#
	echo "Getting vicious"
	sleep 2
	git clone http://git.sysphere.org/vicious 	$root/usr/share/awesome/lib/vicious
#
#	User Configuration (/etc/skel)
#
	skel=$root/etc/skel
	sleep 1
	git clone $URL/awesome-config.git 	$skel/.config/awesome
%end

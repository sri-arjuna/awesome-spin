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
#	
# 	Next 2 are to copy the kickstart files
# 	to the folder 'spin_file' in root's home
#	
	dir_target="$root/root/spin_files"
	dir_src="$(ls $prjs/*)"
#
# 	Copy requires kickstarts files to the image's /root/spin_file
#
	[[ -d $dir_target ]] || mkdir -p $dir_target
	cp 	$dir_src 	$dir_target
#
#	Retrieve 'my stuff'
#
	[[ -d $root/sea ]] || mkdir -p $root/sea
	URL=https://github.com/sri-arjuna
	git clone $URL/tui.git 			$root/sea/tui
	sleep 1
	git clone $URL/tui-sutra.git 		$root/usr/share/sutra
#
#	Get vicious
#
	sleep 1
	git clone http://git.sysphere.org/vicious 	$root/usr/share/awesome/lib/vicious
#
#	User Configuration (/etc/skel)
#
	skel=$root/etc/skel
	sleep 1
	git clone $URL/awesome-config.git 	$skel/.config/awesome
#	[[ -d $skel ]] || mkdir -p $skel
#	list=$(find /home/sea/prjs/zz_unused/userdefaults-hackerstyle)
#	cp $list $skel
%end

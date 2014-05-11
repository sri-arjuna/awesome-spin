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
	git clone https://github.com/sri-arjuna/tui.git 		$root/sea/tui
	git clone https://github.com/sri-arjuna/tui-sutra.git 		$root/sea/tui-sutra
	git clone https://github.com/sri-arjuna/awesome-config.git 	$root/sea/awesome
#
#	Get vicious
#
	git clone http://git.sysphere.org/vicious 			$root/sea/vicious
%end

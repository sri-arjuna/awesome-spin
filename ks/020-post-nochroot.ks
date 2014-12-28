#
#	Retrieve packages from the internet
#
%post --nochroot
#!/bin/sh
msg() { printf '\n\n\t_ %s _\n\n\n' "${@}" ; }
msg "POST - NOCHROOT - START"
#
#	Variables
#
	URL="https://github.com/sri-arjuna"
	root="$INSTALL_ROOT"
	dir_src="$(pwd)"
	pwd
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
	
	msg "Copy from $dir_src to $dir_target"
	
	set -x
	cd "${dir_src}"
	cp -fr	*	 	"$dir_target"
	cp -fr	.[a-zA-Z]* 	"$dir_target"
	set +x
#
#	User Configuration (/etc/skel)
#
	git clone $URL/awesome-config.git 	"$root/etc/skel/.config/awesome"
msg "POST - NOCHROOT - END"
%end

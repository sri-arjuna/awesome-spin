%post
#!/bin/bash
	cd /root/spin_files/scripts/
	sh post-grub.sh
	sh post-lxdm.sh
	sh post-myscripts.sh
	sh post-sustain.sh
#
#	How about styling GRUB2 & Plymouth in advance?
#
	plymouth-set-default-theme solar -R
	echo "GRUB_THEME=/usr/share/grub/themes/circled-nasa-sombrero/theme.txt" >> /etc/default/grub
	# Pre-Build GRUB config
	for F in /boot/grub2/grub.cfg /boot/efi/EFI/fedora/grub.cfg
	do 	echo "Building GRUB2 Config in :: $f"
		grub2-mkconfig -o $f
	done
	# Enable the scripts of mine from github
	echo "PATH=\"\$PATH:/opt\"" >> /etc/bashrc
%end

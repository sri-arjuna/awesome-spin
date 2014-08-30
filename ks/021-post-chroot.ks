%post
#!/bin/bash
	cd /root/spin_files/scripts/
	sh post-grub.sh
	sh post-lxdm.sh
	sh post-myscripts.sh
	sh post-sustain.sh
	
#	read -t 30 -p "Press enter to leave 021-post-chroot.ks" buffer
%end

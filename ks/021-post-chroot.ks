%post
#!/bin/bash
	cd /root/spin_files/scripts/
	sh post-grub.sh
	sh post-lxdm.sh
	sh post-myscripts.sh
	sh post-sustain.sh
	
echo
echo "DONE 021-post-chroot.ks"
%end

%post
#!/bin/bash
	cd /root/spin_files/scripts
	sh skel-config.sh
	sh skel-awesome.sh
	sh post-livesys.sh
#
# 	This goes at the end after all other changes.
#
	echo
	echo "selinux restorecon"
	echo
	chown -R liveuser:liveuser /home/liveuser
	#restorecon -R /home/liveuser
	
#	read -t 30 -p "Press enter to leave 022-post-skel.ks" buffer
%end

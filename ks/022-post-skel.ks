%post
#!/bin/bash
	cd /root/spin_files/scripts
	sh skel-config.sh	# Problem is within here !!
#	sh skel-awesome.sh
	sh post-livesys.sh
#
# 	This goes at the end after all other changes.
#
	echo
	echo "selinux restorecon"
	echo
#	/usr/sbin/useradd -m liveuser
	/bin/chown -R liveuser:liveuser /home/liveuser
	/usr/sbin/restorecon -R /home/liveuser
%end

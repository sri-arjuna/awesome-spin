repo 	--name=rpmfusion-Free 	 --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch 	#--gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-latest file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-rawhide --gpgcheck=1
repo 	--name=rpmfusion-Nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch 	#--gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-latest file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-rawhide --gpgcheck=1
#repo 	--name=rpmfusion-Free 	 --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide&arch=$basearch 		#--gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-latest file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-rawhide --gpgcheck=1
#repo 	--name=rpmfusion-Nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide&arch=$basearch 	#--gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-latest file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-rawhide --gpgcheck=1
repo 	--name=adobe-linux-i386  --baseurl=http://linuxdownload.adobe.com/linux/i386/ 							#--gpgkey=/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux --gpgcheck=1
#repo	--name=rpm.livna.org	 --mirrorlist=http://rpm.livna.org/mirrorlist								#--failovermethod=roundrobin	#--gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-livna
#repo 	--name=VirtualBox 	 --baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch 			#--gpgkey=http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc --gpgcheck=1

#repo 	--name= \
#	--baseurl= \
#	--gpgkey= \
#	--gpgcheck=1

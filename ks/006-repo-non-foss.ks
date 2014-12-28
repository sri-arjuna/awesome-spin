repo    --name=PostInstallerF21    --baseurl=http://sourceforge.net/projects/postinstaller/files/fedora/releases/$releasever/$basearch/updates/
repo    --name=PostInstallerF20    --baseurl=http://sourceforge.net/projects/postinstaller/files/fedora/releases/20/$basearch/updates/
repo 	--name=rpmfusion-Free 	 --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo 	--name=rpmfusion-Nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch
repo 	--name=adobe-linux-i386  --baseurl=http://linuxdownload.adobe.com/linux/i386/

##repo 	--name=VirtualBox 	 --baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch/
##repo --name=chromium --baseurl=http://repos.fedorapeople.org/repos/spot/chromium-stable/fedora-$releasever/$basearch/
##repo	--name=rpm.livna.org	 --mirrorlist=http://rpm.livna.org/mirrorlist

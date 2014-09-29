##lang en_US.UTF-8
##keyboard us
##timezone US/Eastern

timezone Europe/Zurich --nontp
lang de_CH.UTF-8
keyboard sg
keyboard --vckeymap=sg --xlayouts='sg'


auth --useshadow --enablemd5
selinux --enforcing
firewall --enabled --service=mdns
firstboot --reconfig
xconfig --startxonboot

#autopart /  16384 --fstype ext4
#autopart swap 12288
#autopart /boot 1024 --fstype ext4
#autopart /home 262144 --fstype ext4

services --enabled=NetworkManager --disabled=network,sshd

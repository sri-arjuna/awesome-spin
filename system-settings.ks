timezone Europe/Zurich --nontp
lang de_CH.UTF-8
#keyboard --vckeymap=ch --xlayouts='ch'
# sg-latin1
keyboard sg

auth --useshadow --enablemd5
selinux --enforcing
firewall --enabled --service=mdns
firstboot --reconfig
xconfig --startxonboot

#part / --size 16384 --fstype ext4
#part swap 12288
#part /boot 1024 --fstype ext4
#part /home 262144 --fstype ext4

services --enabled=NetworkManager --disabled=network,sshd

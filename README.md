AwesomeWM LiveSpin by (sea)
===========================


Description
-----------

This spin is localized to SwissGerman keyboard layout.
Also it is optimized for my taste of linux experience,
this might not be everyone's taste, and thats just fine.

It comes with basic office applications, such as AbiWord
and Gnumeric, as well as communication tools like XChat,
Thunderbird and FireFox.

Also it offers some basic development tools, such as git,
gcc, rpmbuild, mock, rpmlint, ssh.



Get the iso
------

Thanks to http://sourceforge.com i may offer you direct downloads of my built iso files.
You may download them from:

	[SourceForge Project Files](https://sourceforge.net/projects/awesomewmspin/files/)
	
If you are running Windows or Apple, you may want to use [Universal Netboot Installer](https://sourceforge.net/projects/unetbootin/) to write the iso to an USB-Stick.
If you are running Linux, Unix or BSD version, simply use dd, as in: `dd file.iso /dev/sdu`


Build Instruction
-----------------

Personaly, i do have my projects in $HOME/prjs/PROJECTNAME (change 'prj=' to whatever path applies to you).
Assuming you have a similar set up, here's the lazy setup:


	prj=$HOME/prjs/iso-awesome-sea
	git clone git://git.code.sf.net/p/awesomewmspin/code $prj
	#git clone https://github.com/sri-arjuna/awesome-spin.git $prj
	sudo ln -s $prj/make-iso.sh /usr/bin/make-awesome


Now edit the make-iso.conf in the $prj directory, so that the paths match your system. 

When done, simply type as regular user

		sudo make-awesome

and enjoy the new iso in your $HOME directory.
(Note, if run as root (as in: not with sudo), the iso will be in root's home dir)

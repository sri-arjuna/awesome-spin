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

If there is space left, it'll be made multimediable.



Build Instruction
-----------------

Personaly, i do have my projects in $HOME/prjs/PROJECTNAME.
Assuming you have a similar set up, here's the lazy setup:


	prj=$HOME/prjs/iso-awesome-sea
	git clone https://github.com/sri-arjuna/awesome-spin.git $prj
	sudo ln -s $prj/mk-iso-awesome-sea.sh /usr/bin/


Now edit the mk-iso-awesome-sea.sh, post-1-nochroot.ks and awesome.ks in
the $prj directory, so that the paths match your system. 

When done, simply type as regular user

		sudo mk-iso-awesome-sea.sh

and enjoy the new iso in your $HOME directory.
(Note, if run as root, the iso will be in root's home dir)

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

Copy the files to a folder, and edit the mk-iso-awesome-sea.sh,
post-1-nochroot.ks and awesome.ks so that the paths match your system.

From within that folder, type:

		sudo ln -s $(pwd)/mk-iso-awesome-sea.sh /usr/bin/

Now all you need to do, is a one time check if
you have all required packages installed:

		sudo yum install livecd-tools spin-kickstart

Now simply create the iso with:

		sudo mk-iso-awesome-sea.sh
		
And enjoy the new iso in your $HOME directory.

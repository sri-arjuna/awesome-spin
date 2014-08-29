#
#	Prepare custom /etc/skel files
#
%post
#!/bin/sh
#
# Change to skeldir
#
	cd /etc/skel
	ln -s liveinst.desktop notepad/liveinst.desktop
	mkdir -p net/{dls,pub,web,fas/scm} \
		notepad \
		priv/{templates,docs,cloud} \
		mm/{img,snd,vids} \
		prjs \
		data \
		.local/bin
#
# Write: /etc/skel	.bashrc
#
cat > .bashrc << EOF
#!/bin/bash
# .bashrc by sea, designed for sea's spin using AwesomeWM
#
#	Sources
#
	[ -f /etc/bashrc ] 				&& . /etc/bashrc	
	[ -f /etc/profile.d/tui.sh ] 			&& . /etc/profile.d/tui.sh
	[ -f \$HOME/.config/user-dirs.dirs ] 		&& . \$HOME/.config/user-dirs.dirs
	[ -f \$HOME/.config/prompt-colored-status.sh ] 	&& . \$HOME/.config/prompt-colored-status.sh
#
#	Aliases
#
	alias pm="sudo pm-suspend"
	alias yiy="sudo yum install -y"
	alias upd="sudo yum upgrade -y kernel* yum* ; sudo yum upgrade -y"
	alias ls="ls --group-directories-first --color=auto -h"
	alias ll="ls -l"
	alias lla="ls -la"
	alias la="ls -a"
	alias blame-log="blame >> \$HOME/data/blame.log;cat \$HOME/data/blame.log"
	alias gupd="sudo grub2-mkconfig \\
		-o $( [ -f /boot/grub2/grub.cfg ] && \\
			printf /boot/grub2/grub.cfg || \\
			printf /boot/efi/EFI/fedora/grub.cfg \\
			)"
	alias pis="tui-browser \\
		-t 'Script Manager' \\
		-d 'Cathegory' \\
		-f 'Script' \\
		-p $XDG_SCRIPTS_DIR"
#
#	Execute on terminal display
#
	#source /.config/prompt-colored-status.sh
	#sutra
EOF
	cat > cheatsheet-awesomewm-hotkeys.txt << EOF
## mod4 = Windows Button
## [1-9] = any number between 1 to 9
mod4 + ENTER				Opens a new terminal
mod4 + r				Enter a command/application
mod4 + [1-9]		(switch)	Desktop
mod4 + ctrl + [1-9]	(toggle)	Add Desktop [1-9] to current screen
mod4 + shift + [1-9]			Send active window to Desktop #[1-9]
mod4 + f		(toggle) 	Make active window fullscreen
mod4 + space		(next)  	Window arrangement
mod4 + shift + space 	(previous)	Window arrangement
mod4 + ctrl + r				Reload configuration (!! additional windows !!)
EOF

#
# Set up .config / dirs
#
	cd /etc/skel/.config
	cat > user-dirs.dirs << EOF
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
# 
XDG_DESKTOP_DIR="\$HOME/notepad"
XDG_SCRIPTS_DIR="\$HOME/.local/bin"
XDG_PROJECTS_DIR="\$HOME/prjs"
XDG_DOCUMENTS_DIR="\$HOME/priv/docs"
XDG_CLOUD_DIR="\$HOME/priv/cloud"
XDG_TEMPLATES_DIR="\$HOME/priv/templates"
XDG_DOWNLOAD_DIR="\$HOME/net/dls"
XDG_WEB_DIR="\$HOME/net/web"
XDG_FAS_DIR="\$HOME/net/fas"
XDG_PUBLICSHARE_DIR="\$HOME/net/pub"
XDG_MUSIC_DIR="\$HOME/mm/snd"
XDG_VIDEOS_DIR="\$HOME/mm/vids"
XDG_PICTURES_DIR="\$HOME/mm/img"
EOF

#
# Set up .config / prompt
#
	cat > prompt-colored-status.sh << EOF
#!/bin/bash
#
#	Name:		prompt-colored-status.sh
#	Desription:	Displays 4 diffrent values for each exitstatus of: 0 or 1
#	License:	GPLv3
#	Author: 	Simon A. Erat (sea), erat.simon@gmail.com
#	Created:	2013.07.15
#	Changed:	2013.09.02
#
#
#	Variables
#
	export esc="\\033"
	export reset="\${esc}[0m"
	export whitebg="\${esc}[47m"
	export whitefont="\${esc}[37m"
	export bluebg="\${esc}[44m"
	export bluefont="\${esc}[34m"
	export greenbg="\${esc}[42m"
	export greenfont="\${esc}[32m"
	export redbg="\${esc}[41m"
	export redfont="\${esc}[31m"
	export blackbg="\${esc}[40m"
	export PROMPT_COMMAND='RET=\$?;'
	export RET_VALUE='\$(echo \$RET)'
#
#	Color
#
	return_user_color() {
	# Returns white background and red font for root
	# Returns white background and blue font for users
		[ 0 -eq \$UID ] && echo "\${whitebg}\${redfont}" || echo "\${whitebg}\${bluefont}"
	}
	rnd() { # MAX [ MIN=0 ]
	# Returns a random number up to MAX, 
	# or if provided, between MIN and MAX.
		[ -z \$1 ] && echo "Usage: rnd MAXNUMBER [MINVALUE]" && \\
				return 1 || max=\$1
		[ -z \$2 ] && min=0 || min=\$2
		rnd=\$RANDOM

		while [ \$rnd -gt \$max ] && [ ! \$rnd -lt \$min ]; do rnd=\$((\$RANDOM*\$max/\$RANDOM)) ; done
		printf \$rnd
	}
	return_status_string() { # \$?
	# returns random strings depending on provided numberic argument
	# expect either 0 or 1, outputs number only otherwise
		good=('+' ':)' '✔' '^' )
		bad=( '-' ':(' '✘' 'v' )
		num=\$(rnd 2)
		
		if [ "\$1" -eq 0 ]
		then	echo "\${good[\$num]}"
		elif [ "\$1" -eq 1 ]
		then	printf "\${bad[\$num]}"
		else	printf "\$1"
		fi
	}
	return_status_color() { # $?
	# returns the color values according to its return value
	#
		case "\$1" in
		0)	echo -ne "\${greenbg}${bluefont}"	;;
		1)	echo -ne "\${redbg}${whitefont}"	;;
		*)	echo -ne "\${whitebg}${bluefont}"	;;
		esac
	}
	export -f rnd return_user_color return_status_color return_status_string
	RET_RND='\$(echo -e \$(return_status_color \$RET))\$(echo -e \$(return_status_string \$RET))'
#
#	PS1
#
	export PS1="\$RET_RND\${reset} \w \$(return_user_color)\\\\\\$\${reset} "
EOF



#
# Write: /etc/skel	.config/lxterminal/lxterminal.conf
#
	mkdir lxterminal
	touch lxterminal/lxterminal.conf
	cat > lxterminal/lxterminal.conf << EOF
[general]
fontname=Monospace 10
selchars=-A-Za-z0-9,./?%&#:_
scrollback=10000
bgcolor=#000000000000
bgalpha=59624
fgcolor=#aaaaaaaaaaaa
disallowbold=false
cursorblinks=false
cursorunderline=false
audiblebell=false
tabpos=top
hidescrollbar=true
hidemenubar=true
hideclosebutton=false
disablef10=false
disablealt=false
EOF

#
# Write: /etc/skel	.config/autostart/first.sh
#
	mkdir autostart
	touch autostart/first.sh
	chmod +x autostart/first.sh
	cat > autostart/first.sh << EOF
#!/bin/bash
# Write default folder location to gtk bookmarks.
#
#	Variables
#
	GTK2=\$HOME/.gtk-bookmarks
	GTK3=\$HOME/.config/gtk-3.0/bookmarks
	CONTENT="file://\$HOME/priv/docs Documents
file://\$HOME/prjs Projects
file://\$HOME/.local/bin Scripts
file://\$HOME/net Internet
file://\$HOME/mm Multimedia
file:///run/media/\$USER/ Hub
file:///mnt Mounts"
#
# 	Action
#
	[ -f \$GTK3 ] && \\
		DEST=\$GTK3 || \\
		DEST=\$GTK2
	printf "\$CONTENT" > "\$DEST"
	rm -f \$0 &
EOF


#
#	(re)Do customization outside of livesys script
#

# set up auto-login for liveuser
sed -i s/"# autologin=dgod"/"autologin=liveuser"/g /etc/lxdm/lxdm.conf

# Make awesome the default session, as Awesome is the only one, not required
# sed -i s,"session=/usr/bin/startlxde","session=/usr/bin/awesome",g /etc/lxdm/lxdm.conf

# Get a cool background
[[ -f /usr/share/backgrounds/default-fedora.png ]] || mv /usr/share/backgrounds/default.png /usr/share/backgrounds/default-fedora.png
ln -sf /etc/skel/.config/awesome/img/background.jpg /usr/share/backgrounds/default.png
sed -i s,"bg=/usr/share/backgrounds/default.png","bg=/etc/skel/.config/awesome/img/background.jpg",g /etc/lxdm/lxdm.conf

# Remove language panel
sed -i s/"lang=1"/"lang=0"/g /etc/lxdm/lxdm.conf

%end

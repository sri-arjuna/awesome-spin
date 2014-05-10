#
#	Custom : in chroot
#
%post
#!/bin/sh
#
#	Do install tui, so reporting is more visible
#
	echo "--	--	--	--		--"
	echo
	echo

	echo "		start tui install (chroot)...		DEBUG"

	echo
	echo
	echo "--	--	--	--		--"

	/sea/tui/install.sh
#
#	'Install' my stuff, 
#	that has been placed in $root/sea/NAME
#
	[ -d /etc/skel/.config ] || mkdir -p /etc/skel/.config
	mv /sea/tui-sutra	/usr/share/tui-sutra
	mv /sea/vicious	/usr/share/awesome/lib/vicious
	mv /sea/awesome /etc/skel/.config/awesome
	rmdir /sea
#
#	Customize... GRUB2 Theme & Plymouth
#
	theme=/usr/share/grub/themes/circled-nasa-spiral/theme.txt
	[[ " = "$(grep GRUB_THEME)" ]] && \
		echo "GRUG_THEME=\"$theme\"" >> /etc/default/grub || \
		sed s,"$(grep GRUB_THEME)","GRUB_THEME=\"$theme\"",g -i /etc/default/grub
	
	#tui-title "Rebuild grub2"
	[ -f /boot/efi/EFI/fedora/grub.cfg ] && \
		grb_cfg=/boot/efi/EFI/fedora/grub.cfg || \
		grb_cfg=/boot/grub2/grub.cfg
	grub2-mkconfig -o $grb_cfg
	#tui-title "Rebuild plymouth"
	plymouth-set-default-theme solar -R
#
#	Prepare tui-sutra
#
	ln -s /usr/share/tui-sutra/sutra /usr/bin/sutra
#
#	Awesome config
#
	[ -d /etc/skel/.config ] || mkdir -p /etc/skel/.config
	mv /tmp/awesome /etc/skel/.config/
#
#	XDG-User-Dirs
#	
	tui-title "TRY : Hardcoded /etc/skel/.config/user-dirs.dirs"
	cd /etc/skel
	mkdir -p net/{dls,pub,web,fas/scm} \
		notepad \
		priv/{templates,docs,cloud} \
		mm/{img,snd,vids} \
		prjs
	cat > /etc/skel/.config/user-dirs.dirs << EOF
#\$HOME/.config/user-dirs.dirs
XDG_DESKTOP_DIR="\$HOME/notepad"
XDG_DOWNLOAD_DIR="\$HOME/net/dls"
XDG_PUBLICSHARE_DIR="\$HOME/net/pub"
XDG_MUSIC_DIR="\$HOME/mm/snd"
XDG_PICTURES_DIR="\$HOME/mm/img"
XDG_VIDEOS_DIR="\$HOME/mm/vids"
XDG_TEMPLATES_DIR="\$HOME/priv/templates"
XDG_DOCUMENTS_DIR="\$HOME/priv/docs"
XDG_CLOUD_DIR="\$HOME/priv/cloud"
XDG_PROJECTS_DIR="\$HOME/prjs"
XDG_WEB_DIR="\$HOME/net/web"
XDG_FAS_DIR="\$HOME/net/fas"
XDG_SCM_DIR="\$HOME/net/fas/scm"
XDG_SCRIPTS_DIR="\$HOME/.local/bin"
EOF
	cat /etc/skel/.config/user-dirs.dirs
	echo "Is custom .bashrc shown?"
	read -p "Continue?" buffer

	cat > /etc/skel/.config/prompt-colored-status.sh << EOF
#!/bin/bash
#
#	Variables
#
	export esc="\033"
	export reset="${esc}[0m"
	export whitebg="${esc}[47m"
	export whitefont="${esc}[37m"
	export blackbg="${esc}[40m"
	export redfont="${esc}[31m"
	export redbg="${esc}[41m"
	export bluefont="${esc}[34m"
	export greenbg="${esc}[42m"
	export greenfont="${esc}[32m"
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
		[ -z \$1 ] && echo "Usage: rnd MAXNUMBER [MINVALUE]" && \
				return 1 || max=\$1
		[ -z \$2 ] && min=0 || min=\$2
		rnd=$RANDOM

		while [ \$rnd -gt \$max ] && [ ! \$rnd -lt \$min ]; do rnd=\$((\$RANDOM*\$max/\$RANDOM)) ; done
		echo \$rnd
	}
	return_status_string() { # \$?
	# returns random strings depending on provided numberic argument
	# expect either 0 or 1, outputs number only otherwise
		good=('+' ':)' '✔' )
		bad=('-' ':(' '✘' )
		num=\$(rnd 2)
		
		if [ "\$1" -eq 0 ]
		then	echo "\${good[\$num]}"
		elif [ "\$1" -eq 1 ]
		then	echo "\${bad[\$num]}"
		else	echo "\$1"
		fi
	}
	return_status_color() { # \$?
	# returns the color values according to its return value
	#
		case "\$1" in
		0)	echo -ne "\${greenbg}\${bluefont}"	;;
		1)	echo -ne "\${redbg}\${whitefont}"		;;
		*)	echo -ne "\${whitebg}\${bluefont}"	;;
		esac
	}
	export -f rnd return_user_color return_status_color return_status_string
	RET_RND='\$(echo -e \$(return_status_color \$RET))\$(echo -e \$(return_status_string \$RET))'
#
#	PS1
#
	export PS1="\$RET_RND\${reset} \w \$(return_user_color)\\\\$\${reset} "	
EOF
	printf "source \$HOME/.config/prompt-colored-status.sh" >> /etc/skel/.bashrc

	cat >> /etc/skel/.bashrc << EOF
source \$HOME/.config/user-dirs.dirs
alias pm="sudo pm-suspend"
alias yiy="sudo yum install -y"
alias upd="sudo yum upgrade -y kernel* yum* ; sudo yum upgrade -y"
alias gupd="sudo grub2-mkconfig \
	-o \$( [ -f printf /boot/grub2/grub.cfg ] && \
		printf /boot/grub2/grub.cfg || \
		printf /boot/efi/EFI/fedora/grub.cfg \
		)"
alias ls="ls --group-directories-first --color=auto -h"
alias ll="ls -l"
alias lla="ls -la"
alias la="ls -a"
alias blame-log="blame >> \$HOME/blame.log;cat \$HOME/blame.log"
alias pis="cd \$XDG_SCRIPTS_DIR ; sudo tui-browser \\
	-t 'Script Manager' \\
	-d 'Cathegory' \\
	-f 'Script' \\
	; cd \$OLDPWD "
export pis

# Custom PS1 prompt
source \$HOME/.config/prompt-colored-status.sh
sutra
EOF






# LXDE and LXDM configuration

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/awesome
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
/usr/libexec/notification-daemon
FOE

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE 
[Preferred Applications]
WebBrowser=firefox.desktop
MailClient=thunderbird.desktop
FOE

# set up auto-login for liveuser
sed -i 's/# autologin=.*/autologin=liveuser/g' /etc/lxdm/lxdm.conf

# Make awesome the default session
sed -i 's/session=.*/session=/usr/bin/awesome/g' /etc/lxdm/lxdm.conf


# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/notepad
cp /usr/share/applications/liveinst.desktop /home/liveuser/notepad

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser


%end

#!/bin/bash
# .bashrc by sea, designed for sea's spin using AwesomeWM
#
#	Sources
#
	[ -f /etc/bashrc ] 				&& . /etc/bashrc	
	[ -f /etc/profile.d/tui.sh ] 			&& . /etc/profile.d/tui.sh
	[ -f $HOME/.config/user-dirs.dirs ] 		&& . $HOME/.config/user-dirs.dirs
#
#	Path Updates
#
	[ -d $HOME/.local/bin ]				&& PATH+=":$HOME/.local/bin"
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
	alias blame-log="blame >> $HOME/data/blame.log;cat $HOME/data/blame.log"
	alias uptime="uptime >> $HOME/data/uptime.log;tail $HOME/data/uptime.log"
	alias psy="ps -hux"
	alias topy="top -o RES -csn 1"
	alias gupd="sudo grub2-mkconfig \
		-o $( [ -f /boot/grub2/grub.cfg ] && \
			printf /boot/grub2/grub.cfg || \
			printf /boot/efi/EFI/fedora/grub.cfg \
			)"
	alias pis="tui-browser \
		-t 'Script Manager' \
		-d 'Section' \
		-f 'Script' \
		-p $XDG_SCRIPTS_DIR"
#
#	Execute on terminal display, PS1 & a vedic sutra
#
	[ -f $HOME/.config/prompt-colored-status.sh ] 	&& . $HOME/.config/prompt-colored-status.sh
#	which sutra 1>/dev/zero 2>/dev/zero && \
#		sutra || echo "Namaste, $USER :)"
sh $HOME/.config/autostart/first.sh

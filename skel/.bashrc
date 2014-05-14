# .bashrc
#
#	Sources
#
	[ -f /etc/bashrc ] 				&& . /etc/bashrc	
	[ -f ~/.config/user-dirs.dirs ] 		&& . ~/.config/user-dirs.dirs
	[ -f /etc/profile.d/tui.sh ] 			&& . /etc/profile.d/tui.sh
	[ -f ${0##/*}/.config/prompt-colored-status.sh ] && \
		. ${0##/*}/.config/prompt-colored-status.sh
#
#	Aliases
#
	alias pm="sudo pm-suspend"
	alias yiy="sudo yum install -y"
	alias upd="sudo yum upgrade -y kernel* yum* ; sudo yum upgrade -y"
	alias gupd="sudo grub2-mkconfig \
		-o $( [ -f /boot/grub2/grub.cfg ] && \
			printf /boot/grub2/grub.cfg || \
			printf /boot/efi/EFI/fedora/grub.cfg \
			)"
	alias ls="ls --group-directories-first --color=auto -h"
	alias ll="ls -l"
	alias lla="ls -la"
	alias la="ls -a"
	alias blame-log="blame >> $HOME/blame.log;cat $HOME/data/blame.log"
	alias pis="tui-browser \
		-t 'Script Manager' \
		-d 'Cathegory' \
		-f 'Script' \
		-p $XDG_SCRIPTS_DIR"
#
#	Execute on terminal display
#
	#sutra

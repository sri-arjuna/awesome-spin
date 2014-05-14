#!/bin/bash
#
#	Desription:	Displays 4 diffrent values for each exitstatus of: 0 or 1
#	License:	GPLv3
#	Author: 	Simon A. Erat (sea), sea@fedorapeople.org
#	Created:	2013.07.15
#	Changed:	2013.09.02
#
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
	export PROMPT_COMMAND='RET=$?;'
	export RET_VALUE='$(echo $RET)'
#
#	Color
#
	return_user_color() {
	# Returns white background and red font for root
	# Returns white background and blue font for users
		[ 0 -eq $UID ] && echo "${whitebg}${redfont}" || echo "${whitebg}${bluefont}"
	}
	rnd() { # MAX [ MIN=0 ]
	# Returns a random number up to MAX, 
	# or if provided, between MIN and MAX.
		[ -z $1 ] && echo "Usage: rnd MAXNUMBER [MINVALUE]" && \
				return 1 || max=$1
		[ -z $2 ] && min=0 || min=$2
		rnd=$RANDOM

		while [ $rnd -gt $max ] && [ ! $rnd -lt $min ]; do rnd=$(($RANDOM*$max/$RANDOM)) ; done
		echo $rnd
	}
	return_status_string() { # $?
	# returns random strings depending on provided numberic argument
	# expect either 0 or 1, outputs number only otherwise
		good=('+' ':)' '✔' )
		bad=('-' ':(' '✘' )
		num=$(rnd 2)
		
		if [ "$1" -eq 0 ]
		then	echo "${good[$num]}"
		elif [ "$1" -eq 1 ]
		then	echo "${bad[$num]}"
		else	echo "$1"
		fi
	}
	return_status_color() { # $?
	# returns the color values according to its return value
	#
		case "$1" in
		0)	echo -ne "${greenbg}${bluefont}"	;;
		1)	echo -ne "${redbg}${whitefont}"		;;
		*)	echo -ne "${whitebg}${bluefont}"	;;
		esac
	}
	export -f rnd return_user_color return_status_color return_status_string
	RET_RND='$(echo -e $(return_status_color $RET))$(echo -e $(return_status_string $RET))'
#
#	PS1
#
	export PS1="$RET_RND${reset} \w $(return_user_color)\\\$${reset} "

#!/bin/bash
#
#	Copy awesome wm config
#
	[ -d /etc/skel/.config/awesome ] && mv /etc/skel/.config/awesome /etc/skel/.config/awesome.bak
	[ -d /etc/skel/.config ] || mkdir -p /etc/skel/.config
	mv /tmp/awesome /etc/skel/.config/

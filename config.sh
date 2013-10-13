#!/bin/sh
DEST=/usr/share/spin-kickstarts
[[ ! -d $DEST ]] && mkdir -p $DEST

sudo cp ./fedora*ks $DEST
cp sea*ks $HOME

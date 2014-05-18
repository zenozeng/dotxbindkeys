#!/bin/bash

type xbindkeys >/dev/null 2>&1 || { echo >&2 "xbindkeys not installed, aborting."; exit 1; }
type xdotool >/dev/null 2>&1 || { echo >&2 "xdotool not installed, aborting."; exit 1; }
mkdir -p ~/.dotxbindkeys/plugins
mkdir -p ~/.dotxbindkeys/lib
mkdir -p ~/.dotxbindkeys/user
cp -f lib/* ~/.dotxbindkeys/lib
touch ~/.dotxbindkeys/user/user.scm
if [ -e "/home/$USER/.xbindkeysrc.scm" ]; then
    echo "Found .xbindkeysrc.scm, mv to ~/.xbindkeysrc.scm.bak"
    mv ~/.xbindkeysrc.scm ~/.xbindkeysrc.scm.bak
fi
if [ -e "/home/$USER/.xbindkeysrc" ]; then
    echo "Found .xbindkeysrc, mv to ~/.xbindkeysrc.bak"
    mv ~/.xbindkeysrc ~/.xbindkeysrc.bak
fi
cp init.scm ~/.xbindkeysrc.scm
sudo cp -f bin/* /usr/local/bin
echo "dotxbindkyes installed."

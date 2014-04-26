#!/bin/bash

type xbindkeys >/dev/null 2>&1 || { echo >&2 "xbindkeys not installed, aborting."; exit 1; }
type xdotool >/dev/null 2>&1 || { echo >&2 "xdotool not installed, aborting."; exit 1; }
mkdir -p ~/.dotxbindkeys/plugins
cp -i scheme/* ~/.dotxbindkeys
yes | cp -f bin/* ~/.local/bin

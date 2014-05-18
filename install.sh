#!/bin/bash

type xbindkeys >/dev/null 2>&1 || { echo >&2 "xbindkeys not installed, aborting."; exit 1; }
type xdotool >/dev/null 2>&1 || { echo >&2 "xdotool not installed, aborting."; exit 1; }

mkdir -p /usr/local/lib/dotxbindkeys/
cp -f lib/*.scm /usr/local/lib/dotxbindkeys/
cp -f bin/* /usr/local/bin
echo "dotxbindkyes installed."

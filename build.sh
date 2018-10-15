#!/bin/bash
set -e

SCRIPT=$(readlink "$0")
CONFIGPATH=$(dirname "$SCRIPT")

if [ "$1" == 'list' ]
then
	ls "$CONFIGPATH"
	exit
fi

if [ ! -f "$CONFIGPATH/$1" ]
then
	echo "Can't find config file \"$1\""
	exit
fi

read -p "Want to update package sources? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	scripts/feeds update -a -r
	scripts/feeds install -a
fi

cp "$CONFIGPATH/$1" .config
make defconfig
scripts/diffconfig.sh

echo "Look good? Press enter."
read

# Swallow the first argument
shift

nice make "$@"

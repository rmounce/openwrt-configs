#!/bin/sh

SCRIPT=$(readlink "$0")
CONFIGPATH=$(dirname "$SCRIPT")

cp "$CONFIGPATH/$1" .config
make defconfig
scripts/diffconfig.sh

echo "Look good? Press enter."
read

make -j4

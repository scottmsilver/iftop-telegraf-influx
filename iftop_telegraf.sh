#!/bin/sh  

SCRIPT=$(readlink -f "${0}")

# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")


/usr/local/sbin/iftop -nNb -i igb1 -s 1 -o 2s -t -L 100 2>/dev/null | awk -f $SCRIPTPATH/iftop_parse.awk | $SCRIPTPATH/iftop_telegraf.py

#!/bin/sh  

SCRIPT=$(readlink -f "${0}")

# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

# Update this interface to the interface you wish to monitor.
# Typically this is the LAN interface (the one that is your private network at home)
IFACE=igb1

/usr/local/sbin/iftop -nNb -i $IFACE -s 1 -o 2s -t -L 100 2>/dev/null | awk -f $SCRIPTPATH/iftop_parse.awk | $SCRIPTPATH/iftop_telegraf.py

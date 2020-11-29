#!/bin/sh  

# Path for this script.
SCRIPT=$(readlink -f "${0}")

# Absolute path this script is in (you don't need to change this)
SCRIPTPATH=$(dirname "$SCRIPT")

# Update this interface to the interface you wish to monitor.
# Typically this is the LAN interface (the one that is your private network at home)
IFACE=igb1

# Get a list of talkers by sampling for 2 seconds, up to 100 streams, and then dump them out
# to an awk script that elides out all but the hosts, then parse them in a simple python script that outputs the data in telegraf line format.
/usr/local/sbin/iftop -nNb -i $IFACE -s 1 -o 2s -t -L 100 2>/dev/null | awk -f $SCRIPTPATH/iftop_parse.awk | $SCRIPTPATH/iftop_telegraf.py

#!/usr/local/bin/python3.7

import csv
import socket
import sys
import re

def getHostName(ipAddress):
	hostName = ipAddress

	try:
		hostName = socket.gethostbyaddr(ipAddress.strip())[0]
	except socket.herror:
		pass

	return hostName

def prefixToMultiplier(prefix):
	multiplier = {
		'K': 1000,
		'M': 1000000,
    'G': 1000000000
	}

	return multiplier.get(prefix, 1)


def expandBitRate(bitRate):
	groups = re.match(r"(\d+\.?\d*)(?:(K|M|G)?)", bitRate).groups()
	multiplier = 1.0
	if len(groups) > 1:
		multiplier = prefixToMultiplier(groups[1])

	value = float(groups[0])
	return value * multiplier


with sys.stdin as csvfile:
	csvReader = csv.reader(csvfile)
	for row in csvReader:
		(senderIp, receiverIp, receiveRate, sendRate) = (row[0], row[1], expandBitRate(row[2]), expandBitRate(row[3]))
		sender = getHostName(senderIp)
		receiver = getHostName(receiverIp)
#		print("%s -> %s %s %s" % (sender, receiver, sendRate, receiveRate))

		print("hosts,sender=" + sender + ",receiver=" + receiver + " sendRate=" + str(sendRate) + ",receiveRate=" + str(receiveRate))

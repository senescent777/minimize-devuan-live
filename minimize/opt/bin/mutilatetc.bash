#!/bin/bash
exit 99

	c=$(find /etc -name 'iptab*' -type d -perm /o+w,o+r,o+x | wc -l)
       	c=$(find /etc -name 'iptab*' -type d -perm /g+w | wc -l)
	gf /etc iptab
	${odio} rm /etc/default/rules*
	c=$(${odio} find /etc -name 'rules.v?.?' -type f -perm /g+x,g+w | wc -l)
	gh /etc rules.v
	c=$(find /etc -name 'sudoers*' -type d -perm /o+w,o+r,o+x | wc -l)
	gf /etc sudoers
	c=$(find /etc/sudoers.d -type f -perm /o+w,o+r,o+x | wc -l)
	gf /etc/sudoers.d
		c=$(find /etc -name 'ntp*' -type f -perm /o+w | wc -l)
		gh /etc ntp
	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default
	for f in /etc/resolv.conf /etc/dhcp/dhclient.conf ; do
	if [ -h /etc/network/interfaces ] ; then
		${smr} /etc/network/interfaces
		${svm} /etc/network/interfaces /etc/network/interfaces.OLD
	[ -f /etc/resolv.conf.${t} ] && ${slinky} /etc/resolv.conf.${t} /etc/resolv.conf
	[ -f /etc/dhcp/dhclient.conf.${t} ] && ${slinky} /etc/dhcp/dhclient.conf.${t} /etc/dhcp/dhclient.conf
	[ -f /etc/network/interfaces.${t} ] && ${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
	for f in $(find /etc -type f -name 'ntp*') ; do
	${scm} 0555 /etc/dhcp
	${scm} 0555 /etc/network
	${sco} root:root /etc/network 
	${scm} 0555 /etc/init.d/ntpsec
	${sco} 0:0 /etc/init.d/ntpsec

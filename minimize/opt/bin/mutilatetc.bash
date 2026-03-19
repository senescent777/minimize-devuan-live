#!/bin/bash
exit 99

#TODO:ao. komennoista järkevä kokonaisuus josqs
	c=$(find /etc -name 'iptab*' -type d -perm /o+w,o+r,o+x | wc -l)
		[ ${c} -gt 0 ] && exit 111

       	c=$(find /etc -name 'iptab*' -type d -perm /g+w | wc -l)
	[ ${c} -gt 0 ] && exit 123

	gf /etc iptab
	${odio} rm /etc/default/rules*

	c=$(${odio} find /etc -name 'rules.v?.?' -type f -perm /g+x,g+w | wc -l)
	[ ${c} -gt 0 ] && exit 114

	gh /etc rules.v
	c=$(find /etc -name 'sudoers*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 117
	gf /etc sudoers

	c=$(find /etc/sudoers.d -type f -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 120
	gf /etc/sudoers.d

		c=$(find /etc -name 'ntp*' -type f -perm /o+w | wc -l)
		gh /etc ntp

	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default

	for f in /etc/resolv.conf /etc/dhcp/dhclient.conf ; do
		#tisi olla linkkiyts.tarkistus ensin
		dqb "NOt A SHARk... link: ${f}"
		#	${svm} ${f} ${f}.OLD
	done

	if [ -s /sbin/dhclient-script.1 ] || [ -s /sbin/dhclient-script.0 ] ; then 	
		${smr} /sbin/dhclient-script
		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHIOLE TRYINMG TO REMOVE DHCLIENT-SCRIPT"
	fi

	if [ -h /etc/network/interfaces ] ; then
		${smr} /etc/network/interfaces
	else
		${svm} /etc/network/interfaces /etc/network/interfaces.OLD
	fi

	#t piytäis johtaa jostain ensin

	[ -f /etc/resolv.conf.${t} ] && ${slinky} /etc/resolv.conf.${t} /etc/resolv.conf
	[ -f /etc/dhcp/dhclient.conf.${t} ] && ${slinky} /etc/dhcp/dhclient.conf.${t} /etc/dhcp/dhclient.conf
	[ -f /etc/network/interfaces.${t} ] && ${slinky} /etc/network/interfaces.${t} /etc/network/interfaces

	#for f in ???
	#	${scm} 0444 ${f}
	#	${sco} root:root ${f}
	#done

	for f in $(find /sbin -type f -name 'dhclient*') ; do
		${scm} 0555 ${f}
		${sco} root:root ${f}
	done

	for f in $(find /etc -type f -name 'ntp*') ; do
		${scm} 0444 ${f}
                ${sco} root:root ${f}
	done

	${scm} 0555 /etc/dhcp
	${scm} 0555 /etc/network
	${sco} root:root /etc/network 
	${scm} 0555 /etc/init.d/ntpsec
	${sco} 0:0 /etc/init.d/ntpsec

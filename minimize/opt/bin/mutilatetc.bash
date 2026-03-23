#!/bin/bash
#exit 99
#
#VAIH:ao. komennoista järkevä kokonaisuus josqs

function gf() {
	dqb "gf $1, $2"
	csleep 1

	[ -z "${1}" ] && exit 103
	local c2

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type d -not -user 0 | wc -l)
	else
		dqb "find ${1} -name ${2} -type d -not \$smthing"
		c2=$(${odio} find ${1} -name '${2}*' -type d -not -user 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 104

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type d -not -group 0 | wc -l)
	else
		c2=$(${odio} find ${1} -name '${2}*' -type d -not -group 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 105
}

function gh() {
	dqb "gh $1 , $2"
	csleep 1

	[ -z "${1}" ] && exit 108
	local c2
	dqb "raps.0kj"

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type f  -not -user 0 | wc -l)
	else
		dqb "find ${1} -type f -name "
		c2=$(${odio} find ${1} -type f -name '${2}*' -not -user 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 106

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type f -not -group 0 | wc -l)
	else
		c2=$(${odio} find ${1} -type f -name '${2}*' -not -group 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 107
}

function init2 {
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
}

init2

function p3r1m3tr() {
	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default
}

p3r1m3tr

function clouds_pp1() {
	dqb "#c.pp.1  ( ${1} )"
	local f

	for f in /etc/resolv.conf /etc/dhcp/dhclient.conf ; do
		if [ -h ${f} ] ; then #mikä ero -L nähden?
			if [ -s ${f}.1 ] || [ -s ${f}.0 ] ; then #riittäisikö nämä tark?
				${smr} ${f}
				[ $? -gt 0 ] && dqb "FAILURE TO COMPLY WHILE TRYING TO REMOVE ${f}"
			fi
		else
			dqb "NOt A SHARk... link: ${f}"
			${svm} ${f} ${f}.OLD
		fi
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

	csleep 1
	dqb "...done"
}

function clouds_pre() {
	dqb "cdns.clouds_pre( ${1}, ${2} )"
	csleep 1

	clouds_pp1
	csleep 1
	#clouds_pp2 ${1} #vissiin common_lib.change_bin1:stä löytyy syy miksi rules.v$x.$y tyhjenee
	#clouds_pp3 ${1}
	csleep 1

	dqb "... done"
}

function clouds_post() {
	dqb "cdns.clouds_post() "
	dqb "scm= ${scm}"
	dqb "sco =${sco}"

	csleep 1
	local f

	for f in $(find /etc -type f -name 'resolv.conf*') ; do
		${scm} 0444 ${f}
		${sco} root:root ${f}
	done	

	for f in $(find /etc -type f -name 'dhclient*') ; do
		${scm} 0444 ${f}
		${sco} root:root ${f}
	done

	${scm} 0555 /etc/dhcp

	for f in $(find /sbin -type f -name 'dhclient*') ; do
		${scm} 0555 ${f}
		${sco} root:root ${f}
	done

	${scm} 0555 /sbin
	p3r1m3tr	

	for f in $(find /etc -type f -name 'ntp*') ; do
		${scm} 0444 ${f}
                ${sco} root:root ${f}
	done	
	
	for f in $(find /etc/network -type f -name 'interface*') ; do
		${scm} 0444 ${f}
		${sco} root:root ${f}
	done


	${scm} 0555 /etc/dhcp
	${scm} 0555 /etc/network
	${sco} root:root /etc/network 
	${scm} 0555 /etc/init.d/ntpsec
	${sco} 0:0 /etc/init.d/ntpsec


	if [ ${debug} -eq 1 ] ; then
		${ipt} -L  #
		${ip6t} -L #parempi ajaa vain jos löytyy
		csleep 1 #
	fi #

	dqb "d0n3"
}

#====================================================================
clouds_pre ${mode}
#t pitäis i johtaa jostain ensin? mode?

[ -f /etc/resolv.conf.${t} ] && ${slinky} /etc/resolv.conf.${t} /etc/resolv.conf
[ -f /etc/dhcp/dhclient.conf.${t} ] && ${slinky} /etc/dhcp/dhclient.conf.${t} /etc/dhcp/dhclient.conf
[ -f /etc/network/interfaces.${t} ] && ${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
#=================fktiån ulkopuolella olivat nuo 3 riviä==================================================

clouds_post
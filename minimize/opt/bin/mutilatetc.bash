#!/bin/bash
#exit 99

#VAIH:ao. komennoista järkevä kokonaisuus josqs
debug=1
odio="/usr/bin/sudo"
smr=$(${odio} which rm)
svm=$(${odio} which mv)
scm=$(${odio} which chmod)
sco=$(${odio} which chown)
slinky=$(${odio} which ln)
slinky="${odio} ${slinky} -s "
ipt=$(${odio} which iptables)
ip6t=$(${odio} which ip6tables)
gg=$(${odio} which gpg)
sah6=$(${odio} which sha512sum)

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

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

gf /opt/bin/zxcv
#chattrin kanssa käviSi ktevämmin, lisäksi pitäisi reagoida jyrkemmin?
c3=$(find /opt -name 'zxcv*' -type f -perm /o+w,g+w,u+w | wc -l)
[ ${c3} -gt 0 ] && exit 105
c3=$(find /opt -name 'zxcv*' -type f -perm /o+r,g+r | wc -l)
[ ${c3} -gt 0 ] && exit 106

#vähän kiikun kaakun onko fiksua sudottaa noita ao. komentoja , gg tilapäisesti jemmaan 280326
#if [ ! -z "${gg}" ] ; then
#	if [ -x ${gg} ] ; then
#		${odio} ${gg} --verify /opt/bin/zxcv.sig
#		[ $? -eq 0 ] || exit 107
#	fi
#fi
#
${odio} ${sah6} --ignore-missing -c /opt/bin/zxcv
[ $? -eq 0 ] || exit 108

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

function itin2 {
	local c
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

itin2

function p3r1m3tr() {
	${scm} 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	${sco} -R root:root /etc/iptables
	${scm} 0400 /etc/default/rules*
	${sco} -R root:root /etc/default
}

p3r1m3tr

function clouds_pp1() {
	dqb "#c.pp.1  ( ${1} )"
	local f
	local c0

	for f in etc/resolv.conf etc/dhcp/dhclient.conf ; do
		if [ -h ${f} ] ; then #mikä ero -L nähden?
			c0=$(find / -type f -name "${f}.*" | wc -l)
			#if [ -s ${f}.1 ] || [ -s ${f}.0 ] ; then #riittäisikö nämä tark?

			if [ ${c0} -gt 0 ] ; then
				${smr} ${f}
				[ $? -gt 0 ] && dqb "FAILURE TO COMPLY WHILE TRYING TO REMOVE ${f}"
			else
				dqb "N.S.T.A.S: ${f}.xxx"
			fi
		else
			dqb "NOt A SHARk... link: ${f}"
			${svm} ${f} ${f}.OLD
		fi
	done

#280326:toistaiseksi jemmaan dhslcient-skriptiin sekaantuminen kunnes miettinyt vähän
#	c0=$(find /sbin -type f -name 'dhclient-script.*' | wc -l)
#	#
#	#if [ -s /sbin/dhclient-script.1 ] || [ -s /sbin/dhclient-script.0 ] ; then 
#
#	if [ ${c0} -gt 0 ] ; then 
#		${smr} /sbin/dhclient-script
#		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHIOLE TRYINMG TO REMOVE DHCLIENT-SCRIPT"
#	fi

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

	#sitten oli vielä /o/b/z listan sisällön pakottaminen, oikeastaan

	${scm} 0555 /etc/dhcp
	${scm} 0555 /etc/network
	${sco} root:root /etc/network
	${scm} 0555 /etc/init.d/ntpsec
	${sco} 0:0 /etc/init.d/ntpsec

	if [ ${debug} -eq 1 ] ; then
		${ipt} -L  #
		csleep 1
		dqb "666"
		${ip6t} -L #olisi parempi ajaa vain jos löytyy
		csleep 1 #
	fi #

	dqb "d0n3"
}

#====================================================================
[ $# -lt 1 ] && exit 99
t=$(echo ${1} | tr -dc a-zA-Z0-9/.)

clouds_pre ${t}
#ei olisi hyväksi hukata /e/r.conf

if [ -f /etc/resolv.conf.${t} ] ; then
	${slinky} /etc/resolv.conf.${t} /etc/resolv.conf
	[ $? -eq 0 ] || echo "LINKING FAILED"
else
	dqb "WHERE IS /etc/resolv.conf.${t} ???"
fi

sleep 10
#280326:dhc-juttuihin liittyen miten sitten jos tunaroi dhclient-script:in kanssa? (common_lib saattaa liittyä myös)
#... man dhclient.conf tietysti 1 lähtökohta

#jotain purpatusta näistäkin
[ -f /etc/dhcp/dhclient.conf.${t} ] && ${slinky} /etc/dhcp/dhclient.conf.${t} /etc/dhcp/dhclient.conf
[ -f /etc/network/interfaces.${t} ] && ${slinky} /etc/network/interfaces.${t} /etc/network/interfaces

#=================fktiån ulkopuolella olivat nuo 3 riviä==================================================

clouds_post

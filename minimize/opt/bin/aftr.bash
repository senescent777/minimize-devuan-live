#!/bin/bash
debug=1

if [ -f /.chroot ] ; then
        odio=""
else
        odio=$(which sudo)
fi

function dqb() {
        [ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
        [ ${debug} -eq 1 ] && sleep ${1}
}

ipt=$(${odio} which iptables)
ip6t=$(${odio} which ip6tables)
iptr=$(${odio} which iptables-restore)
ip6tr=$(${odio} which ip6tables-restore)
#==========jokin kirjasto olisi hyvä laatia näille skripteille ===========

#TODO:jokin param resolv.vonf-kikkailuja varten?
#TODO:entäse dot?

${ipt} -A INPUT -p udp -m udp --sport 53 -j b 
${ipt} -A OUTPUT -p udp -m udp --dport 53 -j e

function dda_snd() {
	dqb "dda_snd( ${1})"

	local t
	local u

	t=$(echo ${1} | tr -d -c 0-9.) # | cut -c 15) eivielä
	u=$(echo ${1} | grep 192.168 | wc -l) #

	if [ ${u} -gt 0 ] ; then
		dqb "AA"
		${ipt} -A u -p udp -m udp -s ${t} --sport 53 -j ACCEPT 
		${ipt} -A v -p udp -m udp -d ${t} --dport 53 -j ACCEPT
	else
		dqb "AB"
		#HUOM.070326:oli AIEmmin -{s,d} ${t} ja sitten taas
		${ipt} -A b -p udp -m udp -s ${t} --sport 53 -j ACCEPT 
		${ipt} -A e -p udp -m udp -d ${t} --dport 53 -j ACCEPT
	fi
}

function tod_dda() { 
	dqb "tod_dda( ${1} ) "
#
#	local t
#	t=$(echo ${1} | tr -d -c 0-9. | cut -c 15) #cut uutena, olisi hyvä laittaa toimimaan toivotulla tavalla kanssa
#
#	${ipt} -A u -p tcp --sport 853 -s ${t} -j c
#	${ipt} -A v -p tcp --dport 853 -d ${t} -j f
}

#up/post-up tämäkin
function clouds_case1_1() {
	if [ -s /home/stubby/.stubby.yml ] ; then
		for s in $(grep -v '#' /home/stubby/.stubby.yml | grep address_data | cut -d ':' -f 2) ; do tod_dda ${s} ; done
	else
		dqb "NO CONF FOUND, HAVE TO USE ALT CONF"

		if [ z"${CONF_dsn}" != "z" ] ; then
			for s in ${CONF_dsn} ;  do tod_dda ${s} ; done
		fi
	fi
}

if [ -s /etc/resolv.conf ] ; then
	for s in $(grep -v '#' /etc/resolv.conf | grep names | grep -v 127. | awk '{print $2}') ; do 
		dda_snd ${s}
	done
fi


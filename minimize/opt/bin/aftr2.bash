#!/bin/bash
debug=1


#================================
#ntp-kikkailut erilliseen skriptiin?
#miten muuten ne ipt/netf-persistent? oliko niissä jotain skriptihakemistoa? pystyisikö käyttämään?

function ptn_dda() {
	
	local t
	local u

	t=$(echo ${1} | tr -d -c 0-9.) # | cut -c 15) eivielä
	u=$(echo ${1} | grep 192.168 | wc -l) #

	if [ ${u} -gt 0 ] ; then
		${ipt} -A u -p udp -m udp -s ${t} --sport 123 -j ACCEPT
		${ipt} -A v -p udp -m udp -d ${t} --dport 123 -j ACCEPT
	else
		${ipt} -A b -p udp -m udp -s ${t} --sport 123 -j ACCEPT
		${ipt} -A e -p udp -m udp -d ${t} --dport 123 -j ACCEPT
	fi
}

function ptn2() {
	if [ -x /usr/sbin/ntpd ] ; then
		${ipt} -A INPUT -p udp -m udp --sport 123 -j b 
		${ipt} -A OUTPUT -p udp -m udp --dport 123 -j e

		csleep 1
		dqb "SHOULD START /etc/init.d/ntpsec AROUND HERE"
		csleep 1
	fi
}

function clouds_case0_2() {
	/etc/init.d/dnsmasq stop
	${whack} dnsmasq*
}

function clouds_case1_2() {
	echo "dns";sleep 1
	/etc/init.d/dnsmasq restart
	pgrep dnsmasq

}

#!/bin/bash
debug=0
#distro=""
mode=-1
distro=$(cat /etc/devuan_version)

chmod a-wx ./clouds*
chown root:root ${0}
chmod 0555 ${0}

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function pr4() {
	dqb "cdns.pr4 (${1})" 
}

function pre_part3() {
	dqb "cdns.pre_part3( ${1})"
}

#asiasta kukkaruukkuun: wicd oli aikoinaan siedettävä softa, ainakin Networkmanageriin verrattuna

#HUOM.jatkossa ehkä parempi että komentorivioptioilla ei aktivoida debugia
mode=${1}
[ -d ~/Desktop/minimize/${2} ] && distro=${2}

case $# in
	1)
		dqb "maybe ok"
	;;
	2)
		[ "${2}" == "-v" ] && debug=1
	;;
	3)
		if [ "${2}" == "-v" ] ; then
			debug=1
			distro=${3}
		else
			[ "${3}" == "-v" ] && debug=1
		fi
	;;
	*)
		echo "${0} <mode> [other_params]";exit
	;;
esac

dqb "mode=${mode}"
dqb "distro=${distro}"
csleep 2
#exit

#HUOM. jos tarttee ni näille main distrosta riippuvainen fktioiden esittely 
#(toiv ei tarvitse)

smr=$(sudo which rm)
ipt=$(sudo which iptables)
slinky=$(sudo which ln)
spc=$(sudo which cp)
slinky="${slinky} -s "
sco=$(sudo which chown)
scm=$(sudo which chmod)	
svm=$(sudo which mv)

#240325 lisäykset
ip6t=$(sudo which ip6tables)
iptr=$(sudo which iptables-restore)
ip6tr=$(sudo which ip6tables-restore)

dqb "when in trouble, \"sudo chmod 0755 *.sh ;sudo chmod 0755 ${distro}; sudo chmod 0755 ${distro}/*.sh; sudo chmod 0644 ${distro}/conf\" may help "
#==============================================================
function tod_dda() { 
	dqb "tod_dda(${1}) "
	${ipt} -A b -p tcp --sport 853 -s ${1} -j c
	${ipt} -A e -p tcp --dport 853 -d ${1} -j f
}

function dda_snd() {
	dqb "dda_snd( ${1})"
	${ipt} -A b -p udp -m udp -s ${1} --sport 53 -j ACCEPT 
	${ipt} -A e -p udp -m udp -d ${1} --dport 53 -j ACCEPT
}

#HUOM.220624:stubbyn asentumisen ja käynnistymisen kannalta sleep saattaa olla tarpeen
function ns2() {
	[ y"${1}" == "y" ] && exit
	dqb "ns2( ${1} )"
	${scm} u+w /home
	csleep 3

	/usr/sbin/userdel ${1}
	sleep 3

	adduser --system ${1}
	sleep 3

	${scm} go-w /home
	${sco} -R ${1}:65534 /home/${1}/ #HUOM.280125: tässä saattaa mennä metsään ... tai sitten se /r/s.pid
	dqb "d0n3"
	csleep 4	

	[ ${debug} -eq 1 ]  && ls -las /home
	csleep 3
}

function ns4() {
	dqb "ns4( ${1} )"

	${scm} u+w /run
	touch /run/${1}.pid
	${scm} 0600 /run/${1}.pid
	${sco} ${1}:65534 /run/${1}.pid
	${scm} u-w /run

	sleep 5
	${whack} ${1}* #saattaa joutua muuttamaan vielä
	sleep 5

	dqb "starting ${1} in 5 secs"

	sleep 5
	${odio} -u ${1} ${1} -g #antaa nyt tämän olla näin toistaiseksi(25.3.25)
	echo $?

	sleep 1
	pgrep stubby*
	sleep 5
}

function clouds_pre() {
	dqb "cdns.clouds_pre()"

	if [ -s /etc/resolv.conf.new ] || [ -s /etc/resolv.conf.OLD ] ; then 
		${smr} /etc/resolv.conf
		[ $? -gt 0 ] && echo "FAILURE TO COMPLY WHILE TRYING TO REMOVE RESOLV.CONF"
	fi

	if [ -s /etc/dhcp/dhclient.conf.new ] || [ -s /etc/dhcp/dhclient.conf.OLD ] ; then 
		${smr} /etc/dhcp/dhclient.conf
		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHILÖE TRYING TO REMOVE DHCLIENT.CONF"
	fi

	if [ -s /sbin/dhclient-script.new ] || [ -s /sbin/dhclient-script.OLD ] ; then 	
		${smr} /sbin/dhclient-script
		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHIOLE TRYINMG TO REMOVE DHCLIENT-SCRIPT"
	fi

	csleep 1

	#050425 lisättyjä seur. blokki
	if [ -s /etc/iptables/rules.v4.${1} ] ; then
		if [ -h /etc/iptables/rules.v4 ] ; then
			dqb "smr /e/i/rv4"
			${smr} /etc/iptables/rules.v4
		else
			${svm} /etc/iptables/rules.v4 /etc/iptables/rules.v4.OLD		
		fi
#TODO:viimeistele
#${slinky} /etc/iptables/rules.v4.${1} /etc/iptables/rules.v4
#dqb "stinky1"
	fi

	if [ -s /etc/iptables/rules.v6.${1} ] ; then
		if [ -h /etc/iptables/rules.v6 ] ; then
			dqb "smr /e/i/r6v"
			${smr} /etc/iptables/rules.v6
		else
			${svm} /etc/iptables/rules.v6 /etc/iptables/rules.v6.OLD
		fi
#${slinky} /etc/iptables/rules.v6.${1} /etc/iptables/rules.v6
#dqb "stunky2"
	fi

#	csleep 1
#
#	if [ -s /etc/iptables/rules.v4.${1} ] ; then
#		${slinky} /etc/iptables/rules.v4.${1} /etc/iptables/rules.v4
#		dqb "stinky1"
#	fi
#
#	csleep 1
#
#	#ao. rivillä DROP kaikkiin riittänee säännöiksi
#	if [ -s /etc/iptables/rules.v6.${1} ] ; then
#		${slinky} /etc/iptables/rules.v6.${1} /etc/iptables/rules.v6
#		dqb "stunky2"
#	fi

	csleep 1
	dqb "RELOADING TBLZ RULEZ"
	csleep 1

	#HUOM.160325:lisätty uutena varm. vuoksi
	${iptr} /etc/iptables/rules.v4
	${ip6tr} /etc/iptables/rules.v6
	csleep 2

	#tässä oikea paikka tables-muutoksille vai ei?
	${ipt} -F b
	${ipt} -F e

	#pidemmän päälle olisi kätevämpi nimetä kuin numeroida ne säännöt...
	${ipt} -D INPUT 5
	${ipt} -D OUTPUT 6

	dqb "... done"
}

function clouds_post() {
	dqb "cdns.clouds_post() "
	dqb "scm= ${scm}"
	dqb "sco = ${sco}"
	csleep 5

	${scm} 0444 /etc/resolv.conf*
	${sco} root:root /etc/resolv.conf*

	${scm} 0444 /etc/dhcp/dhclient*
	${sco} root:root /etc/dhcp/dhclient*
	${scm} 0755 /etc/dhcp

	${scm} 0555 /sbin/dhclient*
	${sco} root:root /sbin/dhclient*
	${scm} 0755 /sbin

	${sco} -R root:root /etc/iptables
	${scm} 0400 /etc/iptables/*
	${scm} 0750 /etc/iptables
	csleep 2

	if [ ${debug} -eq 1 ] ; then
		${ipt} -L  #
		${ip6t} -L #parempi ajaa vain jos löytyy
		csleep 3 #
	fi #

	dqb "d0n3"
}

#HUOM. joskohan jatkossa yhdistelisi case0:aa ja case1:stä, {.new,.old} -> {.0,.1} ja sit jotain
function clouds_case0() {
	dqb "cdns.clouds_case0()"

	${slinky} /etc/resolv.conf.OLD /etc/resolv.conf
	${slinky} /etc/dhcp/dhclient.conf.OLD /etc/dhcp/dhclient.conf

	#dhclient-script eri tavalla koska linkkien tukeminen lopetettu kesään -24 mennessä	
	${spc} /sbin/dhclient-script.OLD /sbin/dhclient-script

	if [ y"${ipt}" == "y" ] ; then
		dqb "SHOULD 1NSTALL TABL35"
		exit 88
	else
		${ipt} -A INPUT -p udp -m udp --sport 53 -j b 
		${ipt} -A OUTPUT -p udp -m udp --dport 53 -j e

		if [ -s  /etc/resolv.conf ] ; then
			for s in $(grep -v '#' /etc/resolv.conf | grep names | grep -v 127. | awk '{print $2}') ; do dda_snd ${s} ; done	
		else
			dqb "NO RESOLV.CONF FOUND, HAVE TO USE CONF"
			csleep 1
			
			if [ z"${dsn}" != "z" ] ; then
				for s in ${dsn} ;  do dda_snd ${s} ; done
			fi
		fi
	fi

	/etc/init.d/dnsmasq stop
	/etc/init.d/ntpsec stop
	csleep 3
	${whack} dnsmasq*
	${whack} ntp*
}

function clouds_case1() {
	echo "WORK IN PROGRESS"

	if [ -s /etc/resolv.conf.new ] ; then
		echo "r30lv.c0nf alr3ady 3x15t5"
	else
		touch /etc/resolv.conf.new
		${scm} a+w /etc/resolv.conf.new
		echo "nameserver 127.0.0.1" > /etc/resolv.conf.new
		${scm} 0444 /etc/resolv.conf.new
		${sco} root:root /etc/resolv.conf.new
	fi

	${slinky} /etc/resolv.conf.new /etc/resolv.conf
	${slinky} /etc/dhcp/dhclient.conf.new /etc/dhcp/dhclient.conf
	${spc} /sbin/dhclient-script.new /sbin/dhclient-script

	if [ y"${ipt}" == "y" ] ; then
		echo "SHOULD 1NSTALL TABL35"
	else
		${ipt} -A INPUT -p tcp -m tcp --sport 853 -j b
		${ipt} -A OUTPUT -p tcp -m tcp --dport 853 -j e

		if [ -s /home/stubby/.stubby.yml ] ; then
			for s in $(grep -v '#' /home/stubby/.stubby.yml | grep address_data | cut -d ':' -f 2) ; do tod_dda ${s} ; done
		else
			dqb "NO RESOLV.CONF FOUND, HAVE TO USE CONF"
			csleep 1
		
			if [ z"${dsn}" != "z" ] ; then
				for s in ${dsn} ;  do tod_dda ${s} ; done
			fi
		fi
	fi

	echo "dns";sleep 2
	/etc/init.d/dnsmasq restart
	pgrep dnsmasq

#HUOM.270325:tästä eteenpäin vaatinee pientä laittoa
#ensinnäkin dnsmasq pitäisi saada taas vastaamaan pyyntöihin ja sitten muut jutut
#	echo "stu";sleep 2
#	${whack} stubby* #090325: pitäisiköhän tämä muuttaa?
#	sleep 3	
#			
#	[ -f /run/stubby.pid ] || sudo touch /run/stubby.pid
#	${sco} devuan:devuan /run/stubby.pid #$n
#	${scm} 0644 /run/stubby.pid 
#	sleep 3
#
#	su devuan -c '/usr/bin/stubby -C /home/stubby/.stubby.yml -g'
#	pgrep stubby
}
#====================================================================
clouds_pre ${mode}

case ${mode} in 
	0)
		clouds_case0
	;;
	1)
		clouds_case1
	;;
	*)
		echo "MEE HIMAAS LEIKKIMÄHÄN"
	;;
esac

clouds_post

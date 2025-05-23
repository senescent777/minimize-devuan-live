#!/bin/bash
debug=0
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

#asiasta kukkaruukkuun: wicd oli aikoinaan siedettävä softa, ainakin Networkmanageriin verrattuna

#HUOM.jatkossa ehkä parempi että komentorivioptioilla ei aktivoida debugia
mode=${1}
[ -d ~/Desktop/minimize/${2} ] && distro=${2}

#function init2 {
#	local c
##TODO:jospa vain hakkaisi tässä tuettyjen tdstojen/hmistojen oikeudet kohdalleen ja täts it
#
#	c=$(find /etc -name 'iptab*' -type d -perm /o+w,o+r,o+x | wc -l)
#	[ ${c} -gt 0 ] && exit 111
#	c=$(find /etc -name 'iptab*' -type d -not -user 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 112
#	c=$(find /etc -name 'iptab*' -type d -not -group 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 113
#	c=$(find /etc -name 'rules.v*' -type f -perm /o+w,o+r,o+x | wc -l)
#	[ ${c} -gt 0 ] && exit 114
#	c=$(find /etc -name 'rules.v*' -type f -not -user 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 115
#	c=$(find /etc -name 'rules.v*' -type f -not -group 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 116
#	 
#	c=$(find /etc -name 'sudoers*' -type d -perm /o+w,o+r,o+x | wc -l)
#	[ ${c} -gt 0 ] && exit 117
#	c=$(find /etc -name 'sudoers*' -type d -not -user 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 118
#	c=$(find /etc -name 'sudoers*' -type d -not -group 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 119
#	c=$(find /etc/sudoers.d -type f -perm /o+w,o+r,o+x | wc -l)
#	[ ${c} -gt 0 ] && exit 120
#	c=$(find /etc/sudoers.d -type f -not -user 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 121
#	c=$(find /etc/sudoers.d -type f -not -group 0 | wc -l)
#	[ ${c} -gt 0 ] && exit 122
#}
#
#init2

#sleep 5 #TODO:tästä mallia muihinkin skripteihin
chmod 0400 /etc/iptables/*
chmod 0550 /etc/iptables
chown -R root:root /etc/iptables
chmod 0400 /etc/default/rules*
chown -R root:root /etc/default
sleep 5
		
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
		echo "${0} <mode> [other_params]";exit 13
	;;
esac

dqb "mode=${mode}"
dqb "distro=${distro}"
csleep 2

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

dqb "when in trouble, \"sudo chmod 0755  \*.sh ;sudo chmod 0755 \${distro}; sudo chmod 0755 \${distro}/ \*.sh; sudo chmod 0644 \${distro}/conf\" may help "

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
	[ y"${1}" == "y" ] && exit 154
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

function clouds_pp1() {
	dqb "#c.pp.1  ( ${1} )"
	#TODO:linkkiys-tarkistuksia

	if [ -s /etc/resolv.conf.1 ] || [ -s /etc/resolv.conf.0 ] ; then 
		${smr} /etc/resolv.conf
		[ $? -gt 0 ] && echo "FAILURE TO COMPLY WHILE TRYING TO REMOVE RESOLV.CONF"
	fi

	if [ -s /etc/dhcp/dhclient.conf.1 ] || [ -s /etc/dhcp/dhclient.conf.0 ] ; then 
		${smr} /etc/dhcp/dhclient.conf
		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHILÖE TRYING TO REMOVE DHCLIENT.CONF"
	fi

	#HUOM.17525:mikähän tätäkin tdstoa vaivaa? varmaan pp2 pykiminen sotkenut
	if [ -s /sbin/dhclient-script.1 ] || [ -s /sbin/dhclient-script.0 ] ; then 	
		${smr} /sbin/dhclient-script
		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHIOLE TRYINMG TO REMOVE DHCLIENT-SCRIPT"
	fi
	
	#jatkossa tietebkub parametrina distri...tai iface ... whåtever
	if [ -h /etc/network/interfaces ] ; then
		${smr} /etc/network/interfaces
	else
		${svm} /etc/network/interfaces /etc/network/interfaces.OLD
	fi

	csleep 1
	dqb "...done"
}

function clouds_pp3() {
	csleep 1
	dqb "# c.pp.3 a.k.a RELOADING TBLZ RULEZ ${1}"
	csleep 1

	cp /etc/default/rules.* /etc/iptables

	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default
	sleep 5

	#HUOM.160325:lisätty uutena varm. vuoksi
	${iptr} /etc/iptables/rules.v4.${1}
	${ip6tr} /etc/iptables/rules.v6.${1}
	csleep 2

	#tässä oikea paikka tables-muutoksille vai ei?
	${ipt} -F b
	${ipt} -F e

	#pidemmän päälle olisi kätevämpi nimetä kuin numeroida ne säännöt...
	${ipt} -D INPUT 5
	${ipt} -D OUTPUT 6

	csleep 1
	dqb "...done"
}

function clouds_pre() {
	dqb "cdns.clouds_pre( ${1}, ${2} )"
	csleep 1

	clouds_pp1
	csleep 1
	#clouds_pp2 ${1} #tätäkö ei kutsuta? ja silti menee rules votuiksi?
	clouds_pp3 ${1}
	csleep 1

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

	cp /etc/default/rules.* /etc/iptables

	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default
	sleep 5

	#jotenkin näin (find -type f myös keksitty)
	${sco} -R root:root /etc/network/interfaces*
	${scm} 0444 /etc/network/interfaces
	${scm} 0444 /etc/network/interfaces.*
	csleep 2

	if [ ${debug} -eq 1 ] ; then
		${ipt} -L  #
		${ip6t} -L #parempi ajaa vain jos löytyy
		csleep 3 #
	fi #

	dqb "d0n3"
}

function clouds_case0_0() {
	${ipt} -A INPUT -p udp -m udp --sport 53 -j b 
	${ipt} -A OUTPUT -p udp -m udp --dport 53 -j e
}

function clouds_case1_0() {
	${ipt} -A INPUT -p tcp -m tcp --sport 853 -j b
	${ipt} -A OUTPUT -p tcp -m tcp --dport 853 -j e
}

function clouds_case0_1() {
	if [ -s  /etc/resolv.conf ] ; then
		for s in $(grep -v '#' /etc/resolv.conf | grep names | grep -v 127. | awk '{print $2}') ; do dda_snd ${s} ; done	
	else
		dqb "NO RESOLV.CONF FOUND, HAVE TO USE CONF"
		csleep 1
			
		if [ z"${dsn}" != "z" ] ; then
			for s in ${dsn} ;  do dda_snd ${s} ; done
		fi
	fi
}

function clouds_case1_1() {
	if [ -s /home/stubby/.stubby.yml ] ; then
		for s in $(grep -v '#' /home/stubby/.stubby.yml | grep address_data | cut -d ':' -f 2) ; do tod_dda ${s} ; done
	else
		dqb "NO CONF FOUND, HAVE TO USE ALT CONF"
		csleep 1
		
		if [ z"${dsn}" != "z" ] ; then
			for s in ${dsn} ;  do tod_dda ${s} ; done
		fi
	fi
}

function clouds_case0_2() {
	/etc/init.d/dnsmasq stop
	/etc/init.d/ntpsec stop
	csleep 3
	${whack} dnsmasq*
	${whack} ntp*
}

function clouds_case1_2() {
	
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

#välimiehiä voisi leikellä pois jatkossa
function clouds_case0() {
	dqb "cdns.clouds_case0()"

	if [ y"${ipt}" == "y" ] ; then
		dqb "SHOULD 1NSTALL TABL35"
		exit 88
	else
		clouds_case0_0
		clouds_case0_1
	fi

	clouds_case0_2
}

function clouds_case1() {
	echo "WORK IN PROGRESS"

	if [ y"${ipt}" == "y" ] ; then
		echo "SHOULD 1NSTALL TABL35"
	else
		clouds_case1_0
		clouds_case1_1
	fi

	clouds_case1_2
}

#====================================================================
clouds_pre ${mode}
[ -f /etc/resolv.conf.${mode} ] && ${slinky} /etc/resolv.conf.${mode} /etc/resolv.conf
[ -f /etc/dhcp/dhclient.conf.${mode} ] && ${slinky} /etc/dhcp/dhclient.conf.${mode} /etc/dhcp/dhclient.conf
[ -f /sbin/dhclient-script.${mode} ] && ${spc} /sbin/dhclient-script.${mode} /sbin/dhclient-script

#HUOM.15525:iface olisi parempi idea kuin distro mutta joutuisi includoimaan conf
[ -f /etc/network/interfaces.${distro} ] && ${slinky} /etc/network/interfaces.${distro} /etc/network/interfaces

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
#!/bin/bash
debug=1
mode=-1
distro=$(cat /etc/devuan_version)

#HUOM.16126:tarpeellisia kikkailuja? tuskin (tai siis sqrootissa ehkä)
if [ -f /.chroot ] ; then
	odio=""
else
	odio=$(which sudo)
fi

chmod a-wx ./clouds*
chown root:root ${0}
chmod 0511 ${0}

#tähän /e/i/rules.* oikeuksien/omst pakotus vai tartteeko?

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

sah6=$(which sha512sum)
#asiasta kukkaruukkuun: wicd oli aikoinaan siedettävä softa, ainakin Networkmanageriin verrattuna
#HUOM.jatkossa ehkä parempi että komentorivioptioilla ei aktivoida debugia

mode=${1}

#280226:ao. spagettikoodille hyvä tehdä jotian josqs
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
#

#280226:lienee ok modaamattoman chimaeran kanssa tämä fktio (pl mahd tablesin puute)
function epr1() {
	dqb "31n-p0d-r05..."
	csleep 1
	local c

	#280226:bissiin ao. testi toimii
	gf /opt
        c=$(find /opt -type d -perm /o+w,g+w | wc -l)
        [ ${c} -gt 0 ] && exit 106

	#HUOM. chmod ylEmpänä
	c=$(find /opt/bin -type f -perm /o+w,g+w,o+r,g+r | wc -l)
        [ ${c} -gt 0 ] && exit 108
	gh /opt/bin

	c=$(find /etc -name 'iptab*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 111

	#g-ehto vielä? w riittää?
       	c=$(find /etc -name 'iptab*' -type d -perm /g+w | wc -l)
        [ ${c} -gt 0 ] && exit 123

	gf /etc iptab
	${odio} rm /etc/default/rules*

	#TODO:ruleksien kanssa jatkossa ehtona:a+wx?
	c=$(${odio} find /etc -name 'rules.v?.?' -type f -perm /o+w,o+x,o+r | wc -l) #oli myös o+r
	[ ${c} -gt 0 ] && exit 114

#TODO:	 g+r,u+x ?
	c=$(${odio} find /etc -name 'rules.v?.?' -type f -perm /g+x,g+w | wc -l)
      	[ ${c} -gt 0 ] && exit 124

	#VAIH:SELV TOIMIIKO TÄMÄ TRKISTUS VAI EI
	gh /etc rules.v

	c=$(find /etc -name 'sudoers*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 117
	gf /etc sudoers

	#a+wx,o+r ?
	c=$(find /etc/sudoers.d -type f -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 120
	gf /etc/sudoers.d

	if [ -x /usr/sbin/ntpd ] ; then
		dqb "RA1N 1N SPA1N"
		c=$(find /etc -name 'ntp*' -type f -perm /o+w | wc -l)
        	[ ${c} -gt 0 ] && exit 126
		gh /etc ntp
	fi
}

epr1

function p3r1m3tr() {
	dqb "P3R1M3TR"
	csleep 1

	#cp /etc/default/rules.* /etc/iptables
	#[ -s /etc/iptables/rules.v4.] or exit 666

	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default

	local p
	p=$(pwd)
	cd /

	${sah6} --ignore-missing -c /opt/bin/zxcv
	[ $? -eq 0 ] || exit 66
	cd ${p}

	chmod 0400 /opt/bin/zxcv*
	chown root:root /opt/bin/zxcv*

	if [ -s /opt/bin/zxcv.sig ] ; then
		local g
		g=$(which gpg)

		if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
			#mitenkähän onnistuu verify jos ylempänä chmod 0400 ? TODO:testaa esim @sqroot ?
			${gg} --verify /opt/bin/zxcv.sig
			[ $? -gt 0 ] && exit 126
		fi
	fi

	/bin/netstat -tulpan;sleep 2
	dqb "P3R1MTR D0N3"
}

p3r1m3tr

case $# in
	1)
		dqb "maybe ok"
	;;
	*)
		echo "${0} <mode> [other_params]";exit 13
	;;
esac

dqb "mode=${mode}"
dqb "distro=${distro}"
csleep 1

#HUOM. jos tarttee ni näille main distrosta riippuvainen fktioiden esittely 
#(toiv ei tarvitse)

smr=$(${odio} which rm)
ipt=$(${odio} which iptables)
slinky=$(${odio} which ln)
spc=$(${odio} which cp)
slinky="${slinky} -s "
sco=$(${odio} which chown)
scm=$(${odio} which chmod)
svm=$(${odio} which mv)

#240325 lisäykset
ip6t=$(${odio} which ip6tables)
iptr=$(${odio} which iptables-restore)
ip6tr=$(${odio} which ip6tables-restore)

${odio} modprobe nft #distro-tark taakse vai ei?
dqb "when in trouble, \"${odio} chmod 0755  \*.sh ;${odio} chmod 0755 \${distro}; ${odio} chmod 0755 \${distro}/ \*.sh; ${odio} chmod 0644 \${distro}/conf\" may help "

#==============================================================
function tod_dda() { 
	dqb "tod_dda( ${1} ) "
#
#	local t
#	t=$(echo ${1} | tr -d -c 0-9. | cut -c 15) #cut uutena, olisi hyvä laittaa toimimaan toivotulla tavalla kanssa
#
#	${ipt} -A u -p tcp --sport 853 -s ${t} -j c
#	${ipt} -A v -p tcp --dport 853 -d ${t} -j f
}

function dda_snd() {
	dqb "dda_snd( ${1})"

	local t
	t=$(echo ${1} | tr -d -c 0-9.) # | cut -c 15) eivielä

	#HUOM.070326:oli AIEmmin -{s,d} ${t} ja sitten taas
	${ipt} -A b -p udp -m udp -s ${t} --sport 53 -j ACCEPT 
	${ipt} -A e -p udp -m udp -d ${t} --dport 53 -j ACCEPT
}

function ptn_dda() {
	local t
        t=$(echo ${1} | tr -d -c 0-9.) # | cut -c 15)

	#tai jos aluksi rules.xyz
	${ipt} -A b -p udp -m udp -s ${t} --sport 123 -j ACCEPT
	${ipt} -A e -p udp -m udp -d ${t} --dport 123 -j ACCEPT
}

##==============================================================
##HUOM.220624:stubbyn asentumisen ja käynnistymisen kannalta sleep saattaa olla tarpeen
#function ns2() {
#	[ y"${1}" == "y" ] && exit 145
#	dqb "ns2( ${1} )"
#	${scm} u+w /home
#	csleep 1
#
#	/usr/sbin/userdel ${1}
#	sleep 1
#
#	adduser --system ${1}
#	sleep 1
#
#	${scm} go-w /home
#	${sco} -R ${1}:65534 /home/${1}/ #HUOM.280125: tässä saattaa mennä metsään ... tai sitten se /r/s.pid
#	dqb "d0n3"
#	csleep 1
#
#	[ ${debug} -eq 1 ]  && ls -las /home
#	csleep 1
#}
#
##ns-fktioihinkin jotain param mankelointia mikäli ottaa käyttöön
#toistaiseksi ns-jutut kommentteissa kunnees ehkä x
#
#function ns4() {
#	dqb "ns4( ${1} )"
#
#	${scm} u+w /run
#	touch /run/${1}.pid
#	${scm} 0600 /run/${1}.pid
#	${sco} ${1}:65534 /run/${1}.pid
#	${scm} u-w /run
#
#	sleep 1
#	${whack} ${1}* #saattaa joutua muuttamaan vielä
#	sleep 1
#
#	dqb "starting ${1} in 5 secs"
#
#	sleep 1
#	${odio} -u ${1} ${1} -g #antaa nyt tämän olla näin toistaiseksi(25.3.25)
#	echo $?
#
#	sleep 1
#	pgrep stubby*
#	sleep 1
#}

#190226:josko wanhan resolv.conf nakkaisi Vittuun kuitenkin jossain kohtaa? voi sotkea nimittäin

function clouds_pp1() {
	csleep 1
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

	#csleep 1
	dqb "pp1 done"
}

#130226.2.mjono policy:accept tablesin outputissa saisi johtaa halt:iin kanssa (VAIH)
#150226:rules.v4, rules.v6 :miten niiden kanssa nykyään? piut paut?

function tlah() {
	if [ ${1} -gt 0 ] ; then
		dqb "SHOULD / sb1n / h4lt npow"
		csleep 1
		[ ${debug} -eq 1 ] || /sbin/halt
	fi
}

function clouds_pp3() {
	dqb "# c.pp.3 a.k.a RELOADINGz TBLZ RULEZ ${1}"
	csleep 1

	[ -z "${1}" ] && /sbin/halt
	csleep 1
	dqb "paramz 0k"
	csleep 1
	p3r1m3tr

	local c
	c=$(${ipt} -L  | grep policy | grep ACCEPT | wc -l)
	tlah ${c}

	c=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
	tlah ${c}

	dqb "accept that"
	csleep 2

	local p
	p=$(echo ${1} | tr -d -c 0-9)
	dqb "bfore -f"
	csleep 2

	[ -f /etc/iptables/rules.v4.${p} ] || tlah 1
        [ -f /etc/iptables/rules.v6.${p} ] || tlah 1
	dqb "bfore -s"
	csleep 2

	[ -s /etc/iptables/rules.v4.${p} ] || tlah 1
	[ -s /etc/iptables/rules.v6.${p} ] || tlah 1
	dqb "just bfore iptr"
	csleep 2

	#"-r" - tark ei vissiin tarpeellinen, to state the obv

	${iptr} /etc/iptables/rules.v4.${p}
	tlah $?
	csleep 2

	dqb "v4 reloaded ok"

	${ip6tr} /etc/iptables/rules.v6.${p}
	tlah $?
	csleep 2
	dqb "v6 reloaded ok"

#	#tässä oikea paikka tables-muutoksille vai ei? (josko bain dellisi vuo ketjut)
#	${ipt} -F b
#	${ipt} -F e
#	csleep 2
#	dqb "FLiBe"

	#pidemmän päälle olisi kätevämpi nimetä kuin numeroida ne säännöt...
	#ideana kenties oli hukata ketjut b ja e ?
	#HUOM.7-3-26:jos tarttee delliä ni nämä tällä hetkellä
	#${ipt} -D INPUT 6
	#${ipt} -D OUTPUT 7

	dqb "56"
	csleep 2
	dqb "pp3 done"
}

function clouds_pre() {
	dqb "cdns.clouds_pre( ${1}, ${2} )"
	csleep 1

	[ -z "${1}" ] && exit 65
	[ -z "${2}" ] && exit 65

	local t
	dqb "jst bef0re loop"
	csleep 1

	for t in INPUT OUTPUT FORWARD ; do
		${ipt} -P ${t} DROP
		tlah $?
		dqb "V4 ${t} ok"; csleep 2

		#pitäisikö huuhdella myÖs v4-taulut?
		${ipt} -F ${t}
		tlah $?

		${ip6t} -P ${t} DROP
		tlah $?
		dqb "V6 ${t} ok"; csleep 2

		${ip6t} -F ${t}
		tlah $?
		dqb "V6 -GF ${t} ok"; csleep 2
	done

	clouds_pp1
	csleep 1

	dqb "cpp2"
	#clouds_pp2 ${1} #vissiin common_lib.change_bin1:stä löytyy syy miksi rules.v$x.$y tyhjenee
	csleep 1

	clouds_pp3 ${1}
	csleep 1
	dqb "4 H0RS3M3N"

	#HUOM.22525:linkittyykö resolv.conf tässä vai ei?
	[ -f /etc/resolv.conf.${1} ] && ${slinky} /etc/resolv.conf.${1} /etc/resolv.conf
	[ ${debug} -eq 1 ] && ls -las /etc/resolv*;sleep 1

	[ -f /etc/dhcp/dhclient.conf.${1} ] && ${slinky} /etc/dhcp/dhclient.conf.${1} /etc/dhcp/dhclient.conf
	[ -f /sbin/dhclient-script.${1} ] && ${spc} /sbin/dhclient-script.${1} /sbin/dhclient-script

	#HUOM.25525.1:mitenköhän tämä kohta pitäisi mennä?
	#HUOM.25525.2:$distro ei ehkä käy sellaisenaan, esim. tapaus excalibur/ceres
	local t

	t=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)
	[ -f /etc/network/interfaces.${t} ] && ${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
	[ y"${ipt}" == "y" ] && exit 666

	dqb "S0UL SARC1F1C3 6,9"
}

function clouds_post() {
	dqb "cdns.clouds_post() "
	dqb "scm= ${scm}"
	dqb "sco =${sco}"

	csleep 1
	local f
	g=$(pwd)
	cd /

	for f in $(grep -v '#' /opt/bin/zxcv  | awk '{print $2}') ; do
		${scm} 0444 ${f}
		${sco} root:root ${f}
	done

	cd ${g}

	for f in $(find /sbin -type f -name 'dhclient*') ; do
		${scm} 0555 ${f}
		${sco} root:root ${f}
	done

	p3r1m3tr

	#zxcv-iterointi mennee vähän päällekkäin ao.  loopin kansssa
	for f in $(find /etc -type f -name 'ntp*') ; do
		${scm} 0444 ${f}
                ${sco} root:root ${f}
	done

	${scm} 0555 /etc/dhcp
	${scm} 0555 /sbin
	${scm} 0555 /etc/network
	${sco} root:root /etc/network 
	${scm} 0555 /etc/init.d/ntpsec
	${sco} 0:0 /etc/init.d/ntpsec

	if [ -x /usr/sbin/ntpd ] ; then
#
#010326:toiminee näinkin mutta jos aluksi kiinteillä ip-osoitteilla...
#		for f in $(${odio} grep -v '#' /etc/ntpsec/ntp.conf | grep pool | awk '{print $2}') ; do
#			ptn_dda ${f}
#		done
#
		csleep 1
		dqb "SHOULD START /etc/init.d/ntpsec AROUND HERE"
		csleep 1
	fi

	if [ ${debug} -eq 1 ] ; then
		#legacy-juttujen kanssa oli jokin juttu, tosin ilman legacyä näyttäisi tuottavan toivottua outputtia
		${ipt} -L #-legacy -L
		csleep 2
		dqb "===================666======================================"
		csleep 2
		${ip6t} -L  #-legacy -L
		csleep 1 
	fi #

	dqb "d0n3"
}

#voisi tietenkin selvittää, pystyisik ö iptabl/nefiltl-persistenteille penteille vipuamaan näitä dns-dot-ntp-kikkailuja
function clouds_case0_0() {
	dqb "0 cc of ??? intravenompously stat"
#	${ipt} -A INPUT -p udp -m udp --sport 53 -j b 
#	${ipt} -A OUTPUT -p udp -m udp --dport 53 -j e
}

#TODO:SITTENIN TOISIN  jatkossa (no miten? koita päättää)
function clouds_case1_0() {
	dqb "c10"
#	${ipt} -A INPUT -p tcp -m tcp --sport 853 -j u
#	${ipt} -A OUTPUT -p tcp -m tcp --dport 853 -j v
}

function clouds_case0_1() {
	if [ -s  /etc/resolv.conf ] ; then
		for s in $(grep -v '#' /etc/resolv.conf | grep names | grep -v 127. | awk '{print $2}') ; do dda_snd ${s} ; done	
	else
		dqb "NO RESOLV.CONF FOUND, HAVE TO USE ALT CONF"

		if [ z"${CONF_dsn}" != "z" ] ; then
			for s in ${CONF_dsn} ;  do dda_snd ${s} ; done
		fi
	fi
}

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

function clouds_case0_2() {
	/etc/init.d/dnsmasq stop
	${whack} dnsmasq*
}

function clouds_case1_2() {
	echo "dns";sleep 1
	/etc/init.d/dnsmasq restart
	pgrep dnsmasq

#HUOM.270325:tästä eteenpäin vaatinee pientä laittoa
#ensinnäkin dnsmasq pitäisi saada taas vastaamaan pyyntöihin ja sitten muut jutut
#	echo "stu";sleep 1
#	${whack} stubby* #090325: pitäisiköhän tämä muuttaa?
#	sleep 1
#
#	[ -f /run/stubby.pid ] || ${odio} touch /run/stubby.pid
#	${sco} ${n}:${n} /run/stubby.pid 
#	${scm} 0644 /run/stubby.pid 
#	sleep 1
#
#	su devuan -c '/usr/bin/stubby -C /home/stubby/.stubby.yml -g'
#	pgrep stubby
}

#====================================================================
clouds_pre ${mode} ${distro}

case ${mode} in 
	0)
		clouds_case0_0
		clouds_case0_1
		clouds_case0_2
	;;
	1)
		clouds_case1_0
		clouds_case1_1
		clouds_case1_2
	;;
	*)
		echo "MEE HIMAAS LEIKKIMÄHÄN"
	;;
esac

clouds_post

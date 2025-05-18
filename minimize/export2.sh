#!/bin/bash
debug=0 #1
tgtfile=""
distro=$(cat /etc/devuan_version) #tarpeellinen tässä
PREFIX=~/Desktop/minimize #käyttöön+komftdstoon jos mahd

if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
	echo "/E/IPTABLES IS WRITABEL"
	exit 12
fi

if [ -r /etc/sudoers.d ] || [ -w /etc/iptables ] ; then
	echo "/E/S.D IS WRITABLE"
	exit 34
fi

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 3 <tgtfile> [distro] [-v]: makes the main pkg (old way)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \${PREFIX}/\${distro}"
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"				
	echo "$0 -h: shows this message about usage"	
}

mode=${1}
tgtfile=${2}

#...ehkä pystyisi myös gpo()-tavalla (kokeilisiko?)
case $# in
	1)
		[ "${1}" == "-h" ]  && usage
		exit
	;;
	2)
		dqb "maybe ok"
	;;
	3)
		if [ -d ${PREFIX}/${3} ] ; then
			distro=${3}
		else
			[ "${3}" == "-v" ] && debug=1
		fi
	;;
	4)
		distro=${3}
		[ "${4}" == "-v" ] && debug=1
	;;
	*)
		echo "-h"
		exit
	;;
esac

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
[ z"${distro}" == "z" ] && exit 6
d=${PREFIX}/${distro}

if [ -d ${d} ] && [ -s ${d}/conf ]; then
	. ${d}/conf
else
	echo "CONFIG MISSING" #; exit 55
	pkgdir=/var/cache/apt/archives
fi

if [ -x ${PREFIX}/common_lib.sh ] ; then
	. ${PREFIX}/common_lib.sh
else
	srat="sudo /bin/tar"
	som="sudo /bin/mount"
	uom="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	odio=$(which sudo)

	#jos näillä lähtisi aikankin case q toimimaan
	n=$(whoami)
#	smr=$(${odio} which rm)
#	NKVD=$(${odio} which shred)
#	NKVD="${NKVD} -fu "
#	whack=$(${odio} which pkill)
#	whack="${odio} ${whack} --signal 9 "

	function check_binaries() {
		dqb "exp2.ch3ck_b1nar135( ${1} )"
	}

	function check_binaries2() {
		dqb "exp2.ch3ck_b1nar135_2( ${1} )"
	}

	function fix_sudo() {
		dqb "exp32.fix.sudo"
	}

	function enforce_access() {
		dqb "exp32.enf_acc()"
	}

	function part3() {
		dqb "exp32.part3()"
	}


	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

#HUOM.14525:pitäisiköhän testata ao. else-haara?
if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "L1B M1SSING"

	function pr4() {
		dqb "exp2.pr4 ${1} ${2} " 
	}

	function pre_part3() {
		dqb "exp2.pre_part3 ${1} ${2} "
	}

	check_binaries ${distro}
	check_binaries2
fi

dqb "tar = ${srat} "
${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh

tig=$(sudo which git)
mkt=$(sudo which mktemp)

if [ x"${tig}" == "x" ] ; then
	#HUOM. kts alempaa mitä git tarvitsee
	echo "sudo apt-get update;sudo apt-get install git"
	exit 7
fi

if [ x"${mkt}" == "x" ] ; then
	#HUOM. ei välttämättä ole molemmissa distroissa tuon nimistä pakettia
	echo "sudo apt-get update;sudo apt-get install mktemp"
	exit 8
fi

${sco} -Rv _apt:root ${pkgdir}/partial/
${scm} -Rv 700 ${pkgdir}/partial/
csleep 4

function pre1() {
	[ x"${1}" == "z" ] && exit 666

	${sco} -Rv _apt:root ${pkgdir}/partial/
	${scm} -Rv 700 ${pkgdir}/partial/
	csleep 4

	if [ -d ${1} ] ; then
		dqb "5TNA"

		n=$(whoami)
		enforce_access ${n}
		csleep 2

		local ortsac
		ortsac=$(echo ${1} | cut -d '/' -f 6)

		#HUOM.14525:yritetään tässä muuttaa sources.list s.e. toisen distron pakettien lataus onnistuu
		#erikseen sitten se, mikä sources menee arkistoon ja millä nimellä

		if [ -s /etc/apt/sources.list.${ortsac} ] ; then
			${smr} /etc/apt/sources.list
			${slinky} /etc/apt/sources.list.${ortsac} /etc/apt/sources.list
		else
			part1_5 ${ortsac}
		fi

		csleep 2
	else
		echo "P.V.HH"
		exit 111
	fi
}

function pre2() {
	#debug=1
	dqb "pre2 ${1}, ${2} " #WTIN KAARISULKEET STNA
	[ x"${1}" == "z" ] && exit 666

	local ortsac
	local ledif

	ortsac=$(echo ${1} | cut -d '/' -f 6)
	ledif=$(echo ${1} | cut -d '/' -f 1-5 )

	if [ -d ${1} ] ; then
		dqb "PRKL"
		${odio} ${ledif}/changedns.sh ${dnsm} ${ortsac}
		csleep 4

		${sifu} ${iface}
		[ ${debug} -eq 1 ] && /sbin/ifconfig
		csleep 4

		${sco} -Rv _apt:root ${pkgdir}/partial/
		${scm} -Rv 700 ${pkgdir}/partial/

		${sag_u}
		csleep 4
	else
		echo "P.V.HH"
		exit 111
	fi
}

function tpq() {
	debug=1
	dqb "tpq ${1} ${2}"
	[ -d ${1} ] || exit 22
	dqb "paramz 0k"
	csleep 1

	#${srat} -cf ${1}/xfce.tar ~/.config/xfce4/xfconf/xfce-perchannel-xml 
	${srat} -cf ${1}/xfce.tar ${1}/../../.config/xfce4/xfconf/xfce-perchannel-xml
	csleep 2

	if [ -x ${1}/profs.sh ] ; then
		dqb "DE PROFUNDIS"
			
		. ${1}/profs.sh
		exp_prof ${1}/fediverse.tar default-esr
	else
		dqb "1nT0 TH3 M0RB1D R31CH"	
	fi

	csleep 5
}

function tp1() {
	#debug=1
	dqb "tp1 ${1} , ${2} "
	[ z"${1}" == "z" ] && exit
	dqb "params_ok"
	csleep 3

	if [ -d ${2} ] ; then
		dqb "cleaning up ${2} "
		csleep 3
		${NKVD} ${2}/*.deb
		dqb "d0nm3"
	fi

	local ledif
	ledif=$(echo ${2} | cut -d '/' -f 1-5 )
	#p.itäisiköhän olla jokin tarkistus tässä?

	if [ ${enforce} -eq 1 ] && [ -d ${ledif} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		tpq ${ledif}
	fi

	if [ ${debug} -eq 1 ] ; then
		ls -las ${ledif}
		sleep 5
	fi

	${srat} -rvf ${1} ${ledif} /home/stubby 	
	dqb "tp1 d0n3"
	csleep 3
}

function rmt() {
	#debug=1
	dqb "rmt ${1}, ${2} " #WTUN TYPOT STNA111223456

	[ z"${1}" == "z" ] && exit 1
	[ -s ${1} ] || exit 2

	[ z"${2}" == "z" ] && exit 11
	[ -d ${2} ] || exit 22

	dqb "paramz_ok"
	csleep 3

	${scm} 0444 ${2}/*.deb
	p=$(pwd)

	cd ${2}
	[ -f ./sha512sums.txt ] && ${NKVD} ./sha512sums.txt
	csleep 2

	touch ./sha512sums.txt
	chown $(whoami):$(whoami) ./sha512sums.txt
	chmod 0644 ./sha512sums.txt
	[ ${debug} -eq 1 ] && ls -las sha*;sleep 6

	${sah6} ./*.deb > ./sha512sums.txt
	csleep 2
	psqa .

	${srat} -rf ${1} ${2}/*.deb ${2}/sha512sums.txt
	csleep 1
	cd ${p}

	dqb "rmt d0n3"
}

function tp4() {
	#debug=1
	dqb "tp4 ${1} , ${2} "

	[ z"${1}" == "z" ] && exit 1
	[ -s ${1} ] || exit 2
	
	dqb "DEMI-SEC"
	csleep 1

	[ z"${2}" == "z" ] && exit 11
	[ -d ${2} ] || exit 22

	dqb "paramz_ok"
	csleep 3

	if [ z"${pkgdir}" != "z" ] ; then
		${NKVD} ${pkgdir}/*.deb
		dqb "SHREDDED HUMANS"
	fi

	dqb "EDIBLE AUTOPSY"
	${fib}
	${asy}
	csleep 3

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} groff-base libgdbm6 libpipeline1 libseccomp2 #bsd debconf libc6 zlib1g		
	
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=sudo=1.9.13p3-1+deb12u1
	${shary} libaudit1 libselinux1 #libpam0g #libpam-modules zlib1g #libpam kanssa oli nalkutusta 080525

	${shary} man-db sudo
	message

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=netfilter-persistent=1.0.20
	${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11
	${shary} iptables
	${shary} iptables-persistent init-system-helpers netfilter-persistent

	#actually necessary
	pre2 ${2}

	if [ ${dnsm} -eq 1 ] ; then #josko komentorivioptioksi?
		${shary} libgmp10 libhogweed6 libidn2-0 libnettle8
		${shary} runit-helper
		${shary} dnsmasq-base dnsmasq dns-root-data #dnsutils
		${lftr} 

		#josqs ntp-jututkin mukaan?
		[ $? -eq 0 ] || exit 3

		${shary} libev4
		${shary} libgetdns10 libbsd0 libidn2-0 libssl3 libunbound8 libyaml-0-2 #sotkeekohan libc6 uudelleenas tässä?
		${shary} stubby
	fi

	dqb "${shary} git mktemp in 4 secs"
	csleep 3
	${lftr} 

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=git=1:2.39.2-1~bpo11+1
	#${shary} mktemp #tämän kanssa jotain distro-spesifistä säätöä?
	${shary} libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 zlib1g 
	${shary} git-man git

	[ $? -eq 0 ] && dqb "TOMB OF THE MUTILATED"
	csleep 3
	${lftr}

	case ${iface} in
		wlan0)
			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2
			#toivottavasti ei libdbus sotke mitään ${shary} libdbus-1-3 toistaiseksi jemmaan 280425

			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 libreadline8 # libssl3 adduser
			${shary} wpasupplicant
		;;
		*)
			dqb "not pulling wpasuplicant"
			csleep 4
		;;
	esac

	#HUOM. jos aikoo gpg'n tuoda takaisin ni jotenkin fiksummin kuin aiempi häsläys kesällä
	if [ -d ${2} ] ; then 
		${NKVD} *.deb	
		${svm} ${pkgdir}/*.deb ${2}
		rmt ${1} ${2}
	fi

	dqb "tp4 donew"
	csleep 3
}

#koita päättää mitkä tdstot kopsataan missä fktiossa, interfaces ja sources.list nyt 2 paikassa
function tp2() {
	#debug=1
	dqb "tp2 ${1} ${2}"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2

	dqb "params_ok"
	csleep 5

	${scm} 0755 /etc/iptables
	${scm} 0444 /etc/iptables/rules*

	#jatqs v pois
	${srat} -rvf ${1} /etc/network/interfaces /etc/network/interfaces.*

	#HUOM.16525:meneekö pieleen väärien oikeuksien takia ao. rivi? KOPIOIKO TAR MITÄÄN VAI EI?
	${srat} -rvf ${1} /etc/iptables/rules.v4.? /etc/iptables/rules.v6.?
	echo $?
	sleep 5

	${srat} -rvf ${1} /etc/default/rules* /etc/default/locale* /etc/timezone /etc/locale-gen
	echo $?
	sleep 5

	${scm} -R 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	csleep 6

	#VAIH:exit urputuksen kanssa jos x
	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	#HUOM.15525:se kai onnistuu että samassa tdstossa usemapi iface, auto ja hotplug pois ni pystyy valkkaamaan minkä starttaa/stoppaa?
	case ${iface} in
		wlan0)
			${srat} -rf ${1} /etc/wpa*
		;;
		*)
			dqb "non-wlan"
		;;
	esac

	#HUOM.15525:enforcen nollaus ei vaikuttaisi iaheuttavan mainittavia sivuvaikutuksia ennen omegaa	
	if [ ${enforce} -eq 1 ] ; then
		dqb "das asdd"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuggah
	fi

	if [ ${dnsm} -eq 1 ] ; then
		local f;for f in $(find /etc -type f -name 'stubby*') ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name 'dns*') ; do ${srat} -rf ${1} ${f} ; done
	fi

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*

	dqb "tp2 done"
	csleep 5
}

function tp3() {
	debug=1 #antaa olla vielä
	dqb "tp3 ${1} ${2}"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2

	dqb "paramz_0k"
	csleep 5

	local p
	local q	
	tig=$(sudo which git)

	p=$(pwd)
	q=$(mktemp -d)
	cd ${q}
	
	[ ${debug} -eq 1 ] && pwd  
	csleep 5
	${tig} clone https://github.com/senescent777/more_scripts.git

	[ $? -eq 0 ] || exit 66
	
	dqb "TP3 PT2"
	csleep 5
	cd more_scripts/misc

	#HUOM.14525:ghubista löytyy conf.new mikä vastaisi dnsm=1 (ao. rivi tp2() jatkossa?)
	${spc} /etc/dhcp/dhclient.conf ./etc/dhcp/dhclient.conf.${dnsm} #.0
	
	if [ ! -s  ./etc/dhcp/dhclient.conf.1 ] ; then
		${spc} ./etc/dhcp/dhclient.conf.new ./etc/dhcp/dhclient.conf.1	
	fi

	#HUOM.14525.2:ghubista ei löydy resolv.conf, voisi lennosta tehdä sen .1 ja linkittää myös nimelle .new tmjsp
	# (ao. rivi tp2() jatkossa?)	
	${spc} /etc/resolv.conf ./etc/resolv.conf.${dnsm} #.0

	#joskohan tämä if-blokki pois jatqssa
	if [ -s ./etc/resolv.conf.new ] ; then
		echo "r30lv.c0nf alr3ady 3x15t5"
	else
		${odio} touch ./etc/resolv.conf.new
		${scm} a+w ./etc/resolv.conf.new
		${sco} ${n}:${n}  ./etc/resolv.conf.new

		echo "nameserver 127.0.0.1" > ./etc/resolv.conf.new
		
		${scm} 0444 ./etc/resolv.conf.new
		${sco} root:root ./etc/resolv.conf.new
	fi

	#HUOM.14525.5:eka tarkistus lienee turha
	if [ ! -s ./etc/resolv.conf.1 ] ; then
		 ${spc} ./etc/resolv.conf.new ./etc/resolv.conf.1
	fi

	#HUOM.14525.3:ghubista löytyvä(.new) vastaa tilannetta dnsm=1
	# (ao. rivi tp2() jatkossa?)
	${spc} /sbin/dhclient-script ./sbin/dhclient-script.${dnsm} #.0

	if [ ${dnsm} -eq 0 ] && [ ! -s ./sbin/dhclient-script.1 ] ; then
		  ${spc} ./sbin/dhclient-script.new ./sbin/dhclient-script.1
	fi
	
	#HUOM.14525.4:tp3 ajetaan ennenq lisätään tar:iin ~/D/minim tai paikallisen koneen /e
	#HUOM.sources.list kanssa voisi mennä samantap idealla kuin yllä? 
	# (ao. rivi tp2() jatkossa?)
 	${spc} /etc/apt/sources.list ./etc/apt/sources.list.${2}

	${svm} ./etc/apt/sources.list ./etc/apt/sources.list.tmp #ehkä pois jatqssa (echo "sed" > bash -s saattaisi toimia)
	${svm} ./etc/network/interfaces ./etc/network/interfaces.tmp
	# (ao. rivi tp2() jatkossa?)
	${spc} /etc/network/interfaces ./etc/network/interfaces.${2} #tässä iface olisi parempi kuin distro, EHKä

	${sco} -R root:root ./etc
	${scm} -R a-w ./etc
	${sco} -R root:root ./sbin 
	${scm} -R a-w ./sbin
	${srat} -rvf ${1} ./etc ./sbin 

	echo $?
	cd ${p}
	dqb "tp3 done"
	csleep 6
}

function tpu() {
	#debug=1	
	#HUOM:0/1/old/new ei liity
	dqb "tpu ${1}, ${2}"

	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] && mv ${1} ${1}.OLD
	[ z"${2}" == "z" ] && exit 11
	[ -d ${2} ] || exit 22
	dqb "params_ok"

	#pitäisiköhän kohdehmistostakin poistaa paketit?
	${NKVD} ${pkgdir}/*.deb #toimiiko tuo NKVD vai ei?
	dqb "TUP PART 2"

	${sag} upgrade -u
	echo $?
	csleep 5

	#30425:kuseekohan tuossa jokin? wpasupplicantin poisto melkein johti xorgin poistoon...
	udp6

	dqb "UTP PT 3"
	${svm} ${pkgdir}/*.deb ${2}
	date > ${2}/tim3stamp
	${srat} -cf ${1} ${2}/tim3stamp
	rmt ${1} ${2}

	${sifd} ${iface}
	dqb "SIELUNV1H0LL1N3N"
}

#TODO:-v tekemään jotain hyödyllistä

function tp5() {
	debug=1

	dqb "tp5 ${1} ${2}"
	[ z"${1}" == "z" ] && exit 99
	[ -s ${1} ] || exit 98
	[ -d ${2} ] || exit 97
 
	dqb "params ok"
	csleep 5

	local q
	q=$(mktemp -d)
	cd ${q}
	[ $? -eq 0 ] || exit 77

	${tig} clone https://github.com/senescent777/more_scripts.git
	[ $? -eq 0 ] || exit 99
	
	#HUOM:{old,new} -> {0,1} ei liity
	[ -s ${2}/profs.sh ] && mv ${2}/profs.sh ${2}/profs.sh.OLD
	mv more_scripts/profs/profs* ${2}

	${scm} 0755 ${2}/profs*
	${srat} -rvf ${1} ${2}/profs*

	dqb "AAMUNK01"
}

dqb "mode= ${mode}"
dqb "tar= ${srat}"
csleep 6

pre1 ${d}

case ${mode} in
	0|4) 
		pre1 ${d}
		pre2 ${d}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd
		dd if=/dev/random bs=6 count=1 > ./rnd

		${srat} -cvf ${tgtfile} ./rnd
		tp3 ${tgtfile} ${distro}

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		${srat} -cvf ${d}/e.tar ./rnd
		[ ${mode} -eq 0 ] && tp4 ${d}/e.tar ${d}
		${sifd} ${iface}

		tp1 ${tgtfile} ${d}
		pre1 ${d}
		tp2 ${tgtfile}
	;;
	1|u|upgrade)
		pre2 ${d}
		tpu ${tgtfile} ${d}
	;;
	p)
		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${d}
		tp5 ${tgtfile} ${PREFIX}
	;;
	e)
		pre2 ${d}
		tp4 ${tgtfile} ${d}
	;;
	f)
		rmt ${tgtfile} ${d}
	;;
	q)
		[ z"${tgtfile}" == "z" ] && exit 99
		${sifd} ${iface}

		tpq ${PREFIX}
		${srat} -cf ${tgtfile} ${PREFIX}/xfce.tar ${PREFIX}/fediverse.tar
	;;
esac

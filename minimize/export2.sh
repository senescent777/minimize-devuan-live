#!/bin/bash
debug=1
tgtfile=""
distro=$(cat /etc/devuan_version) #tarpeellinen tässä
PREFIX=~/Desktop/minimize #käyttöön+komftdstoon jos mahd

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

mode=${1}
tgtfile=${2}

case $# in
	1)
		[ "${1}" == "-h" ]  || exit
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
	echo "CONFIG MISSING"; exit 55
fi

. ${PREFIX}/common_lib.sh

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "L1B M1SSING"

	function pr4() {
		dqb "exp2.pr4 (${1})" 
	}

	function pre_part3() {
		dqb "exp2.pre_part3( ${1})"
	}

	check_binaries ${distro}
	check_binaries2
fi

dqb "tar = ${srat} "
${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh

tig=$(sudo which git)
mkt=$(sudo which mktemp)

#HUOM.10525:jostain syystä git poistuu, tee jotain asialle (siihen asti näin)
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
	debug=1
	dqb "pre2( ${1}, ${2})" #WTIN KAARISULKEET STNA
	[ x"${1}" == "z" ] && exit 666

	local ortsac
	ortsac=$(echo ${1} | cut -d '/' -f 6)

	if [ -d ${1} ] ; then
		dqb "PRKL"
		${odio} ${PREFIX}/changedns.sh ${dnsm} ${ortsac}
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
	${srat} -cf ${PREFIX}/xfce.tar ~/.config/xfce4/xfconf/xfce-perchannel-xml 
	csleep 2

	if [ -x ${PREFIX}/profs.sh ] ; then
		dqb "PR0FS.SH F+UND"
			
		. ${PREFIX}/profs.sh
		exp_prof ${PREFIX}/fediverse.tar default-esr
	else
		dqb "FASD FADS SAFD"	
	fi

	csleep 5
}

function tp1() {
	debug=1
	dqb "tp1( ${1} , ${2} )"
	[ z"${1}" == "z" ] && exit
	dqb "params_ok"
	csleep 3

	if [ -d ${2} ] ; then
		dqb "cleaning up ${2} "
		csleep 3
		${NKVD} ${2}/*.deb
		dqb "d0nm3"
	fi

	if [ ${enforce} -eq 1 ] ; then
		dqb "FORCEFED BROKEN GLASS"
		tpq
	fi

	if [ ${debug} -eq 1 ] ; then
		ls -las ${PREFIX}/; sleep 5
	fi

	${srat} -rvf ${1} ${PREFIX} /home/stubby #HUOM.260125: -p wttuun varm. vuoksi
	dqb "tp1 d0n3"
	csleep 3
}

function rmt() {
	debug=1
	dqb "rmt(${1}, ${2})" #WTUN TYPOT STNA111223456

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
	debug=1
	dqb "tp4( ${1} , ${2} )"

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

	#HUOM.260125: -p wttuun varm. vuoksi  
	dqb "tp4 donew"
	csleep 3
}

#HUOM.12525:kakkosparametri ei tee mitään tässä fktiossa
function tp2() {
	debug=1
	dqb "tp2 ${1} ${2}"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2
	dqb "params_ok"
	csleep 5

	#HUOM.30425:koklataan josko sittenkin pelkkä /e/n/interfaces riittäisi koska a) ja b)
	#tablesin kohdalla jos jatkossa /e/i/rules.v? riittäisi?
	#locale ja tzone mukaan toisessa fktiossa vai ei?
	#11525:tuleeko /e/iptables mukaan vai ei? kyl kai
	#HUOM.12525.2:tarttisi ehkä kopsata /e/ipt/r -> /e/d/r

	#HUOM.12525.1:jotain karsimista jatkossa kenties?
	${scm} -R a+r /etc/iptables
	${scm} a+x /etc/iptables
	#HUOM.1252525.25252525:rules.x ei näköjään tullut mukaan, joko väärät jokerit tai käyttöoikeudet, tee joatin
	${srat} -rvf ${1} /etc/network/interfaces /etc/iptables/rules.v4.? /etc/iptables/rules.v6.? 
	${scm} -R 0440 /etc/iptables
	${scm} ug+x /etc/iptables
	ls -las /etc/iptables
	csleep 6

	${srat} -rvf ${1} /etc/default/rules* /etc/default/locale* /etc/timezone /etc/locale-gen

	case ${iface} in
		wlan0)
			${srat} -rf ${1} /etc/wpa*
		;;
		*)
			dqb "non-wlan"
		;;
	esac

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

#HUOM.12525:kakkosparametri ei tee mitään tässä fktiossa
function tp3() {
	debug=1
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

	#TODO:tuonne /e/d/grub-juttuja (disable ipv6-juttuja)
	${tig} clone https://github.com/senescent777/project.git
	[ $? -eq 0 ] || exit 66
	dqb "TP3 PT2"
	csleep 10
	cd project

	${spc} /etc/dhcp/dhclient.conf ./etc/dhcp/dhclient.conf.OLD
	#HUOM.8535:/e/r.conf-tilanne korjattu
	${spc} /etc/resolv.conf ./etc/resolv.conf.OLD
	${spc} /sbin/dhclient-script ./sbin/dhclient-script.OLD

	${svm} ./etc/apt/sources.list ./etc/apt/sources.list.tmp #ehkä pois jatqssa
	${svm} ./etc/network/interfaces ./etc/network/interfaces.tmp

	#HUOM.310325:jostain erityisestä syystä kommenteissa?
	#280425: varm vuoksi takqaisin kommentteihin?
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
	debug=1	

	dqb "tpu( ${1}, ${2})"
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

#TODO:tsoituvia mjpnoja vähemmksi
function tp5() {
	debug=1

	dqb "tp5 ${1} ${2}"
	[ z"${1}" == "z" ] && exit 99
	[ -s ${1} ] || exit 98

	dqb "params ok"
	csleep 5

	local q
	q=$(mktemp -d)
	cd ${q}
	[ $? -eq 0 ] || exit 77

	${tig} clone https://github.com/senescent777/some_scripts.git
	[ $? -eq 0 ] || exit 99

	mv some_scripts/lib/export/profs* ${PREFIX} 
	${scm} 0755 ${PREFIX}/profs*
	${srat} -rvf ${1} ${PREFIX}/profs*

	dqb "AAMUNK01"
}

dqb "mode= ${mode}"
pre1 ${d} #istro}

case ${mode} in
	0)
		pre1 ${d}
		pre2 ${d}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd
		dd if=/dev/random bs=6 count=1 > ./rnd

		${srat} -cvf ${tgtfile} ./rnd
		tp3 ${tgtfile} #${distro}

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		${srat} -cvf ${d}/e.tar ./rnd
		tp4 ${d}/e.tar ${d}	
		${sifd} ${iface}

		tp1 ${tgtfile} ${d}
		pre1 ${d}
		tp2 ${tgtfile} #${distro}
	;;
	3)
		tp1 ${tgtfile} ${d}

		pre1 ${d}
		pre2 ${d}
		tp3 ${tgtfile} #${distro}

		pre1 ${d}
		tp2 ${tgtfile} #${distro}

		pre1 ${d}
		pre2 ${d}
		tp4 ${tgtfile} ${d}
	;;
	1|u|upgrade)
		pre2 ${d}
		tpu ${tgtfile} ${d}
	;;
	p)
		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${d}
		tp5 ${tgtfile}
	;;
	e)
		pre2 ${d}
		tp4 ${tgtfile} ${d}
	;;
	f)
		rmt ${tgtfile} ${d}
	;;
	-h)
		echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
		echo "$0 3 <tgtfile> [distro] [-v]: makes the main pkg (old way)"
		echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
		echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
		echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under ${PREFIX}/\${distro}"
		echo "$0 p <> [] [] pulls Profs.sh from somewhere"
		echo "$0 q <> [] [] archives firefox settings"
				
		echo "$0 -h: shows this message about usage"		
	;;
	q)
		[ z"${tgtfile}" == "z" ] && exit 99
		${sifd} ${iface}

		tpq #fktio ottamaan parametreja?
		${srat} -cf ${tgtfile} ${PREFIX}/xfce.tar ${PREFIX}/fediverse.tar
	;;
esac

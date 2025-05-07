#!/bin/bash
debug=0 #1
tgtfile=""
distro=$(cat /etc/devuan_version) #tarpeellinen tässä

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

mode=${1}
tgtfile=${2}

case $# in
	2)
		dqb "maybe ok"
	;;
	3)
		if [ -d ~/Desktop/minimize/${3} ] ; then
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
	;;
esac

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
[ z"${distro}" == "z" ] && exit 6

if [ -d ~/Desktop/minimize/${distro} ] && [ -s ~/Desktop/minimize/${distro}/conf ]; then
	. ~/Desktop/minimize/${distro}/conf
else
	echo "CONFIG MISSING"; exit 55
fi

. ~/Desktop/minimize/common_lib.sh

if [ -d ~/Desktop/minimize/${distro} ] && [ -x ~/Desktop/minimize/${distro}/lib.sh ] ; then
	. ~/Desktop/minimize/${distro}/lib.sh
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
${scm} 0555 ~/Desktop/minimize/changedns.sh
${sco} root:root ~/Desktop/minimize/changedns.sh

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

function pre() {
	[ x"${1}" == "z" ] && exit 666

	${sco} -Rv _apt:root ${pkgdir}/partial/
	${scm} -Rv 700 ${pkgdir}/partial/
	csleep 4

	if [ -d ~/Desktop/minimize/${1} ] ; then
		dqb "5TNA"

		n=$(whoami)
		enforce_access ${n}
		csleep 2

		if [ -s /etc/apt/sources.list.${1} ] ; then
			${smr} /etc/apt/sources.list
			${slinky} /etc/apt/sources.list.${1} /etc/apt/sources.list
		else
			part1_5 ${1}
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

	if [ -d ~/Desktop/minimize/${1} ] ; then
		dqb "PRKL"
		${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${1}
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

function tp1() {
	dqb "tp1( ${1} , ${2} )"
	[ z"${1}" == "z" ] && exit
	dqb "params_ok"
	csleep 3

	if [ -d ~/Desktop/minimize/${2} ] ; then
		dqb "cleaning up ~/Desktop/minimize/${2} "
		csleep 3
		${NKVD} ~/Desktop/minimize/${2}/*.deb
		dqb "d0nm3"
	fi

	if [ ${enforce} -eq 1 ] ; then
		dqb "FORCEFED BROKEN GLASS"
		${srat} -cf ~/Desktop/minimize/xfce.tar ~/.config/xfce4/xfconf/xfce-perchannel-xml 
		csleep 2

		local tget
		local p
		local f
		
#		#VAIH:josko ao. kikkailut -> profs.js
#		tget=$(ls ~/.mozilla/firefox/ | grep default-esr | tail -n 1)
#		p=$(pwd)
#
#		cd ~/.mozilla/firefox/${tget}
#		dqb "TG3T=${tget}"
#		csleep 2
#
#		${odio} touch ./rnd
#		${sco} ${n}:${n} ./rnd
#		${scm} 0644 ./rnd
#		dd if=/dev/random bs=6 count=1 > ./rnd
#
		#${srat} -cvf ~/Desktop/minimize/someparam.tar ./rnd
		#for f in $(find . -name '*.js') ; do ${srat} -rf ~/Desktop/minimize/someparam.tar ${f} ; done
		##*.js ja *.json kai oleellisimmat kalat
		#cd ${p}

		if [ -x ~/Desktop/minimize/profs.sh ] ; then
			[ -x ~/Desktop/minimize/middleware.sh ] && . ~/Desktop/minimize/middleware.sh
			. ~/Desktop/minimize/profs.sh
			exp_prof ~/Desktop/minimize/someparam.tar
		fi
	fi

	if [ ${debug} -eq 1 ] ; then
		ls -las ~/Desktop/minimize/; sleep 5
	fi

	${srat} -rvf ${1} ~/Desktop/minimize /home/stubby #HUOM.260125: -p wttuun varm. vuoksi
	dqb "tp1 d0n3"
	csleep 3
}

function rmt() {
	dqb=1
	dqb "rmt(${1}, ${2})" #WTUN TYPOT STNA111223456
	${scm} 0444 ~/Desktop/minimize/${2}/*.deb
	p=$(pwd)

	cd ~/Desktop/minimize/${2}
	[ -f ./sha512sums.txt ] && ${NKVD} ./sha512sums.txt
	csleep 3

	touch ./sha512sums.txt
	chown $(whoami):$(whoami) ./sha512sums.txt
	chmod 0644 ./sha512sums.txt
	[ ${debug} -eq 1 ] && ls -las sha*;sleep 6

	${sah6} ./*.deb > ./sha512sums.txt
	csleep 3
	psqa .

	${srat} -rf ${1} ~/Desktop/minimize/${2}/*.deb ~/Desktop/minimize/${2}/sha512sums.txt
	csleep 1
	cd ${p}

	dqb "rmt d0n3"
}

function tp4() {
	dqb=1
	dqb "tp4( ${1} , ${2} )"

	[ z"${1}" == "z" ] && exit 1
	[ -s ${1} ] || exit 2

	[ z"${2}" == "z" ] && exit 11
	[ -d ~/Desktop/minimize/${2} ] || exit 22

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

	#VAIH:testaa

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} groff-base libgdbm6 libpipeline1 libseccomp2 #bsd debconf libc6 zlib1g		
	
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=sudo=1.9.13p3-1+deb12u1
	${shary} libaudit1 libselinux1 #libpam0g #libpam-modules zlib1g #libpam kanssa oli nalkutusta 080525

	${shary} man-db sudo

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
	if [ -d ~/Desktop/minimize/${2} ] ; then 
		${NKVD} ~/Desktop/minimize/${2}/*.deb	
		${svm} ${pkgdir}/*.deb ~/Desktop/minimize/${2}
		rmt ${1} ${2}
	fi

	#HUOM.260125: -p wttuun varm. vuoksi  
	dqb "tp4 donew"
	csleep 3
}

function tp2() {
	debug=1
	dqb "tp2 ${1} ${2}"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2
	dqb "params_ok"
	csleep 5

	#HUOM.30425:koklataan josko sittenkin pelkkä /e/n/interfaces riittäisi koska a) ja b)
	#tablesin kohdalla jos jatkossa /e/i/rules.v? riittäisi?
	${srat} -rf ${1} /etc/iptables /etc/network/interfaces /etc/default/locale

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

	#TODO:tuonne /e/d/grub-juttuja
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
	[ -d  ~/Desktop/minimize/${2} ] || exit 22
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
	${svm} ${pkgdir}/*.deb ~/Desktop/minimize/${2}
	date > ~/Desktop/minimize/${2}/tim3stamp
	${srat} -cf ${1} ~/Desktop/minimize/${2}/tim3stamp
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

	dqb "params ok"
	csleep 5

	local q
	q=$(mktemp -d)
	cd ${q}
	[ $? -eq 0 ] || exit 77

	${tig} clone https://github.com/senescent777/some_scripts.git
	[ $? -eq 0 ] || exit 99

	mv some_scripts/lib/export/profs* ~/Desktop/minimize 
	${scm} 0755 ~/Desktop/minimize/profs*
	${srat} -rvf ${1} ~/Desktop/minimize/profs*

	dqb "AAMUNK01"
}

dqb "mode= ${mode}"
pre ${distro}

case ${mode} in
	0)
		pre ${distro}
		pre2 ${distro}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd
		dd if=/dev/random bs=6 count=1 > ./rnd

		${srat} -cvf ${tgtfile} ./rnd
		tp3 ${tgtfile} ${distro}

		[ -f ~/Desktop/minimize/${distro}/e.tar ] && ${NKVD} ~/Desktop/minimize/${distro}/e.tar
		${srat} -cvf ~/Desktop/minimize/${distro}/e.tar ./rnd
		tp4 ~/Desktop/minimize/${distro}/e.tar ${distro} #${tgtfile} ${distro}	
		${sifd} ${iface}

		tp1 ${tgtfile} ${distro}
		pre ${distro}
		tp2 ${tgtfile} ${distro}
	;;
	3)
		tp1 ${tgtfile} ${distro}

		pre ${distro}
		pre2 ${distro}
		tp3 ${tgtfile} ${distro}

		pre ${distro}
		tp2 ${tgtfile} ${distro}

		pre ${distro}
		pre2 ${distro}
		tp4 ${tgtfile} ${distro}
	;;
	1|u|upgrade)
		pre2 ${distro}
		tpu ${tgtfile} ${distro}
	;;
	p)
		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${distro}
		tp5 ${tgtfile}
	;;
	e)
		pre2 ${distro}
		tp4 ${tgtfile} ${distro}
	;;
	f)
		rmt ${tgtfile} ${distro}
	;;
	-h)
		echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
		echo "$0 3 <tgtfile> [distro] [-v]: makes the main pkg (old way)"
		echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
		echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
		echo "$0 f <tgtfile> [distro] [-v]: archives .deb files"
		echo "$0 -h: shows this message about usage"		
	;;
esac

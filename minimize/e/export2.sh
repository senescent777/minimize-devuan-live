#!/bin/bash

debug=0
distro=$(cat /etc/devuan_version)

d0=$(pwd)
d=${d0}/${distro}
mode=-2
tgtfile=""
gbk=0
mop=""

function usage() {
	echo "$0 3 <tgtfile> [distro?] [-v]: makes th3 main package (new way)"
	echo "$0 4 <tgtfile> [distro?] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 u <tgtfile> [distro?] [-v]: makes Upgrade_pkg"
	echo "$0 e <tgtfile> [distro?] [-v]: archives the Essential .deb packages"
	echo

	echo "$0 l <tgtfile> [-v] [ -d preferred_displaymanager? ] : makes a packaged containing .deb-files for a (preferred) displaymanager"
	echo "$0 g adds Gpg for signature checks, maybe?"
	echo "$0 t ... option for ipTables"
	echo "$0 -h: shows tHis message about usage"
}

#jos muuttaisi blokin koskapa gpo() nykyään? (-h kanssa voisi tehdä toisinkin)
#... jospa ensin export3:sen kanssa kokeilut ja sitttten

if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

function parse_opts_1() {
	dqb "parse_opts_1( ${1})"

	case "${1}" in
		-p)
			#VAIH:VARMISTA ETTÄ TÄMÄ VIPY TOIMII!!! VISSIIN EI TOIMAA JUURI NYT
			#if [ "${gbk}" == "-1" ] ; then
				gbk=1
			#fi
		;;
#		*)
#			if [ -d ${d}/${1} ] ; then
#				#distro=${1} #090326:kuinkahan oleellinen distron yliajo?
#				d=${d0}/${distro}
#			fi
#		;;
	esac
}

function parse_opts_2() {
	dqb "parse_opts_2)))))))( ${1} ; ${2} ))))))"

	case "${1}" in
		-d)
			mop=${2}
		;;
#		*)
#			if [ "${mode}" == "-2" ] ; then
#				mode=${1}
#				tgtfile=${2}
#			else
#				dqb " ${1} NOT SUPPORTED"
#			fi
#		;;
	esac
}

d=${d0}/${distro}

function fallback() { #tarpeellinen?
	exit 59
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	exit 57
fi

[ -z "${distro}" ] && exit 6
d=${d0}/${distro}
process_lib ${d}
mop=${CONF_dm} 

dqb "BEF0RE T1G N0R MKTMP"
sleep 1

if [ -z "${tig}" ] ; then
	echo "SHOULD INSTALL GIT ($0 e)"
	[ "${mode}" == "e" ] || exit 7
fi

if [ -z "${mkt}" ] ; then
	echo "SHOULD INSTALL MKTEMP ($0 e)"
	exit 8
fi

echo "JUST BEFORE INCLUDING FLIES 1nt0 50UP"
sleep 1

if [ -x ${d0}/e/e22.sh ] ; then
	.  ${d0}/e/e22.sh
	[ $? -gt 0 ] && exit 66
	csleep 1

	.  ${d0}/e/e23.sh
	[ $? -gt 0 ] && exit 67
	csleep 1
else
	echo "NO BACKEND FOUND"
	exit 85
fi

[ -z "${tgtfile}" ] && exit 98
t=$(echo ${d} | cut -d '/' -f 1-5)

csleep 1
[ -d ${d0}/${tgtfile} ] && exit 64

e22_hdr ${tgtfile}
[ -v CONF_iface ] && ${sifd} ${CONF_iface}

e22_pre1 ${d} ${distro}
[ ${debug} -eq 1 ] && pwd;sleep 6

e22_pre2 ${CONF_iface} ${CONF_dnsm}
e22_cleanpkgs ${d}
e22_cleanpkgs ${CONF_pkgdir}

#HUOM.nämä voivat jtnkin suhtautua ylempään e22_hdr()-qtsuun jossia n tilanteessa
[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

doit=1
csleep 1

dqb "JUST BEFORE ESAC"
csleep 6

case "${mode}" in
	0)
		exit 97
	;;
	3|4) 
		#TODO:main-oksan kanssa testaus josqs (merd2+exp2)
		#120726:lienee toimiva tämä case (aiNAKin kerran roimi sill01m)
		#18726:case 4 ytrstissä , vissiin toimaa
		#29726:case 3 toimii ehkä

		[ -v CONF_default_arhcive3 ] || exit 66
		e22_z1 ${CONF_hashfile3}

		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} ${CONF_hashfile3}.tmp
		reqwreqw ${CONF_hashfile3}.tmp
		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?

		if [ ${mode} -eq 3 ] && [ "${CONF_env}" == "DEFAULT" ] ; then
			#TODO?:tähän alle ehkä joskus muutoksia, rekursion tarkiotus liittyä?
			#... tai jos case g prujaus...

			e23_tblz ${CONF_iface} ${CONF_dnsm}
			e23_other_pkgs ${CONF_dnsm}
		else
			doit=0
		fi

		e22_home_pre ${tgtfile} ${d} ${CONF_enforce} ${CONF_default_arhcive2} ${CONF_default_arhcive}
		e22_home ${tgtfile} ${d} ${CONF_default_arhcive} 

		e22_pre1 ${d} ${distro}
		e22_acol ${tgtfile} ${CONF_iface} ${CONF_dnsm} ${CONF_enforce}
		fasdfasd ${CONF_hashfile3}.tmp

		e22_sarram ${tgtfile} ${CONF_dm} ${CONF_hashfile3}.tmp
		e22_z2 ${CONF_hashfile3}
		e22_z3 ${CONF_hashfile3} ${tgtfile} ${d0}/MAN1.F2ST
	;;
	u|upgrade)
		#140726:testaus vaiheessa, pakETTeja saa vedettyä ainakin
		#170726:xserver-pakettien hukkaaminen ,  liittyykö g_pt2 ? No Ei ?
		#elikkäs uusi yritys lähiaikoina (DONE?) (part2 jo ok 27726?)
		#bissiin sisältö masentuu ilman kiukutteLuja, ainakin enimmäkseen
		#310726: tai siis kiukutteluja kyllä löytyy
		#VAIH:dblok kutsuvasta koodista part175 ja ten1 jemmaan, palauttelu testikierros kerrallaan

		#020836: sqroot "bind9-dnsutils depends on bind9-host | host; however" accept kusee vai jotain muuta?

		[ -v CONF_pkgdir ] || exit 96
		dqb " ${CONF_iface} SHOULD Be U P B Y No W - Heisenberg"
		csleep 1

		e23_upgp
		${sifd} ${CONF_iface}
		csleep 1

		##e23_upgp2 ${CONF_pkgdir} ${CONF_iface}
		#ten1 ${CONF_iface} ${CONF_pkgdir} #310726:uskaltaakohan tätäkään?
		#saattaa olla ten1 tässä turha koska cg_udp6 myöhemmin
	;;
	e) 
		#18726:bissiin teki asentuvan apketin touilloin
		#24726:paketin osaisi bissiin muodostaa, testaapa miten oksennukset asentuvaqt (VAIH)
		#... masentaessa libn* kanssa kusoo kuappiin vissiin
		#26726 jo korjattu e23_fktiot? bissiin
		#31726:pre_e():n dhcp-karsinta turhaa kikkailua, parempi että dellitään ensin turhat pak ja asenneraan tarpeellisen tilalle ?
		#TODO:e/t/g/l/n/s testailu uudemman kerran

		e22_pre_e ${CONF_iface} ${E22_GS}
		e22_pre_e ${CONF_iface} ${E22_GM}

		csleep 3
		message
		csleep 2

		e23_tblz ${CONF_iface} ${CONF_dnsm}
		dqb "BC/AD"
		csleep 5

		e23_other_pkgs ${CONF_dnsm}
		ls -las ${CONF_pkgdir}/libn*
		csleep 6
	;;
	t) #toiminee mikäli case:t e tai 3 toimivat 
		message
		csleep 2
		e23_tblz ${CONF_iface} ${CONF_dnsm}
	;;
	g) #17726:vissiin muodosti asentuvaa sisältöä tuolloin
		[ -v E22_GI ] || exit 95
		e22_hdr ${d}/e.tar
		${fib}

		e22_pre_e ${CONF_iface} ${E22_GI}
		e22_pre_e ${CONF_iface} ${E22_GG}

		e22_dblock ${d}/e.tar ${d} ${CONF_pkgdir} ${gbk}
		${srat} -rvf ${tgtfile} ${d}/e.tar*
		doit=0
	;;
	l)
		#120726:lienee toimiva tämä case
		#TODO:tähän kilkkeeseen liittyen ne perl-yms. urputukset voisdi vähitellen hoitaa, $distro/accept ...
		
		#020826: sqroot kanssa "twm depends on menu (>= 2.1.26); however:"
		#libglx0:amd64 depends on libglx-mesa0; however:
		#libwutil5:amd64 depends on wmaker-common
		#libegl1:amd64 depends on libegl-mesa0
		#libglx-mesa0:amd64 depends on libglapi-mesa
		#libglx-mesa0:amd64 depends on libgl1-mesa-dri
		#libgtk-3-0:amd64 depends on libgtk-3-common
		#libegl-mesa0:amd64 depends on libglapi-mesa
		#... accept-jutut qnnossa?
		
		#mesa-vdpau-drivers:amd64 depends on libvdpau1; however
		# mesa-vdpau-drivers:amd64 depends on libvdpau1; however:´
		#  Package libvdpau1:amd64 is not installed.
		#libperl5.36:amd64 depends on perl-modules-5.36 (>= 5.36.0-7+deb12u3); however:
		#  Version of perl-modules-5.36 on system is 

		#dpkg: dependency problems prevent configuration of libpython3.11-stdlib:amd64:
		# libpython3.11-stdlib:amd64 depends on libpython3.11-minimal

		#librsvg2-common:amd64 depends on librsvg2-2 (= 2.54.7+dfsg-1~deb12u1); however:
  		#Version of librsvg2-2:amd64 on system is	

		#libxml-parser-perl depends on perl (>= 5.36.0-7+deb12u3); however:
		#  Version of perl on system is

		#python3.11 depends on libpython3.11-stdlib (= 3.11.2-6+deb12u7); however:
  		#Package libpython3.11-stdlib:amd64 is

		#perl depends on libperl5.36 (= 5.36.0-7+deb12u3); however:
		#  Package libperl5.36:amd64 is
		# git depends on perl; however

		csleep 1
		[ -v CONF_dm ] || exit 77
		e23_dm ${mop}
	;;
	n)
		#24726:kokeeksi tehdään uusi paketti (VAIH)
		#TODO:masentelu ja sivuvaikutukset

		${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
		${shary} ntpsec
	;;
#	x)
#		#:uusiksi vain koko pasq?
#		e23_xyz
#	;;
	s) #lienee tekevän toimivaa oksennusta (28626)
		e23_st
	;;
	*)
		echo "MAYBE U SHOULD USE export3 INSTEAD"
		sleep 5
		${d0}/export3.bash ${mode} ${tgtfile} -v
		exit
	;;
esac

#tktiona vähän turhaq, tarkistuksia enemmän kun varsnsiats koodia, toisaalta voisi prujata fktion sisällön niihin 2 kohtaan export2:sessa
#function e22_dblock() {
#	dqb "e22_dblock(${1} , ${2} , ${3} , ${4} )))) "
#
#	[ -z "${1}" ] && exit 14
#	[ -s ${1} ] || exit 15
#	[ -z "${2}" ] && exit 11
#	[ -d ${2} ] || exit 22
#	[ -w ${2} ] || exit 23
#	[ -z "${3}" ] && exit 33
#	[ -d ${3} ] || exit 34
#	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...
#	[ -z "${4}" ] && exit 37
#
#	dqb ".PARS-OK"
#	csleep 1
#
#	[ ${debug} -eq 1 ] && pwd
#
#	ls -la ${3}/*.deb | wc -l
#
#	for s in ${PART175_LIST} ; do
#		${sharpy} ${s}*
#		${NKVD} ${3}/${s}*.deb
#	done
#
#	local t
#	t=$(echo ${2} | cut -d "/" -f 1-6)
#	e22_ts ${t} ${3}
#	dqb "JST B3F0R3 3NF0RC3"
#	csleep 10
#
#	enforce_access $(whoami) ${t}
#	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
#	csleep 10
#
#	e22_arch ${1} ${2} ${4}
#	e22_cleanpkgs ${2}
#}

#tuossa alla vielä jotain laittoa?
if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then
	e22_hdr ${d}/f.tar
	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} ${gbk}
	e22_ftr ${d}/f.tar

	${srat} -rvf ${tgtfile} ${d}/f.tar*
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar*
fi

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi

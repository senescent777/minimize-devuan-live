#!/bin/bash

debug=0 #1
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

#VAIH:jos muuttaisi blokin koskapa gpo() nykyään? (-h kanssa voisi tehdä toisinkin)
#... jospa ensin export3:sen kanssa kokeilut ja sitttten

if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se peruslähtökohta (tai sitten saatanallisuus)
#290426:parse_fktioiden siirto e22:seen olisi 1 idea, tosin siitä seurannee paljon säätöä

function parse_opts_1() {
	dqb "parse_opts_1( ${1})"

	case "${1}" in
		-p)
			if [ "${gbk}" == "-1" ] ; then
				gbk=1
			fi
		;;
		*)
			if [ -d ${d}/${1} ] ; then
				#distro=${1} #090326:kuinkahan oleellinen distron yliajo?
				d=${d0}/${distro}
			fi
		;;
	esac

	#290326:jspa tu case-esac esim. toimisi?
}

function parse_opts_2() {
	dqb "parse_opts_2)))))))( ${1} ; ${2} ))))))"

	case "${1}" in
		-d)
			mop=${2}
		;;
		*)
			dqb " ${1} NOT SUPPORTED"
		;;
	esac
}

#parsetuksen knssa menee jännäksi jos conf pitää ladata ennen common_lib (no parse_opts:iin tiettty muutoksia?)
d=${d0}/${distro}

function fallback() { #tarpeellinen?
	exit 59
}

if [ -x ${d0}/common_lib.sh ] ; then #200426:edelleen tarpeellinen kirjasto
	. ${d0}/common_lib.sh
else
	#johdonmukaisuus virhekoodeissa olisi tietty kiva
	exit 57
fi

[ -z "${distro}" ] && exit 6
d=${d0}/${distro} #nykyään vähän turha tässä
process_lib ${d}
mop=${CONF_dm} #voinee joutua muuttamaan jatkossa?

#suorituksen keskeytys aLEmpaa näille main jos ei löydy tai -x ?
dqb "BEF0RE T1G N0R MKTMP"
sleep 1

if [ -z "${tig}" ] ; then
	echo "SHOULD INSTALL GIT"
	[ "${mode}" == "e" ] || exit 7  #VAIH:exit vain jos mode!=e ?
fi

if [ -z "${mkt}" ] ; then
	echo "SHOULD INSTALL MKTEMP"
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
	exit 58
fi

#https://askubuntu.com/questions/1206167/download-packages-without-installing liittynee
[ -z "${tgtfile}" ] && exit 98
t=$(echo ${d} | cut -d '/' -f 1-5)

cont=0
dqb "ESAC1"
csleep 1
[ -d ${d0}/${tgtfile} ] && exit 64

#-h pysähtyy ennen tätä riviä?
e22_hdr ${tgtfile}
[ -v CONF_iface ] && ${sifd} ${CONF_iface}
#jokin varmistus vielä että iface alhaalla?

#HUOM!!! e22_pre2() AJAA sifu-KOMENNON JOTEN TÄSSÄ EI ERIKSEEN TARVITSE
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

case "${mode}" in
	0)
		exit 97
	;;
	3|4) 
		#3 taisi toimia 04/26 tienoilla ainakin kerran
		# 21426 onnasi viimeksi paketin rakennus tässä moodissa, sisältökin jnkin verran toimaa

		#4 toimi viimeksi 180426
		#merd2 taisi toimia 21.4
	
		[ -v CONF_default_arhcive3 ] || exit 66
		z1 /opt/bin/zxcv

		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} /opt/bin/zxcv.tmp
		reqwreqw /opt/bin/zxcv.tmp

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 3 ] && [ ! -v CONF_testgris ] ; then
			e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
			e23_other_pkgs ${CONF_dnsm}
		else
			doit=0
		fi
		
		e22_home_pre ${tgtfile} ${d} ${CONF_enforce} ${CONF_default_arhcive2} ${CONF_default_arhcive}
		e22_home ${tgtfile} ${d} ${CONF_default_arhcive} 

		e22_pre1 ${d} ${distro}
		e22_acol ${tgtfile} ${CONF_iface} ${CONF_dnsm} ${CONF_enforce}
		fasdfasd /opt/bin/zxcv.tmp

		e22_sarram ${tgtfile} ${CONF_dm} /opt/bin/zxcv.tmp
		z2 /opt/bin/zxcv´
		z3 /opt/bin/zxcv ${tgtfile} ${d0}/MAN1.F2ST
	;;
	#180426:osasi paketin muodostaa, asennuksen aikana pientä nalkutusta
	#dpkg: dependency problems prevent configuration of libxml-parser-perl:
 	#libxml-parser-perl depends on perl  however:
	#010526:edelleen osasi paketin muodostaa, toimivuus vielä selvitettävä
	u|upgrade)
		[ -v CONF_pkgdir ] || exit 96
		dqb " ${CONF_iface} SHOULD BY UP BY NOW"
		csleep 1

		e23_upgp
		${sifd} ${CONF_iface}
		csleep 1
		e23_upgp2 ${CONF_pkgdir} ${CONF_iface}
	;;
	e) 
		#300426:paketin muodostaa jälleen, sisällön toinmivuus slevitettävä
		#010526:jos alkaa git hukkumaan säännöllisesti ni jotain tarttisi tehdä
		
		#TODO:fiksummin jatkossa tämä blokki (kts myös e23_tblz())
		if [ "${CONF_iface}" == "eth0:1" ] ; then
			for p in ${E22_GS} ; do
				q=$(echo ${p} | grep -v dhcp)
				[ -z "${q}" ] || ${shary} ${q}
				csleep 1
			done

			for p in ${E22_GM} ; do
				q=$(echo ${p} | grep -v dhcp)
				[ -z "${q}" ] || ${shary} ${q}
				csleep 1
			done
		else
			${shary} ${E22_GS}
			${shary} ${E22_GM}
		fi

		csleep 3
		message
		csleep 2

		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
		e23_other_pkgs ${CONF_dnsm}
	;;
	t)
		#300426:osannee paketin tehdä?
		message
		csleep 2
		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
	;;
	g)
		[ -v E22_GI ] || exit 95
		#VAIH (modostetun paketin toimivuuden testaus lähinnä)
		e22_hdr ${d}/e.tar

		${fib}
		${shary} ${E22_GI}
		e22_dblock ${d}/e.tar ${d} ${CONF_pkgdir} ${gbk}
		${srat} -rvf ${tgtfile} ${d}/e.tar*

		doit=0
	;;
	l)
		#1104236:desktop_live:n kanssa onnistui jo paketin asennus
		#minimal_live:n kanssa ei

		csleep 1
		[ -v CONF_dm ] || exit 77
		e23_dm ${mop}
	;;
	n)
		#VAIH:ntp-jutut takaisin josqs?
		${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
		${shary} ntpsec
	;;
#	x)
#		#TODO:uusiksi vain koko pasq?
#		e23_xyz
#	;;
	s)
		e23_st
	;;
	*)
		exit
	;;
esac

#exit

if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then 
	e22_hdr ${d}/f.tar
	#HUOM.11326:d-blokin tapa toimia aiheuttaa lisäsäätöä sqroot-ympäristössä, koita päättää mitä tehdä asialle
	#exit

	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} ${gbk}
	e22_ftr ${d}/f.tar
	#z3?	

	${srat} -rvf ${tgtfile} ${d}/f.tar* 
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar* 
fi

#exit

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi

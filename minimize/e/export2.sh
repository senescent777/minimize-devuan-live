#!/bin/bash

debug=1
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
#		*)
#			if [ -d ${d}/${1} ] ; then
#				#distro=${1} #090326:kuinkahan oleellinen distron yliajo?
#				d=${d0}/${distro}
#			fi
#		;;
	esac

	#290326:jspa tu case-esac esim. toimisi?
}

function parse_opts_2() {
	dqb "parse_opts_2)))))))( ${1} ; ${2} ))))))"

	case "${1}" in
		-d)
			mop=${2}
		;;
#		*)
#			#
#			if [ "${mode}" == "-2" ] ; then
#				mode=${1}
#				tgtfile=${2}
#			else
#				dqb " ${1} NOT SUPPORTED"
#			fi
#		;;
	esac
}

#parsetuksen knssa menee jännäksi jos conf pitää ladata ennen common_lib (no parse_opts:iin tiettty muutoksia?)
d=${d0}/${distro}

function fallback() { #tarpeellinen?
	exit 59
}

if [ -x ${d0}/common_lib.sh ] ; then #200426:on edelleen tarpeellinen kirjasto
	. ${d0}/common_lib.sh
else
	#johdonmukaisuus virhekoodeissa olisi tietty kiva
	exit 57
fi

echo "MERGE 1take:s $0 w/ 7thsons:s $0"
sleep 6

[ -z "${distro}" ] && exit 6
d=${d0}/${distro} #nykyään vähän turha tässä
process_lib ${d}
mop=${CONF_dm}

#suorituksen keskeytys aLEmpaa näille main jos ei löydy tai -x ?
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

#vrt. toisen repon setup2
E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 git-man git"
	
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

#getoot .o "34uetglnxs" ...

case "${mode}" in
	0)
		exit 97
	;;
	3|4) 
		#3 taisi toimia 04/26 tienoilla ainakin kerran
		# 21426 onnasi viimeksi paketin rakennus tässä moodissa, sisältökin jnkin verran toimaa
		#130526 taas testikierros menossa mode 3:n tuotoksen kanssa, enimmäkseen ok?

		#4 toimi viimeksi 180426 (uusi testikieRRos uudella paketilla 100526, ehkä ok pl ffox profiili?)
		# 1take-oksassa 210526 ok (250526 uudempi ytritys, enimmäkseen ok)
		#260526 vaikuttaisi vielä tuoreempi tuotos toimivan myös modaamattoman kiekon kanssa jnkn verran

		#TODO:main-oksan kanssa testaus josqs (merd2+exp2)
		#merd2 taisi toimia kerrab 21.4 , 21.5 toisen kerrab
		[ -v CONF_default_arhcive3 ] || exit 66
		z1 /opt/bin/zxcv

		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} /opt/bin/zxcv.tmp
		reqwreqw /opt/bin/zxcv.tmp

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 3 ] && [ ! -v CONF_testgris ] ; then
			#TODO:e.tar-kikkailu -> other_okgs() syystä gpg puuttuu
			#... rekursion kanssa jos vaikka tekisi

			e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
			e23_other_pkgs ${CONF_dnsm}
		else
			doit=0
		fi
		
		#110526:config.tar.bz2, fediverse.tar ja profs.sh tulisi kyllä löytyä kohde-paketista edelleen
		#130526:profiilit jo toimivat tuolloin?		
		

		e22_home_pre ${tgtfile} ${d} ${CONF_enforce} ${CONF_default_arhcive2} ${CONF_default_arhcive}
		e22_home ${tgtfile} ${d} ${CONF_default_arhcive} 

		e22_pre1 ${d} ${distro}
		e22_acol ${tgtfile} ${CONF_iface} ${CONF_dnsm} ${CONF_enforce}
		fasdfasd /opt/bin/zxcv.tmp

		e22_sarram ${tgtfile} ${CONF_dm} /opt/bin/zxcv.tmp
		z2 /opt/bin/zxcv
		z3 /opt/bin/zxcv ${tgtfile} ${d0}/MAN1.F2ST
	;;
	#
	#180426:osasi paketin muodostaa, asennuksen aikana pientä nalkutusta
	#dpkg: dependency problems prevent configuration of libxml-parser-perl:
 	#libxml-parser-perl depends on perl  however:
	#010526:edelleen osasi paketin muodostaa, toimivuus vielä selvitettävä
	#	
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
		#010526:jos alkaa git hukkumaan säännöllisesti ni jotain tarttisi tehdä
		#110526:taitaa toimia muodostettttu paketti

		e22_pre_e ${E22_GS}
		e22_pre_e ${E22_GM}
		#130526:E22_GG  masenteluy löytyy jo fktiosta other_pkgs()

		csleep 3
		message
		csleep 2

		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
		e23_other_pkgs ${CONF_dnsm}
	;;
	t)
		#130526:suattaapi olla niinnii jotta toimii koska "$0 3" äskettäin
		message
		csleep 2
		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
	;;
	g)
		#130526:testattu että tämä case toimii, luo paketin mikä asentuu
		#VAIH:bissiin git mukaan tähänkin prkl?
		
		[ -v E22_GI ] || exit 95
		e22_hdr ${d}/e.tar

		${fib}
		${shary} ${E22_GI} #ei tarvinne tässä pre_e kautta mennä
		${shary} ${E22_GG}

		e22_dblock ${d}/e.tar ${d} ${CONF_pkgdir} ${gbk}
		${srat} -rvf ${tgtfile} ${d}/e.tar*

		doit=0
	;;
	l)
		#1104236:desktop_live:n kanssa onnistui jo paketin asennus
		#minimal_live:n kanssa ei
		#010526:edelleen muodostaa paketin, sisällön validius selvitettävä

		csleep 1
		[ -v CONF_dm ] || exit 77
		e23_dm ${mop}
	;;
	n)
		#VAIH:ntp-jutut takaisin josqs? 260526 -> ?
		${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
		${shary} ntpsec
	;;
#	x)
#		#:uusiksi vain koko pasq?
#		e23_xyz
#	;;
	s)
		e23_st
	;;
	*)
		#VAUH:parsetuksen kanssa jotain, ei tarvitsisi puolta päivää raksuttaa ao. urputusta varten
		#getopt tai sitten vain käskyttäisi exp3sta?

		echo "MAYBE U SHOULD USE export3 INSTEAD"
		sleep 5

		${d0}/export3.bash ${mode} ${tgtfile} -v
		exit
	;;
esac

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

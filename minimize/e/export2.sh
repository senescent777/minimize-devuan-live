#!/bin/bash

debug=0 #1
distro=$(cat /etc/devuan_version)

d0=$(pwd)
d=${d0}/${distro}
mode=-2
tgtfile=""
gbk=-1
mop=""

function usage() {
	echo "$0 3 <tgtfile> [distro?] [-v]: makes th3 main package (new way)"
	echo "$0 4 <tgtfile> [distro?] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 u <tgtfile> [distro?] [-v]: makes Upgrade_pkg"
	echo "$0 e <tgtfile> [distro?] [-v]: archives the Essential .deb packages"
	echo

	echo "$0 l <tgtfile> [-v] [ -d preferred_displaymanager? ] : makes a packaged containing .deb-files for a (preferred) displaymanager"

	#$d pitäisi alustaa ennen tätä
	echo "$0 f <tgtfile> [distro?] [-v]: archives .deb Files under ${d0}/\${distro}"

	echo "$0 p <> [] [] Pulls \${CONF_default_archive3} from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 c is sq-Chroot-env-related option"
	echo "$0 g adds Gpg for signature checks, maybe?"
	echo "$0 t ... option for ipTables"

	echo "$0 -h: shows tHis message about usage"
}

#TODO:jos muuttaisi blokin koskapa gpo() nykyään? (-h kanssa voisi tehdä toisinkin)
#... joko jo 190426?

if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se peruslähtökohta (tai sitten saatanallisuus)

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

#echo "distro: ${distro}"
#sleep 5
#dqb ja csleep vielä määritelty

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
	#johdonmukaisuus virhekoodeissa olisi tietty kiva
	exit 56
fi

[ -z "${distro}" ] && exit 6
d=${d0}/${distro} #nykyään vähän turha tässä
process_lib ${d}
mop=${CONF_dm} #voinee joutua muuttamaan jatkossa

#suorituksen keskeytys aLEmpaa näille main jos ei löydy tai -x ?
dqb "BEFORE TIG NOR MKTMP"
sleep 1

if [ -z "${tig}" ] ; then
	echo "SHOULD INSTALL GIT"
	exit 7 #syystä excalibur-testit tilap kommentteihin 16126
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

#TODO:tästä ekasta case-blokista oma skriptinsä?
case "${mode}" in
#	rp) #080326:toistaiseksi jemmaan, kiukuttelua (takaisin komm josqs?)
#		[ -s "${tgtfile}" ] || exit 67
#		[ -r "${tgtfile}" ] || exit 68
#		e22_rpg ${tgtfile} ${d}
#17426:josqs ta,aisin kommenteista?
#	;;
	f) #170426:osaa tehdä paketin edelleen
		enforce_access $(whoami) ${t}
		e22_arch ${tgtfile} ${d} ${gbk}
		
		#HUOM! EIPÄ KIKKAILLA sha512sums.txt KANSSA, tar.sha PAREMPI IDEA
		#, PITÄÄ VAIN SAADA AIKAISEKSI common_lib.ah HUOMIOIMAAN SE
	;;
	q)
		#170326:tekee edelleen arkiston, sisältö kenties ok
		[ -v CONF_default_arhcive ] || exit 33
		[ -v CONF_default_arhcive2 ] || exit 34
		[ -v CONF_default_arhcive3 ] || exit 35

		e23_qrs ${tgtfile} ${d0} ${CONF_default_arhcive2} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
	c) #ainakin 160426 tIEnoilla toimi viimeksi
		e22_cde ${tgtfile} ${d0} ${distro}
	;;
	p) #170326:lienee kunnossa
		[ -v CONF_default_arhcive3 ] || exit 66
		csleep 1
		[ -v CONF_iface ] && ${sifu} ${CONF_iface}
		e23_profs ${tgtfile} ${d0} ${CONF_default_arhcive3}	
	;;
	-h)
		usage
	;;
#	b)
#		#230326:tekee jo jotain, vielä sietää miettiä onko siinä pointtia mitä tekee
#		for f in $(find ${d0} -type f -name "*lib.sh") ; do
#			e22_ftr ${f}
#		done
#	;;
	*)
		cont=1
	;;
esac

if [ $cont -eq 1 ] ; then
	dqb "R3D B3F0R3 BL4KC"
else
	e22_ftr ${tgtfile}	
	exit 66
fi

csleep 1
#290326:e_jutut vielä tarpeellisia?
e_final
e_h $(whoami) ${d0}
dqb "EHD0.LL1.N3 1v2k"
csleep 1

#HUOM!!! e22_pre2() AJAA sifu-KOMENNON JOTEN TÄSSÄ EI ERIKSEEN TARVITSE
e22_pre1 ${d} ${distro}
[ ${debug} -eq 1 ] && pwd;sleep 6

#290326:pre2() 2. param pois?
e22_pre2 ${d} ${distro} ${CONF_iface} ${CONF_dnsm}
e22_cleanpkgs ${d}
e22_cleanpkgs ${CONF_pkgdir}

#HUOM.nämä voivat jtnkin suhtautua ylempään e22_hdr()-qtsuun jossia n tilanteessa
#[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar #180426:tilapäisesti jemmaan kokeilun takia, takaisin josqs
[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar
doit=1
csleep 1

case "${mode}" in
	0)
		exit 97
	;;
	3|4) 
		#3 taisi toimia 04/26 tienoilla ainakin kerran (VAIH:e tai 3 kanssa ne e22_a()- kikkailut?)
		#4 toimi viimeksi 180426
		#(merd2 tst myöhemmin, ehkä)
	
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
		z2 /opt/bin/zxcv 		
		z3 /opt/bin/zxcv ${tgtfile} ${d0}/MAN1.F2ST
	;;
	#180426:osasi paketin muodostaa, asennusvaih pientä nalkutusta
	#dpkg: dependency problems prevent configuration of libxml-parser-perl:
 	#libxml-parser-perl depends on perl  however:

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
		#... chattr olisi kYllä paikallaan etteI vahingossa spedeilisi
		#070426:paketin sisältö vaikuttaa toimivan minimal_liven alaisuudessa, entä desktop? sielläkin
		#... oliko jostain libpam- paketeista ulinaa? tuliko libcom-err2 mukaan?
		#... testaus uusiksi joskus?

		${shary} ${E22_GS}
		${shary} ${E22_GM}
		csleep 3

		message
		csleep 2

		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
		e23_other_pkgs ${CONF_dnsm}
	;;
	t)
		#290326:osaa paketin tehdä, todnäk asentuu myös
		message
		csleep 2
		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
	;;
	g)
		[ -v E22_GI ] || exit 95
		#170426 edelleen osasi paketin muodostaa, todnäk asentuu myös

		${fib}
		${shary} ${E22_GI}
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
	*)
		exit
	;;
esac

function e22_dblock() { #140426:lienee toimiva tämä fktio
	dqb "e22_dblock(${1} , ${2} , ${3} , ${4} )))) "

	[ -z "${1}" ] && exit 14
	[ -s ${1} ] || exit 15 #"exp2 e" kautta tultaessa tökkäsi tähän kunnes (vielä 080326?)
	#[ -w ${1} ] || exit 16 #ei näin?
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 23
	[ -z "${3}" ] && exit 33
	[ -d ${3} ] || exit 34
	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...
	[ -z "${4}" ] && exit 37

	dqb ".PARS-OK"
	csleep 1

	[ ${debug} -eq 1 ] && pwd
	#aval0n #tarpeellinen?
	ls -la ${3}/*.deb | wc -l
	
	#HUOM.160326:ao. for-blokki omaksi fktioksi?
	for s in ${PART175_LIST} ; do
		${sharpy} ${s}*
		${NKVD} ${3}/${s}*.deb
	done
	
	local t
	t=$(echo ${2} | cut -d "/" -f 1-6) #joitain tr-jekkuja vielä?
	e22_ts ${t} ${3}
	dqb "JST B3F0R3 3NF0RC3"
	csleep 1
	
	enforce_access $(whoami) ${t}
	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
	csleep 1

	e22_arch ${1} ${2} ${4}
	e22_cleanpkgs ${2}
}

if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then 
	e22_hdr ${d}/f.tar
	#HUOM.11326:d-blokin tapa toimia aiheuttaa lisäsäätöä sqroot-ympäristössä, koita päättää mitä tehdä asialle

	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} ${gbk}
	e22_ftr ${d}/f.tar
	#z3?	

	${srat} -rvf ${tgtfile} ${d}/f.tar* 
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar* 
fi

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi

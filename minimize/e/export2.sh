#!/bin/bash
#jotain oletuksia kunnes oikea konftdsto saatu lotottua
debug=0 #1
distro=$(cat /etc/devuan_version)
# | cut -d '/' -f 1) #160126 cut-kikkailu pois sotkemasta, muualla kun menee toisin
d0=$(pwd)
d=${d0}/${distro}
mode=-2
tgtfile=""
gbk=-1
mop=""

function usage() {
	echo "$0 3 <tgtfile> [distro?] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro?] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 u <tgtfile> [distro?] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro?] [-v]: archives the Essential .deb packages"
	echo
	
	echo "$0 l <tgtfile> [-v] [ -d preferred_displaymanager ] : makes a packaged containing .deb-files for a (preferred) displaymanager"

	#$d pitäisi alustaa ennen tätä
	echo "$0 f <tgtfile> [distro?] [-v]: archives .deb Files under ${d0}/\${distro}"

	echo "$0 p <> [] [] pulls \${CONF_default_archive3} from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 c is sq-Chroot-env-related option"
	echo "$0 g adds Gpg for signature checks, maybe?"
	echo "$0 t ... option for ipTables"

	echo "$0 -h: shows this message about usage"
}

#TODO:jos muuttaisi blokin koskapa gpo() nykyään? (-h kanssa voisi tehdä toisinkin)

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

function fallback() {
	exit 59
}

echo "distro: ${distro}"
sleep 5
#dqb ja csleep vielä määritelty

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
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

#dirnamen kanssa ei oikein toiminut aiemmin
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

echo "AFTER 1NCLUD1NG FILEZ"
sleep 2

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

case ${mode} in
#	rp) #080326:toistaiseksi jemmaan, kiukuttelua
#		[ -s "${tgtfile}" ] || exit 67
#		[ -r "${tgtfile}" ] || exit 68
#		e22_rpg ${tgtfile} ${d}
#	;;
	f) #220326:toimii, tai ainakin osasi tehdä paketin
		enforce_access $(whoami) ${t}
		e22_arch ${tgtfile} ${d} ${gbk}
	;;
	q)
		#170326:tekee edelleen arkiston, sisältö kenties ok
		[ -v CONF_default_arhcive ] || exit 33
		[ -v CONF_default_arhcive2 ] || exit 34
		[ -v CONF_default_arhcive3 ] || exit 35

		e23_qrs ${tgtfile} ${d0} ${CONF_default_arhcive2} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
	c) #030426 tIEnoilla toimi viimeksi
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
#		for f in $(find ${d0} -type f -name '*lib.sh') ; do
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
[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar
doit=1
csleep 1

case ${mode} in
	0)
		exit 97
	;;
	3|4) 
		#3 toiminnan testaus menossa taas (020426)
		#4 toiminee kanssa (180326, pl. import2 viimeaikaiset kiukuttelut)
		
		[ -v CONF_default_arhcive3 ] || exit 66
		dqb "NVDK 1b 2 secs"
		csleep 2

		${NKVD} /opt/bin/zxcv.tmp
		${spc} /opt/bin/zxcv /opt/bin/zxcv.ÅLD
		${spc} /opt/bin/zxcv.sig /opt/bin/zxcv.sig.ÅLD
		${spc} /opt/bin/zxcv.sha /opt/bin/zxcv.sha.ÅLD

		csleep 1
		fasdfasd /opt/bin/zxcv.tmp

		#020426:ao. rivin kanssa muutokasi vaiei?
		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} /opt/bin/zxcv.tmp

		reqwreqw /opt/bin/zxcv.tmp
	
		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 3 ] && [ ! -v CONF_testgris ] ; then
			#VAIH:testgris-ehto mukaan, tosin pointti?
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
		reqwreqw /opt/bin/zxcv.tmp
		csleep 1

		${NKVD} /opt/bin/zxcv.sig
		${NKVD} /opt/bin/zxcv.sha
		${NKVD} /opt/bin/zxcv
		csleep 1

		fasdfasd /opt/bin/zxcv.sig
		fasdfasd /opt/bin/zxcv.sha
		${svm} /opt/bin/zxcv.tmp /opt/bin/zxcv
		csleep 1

		${sah6} --ignore-missing -c /opt/bin/zxcv
		csleep 3
		
		e22_tyg /opt/bin/zxcv
		${sah6} /opt/bin/zxcv > /opt/bin/zxcv.sha
		
		reqwreqw /opt/bin/zxcv.sig
		reqwreqw /opt/bin/zxcv.sha #pointtia tämmöisessä?
		csleep 1
			
		${srat} -rvf ${tgtfile} /opt/bin/zxcv*
	;;
	#280326:saa aikaiseksi paketin, sisällön testaus vielä
	u|upgrade)
		[ -v CONF_pkgdir ] || exit 96
		dqb " ${CONF_iface} SHOULD BY UP BY NOW"
		csleep 1
	
		e23_upgp
		${sifd} ${CONF_iface}
		csleep 1
		e23_upgp2 ${CONF_pkgdir} ${CONF_iface}
	;;
	e) #290326:ehkä jopa toimii koska "$0 3"
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
	#230326:edelleen osaa paketin tehdä
		${shary} ${E22GI}
	;;
	l) #TODO:testaus uusicksi viimeaikaisen sorkinnan takia
		csleep 1
		[ -v CONF_dm ] || exit 77
		e23_dm ${mop}
	;;
#VAIH:vaikkapa tähän väliin uusi toiminto, if ja äksä... (jatkossa e23)
	m)
		[ -v E22_GS ] || exit 78
		[ -v E22_M ] || exit 79
		
		${shary} ${E22_GS}
		#${shary} ifupdown adduser iproute2 net-tools tar mount coreutils
		${shary} ${E22_M} #tämän kanssa piTäisi viel itEroida

		#tässä alla vöib tulla suurempi lottoaminen (jospa jollain livecd:llä selvittäisi mitä oik tarv)
		${shary} xorg xorg-docs-core
		${shary} xserver-xorg xserver-xorg-legacy xserver-xorg-core xserver-common
		${shary} xserver-xorg-input-all xserver-xorg-video-all
		${shary} xinit x11-apps x11-common x11-session-utils x11-utils x11-xkb-utils x11-xserver-utils  
		${shary} xauth xbitmaps xterm 
		#TODO:xserver-xorg-video-* ainakin mukaan
		
#		#dpkg: dependency problems prevent configuration of x11-apps:
# x11-apps depends on libxaw7 (>= 2:1.0.14); however:
#  Package libxaw7 is not installed.
# x11-apps depends on libxcb-damage0; however:
#  Package libxcb-damage0 is not installed.
# x11-apps depends on libxft2 (>> 2.1.1); however:
#  Package libxft2 is not installed.
# x11-apps depends on libxi6 (>= 2:1.2.99.4); however:
#  Package libxi6 is not installed.
# x11-apps depends on libxkbfile1 (>= 1:1.1.0); however:
#  Package libxkbfile1 is not installed.
# x11-apps depends on libxmu6 (>= 2:1.1.3); however:
#  Package libxmu6 is not installed.
# x11-apps depends on libxmuu1 (>= 2:1.1.3); however:
#  Package libxmuu1 is not installed.
#... "case l" jos kuittaisi äksän lib-jutut (tai sit boottaa minimal-liveen ja asenna x+wdm siihen) (TODO?)
	;;
	n)
		#VAIH:ntp-jutut takaisin josqs?

		${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
		${shary} ntpsec
	;;
	*)
		exit
	;;
esac

if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then 
	e22_hdr ${d}/f.tar
	#140326:pitäisiköhän tämä kohta muuttaa? miten?

	#HUOM.11326:d-blokin tapa toimia aiheuttaa lisäsäätöä sqroot-ympäristössä, koita päättää mitä tehdä asialle
	#... voisi sitäpaitsi kys fktion räjäyttää auki q käytössä vain 1 paikasta
	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} ${gbk}

	e22_ftr ${d}/f.tar
	#140326:pitäisiköhän yo. kohta muuttaa? miten? miksi?

	${srat} -rvf ${tgtfile} ${d}/f.tar* 
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar* 
fi

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi

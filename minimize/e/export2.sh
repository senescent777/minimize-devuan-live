#!/bin/bash
#jotain oletuksia kunnes oikea konftdsto saatu lotottua
debug=0 #1

distro=$(cat /etc/devuan_version)
# | cut -d '/' -f 1) #160126 cut-kikkailu pois sotkemasta, muualla kun menee toisin

d0=$(pwd)
mode=-2
tgtfile=""

function usage() {
	echo "$0 0 <tgtfile> [distro?] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro?] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro?] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro?] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro?] [-v]: archives .deb Files under \$ {d0} /\${distro}"
	echo "$0 p <> [] [] pulls ${CONF_default_archive3} from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 c is sq-Chroot-env-related option"
	echo "$0 g adds Gpg for signature checks, maybe?"
	echo "$0 t ... option for ipTables"

	echo "$0 -h: shows this message about usage"
}

#TODO:jos muuttaisi blokin koskapa gpo() nykyään? (-h kanssa voisi tehdä toisinkin)

if [ $# -gt 1 ] ; then
	mode=${1}

#	if [ -f ${1} ] ; then
#		exit 99
#	fi

	tgtfile=${2}
else
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se peruslähtökohta (tai sitten saatanallisuus)

function parse_opts_1() {
	if [ -d ${d}/${1} ] ; then
		#distro=${1} #090326:kuinkahan oleellinen distron yliajo?
		d=${d0}/${distro}
	fi
}

#
#function parse_opts_2() {
#}

#parsetuksen knssa menee jännäksi jos conf pitää ladata ennen common_lib (no parse_opts:iin tiettty muutoksia?)
d=${d0}/${distro}

function fallback() {
exit 59
}

#dqb ja csleep vielä määritelty

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
	exit 56
fi

[ -z "${distro}" ] && exit 6
d=${d0}/${distro}
process_lib ${d}
#suorituksen keskeytys aLEmpaa näille main jos ei löydy tai -x ?

if [ -z "${tig}" ] ; then
	exit 7 #syystä excalibur-testit tilap kommentteihin 16126
fi

if [ -z "${mkt}" ] ; then
	exit 8
fi

#dirnamen kanssa ei oikein toiminut aiemmin
if [ -x ${d0}/e/e22.sh ] ; then
	.  ${d0}/e/e22.sh
	dqb $?
	csleep 1

	.  ${d0}/e/e23.sh
	dqb $?
	csleep 2
else
	exit 58
fi

#https://askubuntu.com/questions/1206167/download-packages-without-installing liittynee
[ -z "${tgtfile}" ] && exit 98
t=$(echo ${d} | cut -d '/' -f 1-5)

cont=0
dqb "ESAC1"
csleep 1

#VAIH:jotenkin pitäisi reagoida jos $tgtfile == "-v" tai $d0/$tgtfile eksistoi
[ -d ${d0}/${tgtfile} ] && exit 64

#-h pytsåähtyy ennen tätä riviä?
e22_hdr ${tgtfile}

case ${mode} in
#	rp) #080326:toistaiseksi jemmaan, kiukuttelua
#		[ -s "${tgtfile}" ] || exit 67
#		[ -r "${tgtfile}" ] || exit 68
#		e22_rpg ${tgtfile} ${d}
#	;;
	f) #140326: tekee paketin, purq onnistuu myös
		enforce_access ${n} ${t}
		e22_fgh ${tgtfile} ${d}
	;;
	q)
		#140326:toimi ainakin kerrabn
		[ -v CONF_iface ] && ${sifd} ${CONF_iface}
		[ -v CONF_default_arhcive ] || exit 33
		[ -v CONF_default_arhcive2 ] || exit 34
		[ -v CONF_default_arhcive3 ] || exit 35

		e23_qrs ${tgtfile} ${d0} ${CONF_default_arhcive2} ${CONF_default_arhcive} ${CONF_default_arhcive3}
		#exit #tarkoitus olisi ettei suoritusta jatkettaisi tätä pidemmälle
	;;
	c) #110326:toimi
		e22_cde ${tgtfile} ${d0} ${distro}
	;;
	g) #090326:oksennetut komennot vissiin ok edelleen
		e23_ghi ${tgtfile} ${d0} ${distro}
		#exit
	;;
	p) #110326:VAIH (testaus, sisällön lähinnä, kts $0 4)
		[ -v CONF_default_arhcive3 ] || exit 666
		e23_profs ${tgtfile} ${d0} ${CONF_default_arhcive3}	
	;;
	-h)
		usage
	;;
	*)
		cont=1
	;;
esac

if [ $cont -eq 1 ] ; then
	dqb "R3D B3F0R3 BL4KC"
else
	e22_ftr ${tgtfile}	
	exit 666
fi

csleep 1

e_final
e_h ${n} ${d0} 
#TODO:changedns:n dns-osuuden vipuaminen joko resolVconf:ille tai dnsmasq:lle? , kumman saakaan pienemmällä säädöllä toimimaan

if [ -x /opt/bin/changedns.bash ] ; then
	${odio} /opt/bin/changedns.bash ${CONF_dnsm}
else
	if [ -x ${d0}/opt/bin/changedns.bash ] ; then
		${odio} ${d0}/opt/bin/changedns.bash ${CONF_dnsm}
	else
		dqb "changedns not an option"
		csleep 5
	fi
fi

#...saisiko yo skriptin jotenkin yhdistettyä ifup:iin? siihen kun liittyy niitä skriptejä , post-jotain.. (ls /etc/network)
#.. kts interfaces.tmp liittyen (080326)

e22_pre1 ${d} ${distro}
[ ${debug} -eq 1 ] && pwd;sleep 6

#110326:pre2:sen parametrit kaikki tarpeellisia kunnes ... ?
e22_pre2 ${d} ${distro} ${CONF_iface} ${CONF_dnsm}
e22_cleanpkgs ${d}
e22_cleanpkgs ${CONF_pkgdir}

#HUOM.nämä voivat jtnkkin suhtautua ylmepään e22_hdr()-qtsuun
[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar
doit=1
csleep 1

case ${mode} in
	0)
		exit 97
	;;
	3|4) 
		#VAIH:testaus TAAS , eRItyisesti miten nelosen output g_doit:n imp2-kikkailun kanssa?
		#VAIH:jos sen "exp2 p" saisi samalla kertaa testattua
		[ -v CONF_default_arhcive3 ] || exit 66
		dqb "NVDK 1b 5 secs"
		csleep 5

		${NKVD} ${d0}/${CONF_default_arhcive3}*
		[ -f /opt/bin/zxcv ] && ${NKVD} /opt/bin/zxcv*

		csleep 1
		fasdfasd /opt/bin/zxcv
		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} /opt/bin/zxcv

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 3 ] ; then
			e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
			e23_other_pkgs ${CONF_dnsm}

		else
			doit=0
		fi

		e22_home_pre ${tgtfile} ${d} ${CONF_enforce} ${CONF_default_arhcive2}
		e22_home ${tgtfile} ${d} ${CONF_default_arhcive} #${CONF_enforce} ${CONF_default_arhcive2}
		e22_pre1 ${d} ${distro}

		e22_acol ${tgtfile} ${CONF_iface} ${CONF_dnsm} ${CONF_enforce}
		fasdfasd /opt/bin/zxcv #onko ihan pakko? 

		e22_sarram ${tgtfile} ${CONF_dm} /opt/bin/zxcv
		reqwreqw /opt/bin/zxcv
		csleep 1

		fasdfasd /opt/bin/zxcv.sig	
		e22_tyg /opt/bin/zxcv
		reqwreqw /opt/bin/zxcv.sig			
		${srat} -rvf ${tgtfile} /opt/bin/zxcv*
	;;
	#140326:toimi ainakin kerran
	u|upgrade)
		[ -v CONF_pkgdir ] || exit 96
		dqb " ${CONF_iface} SHOULD BY UP BY NOW"
		csleep 1

		e23_upgp
		${sifd} ${CONF_iface}
		csleep 1
		e23_upgp2 ${CONF_pkgdir} ${CONF_iface}
	;;
	e) #110326 tienoilla e/l/t - caset osasivat paketin tehdä , sis asentumista ei vielä testattu
		message
		csleep 2
		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
		e23_other_pkgs ${CONF_dnsm}
	;;
	t) 
		#toiminee sikäli mikäli case e) toimii
		message
		csleep 2
		e23_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
	;;
	l) #110326:osaa tehdä paketin ja sisältö asentui
		csleep 1
		[ -v CONF_dm ] || exit 77
		e23_dm ${CONF_dm}
	;;
	*)
		exit
	;;
esac

if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then 
	e22_hdr ${d}/f.tar #140326:pitäisiköhän tämä kohta muuttaa?

	#HUOM.11326:d-blokin tapa toimia aiheuttaa lisäsäätöä sqroot-ympäristössä, koita päättää mitä tehdä asialle
	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} 
	e22_ftr ${d}/f.tar  #140326:pitäisiköhän tämä kohta muuttaa?

	${srat} -rvf ${tgtfile} ${d}/f.tar* 
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar* 
fi

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi

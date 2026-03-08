#!/bin/bash
#jotain oletuksia kunnes oikea konftdsto saatu lotottua
debug=0 #1
distro=$(cat /etc/devuan_version) # | cut -d '/' -f 1) #160126 cut-kikkailu pois sotkemasta, muualla kun menee toisin
d0=$(pwd)
mode=-2
tgtfile=""

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \$ {d0} /\${distro}"
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
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
		distro=${1}
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
	exit 7 #syystä excalibut-testit tilap kommentteihin 16126
fi

if [ -z "${mkt}" ] ; then
	exit 8
fi

#dirnamen kanssa ei oikein toiminut
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

#VAIH:q,rp,f,g,c,p
#TODO:jospa myös keskeyttäisi suorituksen mikäli ei mode täsmää mihinkään

case ${mode} in
#	rp) #080326:toistaiseksi jemmaan, kiukuttelua
#		[ -s "${tgtfile}" ] || exit 67
#		[ -r "${tgtfile}" ] || exit 68
#		e22_rpg ${tgtfile} ${d}
#	;;
	f) #VAIH:testaus (seur pakettei $d alle)
		enforce_access ${n} ${t}
		e22_fgh ${tgtfile} ${d}
	;;
	q)
		#VAIH:tämän casen testaus (paketin purku lähinnä)
		[ -v CONF_iface ] && ${sifd} ${CONF_iface}
		e22_hdr ${tgtfile}
		e23_qrs ${tgtfile} ${d0}
		exit #tarkoitus olisi ettei suoritusta jatkettaisi tätä pidemmälle
	;;
	c) #VAIH:testaa miten paketin sisältö purkautuu
		e22_cde ${tgtfile} ${d0} ${distro}
	;;
	g) #VAIH:testit (oksennetuille komennoille niinqy)
		e23_ghi ${tgtfile} ${d0} ${distro}
		exit
	;;
	p) #VAIH:testit.paketin.purq (qhan kasaaminen ensin)
		e22_hdr ${tgtfile}
		e23_profs ${tgtfile} ${d0}	
	;;
	-h)
		usage
	;;
esac

exit 666

#TODO:ao.for-blokkiin muutoksia jatkossa
#for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
#	${scm} 0555 ${x}
#	${sco} root:root ${x}
#	#distro-param takaisin mikä li a lkaa cross-distro-kikkailuihin
#	${odio} ${x} ${CONF_dnsm} 
#done

e22_pre1 ${d} ${distro}
[ ${debug} -eq 1 ] && pwd;sleep 6

#...saisiko yo skriptin jotenkin yhdistettyä ifup:iin? siihen kun liittyy niitä skriptejä , post-jotain.. (ls /etc/network)
#.. kts interfaces.tmp liittyen (080326)

e22_hdr ${tgtfile}
e22_pre2 ${d} ${distro} ${CONF_iface} ${CONF_dnsm}

e22_cleanpkgs ${d}
e22_cleanpkgs ${CONF_pkgdir}

[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

doit=1
csleep 1

case ${mode} in
	0)
		exit 97
	;;
#	3|4) 
#		#TODO:testaus TAAS , eRItyisesti miten nelosen output g_doit:n imp2-kikkailun kanssa
#	
#		[ -f /opt/bin/zxcv ] && ${NKVD} /opt/bin/zxcv*
#		csleep 1
#		fasdfasd /opt/bin/zxcv
#		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} /opt/bin/zxcv
#
#		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
#		if [ ${mode} -eq 3 ] ; then
#			e22_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
#			e22_other_pkgs ${CONF_dnsm}
#
#		else
#			doit=0
#		fi
#
#		e22_home ${tgtfile} ${d} ${CONF_enforce} 
#		e22_pre1 ${d} ${distro}
#
#		e22_acol ${tgtfile} ${CONF_iface} ${CONF_dnsm} ${CONF_enforce}
#		fasdfasd /opt/bin/zxcv #onko ihan pakko? 
#
#		e22_sarram ${tgtfile} ${CONF_dm} /opt/bin/zxcv
#		reqwreqw  /opt/bin/zxcv
#		csleep 1
#
#		fasdfasd /opt/bin/zxcv.sig	
#		e22_tyg /opt/bin/zxcv
#		reqwreqw /opt/bin/zxcv.sig			
#		${srat} -rvf ${tgtfile} /opt/bin/zxcv*
#	;;
#	#u taisi toimia jnkin aikaa 01/26
#	u|upgrade)
#		[ -v CONF_pkgdir ] || exit 96
#		e22_upgp ${tgtfile} ${CONF_pkgdir} ${CONF_iface}
#	;;
#	e)
#		#020326: (saa aikaiseksi ei-tyhjän paketin: 1, paketin sisältö asentuu:1)
#		e22_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
#		e22_other_pkgs ${CONF_dnsm}
#	;;
#	t) 
#		#HUOM.wanhat .deb alta pois ennen pak purq jotta pääsee varmuuteen		
#		#cleanpkgs() tulisi hoitaa se
#
#		message
#		csleep 2
#		e22_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
#	;;
#	l)
#		csleep 1
#		[ -v CONF_dm ] || exit 77
#		#[ -f ${d0}/e/e23.sh ] && . ${d0}/e/e23.sh
#
#		#voisi tietysti kjäkin sanoa komentorivillä mitä dm:ää halutaan käyttää		
#		#VAIH:uuteen skriptiin nämä dm-kikkailut?
#		e22_dm ${CONF_dm}
#	;;
	*)
		exit
	;;
esac

if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then 
	e22_hdr ${d}/f.tar 

	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} 
	e22_ftr ${d}/f.tar 

	${srat} -rvf ${tgtfile} ${d}/f.tar* 
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar* 
fi

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi
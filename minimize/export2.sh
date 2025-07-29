#!/bin/bash
debug=1
distro=$(cat /etc/devuan_version | cut -d '/' -f 1) #HUOM.28525:cut pois jatkossa?
d0=$(pwd)
echo "d0= ${d0}"
mode=-2
tgtfile=""
#HUOM.8725.1:joskohan wpa_supplicant.conf kanssa asiat kunnossa

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \$ {d0} /\${distro}" 
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	#c?
	echo "$0 t ... option for ipTables"			
	echo "$0 -h: shows this message about usage"	
}

#VAIH:tämä parsetus-paska uusiksi
if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se perusidea
function parse_opts_1() {
#	debug=1
	dqb "patse_otps8( ${1}, ${2})"

	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			#menisiköhän näin?
			if [ -d ${d}/${1} ] ; then
				distro=${1}
				d=${d0}/${distro}
			fi
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

#parsetuksen knssa menee jännäksi jos conf pitää lkadata ennen common_lib (no paerse_opts:iin tiettty)
d=${d0}/${distro}

if [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa?
	echo "CONF MISSING"
	exit 55
fi

#exit

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
	dqb "FALLBACK"
	dqb "chmod +x ${d0}/common_lib.sh may be a good idea now"
	exit 56 #HUOM.28725:toistaiseksi näin
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}
#exit

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 2

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else 
	exít 57
fi

dqb "tar = ${srat} "

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

dqb "AFTER GANGRENE SETS IN"
csleep 1

tig=$(${odio} which git)
mkt=$(${odio} which mktemp)

if [ x"${tig}" == "x" ] ; then
	#HUOM. kts alempaa mitä git tarvitsee
	echo "sudo apt-get update;sudo apt-get install git"
	exit 7
fi

if [ x"${mkt}" == "x" ] ; then
	#coreutils vaikuttaisi olevan se paketti mikä sisältää mktemp
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

dqb "${sco} -Rv _apt:root ${pkgdir}/partial"
csleep 1
${sco} -Rv _apt:root ${pkgdir}/partial/
${scm} -Rv 700 ${pkgdir}/partial/
csleep 1

#HUOM. ei kovin oleellista ajella tätä skriptiä squashfs-cgrootin siäsllä
#mutta olisi hyvä voida testailla sq-chrootin ulkopuolella

dqb "PRE0"
csleep 1

#HUOM.26726:jokin ei-niin-ilmeinen bugitus menossa, toiv wi ole common_lib.sh syynä
#jhokatap aloitettu expo2 jakaminen osiin käytönnöin syistä

if [ -x ${d0}/e22.sh ] ; then
	dqb "222"
	.  ${d0}/e22.sh
	csleep 2 
fi

##HUOM.25525:tapaus excalibur/ceres teettäisi lisähommia, tuskin menee qten alla
#tcdd=$(cat /etc/devuan_version)
#t2=$(echo ${d} | cut -d '/' -f 6 | tr -d -c a-zA-Z/) #tai suoraan $distro?
#	
#if [ ${tcdd} != ${t2} ] ; then
#	dqb "XXX"
#	csleep 1
#	shary="${sag} install --download-only "
#fi
#TODO:t2-kikkailut jatkossa ennen e22?

##https://askubuntu.com/questions/1206167/download-packages-without-installing liittynee

dqb "mode= ${mode}"
dqb "tar= ${srat}"
csleep 1
[ -v testgris ] || pre1 ${d} ${distro}

#TODO:update.sh liittyen oli jotain juttuja sen kanssa mitä otetaan /e alta mukaan, voisi katsoa
#tgtfile:n kanssa muitakin tarkistuksia kuin -z ?

case ${mode} in
	0|4) #HUOM.28725:case 4 toimii, 0 voisi testata vielä

		[ z"${tgtfile}" == "z" ] && exit 99 
		[ -v testgris ] || pre1 ${d} ${distro} #toinen ajokerta tarpeen?
		[ -v testgris ] || pre2 ${d} ${distro} ${iface}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd

		dd if=/dev/random bs=12 count=1 > ./rnd
		${srat} -cvf ${tgtfile} ./rnd
		[ -v testgris ] || tp3 ${tgtfile} ${distro}
		
		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

		dd if=/dev/random bs=12 count=1 > ./rnd
		${srat} -cvf ${d}/f.tar ./rnd #tarvitseeko random-kuraa 2 kertaan?
		[ ${mode} -eq 0 ] && tp4 ${d}/f.tar ${d} ${distro} ${iface}
		#HUOM.25725:vissiin oli tarkoituksellla f.tar eikä e.tar, tuossa yllä
		${sifd} ${iface}

		#HUOM.22525: pitäisi kai reagoida siihen että e.tar enimmäkseen tyhjä?
		tp0 ${tgtfile} ${d} 	
		tp1 ${tgtfile} ${d} ${testgris}
		pre1 ${d} ${distro}

		[ -v testgris ] || tp2 ${tgtfile} ${iface}
	;;
	1|u|upgrade) #HUOM.28725:tekee tarin ja sisältökin asentuu
		[ z"${tgtfile}" == "z" ] && exit 99 

		pre2 ${d} ${distro} ${iface}
		tup ${tgtfile} ${d} ${iface}
	;;
	p) #HUOM.28725:toimii
		[ z"${tgtfile}" == "z" ] && exit 99 

		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${d} ${distro} ${iface}
		tp5 ${tgtfile} ${d0} 
	;;
	e)  #HUOM.28725:tämän output toimii (nykyään import2 3 $file käsittelee)
		pre2 ${d} ${distro} ${iface}
		tp4 ${tgtfile} ${d} ${distro} ${iface}
	;;
	f)  #HUOM.28725:testattu, toimii ainakin sen verran että tekee tarin minkä sisältä järkeväno loinen
		rmt ${tgtfile} ${d}
		#HUOM. ei kai oleellista päästä ajelemaan tätä skriptiä chroootin sisällä, generic ja import2 olennaisempia
	;;
	q) #HUOM.28725:toimii, luo tarin ja sisältökin nykyään oikeanlainen
		[ z"${tgtfile}" == "z" ] && exit 99
		${sifd} ${iface}

		#HUOM.28725:roiskiko väärään hakemistoon juttuja tpq()? toiv ei enää
		tpq ~ ${d0}
		cd ${d0}
		#HUOM.28725:puuttuvien fktioiden takia ei suoritusta näköjään keskeytetä	

		q=$(mktemp)
		${srat} -cf ${tgtfile} ${q}

		dqb "	OIJHPIOJGHOYRI&RE"
		[ ${debug} -eq 1 ] && pwd
		csleep 1

		for f in $(find ~ -type f -name config.tar.bz2 -or -name fediverse.tar) ; do
			${srat} -rvf ${tgtfile} ${f}
		done

		dqb "CASE Q D0N3"
		csleep 3
	;;
	t) #HUOM.28725:testattu, tekee tarin, sisältö vaikuttaa järkevältä
		pre2 ${d} ${distro} ${iface}
		${NKVD} ${d}/*.deb
		tlb ${d} ${iface} ${distro}
		${svm} ${pkgdir}/*.deb ${d}
		rmt ${tgtfile} ${d}
	;;
	c) #uusi optio chroot-juttuja varten, toiminee (27.7.25)
		[ z"${tgtfile}" == "z" ] && exit 99

		cd ${d0}
		q=$(mktemp)
		${srat} -cvf ${tgtfile} ${q}

		for f in $(find . -type f -name conf -or -name lib.sh) ; do ${srat} -rvf ${tgtfile} ${f} ; done
		bzip2 ${tgtfile}
		tgtfile="${tgtfile}".bz2 
	;;
	-h) #HUOM.24725:tämä ja seur case lienevät ok, ei tartte just nyt testata
		usage
	;;
	*)
		echo "-h"
		exit
	;;
esac

if [ -s ${tgtfile} ] ; then
	${odio} touch ${tgtfile}.sha
	${sco} $(whoami):$(whoami) ${tgtfile}.sha
	${scm} 0644 ${tgtfile}.sha

	${sah6} ${tgtfile} > ${tgtfile}.sha
	${sah6} -c ${tgtfile}.sha

	echo "cp ${tgtfile} \${tgt}; cp ${tgtfile}.sha \${tgt}" 
fi
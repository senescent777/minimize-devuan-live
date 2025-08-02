#!/bin/bash

debug=1
distro=$(cat /etc/devuan_version | cut -d '/' -f 1) #HUOM.28525:cut pois jatkossa?
d0=$(pwd)
echo "d0= ${d0}"
mode=-2
tgtfile=""

#HUOM.8725.1:joskohan wpa_supplicant.conf kanssa asiat kunnossa
#HUOM.020825:jotain häikkää tuon kanssa taas, ei välttämättä juuri conf
#HUOM.020825.2:jospa kirjoittaisi uusiksi nuo exp2/imp2/e22-paskat fråm scratch

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

if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se perusidea
function parse_opts_1() {
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

#parsetuksen knssa menee jännäksi jos conf pitää ladata ennen common_lib (no parse_opts:iin tiettty muutoksia?)
d=${d0}/${distro}

if [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa?
	echo "CONF MISSING"
	exit 55
fi

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
	dqb "FALLBACK"
	dqb "chmod +x ${d0}/common_lib.sh may be a good idea now"
	exit 56 #HUOM.28725:toistaiseksi näin
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 2

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else 
	exit 57
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

#HUOM.26726:jokin ei-niin-ilmeinen bugitus menossa, toiv ei ole common_lib.sh syynä
#jokatap aloitettu expo2 jakaminen osiin käytönnön syistä

if [ -x ${d0}/e22.sh ] ; then
	dqb "222"
	.  ${d0}/e22.sh
	csleep 2
else
	exit 58
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
pre1 ${d} ${distro} #[ -v testgris ] || 

#TODO:update.sh liittyen oli jotain juttuja sen kanssa mitä otetaan /e alta mukaan, voisi katsoa
#... jos on jotain sivuvaikutuksia ni pikemminkin tdstoon e22.sh nykyään
#... onkohan vielä ajankohtainen?

#tgtfile:n kanssa muitakin tarkistuksia kuin -z ?
[ -x /opt/bin/changedns.sh ] || exit 59

${odio} touch ./rnd
${sco} ${n}:${n} ./rnd
${scm} 0644 ./rnd
dd if=/dev/random bs=12 count=1 > ./rnd
${srat} -cvf ${tgtfile} ./rnd
#TODO:exit jos pykii

case ${mode} in
	0|4) #HUOM.020825:0 TEKEE TOIMIVAN TAR:IN ELI EIPÄ SORKITA 666!!!
		#... mod pientä kiukuttelua ifup kanssa (VAIH)
		#... testgris-kikkailut roskikseen olisi 1 idea (VAIH)
		#... case 4 kanssa toimi tällä viikolla

		[ z"${tgtfile}" == "z" ] && exit 99 
		pre2 ${d} ${distro} ${iface} ${dnsm} #[ -v testgris ] || 

		[ ${debug} -eq 1 ] && ${srat} -tf ${tgtfile} 
		csleep 3

		tp3 ${tgtfile} ${distro} #[ -v testgris ] || 
		dqb "TP3 DON3, next:rm some rchivies"
		csleep 3

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

		#HUOM.020825:miksi varten tar nollautui äkkiä?
		dqb "srat= ${srat}"
		csleep 5

		dd if=/dev/random bs=12 count=1 > ./rnd
		${srat} -cvf ${d}/f.tar ./rnd

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 0 ] ; then
			tp4 ${d}/f.tar ${d} ${distro} ${iface}

			[ ${debug} -eq 1 ] && ls -las ${d}
			csleep 5
		fi

		#HUOM.25725:vissiin oli tarkoituksellla f.tar eikä e.tar, tuossa yllä
		${sifd} ${iface}
		#HUOM.22525: pitäisi kai reagoida siihen että e.tar enimmäkseen tyhjä?

		tp0 ${d} 
		[ ${debug} -eq 1 ] && ls -las ${d}
		csleep 5
 	
		tp1 ${tgtfile} ${d} #${testgris}
		
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}
		csleep 4
		${NKVD} ${d}/*.tar #tartteeko piostaa?

		pre1 ${d} ${distro}
		dqb "B3F0R3 RP2	"
		csleep 5	
		tp2 ${tgtfile} ${iface} ${dnsm} #[ -v testgris ] || 
	;;
	1|u|upgrade) #HUOM.29725:ainakin chimaeran kanssa tup():in tekemät paketit kelpaavat
		[ z"${tgtfile}" == "z" ] && exit 99 

		pre2 ${d} ${distro} ${iface} ${dnsm}
		tup ${tgtfile} ${d} ${iface} ${dnsm}
	;;
	p) #HUOM.28725:toimii
		[ z"${tgtfile}" == "z" ] && exit 99 

		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${d} ${distro} ${iface} ${dnsm}
		tp5 ${tgtfile} ${d0} 
	;;
	e)  #VAIH:tarkista toiminta (31725 näyttäisi tekevän tarin)
		pre2 ${d} ${distro} ${iface} ${dnsm}
		tp4 ${tgtfile} ${d} ${distro} ${iface}
	;;
	f)  #HUOM.28725:testattu, toimii ainakin sen verran että tekee tarin minkä sisältä järkeväno loinen
		rmt ${tgtfile} ${d}
		#HUOM. ei kai oleellista päästä ajelemaan tätä skriptiä chroootin sisällä, generic ja import2 olennaisempia
	;;
	q) #HUOM.020825:toimii
		[ z"${tgtfile}" == "z" ] && exit 99
		${sifd} ${iface}
	
		tpq ~ ${d0}
		cd ${d0}
	
		q=$(mktemp)
		${srat} -cf ${tgtfile} ${q}

		dqb "	OIJHPIOJGHOYRI&RE"
		pwd
		csleep 1

		#HUOM.28725:roiskiko väärään hakemistoon juttuja tpq()? toiv ei enää
		tpq ~ ${d0}
		
		#HUOM.28725:puuttuvien fktioiden takia ei suoritusta näköjään keskeytetä	

		q=$(mktemp)
		${srat} -cf ${tgtfile} ${q}

		dqb "	OIJHPIOJGHOYRI&RE"
		[ ${debug} -eq 1 ] && pwd
		csleep 1

		cd ~

		for f in $(find . -type f -name config.tar.bz2 -or -name fediverse.tar -or -name pulse.tar) ; do
			${srat} -rvf ${tgtfile} ${f}
		done

		dqb "CASE Q D0N3"
		csleep 3
	;;
	t) #VAIH:tarkista toiminta TAAS (020825 tekee tar:in, sisällön kelvollisuus vielä testaamatta)
		pre2 ${d} ${distro} ${iface} ${dnsm}
		${NKVD} ${d}/*.deb
		tlb ${d} ${iface} ${distro} ${dnsm}
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

		mv ${tgtfile}.bz2 ${tgtfile}.bz3
		tgtfile="${tgtfile}".bz3 #tarkpoituksella tämä pääte 
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

	#TODO:gpg-juttuja tähän?
	${sah6} ${tgtfile} > ${tgtfile}.sha
	${sah6} -c ${tgtfile}.sha

	echo "cp ${tgtfile} \${tgt}; cp ${tgtfile}.sha \${tgt}" 
fi
#!/bin/bash
debug=0 #1
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

function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			if [ ${mode} -eq -2 ] ; then
				mode=${1}
			else
				if [ -d ${d}/${1} ] ; then 
					distro=${1}
				else
					tgtfile=${1}
				fi
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

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
##	#HUOM.23525:oleellisempaa että import2 toimii tarvittaessa ilman common_lib
##	#"lelukirjasto" saattaa toimia sen vErrAn että "$0 4 ..." onnistuu	
##	
##	srat="sudo /bin/tar"
##	som="sudo /bin/mount"
##	uom="sudo /bin/umount"
##	scm="sudo /bin/chmod"
##	sco="sudo /bin/chown"
##	odio=$(which sudo)
##
##	#jos näillä lähtisi aiNAKin case q toimimaan
##	n=$(whoami)
##	sah6=$(${odio} which sha512sum)
##	smr="${odio} which rm"
##	smr="${odio} ${smr}"
##
##	function check_binaries() {
##		dqb "exp2.ch3ck_b1nar135 ${1} "
##	}
##
##	function check_binaries2() {
##		dqb "exp2.ch3ck_b1nar135_2 ${1} "
###	}
##
##	function fix_sudo() {
##		dqb "exp32.fix.sudo"
##	}
##
##	function enforce_access() {
##		dqb "exp32.enf_acc"
##	}
##
##	function part3() {
##		dqb "exp32.part3"
##	}
##
##	function part1_5() {
##		dqb "exp32.p15"
##	}
##
##	function message() {
##		dqb "exp32.message"
##	}
##
##	function jules() {
##		dqb "exp32.jules"
##	}
##
##	#HUOM.23525:josko tässä kohtaa pakotus riittäisi
##	function other_horrors() {
##		dqb "AZATHOTH AND OTHER HORRORS"
##		#${spc} /etc/default/rules.* /etc/iptables #tartteeko tuota enää 27525?
##
##		${scm} 0400 /etc/iptables/*
##		${scm} 0550 /etc/iptables
##		${sco} -R root:root /etc/iptables
##		${scm} 0400 /etc/default/rules*
##		${scm} 0555 /etc/default
##		${sco} -R root:root /etc/default
##	}
##
##	function ppp3() { #TODO:rename or not?
##		dqb "exp32.ppp3"
##	}
##
##	prevopt=""
##
##	for opt in $@ ; do
##		parse_opts_1 ${opt}
##		parse_opts_2 ${prevopt} ${opt}
##		prevopt=${opt}
##	done

	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 2

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
#else
#	echo "NOT (L1B AVA1LABL3 AND 3X3CUT4BL3)"
#
#	function pr4() {
#		dqb "exp2.pr4 ${1} " 
#	}
#
#	function udp6() {
#		dqb "exp32.UPD6()"
#	}
#
#	#onko tässä sktiptissä oleellista välittää $d part3:lle asti c_b välityksellä?
#	check_binaries ${d}
#	check_binaries2
fi

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \$ {d0} /\${distro}" 
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 t ... option for ipTables"			
	echo "$0 -h: shows this message about usage"	
}

dqb "tar = ${srat} "

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

dqb "AFTER CANGEDNS"
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
	echo "222"
	.  ${d0}/e22.sh
	sleep 2 
fi


#

#

#
#HUOM.25725:josko nyt toimisi tarpeeksi jyvin tp1()

#

#
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
##HUOM.25725:joskohan jakaisi tämän skriptin 2 osaan, fktio-kirjasto se uusi osa
#

#
#koita päättää mitkä tdstot kopsataan missä fktiossa, interfaces ja sources.list nyt 2 paikassa
#HUOM.20525:joskohan locale- ja rules- juttuja varten uusi fktio? vääntöä tuntuu riittävän nimittäin

#
##HUOM.23525: b) firefoxin käännösasetukset, pikemminkin profs.sh juttuja
##dnsm 2. parametriksi... eiku ei, $2 onkin jo käytössä ja tarttisi sen cut-jekun

#

#
##TODO:-v tekemään jotain hyödyllistä (miten tilanne 8725 ja sen jälk?)
#


dqb "mode= ${mode}"
dqb "tar= ${srat}"
csleep 1
[ -v testdris ] || pre1 ${d} ${distro}

#TODO:update.sh liittyen oli jotain juttuja sen kanssa mitä otetaan /e alta mukaan, voisi katsoa

case ${mode} in
	0|4) #HUOM.28725:case 4 toimii, 0 voisi testata vielä

		[ z"${tgtfile}" == "z" ] && exit 99 
		[ -v testdris ] || pre1 ${d} ${distro} #toinen ajokerta tarpeen?
		[ -v testdris ] || pre2 ${d} ${distro} ${iface}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd

		dd if=/dev/random bs=12 count=1 > ./rnd
		${srat} -cvf ${tgtfile} ./rnd
		[ -v testdris ] || tp3 ${tgtfile} ${distro}
		
		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

		dd if=/dev/random bs=12 count=1 > ./rnd
		${srat} -cvf ${d}/f.tar ./rnd #tarvitseeko random-kuraa 2 kertaan?
		[ ${mode} -eq 0 ] && tp4 ${d}/f.tar ${d} ${distro} ${iface}
		#HUOM.25725:vissiin oli tarkoituksellla f.tar eikä e.tar, tuossa yllä
		${sifd} ${iface}

		#HUOM.22525: pitäisi kai reagoida siihen että e.tar enimmäkseen tyhjä?
		tp0 ${tgtfile} ${d} 	
		tp1 ${tgtfile} ${d} ${testdris}
		pre1 ${d} ${distro}

		[ -v testdris ] || tp2 ${tgtfile} ${iface}
	;;
	1|u|upgrade) #TODO:testaa uusiksi kohta
		[ z"${tgtfile}" == "z" ] && exit 99 

		pre2 ${d} ${distro} ${iface}
		tup ${tgtfile} ${d} ${iface}
	;;
#	p) #HUOM.28725:testaa uusiksi  (arkiston sisältö lähinnä, TODO)
#		
#		[ z"${tgtfile}" == "z" ] && exit 99 
#
#		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
#		pre2 ${d} ${distro} ${iface}
#		tp5 ${tgtfile} ${d0} 
#	;;
	e)  #HUOM.28725:tämän output toimii (nykyään import2 3 $file käsittelee)
		pre2 ${d} ${distro} ${iface}
		tp4 ${tgtfile} ${d} ${distro} ${iface}
	;;
	f)  #TODO:testaa uusiksi
		rmt ${tgtfile} ${d} #HUOM. ei kai oleellista päästä ajelemaan tätä skriptiä chroootin sisällä, generic ja import2 olennaisempia
	;;
#	q) #TODO:testaa uusiksi tpq() output, meneekö arkistoo nmitä pitää?
#		[ z"${tgtfile}" == "z" ] && exit 99
#		${sifd} ${iface}
#	
#		#HUOM.28725:roiskiiko väärään hakemistoon juttuja tpq()?
#		tpq ~ ${d0}
#		cd ${d0}
#	
#		q=$(mktemp)
#		${srat} -cf ${tgtfile} ${q}
#
#		dqb "	OIJHPIOJGHOYRI&RE"
#		pwd
#		csleep 1
#
#		#TODO:pitäisi kai sanoa cd tässä
#
#		for f in $(find ~ -type f -name config.tar.bz2 -or -name fediverse.tar) ; do
#			${srat} -rvf ${tgtfile} ${f}
#		done
#		
#		dqb "CASE Q D0N3"
#		csleep 3
#	;;
	t) #TODO:testaa
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
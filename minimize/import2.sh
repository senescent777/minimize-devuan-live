#!/bin/bash
debug=0
srcfile=""

distro=$(cat /etc/devuan_version)
CONF_dir=/media
CONF_part0=ABCD-1234
mode=-2
d0=$(pwd)
[ -z "${distro}" ] && exit 6
d=${d0}/${distro}

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "${0} <mode> <srcfile> [distro?] [debug] "
	echo "when mode=k , this imports PUBLIC_KEYS , u have to import private keys another way!!!"
	echo "	\t also in that case, srcfile=the_dir_that_contains_some_named_keys"
}

#VAIH:"$0 -1 -v" , toimiiko oikein?

if [ $# -gt 0 ] ; then
	mode=${1}
	[ -f ${1} ] && exit 99
	[ "${2}" == "-v" ] || srcfile=${2}

	#parse_opts pitäisi
	if [ "${3}" == "-v" ] || [ "${4}" == "-v" ] ; then
		debug=1
	fi
fi

function parse_opts_1() {
	dqb "parse_opts_1( ${1} )"

	if [ "${mode}" == "-2" ] ; then
		mode=${1}
	fi
}

function parse_opts_2() {
	dqb "(imp2.parseopts_2 ; ${1} ; ${2} ;"

	if [ -f ${2} ] || [ -d ${2} ] ; then
		
		if [ -z "${srcfile}" ] ; then
			if [ "${2}" != "-v" ] ; then	
				srcfile=${2}
			fi
		fi
	fi

}

dqb "SHOULD gg --veriFy ${d0}/common_lib.sh HERE, MAYBE?"
csleep 1

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
#else
#	#190326:vissiin tämän haaran kanssa jutut toimivat jnkn verran ja thats it
#	#280426:else-haara vielä tarpeellinen?
#
#	if [ -s ${d0}/$(whoami).conf ] ; then
#		echo "ALT.C0NF1G"
#		sleep 2
#		. ${d0}/$(whoami).conf
#	else
#		if [ -d ${d} ] && [ -s ${d}/conf ] ; then
#			echo "ordnary cqf"
#			. ${d}/conf
#		else
#		 	exit 57
#		fi	
#	fi
#
#	#debug=1
#	dqb "FALLBACK"
#	sleep 5
#
#	odio=$(which sudo)
#	
#	echo "MAYBE U SHOULD chmod a+x ${d0}/common_lib.sh"
#	sleep 5
#
#	function check_binaries() {
#		dqb "imp2.check1"
#
#		mkt=$(${odio} which mktemp)
#		scm=$(${odio} which chmod)
#		sah6=$(${odio} which sha512sum)
#
#		srat=$(${odio} which tar)
#		#eXit jos srat ei?
#
#		gg=$(${odio} which gpg)
#		som=$(${odio} which mount)
#		uom=$(${odio} which umount)
#	}
#
#	function check_binaries2() {
#		echo "imp2.check2"
#	
#		som="${odio} ${som}"
#		uom="${odio} ${uom}"
#		srat="${odio} ${srat}"
#	}
#
#	function part3() {
#		dqb "imp2.part3 :NOT SUPPORTED"
#		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount?
#	}
#
#	function other_horrors() {
#		dqb "AZATH0TH AND OTHER H0RR0RR55.6"
#	}
#
#	function ocs() {
#		echo "======IPM2.=OCS( ${1} )="
#		which ${1}
#		echo "==================="
#	}
#
#	#barm vuokxi
#	function enforce_access() {
#		dqb "imp2.3nf :NOT SUPPORTED"
#	}
#
#	for opt in $@ ; do
#		parse_opts_1 ${opt}
#		parse_opts_2 ${prevopt} ${opt}
#		prevopt=${opt}
#	done
fi

dqb "imp2:AFTR common_lib"
csleep 1
[ -z "${distro}" ] && exit 6
csleep 1

if [ -x ${mkt} ] ; then #kts. tpr()
	dqb "ipm2.MTK"
else
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

echo "in case of trouble, \"chmod a-x common_lib.sh\" or \"chmod a-x \${distro}/lib.sh\" may help"
csleep 1
#HUOM. tähän ei "process_lib ${d}" , mennään tarkoituksella toisella tavalla (ainakin jnkin aikaa)

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else	
	echo $?
	dqb "N 0 L1.B"
	csleep 1
fi

check_binaries ${d}
[ $? -eq 0 ] || exit 

check_binaries2
[ $? -eq 0 ] || exit

#-x sifd - testi olisi myös idea
[ -v CONF_iface ] && ${sifd} ${CONF_iface}

[ -v mkt ] || exit 7
[ -z "${mkt}" ] && exit 9
echo "mkt= ${mkt} "

[ -v srat ] || exit 8
[ -z "${srat}" ] && exit 10

olddir=$(pwd)
part=/dev/disk/by-uuid/${CONF_part0}
dqb "L0G"

ocs tar
dqb "srat: ${srat}"
csleep 1
dqb "LHP"
	
#josko tilansäästön nimissä kolmaskin ehto? tai ehkä ei pakko
if [ -s /OLD.tar ] ; then
	dqb "OLD.tar OK"
else
	dqb "SHOULD MAKE A BACKUP OF /etc,/sbin,/home/stubby AND  ~/Desktop ,  AROUND HERE "
	csleep 1
	${srat} -cf /OLD.tar /etc /sbin /home/stubby ~/Desktop
fi

dqb "ip2.m.Lpgqq"
#VAIH:vähitellen kommentoituja blokkeja siivoten

#HUOM.280426:käytetäänk tätä jossain? jep, ei vielä pois
function cptp2() {
	[ -z "${1}" ] && echo 99
	#[ -z "${2}" ] && echo 98
	[ -d ${1} ] || exit 97

	#tr-kikkailu tässä ei niitä parhaimpia ideoita 
	local t
	t=$(echo ${1} | cut -d '/' -f 1-5 | tr -d -c 0-9a-zA-Z/.)
	
	if [ -f ${t}/common_lib.sh ] ; then
		#pointti?
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			${gg} --verify ${t}/common_lib.sh.sig 		
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"		
		fi
		
		ls -las /etc/res*
		csleep 10

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t}

			dqb "running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s t as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
		fi
		
		ls -las /etc/res*
		csleep 10
	fi

	if [ -d ${t} ] ; then
		${scm} 0755 ${t}
		${scm} 0555 ${t}/*.sh
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb
	fi

	[ ${debug} -eq 1 ] && ls -las ${1}
}

dqb "HPL"
#TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)
#olisi kai hyväksi selvittää missä kosahtaa kun common_lib pois pelistä (${CONF_default_archive3} siis)

fox=$(${odio} which firefox)

#160326:toimiiko edelleen? "$0 q"-reittiä ainakin
function tpr() {
	dqb "UPIR ) ${1} , ${2} , ${3} ("
	csleep 1

	[ -z "${1}" ] && exit 8
	[ -z "${2}" ] && exit 9
	[ -z "${3}" ] && exit 10
	[ -d ${1} ] || exit 11

	[ -f ${1}/${2} ] || exit 12
	[ -s ${1}/${2} ] || exit 13
	[ -r ${1}/${2} ] || exit 14

	[ -f ${1}/${3} ] || exit 15
	[ -s ${1}/${3} ] || exit 16

	if [ ! -x ${1}/${3} ] ; then
		dqb "CANNOT INCLUDE PROFS.HS 0 R WHÅTEVER"
		dqb "$0 1 \$srcfile | chmod +x ${3} ?"
		exit 17
	fi

	dqb "tpr.pars_ok"
	csleep 1

	#fktioiden {im,ex}portointia jos kokeilisi? man bash...
	. ${1}/${3}
	[ $? -gt 0 ] && exit 19

	dqb "INCLUDE OK"
	#csleep 1

	local q
	local r
	q=$(mktemp -d)
	[ $? -gt 0 ] && exit 20

	dqb "JUST BEFORE TAR ${1}/${2}"
	#jos vielä härdelliä niin keskeytetään mikäli ei $2:sta löydä prefs.js?
	r=$(${srat} -tf ${1}/${2} | grep prefs.js | wc -l) #vielä jos arhc_4 ?
	[ ${r} -gt 0 ] || exit 21
	csleep 1

	${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/${2}
	[ $? -gt 0 ] && exit 22
	csleep 1

	dqb "JUST BEFORE impo_prof"
	csleep 1

	imp_prof esr $(whoami) ${q}
	dqb $?
	csleep 

	dqb "UP1R D0N3"
	csleep 1
}

#sqrot ei tarvitse tätä blokkia (pl. ehkä -h) 
#HUOM.060426:tämä case-esac voisi toimia ilmankin kirjastoa, qhan vain konftdsto löytyy
#110426:tässäkin "-v" tarpeen?

#TODO:ne kiukuttelut pois jo? mitkä?
case "${mode}" in
	-1) 
		# "$0 -1 -v" , miten toimii?
		part=/dev/disk/by-uuid/${CONF_part0}
		[ -b ${part} ] || dqb "no such thing as ${part}"
		c=$(grep -c ${CONF_dir} /proc/mounts)

		if [ ${c} -lt 1 ] ; then
			${som} -o ro ${part} ${CONF_dir}
			csleep 1
			${som} | grep ${CONF_dir}
		fi

		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] unpack AND install | $0 1 <source> just unpacks the archive | $0 3 ..."
		#mode=-3
		#remember:to_umount olisi hyvä muistuttaa kuitenkin
	;;
	2)
		${uom} ${CONF_dir}
		csleep 1
		${som} | grep ${CONF_dir}
	;;
	-h)
		usage
		exit
	;;
esac

[ -z "${srcfile}" ] && exit 44

if [ -s ${srcfile} ] || [ -d ${srcfile} ] ; then #eka tark oli -s , vissiin oltava taas
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	dqb "SD"
else
	#220326:myös sqroot-ymp tähän jouduttu, syy muu kuin ilmeinen?
	#010426:exitin ohitus jos ollaan sqrootissa?
	
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	[ -f ${srcfile} ] || dqb "NOT A FILE"
	dqb "SMTHING WRONG WITH ${srcfile} "
	exit 55
fi

#[ -s ${srcfile} ] || exit 34 #pitäIsikö olla if-blokin sisällä?
[ -r ${srcfile} ] || exit 35

if [ "${mode}" == "-3" ] || [ "${mode}" == "r" ] ; then
	dqb "asia kunnossa"
else
	read -p "U R ABT TO INSTALL  C0NTENTS OV:  ${srcfile} , SURE ABOUT THAT?" confirm
	[ "${confirm}" == "Y" ] || exit 33
fi

#140326:toimiikohan nuo debug-hommat kuten tarkoitus?
dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "srcfile=${srcfile}"
csleep 1

#HUOM.280426:jatkossa tämä skripti lienee turha sqroot-ympäristössä, voisi karsia siitä yuhdestä paketista
#... paItsi että "$0 r"

case "${mode}" in
	1) 
		echo "sq-rot ${mode} ${tgtfile}"
		exit
	;; 
	0|3) #tässä kohtaa tuli se juttu sqroot-ympäristön kanssa, case 0 vs minne f.tar purkautuu
		echo "sq-rot ${mode} ${tgtfile}"
		exit

#		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
	;;
	r) #160326:ehkä tämä jo toimii
	#sqrot ei tarvitse tätä casea, kai
		[ -d ${srcfile} ] || exit 23
		[ -v CONF_default_arhcive ] || exit 24
 		[ -v CONF_default_arhcive2 ] || exit 25
		[ -v CONF_default_arhcive3 ] || exit 18
		
		[ -z "${fox}" ] && exit 26
		[ -x ${fox} ] || exit 27

		${sr0} -C ~ -jxf ~/${CONF_default_arhcive2}
		echo $?
		csleep 2
		echo "JUST VEFORE TPR"
		tpr ${srcfile} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
#	q)
#		#160326:toimi
#		#sqrot ei tarvitse tätä casea, kai
#		# (turha case oikeastaan koska "$0 1"+"$0 r" (TODO?:jospa tekisi jotain liittyen)
#		#btw. ffox 147-jutut enemmän ${CONF_default_archive3}:n heiniä
#		
#		[ -z "${fox}" ] && exit 26
#		[ -x ${fox} ] || exit 27
#
#		[ -v CONF_default_arhcive ] || exit 24
# 		[ -v CONF_default_arhcive2 ] || exit 25
#		[ -v CONF_default_arhcive3 ]  || exit 18
#
#		#HUOM.110326:olisi parempi , varm. buoksi delliä tai nimetä uudetsaan aiemmatr default_arch ja default_arch2
#
#		c=$(${srat} -tf ${srcfile} | grep ${CONF_default_arhcive} | wc -l)
#		[ ${c} -gt 0 ] || exit 27
#		common_part ${srcfile} ${d} /
#
#		${sr0} -C ~ -jxf ~/${CONF_default_arhcive2}
#		tpr ${d0} ${CONF_default_arhcive} ${CONF_default_arhcive3}
#	;;
	-3)
		dqb "do_Nothing()"
	;;
	*)
		echo "-h"
	;;
esac

cptp2 ${d}
cd ${olddir}
#ettei umount unohdu 

if [ -v part ] || [ -v CONF_dir ] ; then
	echo "REMEMBER 2 UNM0UNT TH3S3:"
	[ -z ${part} ] || grep ${part} /proc/mounts #greppaus voi jäädä junnaamaan?
	[ -z ${CONF_dir} ] || grep ${CONF_dir} /proc/mounts
fi

${scm} 0555 $0
#HUOM.290925: tämän skriptin pitäisi kuvakkeen kanssa löytyä filesystem.squashfs sisältä (no löytyykö?)

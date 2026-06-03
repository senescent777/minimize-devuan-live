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
else
	#130526:else-haara tarpeellinen joissain tilanteissa, ei poisteta
	#TODO:viimeaikaisten sorkintojen takia tämä haara tulisi testata

	if [ -s ${d0}/$(whoami).conf ] ; then
		echo "ALT.C0fn.1G"
		sleep 2
		. ${d0}/$(whoami).conf
	else
		if [ -d ${d} ] && [ -s ${d}/conf ] ; then
			echo "ord1nary cqf"
			. ${d}/conf
		else
		 	exit 57
		fi
	fi

	#debug=1
	dqb "FALLBACK"
	sleep 5

	odio=$(which sudo)
	
	echo "MAYBE U SHOULD chmod a+x ${d0}/common_lib.sh"
	sleep 5

	function check_binaries() {
		dqb "imp2.check1"

		mkt=$(${odio} which mktemp)
		scm=$(${odio} which chmod)
		#sah6=$(${odio} which sha512sum) TODO:TÄMÄN KANSSA JUTTUJA

		srat=$(${odio} which tar)
		#eXit jos srat ei?

		gg=$(${odio} which gpg)
		som=$(${odio} which mount)
		uom=$(${odio} which umount)
	}

	function check_binaries2() {
		echo "imp2.check2"
	
		som="${odio} ${som}"
		uom="${odio} ${uom}"
		srat="${odio} ${srat}"
	}

	function part3() {
		dqb "imp2.part3 :NOT SUPPORTED"
		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount?
	}


	function other_horrors() {
		dqb "AZATH0TH AND OTHER H0RR0RR55.6"
	}

	function ocs() {
		echo "======IPM2.=OCS( ${1} )="
		which ${1}
		echo "==================="
	}

	

	#barm vuokxi
	function enforce_access() {
		dqb "imp2.3nf :NOT SUPPORTED"
	}

	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
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

if [ ! -z "${sifd}" ] && [ -v CONF_iface ] ; then
	${sifd} ${CONF_iface}
fi

[ -v mkt ] || exit 7
[ -z "${mkt}" ] && exit 9
dqb "mkt= ${mkt} "

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

function cptp2() {
	dqb "ip2m c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && echo 99
	[ -z "${2}" ] && echo 98
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 1

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
			enforce_access $(whoami) ${t} #${2} toka param turha?
			csleep 10

			#TODO:ao. tesktin muuttaminen
			dqb "1MP,2: running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s t as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
		fi
		
		ls -las /etc/res*
		csleep 10
	fi

	csleep 1

	if [ -d ${t} ] ; then
		dqb "HAIL UKK"

		${scm} 0755 ${t}
		${scm} 0555 ${t}/*.sh
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb

		csleep 1
	fi

	[ ${debug} -eq 1 ] && ls -las ${1}
	csleep 1
}

dqb "HPL"
#TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)
#olisi kai hyväksi selvittää missä kosahtaa kun common_lib pois pelistä (${CONF_default_archive3} siis)
fox=$(${odio} which firefox)

function tpr() {
	dqb "UPIR ) ${1} , ${2} , ${3} ("
	csleep 2

	[ -z "${1}" ] && exit 8
	[ -z "${2}" ] && exit 9
	[ -z "${3}" ] && exit 10
	[ -d ${1} ] || exit 11

	[ -f ${1}/${2} ] || exit 12
	[ -s ${1}/${2} ] || exit 13
	[ -r ${1}/${2} ] || exit 14

	[ -f ${1}/${3} ] || exit 15
	[ -s ${1}/${3} ] || exit 16

	dqb "trp.pars_ok.0"
	csleep 1

	if [ ! -x ${1}/${3} ] ; then
		dqb "CANNOT INCLUDE PROFS.HS 0 R WHÅTEVER"
		dqb "$0 1 \$srcfile | chmod +x ${3} ?"
		exit 17
	fi

	dqb "tpr.pars_ok"
	csleep 2

	#fktioiden {im,ex}portointia jos kokeilisi? man bash...
	. ${1}/${3}
	[ $? -gt 0 ] && exit 19

	dqb "INCLUDE OK"

	local q=$(${mkt} -d) #toimisiko näin?
	[ $? -gt 0 ] && exit 20

	dqb "JUST BEFORE TAR ${1}/${2}"
	#jos vielä härdelliä niin keskeytetään mikäli ei $2:sta löydä prefs.js?
	local r=$(${srat} -tf ${1}/${2} | grep prefs.js | wc -l) #vielä jos arhc_4 ?
	[ ${r} -gt 0 ] || exit 21
	csleep 1

	${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/${2}
	[ $? -gt 0 ] && exit 22
	csleep 2

	dqb "JUST BEFORE impo_prof"
	csleep 2

	imp_prof esr $(whoami) ${q}
	dqb $?
	csleep 2

	dqb "UP1R D0N3"
	csleep 2
}

case "${mode}" in
	-1) 
		# "$0 -1 -v" , miten toimii? vissiin
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

dqb "debug: 1"
echo "mode: ${mode} "
echo "srcfile: ${srcfile} "
[ -z "${srcfile}" ] && exit 44

if [ -s ${srcfile} ] || [ -d ${srcfile} ] ; then
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	dqb "SD"
else
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	[ -f ${srcfile} ] || dqb "NOT A FILE"
	dqb "SMTHING WRONG WITH ${srcfile} "
	exit 55
fi

[ -r ${srcfile} ] || exit 35

if [ "${mode}" == "-3" ] || [ "${mode}" == "r" ] ; then
	dqb "asia kunnossa"
else
	read -p "U R ABT TO INSTALL  C0NTENTS OV:  ${srcfile} , SURE ABOUT THAT?" confirm
	[ "${confirm}" == "Y" ] || exit 33
fi

dqb "IPM2.mode=${mode}"
dqb "2ipm.distro=${distro}"
dqb "m2pi.srcfile=${srcfile}"
csleep 5

case "${mode}" in
	1|0|3) #20526:ilmeinen bugi vihdoinkin korjattu
		./sq-rot.sh ${mode} ${srcfile} -v
		#dqb $?
		#dqb "2IMP: 	AFTR S.Q.R"
		#csleep 10
	;; 
	r)
		dqb "NT R"
		csleep 5

		[ -d ${srcfile} ] || exit 23
		[ -v CONF_default_arhcive ] || exit 24
 		[ -v CONF_default_arhcive2 ] || exit 25
		[ -v CONF_default_arhcive3 ] || exit 18
		
		[ -z "${fox}" ] && exit 26
		[ -x ${fox} ] || exit 27
		[ -s ~/${CONF_default_arhcive2} ] || exit 29

		${sr0} -C ~ -jxf ~/${CONF_default_arhcive2}


		tpr ${srcfile} ${CONF_default_arhcive} ${CONF_default_arhcive3}

		dqb "XP R"
		csleep 5
	;;
#	q)
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

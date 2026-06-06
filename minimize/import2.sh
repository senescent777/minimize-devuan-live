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


if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	#130526:else-haara tarpeellinen joissain tilanteissa, ei poisteta

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

	function check_binaries() {
		echo "generic.replacement.4.check_bin"
	}

	function check_binaries2() {
		echo "generic.replacement.4.check_bin2"
	}

	odio="sudo"
	mkt=$(${odio} which mktemp) #tarvittiinko tätä johonkin? tpr() ainakin
	srat=$(${odio} which tar)
	srat="${odio} ${srat} "
	som=$(${odio} which mount)
	uom=$(${odio} which umount)
	som="${odio} ${som}"
	uom="${odio} ${uom}"
	scm=$(${odio} which chmod)

	function ocs() {
		echo "ocs()))) ${1} ?"
	}
fi

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

[ -v srat ] || exit 8
[ -z "${srat}" ] && exit 10

olddir=$(pwd)
part=/dev/disk/by-uuid/${CONF_part0}

ocs tar

csleep 1

	
if [ -s /OLD.tar ] ; then
	dqb "OLD.tar OK"
else
	dqb "SHOULD MAKE A BACKUP OF /etc,/sbin,/home/stubby AND  ~/Desktop ,  AROUND HERE "
	csleep 1
	${srat} -cf /OLD.tar /etc /sbin /home/stubby ~/Desktop
fi


function cptp2() {
	[ -z "${1}" ] && echo 99
	[ -d ${1} ] || exit 97

	local t
	t=$(echo ${1} | cut -d '/' -f 1-5 | tr -d -c 0-9a-zA-Z/.)
	
	if [ -f ${t}/common_lib.sh ] ; then
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			${gg} --verify ${t}/common_lib.sh.sig 		
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"		
		fi
		
		ls -las /etc/res*
		csleep 10

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t}
			csleep 10

			#DONE:teskti.uusiksi
			dqb "1MP,2: running mutilatetc.bash maY be necessary now to fix some things"
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

#TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)

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

	if [ ! -x ${1}/${3} ] ; then
		dqb "CANNOT INCLUDE PROFS.HS 0 R WHÅTEVER"
		dqb "$0 1 \$srcfile | chmod +x ${3} ?"
		exit 17
	fi


	#fktioiden {im,ex}portointia jos kokeilisi? man bash...
	. ${1}/${3}
	[ $? -gt 0 ] && exit 19

	local q
	local r
	q=$(${mkt} -d)
	[ $? -gt 0 ] && exit 20

	r=$(${srat} -tf ${1}/${2} | grep prefs.js | wc -l) #vielä jos arhc_4 ?
	[ ${r} -gt 0 ] || exit 21
	csleep 1

	${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/${2}
	[ $? -gt 0 ] && exit 22
	csleep 2

	

	imp_prof esr $(whoami) ${q}
	dqb $?
	csleep 2

	
}


case "${mode}" in
	-1) 
		dqb "DIPOLIN KÄPY"
		csleep 3

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
dqb "2p1m.distro=${distro}"
dqb "m2pi.srcfile=${srcfile}"
dqb "4th arra of..."
csleep 5


case "${mode}" in
	1|0|3)
		./sq-rot.sh ${mode} ${srcfile} -v
	;; 
	r)
		[ -d ${srcfile} ] || exit 23
		[ -v CONF_default_arhcive ] || exit 24
 		[ -v CONF_default_arhcive2 ] || exit 25
		[ -v CONF_default_arhcive3 ] || exit 18
		
		[ -z "${fox}" ] && exit 26
		[ -x ${fox} ] || exit 27
		[ -s ~/${CONF_default_arhcive2} ] || exit 29

		${sr0} -C ~ -jxf ~/${CONF_default_arhcive2}


		tpr ${srcfile} ${CONF_default_arhcive} ${CONF_default_arhcive3}

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
	[ -z "${part}" ] || grep ${part} /proc/mounts #greppaus voi jäädä junnaamaan?
	[ -z "${CONF_dir}" ] || grep ${CONF_dir} /proc/mounts
fi

${scm} 0555 $0
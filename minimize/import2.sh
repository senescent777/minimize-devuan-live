#!/bin/bash
debug=0 #1
file=""
distro=$(cat /etc/devuan_version) #tämä tarvitaan toistaiseksi
dir=/mnt
part0=ABCD-1234
PREFIX=~/Desktop/minimize
mode=-2

#HUOM.21525:uudet tark siirretty tdstoon common_lib

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

[ -z ${distro} ] && exit 6

dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "file=${file}"
d=${PREFIX}/${distro}

if [ -d ${d} ] && [ -s ${d}/conf ] ; then
	. ${d}/conf
fi

function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			if [ ${mode} -eq -2 ] ; then
				mode=${1}
			else
				if [ -d ${PREFIX}/${1} ] ; then
					distro=${1}
				else
					file=${1}
				fi
			fi
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

function usage() {
	echo "${0} [mode] [tgtfile] <distro> <debug> "
}

if [ -x ${PREFIX}/common_lib.sh ] ; then
	. ${PREFIX}/common_lib.sh
else
	srat="sudo /bin/tar"
	som="sudo /bin/mount"
	uom="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	odio=$(which sudo)

	#jos näillä lähtisi aikankin case q toimimaan
	n=$(whoami)
	smr=$(${odio} which rm)
	NKVD=$(${odio} which shred)
	NKVD="${NKVD} -fu "
	whack=$(${odio} which pkill)
	whack="${odio} ${whack} --signal 9 "

	function check_binaries() {
		dqb "imp2.ch3ck_b1nar135( \${1} )"
	}

	function check_binaries2() {
		dqb "imp2.ch3ck_b1nar135_2( \${1} )"
	}

	function fix_sudo() {
		dqb "imp32.fix.sudo"
	}

	function enforce_access() {
		dqb "imp32.enf_acc()"
	}

	function part3() {
		dqb "imp32.part3()"
	}

	#tähän sitten se common_lib.init2 copypastella? tai jos ne /e pakotukset mieluummin
	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo $?
	dqb "NO LIB"
	csleep 1

	#HUOM.18525:ao. 2 fktiota voisi esitellä pikemminkin sittenq lib puuttuu
	function pr4() {
		dqb "imp2.pr4 (\${1} \${2})" 
	}

	function pre_part3() {
		dqb "imp2.pre_part3( \${1} \${2})"
	}

	check_binaries ${distro}
	echo $?
	[ $? -eq 0 ] || exit 7 #kosahtaako fix_sudon takia?
	
	csleep 1

	check_binaries2
	[ $? -eq 0 ] || exit 8
	csleep 1
fi

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}

if [ ! -s /OLD.tar ] ; then 
	${srat} -cf /OLD.tar /etc /sbin /home/stubby /home/devuan/Desktop
fi

dqb "b3f0r3 par51ng tha param5"
csleep 5

#glorified "tar -x" this function is - Yoda
function common_part() {
	debug=1

	dqb "common_part( ${1}, ${2})"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2

	[ y"${2}" == "y" ] && exit 11
	[ -d ${2} ] || exit 22
	dqb "paramz_0k"

	cd /
	#VAIH:sha-tarkistus toimimaan, polun kanssa on juttuja
	dqb "DEBUG:${srat} -xf ${1} "
	csleep 2
	
	if [ -s ${1}.sha ] ; then #mennäänkö tähän?
		dqb "KHAZAD-DUM"
		cat ${1}.sha
		${sah6} ${1}
		csleep 10
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	csleep 5
	${srat} -xf ${1}
	csleep 2
	dqb "tar DONE"

	if [ -x ${2}/../common_lib.sh ] ; then
		enforce_access ${n}
		dqb "running changedns.sh maY be necessary now to fix some things"
	fi

	csleep 3
	
	if [ -d ${2} ] ; then 
		dqb "HAIL UKK"

		${scm} 0755 ${2}
		${scm} a+x ${2}/*.sh
		${scm} 0444 ${2}/conf*
		${scm} 0444 ${2}/*.deb

		csleep 3
	fi

	[ ${debug} -eq 1 ] && ls -las ${2}
	csleep 3
	dqb "ALL DONE"
}

case "${mode}" in
	-1) #jatkossa jokim fiksumpi kuin -1
		part=/dev/disk/by-uuid/${part0}		
		[ -b ${part} ] || dqb "no such thing as ${part}"

		${som} -o ro ${part} ${dir}
		csleep 5
		${som} | grep ${dir}

		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] (unpack AND install) | $0 1 <source> (just unpacks the archive)"
	;;
	2)
		${uom} ${dir}
		csleep 3
		${som} | grep ${dir}

		[ $? -eq 0 ] && echo "NEXT:  \${distro}/doIt6.sh (maybe)"
	;;
	1)
		[ x"${file}" == "x" ] && exit 44
		[ -s ${file} ] || exit 55

		read -p "U R ABT TO INSTALL ${file} , SURE ABOUT THAT?" confirm
		[ "${confirm}" == "Y" ]  || exit 33
		common_part ${file} ${d}

		csleep 3
		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	0|3)
		dqb "ZER0 S0UND"
		csleep 2

		[ x"${file}" == "x" ] && exit 55
		dqb "KL"
		csleep 2

		[ -s ${file} ] || exit 66
		dqb "${file} IJ"
		csleep 2

		[ z"{distro}" == "z" ] && exit 77
		dqb " ${3} ${distro} MN"
		csleep 2

		read -p "U R ABT TO INSTALL ${file} , SURE ABOUT THAT?" confirm
		[ "${confirm}" == "Y" ] || exit 33
		common_part ${file} ${d}

		if [ ${1} -eq 0 ] ; then
			if [ -s ${d}/e.tar ] ; then
				common_part ${d}/e.tar ${d}
			fi
		fi

		dqb "c_p_d0n3, NEXT: pp3()"
		csleep 6

		part3 ${d} ${dnsm}
		other_horrors #HUOM.21525:varm. vuoksi jos dpkg...
		csleep 2

		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	q)
		[ x"${file}" == "x" ] && exit 55
		dqb "KL"
		csleep 2

		[ -s ${file} ] || exit 66
		dqb "${file} IJ"
		csleep 2

		if [ -x ${PREFIX}/profs.sh ] ; then
			. ${PREFIX}/profs.sh
			[ $? -gt 0 ] && exit 33
			
			dqb "INCLUDE OK"
			csleep 3

			q=$(mktemp -d)
			${srat} -C ${q} -xvf ${file}
			imp_prof esr ${n} ${q}
		else
			dqb "CANNOT INCLUDE PROFS.HS"
		fi
	;;
	-h)
		usage
	;;
	*)
		echo "-h"
	;;
esac

#ettei umount unohdu
echo "REMEMBER 2 UNM0UNT TH3S3:"
grep ${part} /proc/mounts
grep ${dir} /proc/mounts

chmod 0755 $0
#HUOM. tämän olisi kuvakkeen kanssa tarkoitus mennä jatkossa filesystem.squashfs sisälle

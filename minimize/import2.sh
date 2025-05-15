#!/bin/bash
debug=0 #1
file=""
distro=$(cat /etc/devuan_version) #tämä tarvitaan toistaiseksi
dir=/mnt
part0=ABCD-1234
PREFIX=~/Desktop/minimize

if [ -r /etc/iptables ] || [ -w /etc/iptables ]  || [ -r /etc/iptables/rules.v4 ] ; then
	echo "/E/IPTABLES IS WRITABEL"
	exit 12
fi

if [ -r /etc/sudoers.d ] || [ -w /etc/iptables ] ; then
	echo "/E/S.D IS WRITABLE"
	exit 34
fi

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

case $# in
	1)
		dqb "maybe ok" #tap -1 ja 2 ok, muissa pitäisi fileen puuttuminen p ysäyttää
	;;
	2)
		if [ -d ${PREFIX}/${2} ] ; then
			distro=${2}
		else
			file=${2}
		fi
	;;
	3)
		file=${2}

		if [ -d ${PREFIX}/${3} ] ; then
			distro=${3}
		else
			[ "${3}" == "-v" ] && debug=1
		fi
	;;
	4)
		file=${2}
		distro=${3}
		[ "${4}" == "-v" ] && debug=1
	;;
	*)
		echo "$0 <mode> <other_params>"
	;;
esac

[ z"${distro}" == "z" ] && exit 6

function pr4() {
	dqb "imp2.pr4 (${1} ${2})" 
}

function pre_part3() {
	dqb "imp2.pre_part3( ${1} ${2})"
}

mode=${1}
dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "file=${file}"
d=${PREFIX}/${distro}

if [ -d ${d} ] && [ -s ${d}/conf ] ; then
	. ${d}/conf
fi

if [ -x ${PREFIX}/common_lib.sh ] ; then
	. ${PREFIX}/common_lib.sh
else
	srat="sudo /bin/tar"
	som="sudo /bin/mount"
	som="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	odio=$(which sudo)
	
	function check_binaries() {
		dqb "imp2.ch3ck_b1nar135(${1} )"
	}

	function check_binaries2() {
		dqb "imp2.ch3ck_b1nar135_2(${1} )"
	}

	function fix_sudo() {
		dqb"imp32.fix.sudo"
	}

	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	#TODO:josko testaisi tilanteen missä $distro/{conf,lib} puuttuvat
	#JOKO JO?
	echo $?
	dqb "NO LIB"
	csleep 1

	check_binaries ${distro}
	[ $? -eq 0 ] || exit 7 #kosahtaako fix_sudon takia?
	echo $?
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
	dqb "DEBUG:${srat} -xf ${1} "
	csleep 2
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

case "${1}" in
	-1)
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
	*)
		echo "-h"
	;;
esac

chmod 0755 $0
#HUOM. tämän olisi kuvakkeen kanssa tarkoitus mennä jatkossa filesystem.squashfs sisälle

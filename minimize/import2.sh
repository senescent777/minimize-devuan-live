#!/bin/bash
debug=0
file=""
distro=$(cat /etc/devuan_version) #tämjä tarvitaan toistaiseksi
#joitain oletusarvoja
dir=/mnt
part0=ABCD-1234
#n=$(whoami)

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
		if [ -d ~/Desktop/minimize/${2} ] ; then
			distro=${2}
		else
			file=${2}
		fi
	;;
	3)
		file=${2}

		if [ -d ~/Desktop/minimize/${3} ] ; then
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
	dqb "imp2.pr4 (${1})" 
}

function pre_part3() {
	dqb "imp2.pre_part3( ${1})"
}

mode=${1}
dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "file=${file}"
#exit

if [ -d ~/Desktop/minimize/${distro} ] && [ -s ~/Desktop/minimize/${distro}/conf ] ; then
	. ~/Desktop/minimize/${distro}/conf
fi

if [ -x ~/Desktop/minimize/common_lib.sh ] ; then
	. ~/Desktop/minimize/common_lib.sh
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

if [ -d ~/Desktop/minimize/${distro} ] && [ -x ~/Desktop/minimize/${distro}/lib.sh ] ; then
	. ~/Desktop/minimize/${distro}/lib.sh
else
	echo $?
	csleep 1

	check_binaries ${distro}
	#[ $? -eq 0 ] || exit 7 #kosahtaako fix_sudon takia?
	echo $?
	csleep 1

	check_binaries2
	#[ $? -eq 0 ] || exit 8
	csleep 1
fi

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}

if [ ! -s /OLD.tar ] ; then 
	${srat} -cf /OLD.tar /etc /sbin /home/stubby /home/devuan/Desktop
fi

dqb "b3f0r3 par51ng tha param5"
csleep 5

#glorified "tar -x" is this functiuon 
function common_part() {
	dqb "common_part()"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2

	[ y"${2}" == "y" ] && exit 11
	dqb "paramz_0k"

	cd /
	dqb "DEBUG:${srat} -xf ${1} "
	csleep 2
	${srat} -xf ${1}
	csleep 2
	dqb "tar DONE"

	if [ -x ~/Desktop/minimize/common_lib.sh ] ; then
		enforce_access ${n}
		dqb "running changedns.sh maY be necessary now to fix some things"
	fi

	[ ${debug} -eq 1 ] && ls -las ~/Desktop/minimize/*.sh
	csleep 3
	
	if [ -d ~/Desktop/minimize/${2} ] ; then 
		dqb "HAIL UKK"

		${scm} 0755 ~/Desktop/minimize/${2}
		${scm} a+x ~/Desktop/minimize/${2}/*.sh
		${scm} 0444 ~/Desktop/minimize/${2}/conf*

		${scm} 0444 ~/Desktop/minimize/${2}/*.deb
		csleep 3
	fi

	[ ${debug} -eq 1 ] && ls -las ~/Desktop/minimize/${2}
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

		common_part ${file} ${distro}
		csleep 3
		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	0)
		#HUOM.21035: joskohan uuden päivityspaketin kanssa olisi nalkutukset poistettu

		[ x"${file}" == "x" ] && exit 55
		dqb "KL"
		csleep 2

		[ -s ${file} ] || exit 66
		dqb "${file} IJ"
		csleep 2

		[ z"{distro}" == "z" ] && exit 77
		dqb " ${3} ${distro} MN"
		csleep 2

		common_part ${file} ${distro}

		pre_part3 ~/Desktop/minimize/${distro}
		pr4 ~/Desktop/minimize/${distro}

		part3 ~/Desktop/minimize/${distro}
		csleep 2

		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	*)
		echo "-h"
	;;
esac

chmod 0755 $0
#HUOM. tämän olisi kuvakkeen kanssa tarkoitus mennä jatkossa filesystem.squashfs sisälle

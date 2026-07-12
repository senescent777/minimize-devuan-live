#!/bin/bash
debug=0
distro=$(cat /etc/devuan_version)
d0=$(pwd)
d=${d0}/${distro}
mode=-2
tgtfile=""
gbk=0

function usage() {
	echo "$0 <mode> <tgtfile> [ -v] [-p] "
	echo "mode:"
	echo "f: makes archive of .deb-Files"
	echo "q: makes archive contaihing firefox profile"
	echo "c: is sq-Chroot-env-related option"
	echo "p: Pulls \${CONF_default_archive3} from somewhere?"
}

function parse_opts_1() {
	dqb "x3.popts1 ${1} "

	case "${1}" in
		-p)
			#if [ ${gbk} -lt 1 ] ; then
				gbk=1
			#fi
		;;
		*)
			#tämä voisi olla myös parse_opts_2:sessa?
			if [ "${mode}" == "-2" ] ; then
				mode=${1}
			fi
		;;
	esac
}

function parse_opts_2() {
	if [ -z "${tgtfile}" ] ; then
		if [ "${2}" != "-v" ] ; then			
			tgtfile=${2}
		fi
	fi
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	exit 5
fi

[ -z "${distro}" ] && exit 6
#d=${d0}/${distro}
process_lib ${d}

if [ -x ${d0}/e/e22.sh ] ; then
	.  ${d0}/e/e22.sh
	.  ${d0}/e/e23.sh
else
	echo "NO BACKEND FOUND"
	exit 58
fi

[ -d ${tgtfile} ] && exit 99 #P.V.H.H
e22_hdr ${tgtfile}
[ "${mode}" == "rp" ] || e22_hdr ${tgtfile}
[ -v CONF_iface ] && ${sifd} ${CONF_iface}

case "${mode}" in
	rp) #VAIH:tämän testailu esim. kehitysymp, parametreja vähän lisää fktiolle yms
		#siirtynee koodia casen ja fktion välillä vielä
		[ -s "${tgtfile}" ] || exit 67
		[ -r "${tgtfile}" ] || exit 68
		e22_rpg ${tgtfile} ${d}

	;;
	f)
		t=$(echo ${d} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)
		enforce_access $(whoami) ${t}
		e22_arch ${tgtfile} ${d} ${gbk}
	;;
	q)
		[ -v CONF_default_arhcive ] || exit 33
		[ -v CONF_default_arhcive2 ] || exit 34
		[ -v CONF_default_arhcive3 ] || exit 35
		e23_qrs ${tgtfile} ${d0} ${CONF_default_arhcive2} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
	c)
		e22_cde ${tgtfile} ${d0} ${distro}

		#EI EDELLLEENKÄÄN NÄIN???
		#mv ${tgtfile} ${tgtfile}.tmp
		#bzip2 -c -z ${tgtfile}.tmp > ${tgtfile}
		#[ $? -eq 0 ] && ${NKVD} ${tgtfile}.tmp
	;;
	p)
		#25626:ehkä toimi kerrabn tuolloin
		[ -v CONF_default_arhcive3 ] || exit 66
		csleep 1
		[ -v CONF_iface ] && ${sifu} ${CONF_iface}
		e23_profs ${tgtfile} ${d0} ${CONF_default_arhcive3}	
	;;
	-h)
		usage
	;;
	s)
		e22_stu ${tgtfile} 
	;;
#	b)
#		#230326:tekee jo jotain, vielä sietää miettiä onko siinä pointtia mitä tekee
#		for f in $(find ${d0} -type f -name "*lib.sh") ; do
#			e22_ftr ${f}
#		done
#	;;
#	*)
#		cont=1
#	;;
esac

#tktiona vähän turhaq, tarkistuksia enemmän kun varsnsiats koodia, toisaalta voisi prujata fktion sisällön niihin 2 kohtaan export2:sessa
#function e22_dblock() {
#	dqb "e22_dblock(${1} , ${2} , ${3} , ${4} )))) "
#
#	[ -z "${1}" ] && exit 14
#	[ -s ${1} ] || exit 15
#	[ -z "${2}" ] && exit 11
#	[ -d ${2} ] || exit 22
#	[ -w ${2} ] || exit 23
#	[ -z "${3}" ] && exit 33
#	[ -d ${3} ] || exit 34
#	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...
#	[ -z "${4}" ] && exit 37
#
#	dqb ".PARS-OK"
#	csleep 1
#
#	[ ${debug} -eq 1 ] && pwd
#
#	ls -la ${3}/*.deb | wc -l
#	
#	for s in ${PART175_LIST} ; do
#		${sharpy} ${s}*
#		${NKVD} ${3}/${s}*.deb
#	done
#	
#	local t
#	t=$(echo ${2} | cut -d "/" -f 1-6)
#	e22_ts ${t} ${3}
#	dqb "JST B3F0R3 3NF0RC3"
#	csleep 10
#	
#	enforce_access $(whoami) ${t}
#	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
#	csleep 10
#
#	e22_arch ${1} ${2} ${4}
#	e22_cleanpkgs ${2}
#}
e22_ftr ${tgtfile}
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
#d=${d0}/${distro} #nykyään vähän turha tässä
process_lib ${d}

if [ -x ${d0}/e/e22.sh ] ; then
	.  ${d0}/e/e22.sh #tässä jotain vikaa vikaa? toiv ei
	.  ${d0}/e/e23.sh
else
	echo "NO BACKEND FOUND"
	exit 58
fi

e22_hdr ${tgtfile}
#[ -v CONF_iface ] && ${sifd} ${CONF_iface} #toistaiseksi pois sotkemasta

case "${mode}" in
#	rp) #080326:toistaiseksi jemmaan, kiukuttelua (takaisin komm josqs?)
#		[ -s "${tgtfile}" ] || exit 67
#		[ -r "${tgtfile}" ] || exit 68
#		e22_rpg ${tgtfile} ${d}
#17426:josqs ta,aisin kommenteista?
#	;;
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
	;;
	p)
		[ -v CONF_default_arhcive3 ] || exit 66
		csleep 1
		[ -v CONF_iface ] && ${sifu} ${CONF_iface}
		e23_profs ${tgtfile} ${d0} ${CONF_default_arhcive3}	
	;;
	-h)
		usage
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

e22_ftr ${tgtfile}
#!/bin/bash
d0=$(pwd)

tcmd=$(which tar)
[ -z "${tcmd}" ] && exit 11
[ -x ${tcmd} ] || exit 12

spc=$(which cp)
[ -z "${spc}" ] && exit 13
[ -x ${spc} ] || exit 14
n=$(whoami) #mihin tarvitaan?

svm=$(which mv)
[ -z "${svm}" ] && exit 13
[ -x ${svm} ] || exit 14

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
		svm="sudo ${svm} "
	fi
else
	exit 10
fi

tgt=${1}
[ -s ${tgt} ] && ${svm} ${tgt} ${tgt}.OLD

#tai jos conf-kikkailu vähän toisin
if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -s ${d0}/../$(whoami).conf ] ; then
		echo "ALT.C0NF1G3"
		. ${d0}/../$(whoami).conf
	fi
fi

#tätä pitäisi vähän miettiä
if [ -v CONF_testgris ] && [ -d ${CONF_testgris} ] ; then
	echo "YLIULIULI FADS FASDD FASDDQH"
	cd ${CONF_testgris}

	#HUOM:-C olisi myös keksitty
else
	cd /
fi

if [ -s ${d0}/MAN1.F2ST ] ; then
	${tcmd} -rvf ${tgt} ${d0}/MAN1.F2ST
	echo "update2.sh ${tgt} ${2} ${3}"
fi

#060626:suattaapi olla turha tdsto nykyään


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
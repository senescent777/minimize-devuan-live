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
#!/bin/bash
d0=$(pwd)

tcmd=$(which tar)
[ -z "${tcmd}" ] && exit 11
[ -x ${tcmd} ] || exit 12

spc=$(which cp)
[ -z "${spc}" ] && exit 13
[ -x ${spc} ] || exit 14
n=$(whoami)

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		#TODO:testaus miten saa tOImimaan omegan ajon jlkeen?
		#... pitäisi onnata qhan kohteen käyttöoik kunnossa

		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
	fi
else
	exit 10
fi

tgt=${1}
[ -z "${tgt}" ] && exit 15
[ -s "${tgt}" ] || exit 16
[ -r "${tgt}" ] || exit 17

echo "PARAMS CHECKED"
sleep 1

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -s ${d0}/../$(whoami).conf ] ; then
		echo "ALT.C0NF1G3"
		. ${d0}/../$(whoami).conf
	fi
fi

#pelkästään .deb-paketteja sisältävien kalojen päivityksestä pitäisi urputtaa	
${tcmd} -tf ${tgt} | grep ".deb"
sleep 1

read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
[ "${confirm}" != "Y" ] && exit 

${spc} ${tgt} ${tgt}.OLD #cp vaiko mv?
[ $? -eq 0 ] || echo "chmod | chown ?"
sleep 1
t=$(pwd)

if [ -v CONF_testgris ] && [ -d ${CONF_testgris} ] ; then
	echo "YLIULIULI"
	cd ${CONF_testgris}

	#HUOM:-C olisi myös keksitty
else
	cd /
fi

if [ ! -s ${d0}/MAN1.F2ST ] ; then
	${tcmd} -tf ${tgt} | grep -v .tar > ${d0}/MAN1.F2ST
	${tcmd} -rvf ${tgt} ${d0}/MAN1.F2ST

	#g=$(${tcmd} -tf ${tgt} | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar )
	sleep 1
	
	#for f in ${g} ; do 
	#	if [ -f ${f} ] ; then #josko nyt
	#		if [ ! -h ${f} ] ; then 
	#			${tcmd} -rvf ${tgt} ${f} #HUOM. "-uvf" KANSSA MENEE VITUIKSI JOS EI OLE TARKKANA 666 !!!
	#			[ $? -eq 0 ] || echo "chmod | chown ?"
	#		fi
	#	fi
	#done	
fi

${tcmd} -T ${d0}/MAN1.F2ST -f ${tgt} -rv

#jotat ehtisi synkata 
sleep 6;sudo /bin/sync;sleep 4

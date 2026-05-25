#!/bin/bash
d0=$(pwd)

tcmd=$(which tar)
[ -z "${tcmd}" ] && exit 11
[ -x ${tcmd} ] || exit 12

spc=$(which cp)
[ -z "${spc}" ] && exit 13
[ -x ${spc} ] || exit 14
n=$(whoami)
par3=""

#VAIH:kolmatta param testattu ?
#"kokonaan uusi päivitysskripti" jo tehty, vaan onko siinä pointtia?

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		#030526:onnistuu tämän skriptin toiminta myös omegan jälkeen kunhan x 
		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
	fi

	par3=${3}
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
${tcmd} -tf ${tgt} | grep '.deb' | head -n 5
sleep 1

read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
[ "${confirm}" != "Y" ] && exit 

${spc} ${tgt} ${tgt}.OLD #cp vaiko mv?
[ $? -eq 0 ] || echo "chmod | chown ?"
sleep 1
t=$(pwd)

#TODO:CONF_env-juttuja
#TODO:erityisesti olisi hyvä välttää resolv.conf päivittyminen kun se kerran saatu kuntoon

if [ -v CONF_testgris ] && [ -d ${CONF_testgris} ] ; then
	echo "YLIULIULI FADS FASDD FASDDQH"
	cd ${CONF_testgris}

	#HUOM:-C olisi myös keksitty
else
	cd /
fi

function process_row() {
	${tcmd} -rvf ${1} ${2}
}

if [ ! -s ${d0}/MAN1.F2ST ] ; then
	${tcmd} -tf ${tgt} | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar | grep -v .deb > ${d0}/MAN1.F2ST
	${tcmd} -rvf ${tgt} ${d0}/MAN1.F2ST
	sleep 1
fi

echo "JUST BEFOR.E PROCESSING ROWS"
sleep 1
g=$(grep -v '#' ${d0}/MAN1.F2ST | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar | grep -v .deb  )

if [ ! -z "${par3}" ] ; then
	g=$(echo ${g} | grep -v ${par3})
fi

for f in ${g} ; do
	if [ -f ${f} ] ; then
		if [ ! -d ${f} ] ; then #"-h" - tark vielä?
			process_row ${tgt} ${f}
		fi
	fi
done

#joTTA ehtisi synkata 
sleep 6;sudo /bin/sync;sleep 4

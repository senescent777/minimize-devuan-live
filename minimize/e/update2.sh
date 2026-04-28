#!/bin/bash
d0=$(pwd)

tcmd=$(which tar)
[ -z "${tcmd}" ] && exit 11
[ -x ${tcmd} ] || exit 12

spc=$(which cp)
[ -z "${spc}" ] && exit 13
[ -x ${spc} ] || exit 14
n=$(whoami)

#TODO:kolmanneksi parametriksi alihakemisto mikä dumpataan arkistoon, sen sijaan että käydään koko lista läpi ?

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
${tcmd} -tf ${tgt} | grep '.deb' | head -n 5
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

function process_row() {
	${tcmd} -rvf ${1} ${2}
}

#HUOM.170426:olisi hyvä keksiä tähänkin jotain siltä varalta että merd2 ei tulisi ylimääräisiä kopioita

if [ ! -s ${d0}/MAN1.F2ST ] ; then
	${tcmd} -tf ${tgt} | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar | grep -v .deb > ${d0}/MAN1.F2ST
	${tcmd} -rvf ${tgt} ${d0}/MAN1.F2ST
	sleep 1
fi

echo "JUST BEFOR.E PROCESSING ROWS"
sleep 1

#toimiikohan kehitysynp.tössä niinqu pitää?
#${tcmd} -T ${d0}/MAN1.F2ST --exclude '*.tar' --exclude '*.deb' -f ${tgt} -rv

for f in $(grep -v '#' ${d0}/MAN1.F2ST | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar | grep -v .deb  ) ; do
	if [ -f ${f} ] ; then
		if [ ! -d ${f} ] ; then #"-h" - tark vielä?
			process_row ${tgt} ${f}
		fi
	fi
done

#jotat ehtisi synkata 
sleep 6;sudo /bin/sync;sleep 4

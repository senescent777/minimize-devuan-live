#!/bin/bash
d0=$(pwd)
tcmd=$(which tar)
spc=$(which cp)
n=$(whoami)

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
	fi
else
	exit 10
fi

tgt=${1}
[ -z ${tgt} ] && exit 11
[ -s ${tgt} ] || exit 12
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
${tcmd} -tf ${tgt} | grep '.deb'
sleep 3

read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
[ "${confirm}" != "Y" ] && exit 

function process_entry() {
	${tcmd} -f ${1} -rv ${2}
}

${spc} ${tgt} ${tgt}.OLD #cp vaiko mv?
sleep 2
t=$(pwd)

if [ -v testgris ] && [ -d ${testgris} ] ; then
	cd ${testgris}

	#-C olisi myös keksitty
	#exclude voisi olla myös hyvä (else-haarassa on jo)
	#miten se -u ? (ekalla yrityksellä else-haarassa ei oikein toiminut toiv tavalla)

#	#nalqtus jos /etc yai /opt puuttuu paketista?
#	for f in $(${tcmd} -tf ${tgt}) ; do
#		${tcmd} -rvf ${tgt} ${f}
#	done
else
	echo "VAIH:else-branch"
	cd /
fi

for f in $(${tcmd} -tf ${tgt} | grep -v '${n}.conf'  | grep -v .chroot) ; do
	if [ -f ${f} ] ; then #josko nyt
		${tcmd} -uvf ${tgt} ${f}
	fi
done

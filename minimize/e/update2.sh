#!/bin/bash
d0=$(pwd)

tcmd=$(which tar)
[ -z "${tcmd}" ] && exit 11
[ -x ${tcmd} ] || exit 12

#TODO:tämä kikkare roskikseen, pitäisi keksiä parempiq ei kerran jaksa kesä/talviajan/lokaalien kanssa kikkailla

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
[ -r "${tgt}" ] || exit 18
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

#TODO:näille main urputus jos ei ole $tgt sis hmisto mountattu?

#pelkästään .deb-paketteja sisältävien kalojen päivityksestä pitäisi urputtaa	
${tcmd} -tf ${tgt} | grep '.deb'
sleep 1

#... pikemminkin {f/g/e}.tar läsnäolosta kohteessa pitäisi yrputtaa

read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
[ "${confirm}" != "Y" ] && exit 

function process_entry() {
	${tcmd} -f ${1} -rv ${2}
}

${spc} ${tgt} ${tgt}.OLD #cp vaiko mv?
[ $? -eq 0 ] || echo "chmod | chown ?"
sleep 1
t=$(pwd)

if [ -v CONF_testgris ] && [ -d ${CONF_testgris} ] ; then
	echo "YLIULIULI"
	cd ${CONF_testgris}

	#TODO?:-C olisi myös keksitty
	#TODO?:nalqtus jos /etc yai /opt puuttuu paketista?
else
	cd /
fi

#lisäsäätöä /e/resolv , /e/localtime /e/timezone suhteen vai ei? vissiin ei

g=$(${tcmd} -tf ${tgt} | grep -v '${n}.conf' | grep -v .chroot)
c=$(find / -maxdepth 1 -type f -name OLD.tar -size +10M | wc -l)

if [ ${c} -gt 0 ] ; then
	echo "ÅLD"
	g=$(echo ${g} | grep -v OLD.tar)
fi

sleep 1
c=$(find ${d0} -type f -name e.tar -size +10M | wc -l)

if [ ${c} -gt 0 ] ; then
	echo "e"
	g=$(echo ${g} | grep -v e.tar)
fi

sleep 1
c=$(find ${d0} -type f -name f.tar -size +10M | wc -l)

if [ ${c} -gt 0 ] ; then
	echo "f"
	g=$(echo ${g} | grep -v f.tar)
fi

sleep 1

for f in ${g} ; do
	#VAIH:jokin rajoitus linkkien suhteen
	if [ -f ${f} ] ; then #josko nyt
		#if [ ! -h ${f} ] ; then 
			${tcmd} -uvf ${tgt} ${f}
			[ $? -eq 0 ] || echo "chmod | chown ?"
		#fi
	fi
done

#jotat ehtisi synkata 
sleep 6;sudo /bin/sync;sleep 4

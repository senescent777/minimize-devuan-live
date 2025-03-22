#!/bin/bash

#KIKKAILUT ROSKIKSEEN 666!
#
#d=$(dirname $0)
#echo "VERY MUCH UNDER CONSTRUCTION"
#echo "VAIH: se sudotus-selvitys"
#if [ -s ${d}/conf ] && [ -s ${d}/lib.sh ] ; then
#	. ${d}/conf
#	. ${d}/lib.sh
#else
#	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING"
#	exit 111	
#fi
#260125: vaikuttaisi toimivan jnkn verran, ainakin sisään loggaus onnistuu
#
##. ${d}/${1}/conf
#. ${d}/common_lib.sh

debug=1
odio=$(which sudo)
smr=$(sudo which rm)
smr="${odio} ${smr} "
whack=$(sudo which pkill)
whack="${odio} ${whack} --signal 9 "

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

echo "${smr} /etc/sudoers.d/live (TODO)"
echo "${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan (TODO)"
csleep 5
${whack} xfce4-session
#sössön sössön stna
#!/bin/bash

odio=$(which sudo)
smr=$(${odio} which rm)
smr="${odio} ${smr} "

whack=$(${odio} which pkill)
whack="${whack} --signal 9 "
svm=$(${odio} which mv)
svm="${odio} ${svm}"
mode=3

if [ $# -gt 0 ] ; then
	mode=${1}
fi

#100126:ei vain toimi päivityspaketin jälkeen toivotulla tavalla ja that's it (koita keksiä jotain)
#
#if [ ${mode} -gt 1 ]; then
#	${scm} g+rw /dev/tty0	#JOKO JP PRKL (no eipä oikeastaan päivityspak jälk tilannetta paranna)
#	${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan ,tty,input
#fi

[ ${mode} -gt 2 ] && ${smr} /etc/sudoers.d/live
[ ${mode} -gt 3 ] && ${svm} /etc/sudoers_new /etc/sudoers #miten Tämä toimii nykyään?
[ ${mode} -gt 0 ] && ${whack} xfce4-session

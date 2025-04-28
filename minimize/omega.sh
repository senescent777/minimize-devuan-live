#!/bin/bash

debug=1
odio=$(which sudo)
smr=$(sudo which rm)
smr="${odio} ${smr} "

whack=$(sudo which pkill)
#pkill parempi sudotettuna vai ilman? vissiin ilman
whack="${whack} --signal 9 "
#whack="${odio} ${whack}  "

svm=$(${odio} which mv)
svm="${odio} ${svm}"
mode=3

if [ $# -gt 0 ] ; then
	mode=${1}
fi

#function dqb() {
#	[ ${debug} -eq 1 ] && echo ${1}
#}
#
#function csleep() {
#	[ ${debug} -eq 1 ] && sleep ${1}
#}

[ ${mode} -gt 1 ] && ${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan 
[ ${mode} -gt 2 ] && ${smr} /etc/sudoers.d/live
[ ${mode} -gt 3 ] && ${svm} /etc/sudoers_new /etc/sudoers
[ ${mode} -gt 0 ] && ${whack} xfce4-session
#!/bin/bash

debug=1
odio=$(which sudo)
smr=$(sudo which rm)
smr="${odio} ${smr} "

whack=$(sudo which pkill)
#parempi sudotettuna vai ilman?
whack="${odio} ${whack} --signal 9 "
mode=1

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan 
${smr} /etc/sudoers.d/live

${whack} xfce4-session
#sössön sössön stna
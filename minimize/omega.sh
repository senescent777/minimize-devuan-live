#!/bin/bash

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
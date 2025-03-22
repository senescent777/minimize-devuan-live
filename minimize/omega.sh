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

#olisikohan shred parempi tässä?
${smr} /etc/sudoers.d/live

#HUOM.220325:testattu daedaluksen kanssa, toiminee suht koht toivotulla tavalla kun useRmod kommentoitu pois
#jatkossa a) testaus ei-kommentoidun usermod'in kanssa
#b) meshuggahiin vain ne komennot mitkä oikeasti tarvitaan, ja parametrien huomiointi jos mahd 
#c) %sudo mäkeen /e/sudoers'ista? rootille root-salasanan vaatiminen?
echo "${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan (TODO)"

csleep 5
${whack} xfce4-session
#sössön sössön stna
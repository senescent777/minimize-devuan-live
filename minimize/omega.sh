#!/bin/bash

debug=1
odio=$(which sudo)
smr=$(sudo which rm)
smr="${odio} ${smr} "
whack=$(sudo which pkill)
whack="${odio} ${whack} --signal 9 "
mode=1

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#olisikohan shred parempi tässä?
${smr} /etc/sudoers.d/live

#HUOM.220325:testattu daedaluksen kanssa, toiminee suht koht toivotulla tavalla kun useRmod kommentoitu pois
#jatkossa a) testaus ei-kommentoidun usermod'in kanssa (toiminee)
#b) meshuggahiin vain ne komennot mitkä oikeasti tarvitaan(alkaisi olla tehty)
#c) %sudo mäkeen /e/sudoers'ista? rootille root-salasanan vaatiminen? (TODO, sudoers_new liittyy)
#d) usermod-kikkailun jÄlkeen which aiheutti urputusta joten lisätty cb_list:iin (toiv ei sivuvaikutuksia)

if [ ${mode} -gt 0 ] ; then
	dqb "USERMOD IN 3 SECS"
	csleep 3 # jos on jotain vaikutusta johonkin latenssin pituudella

	#TODO:sudoers_new kopsaten oikealle nimelle
	#changedns/ifup/ifdown eivät 24,3 oikein toimineet, jotain tarttis tehrä
	#HUOM.250325:ensimmäinen kkeilu daedaluksen kanssa niin näytti jo toimivan kuten pitää
	
	${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan 
else
	dqb "NOT TOUCHING GROUPS THIS TIME"
fi

csleep 5
${whack} xfce4-session
#sössön sössön stna
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

#131125;kiukuttelua edelleen slim:in kanssa, ei liittyne g_pt2seen kuitenkaan
[ ${mode} -gt 1 ] && ${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan 
[ ${mode} -gt 2 ] && ${smr} /etc/sudoers.d/live
[ ${mode} -gt 3 ] && ${svm} /etc/sudoers_new /etc/sudoers #miten yämä toimii nykyään?
[ ${mode} -gt 0 ] && ${whack} xfce4-session
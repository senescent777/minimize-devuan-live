#!/bin/bash

odio=$(which sudo)
smr=$(${odio} which rm)
smr="${odio} ${smr} "

#scm=$(${odio} which mv)
#scm="${odio} ${scm}"

whack=$(${odio} which pkill)
whack="${whack} --signal 9 "
svm=$(${odio} which mv)
svm="${odio} ${svm}"
mode=3

if [ $# -gt 0 ] ; then
	mode=${1}
fi

if [ ${mode} -eq 5 ] ; then
	sudo /etc/init.d/ntpsec stop
	sudo apt --fix-broken install
	sudo /etc/init.d/slim stop
	exit
fi

if [ ${mode} -eq 6 ] ; then
	sudo apt-get remove --purge slim*
	sudo /etc/init.d/wdm start
	exit
fi

if [ ${mode} -gt 1 ]; then
	#${scm} g+rw /dev/tty0 #ehkä toimii ilmankin mutta pidetäänpä nyt kommenteissa vielä
	${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev,tty devuan #,input tämä vai tty?
fi

[ ${mode} -gt 2 ] && ${smr} /etc/sudoers.d/live
[ ${mode} -gt 3 ] && ${svm} /etc/sudoers_new /etc/sudoers #miten tämä toimii nykyään?
#to state the obvious:jos ei olla äksässä sisällä ni pikemminkin logout tässä alla
[ ${mode} -gt 0 ] && ${whack} xfce4-session

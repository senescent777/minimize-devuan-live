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

#251125:edelleen päivityspak ajamisesta seuraa "login command failed", kyse lienee muustaq hmistojen käyttöoik
#... jos ei muuta keksi ni slim pois kiekolta/esim lxdm tilalle? tai pikemminkin minimal livecd pohjaksi?
#131225:viime aikoina taas tullut login-ongelma muttei välttis liity lxdm:n
#231225:suattaapi olla että login-ongelma poissa vuan suattaapi ettei
#040126:nykyään toimii toivotulla tavalla (kirjautumisen suhteen) kunhan ei sitä päivityspakettia aja
#... toiminnasta sudon kanssa en ole varma (sudoersiin menevän tdston sisältö saattaa olla P-V-H-H tai sitten ei)
#joko paskaa sisältöä tai paskat versiot softista olisi 2 ensimmäistä arvaistaq
#urpoa nimittäin jos /e/s.d alaiseen tdstonimeen kaatuu sudotus

#tty tai input mukaan ryhmiin kokeeksi? TODO:testaa seur miten modatulla kiekolla käy
[ ${mode} -gt 1 ] && ${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev devuan #,tty,input
[ ${mode} -gt 2 ] && ${smr} /etc/sudoers.d/live
[ ${mode} -gt 3 ] && ${svm} /etc/sudoers_new /etc/sudoers #miten Tämä toimii nykyään?
[ ${mode} -gt 0 ] && ${whack} xfce4-session

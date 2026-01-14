#!/bin/bash
mode=2
distro=$(cat /etc/devuan_version)
d0=$(pwd)
#echo "d0=${d0}"
[ z"${distro}" == "z" ] && exit 6
debug=0 #1
d=${d0}/${distro} 

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
		echo "NO CONF"
	 	exit 57
	fi	
fi

function parse_opts_1() {
	dqb "parseopts_1 ${1} ${2}"

	if [ -d ${d0}/${1} ] ; then
		distro=${1}
	else
		case  "${1}" in
			0|1|2) #varsinainen numeerisuustarkistus parempi
				mode=${1}
			;;
			*)
				dqb "invalid param"
			;;
		esac
	fi
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	[ ${debug} -gt 0 ] && ls -las ${d0}
	echo "NO COMMON L1B (AVA1LABL3 AND 3XECUTABL3)"
	exit 55
fi

[ $? -gt 0 ] && exit 56
sleep 1

#https://linuxopsys.com/use-dollar-at-in-bash-scripting
#https://tecadmin.net/bash-special-variables/ nuo ei välttis liity mutta

#=====================================PART0=========================================================
dqb "b3f0r3 p.076"
dqb "mode= ${mode}"
csleep 1

#291125:nimeämistä jos vähän miettisi ao. ja 2_5 suhteen ?
part076 ${distro}

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING OR NOT EXECUTABLE"
	exit 111
fi

#==================================PART 1============================================================
dqb "mode= ${mode}"
dqb "debug= ${debug}"
#exit

#221225:mitäs kaikkia pointteja olikaan ohittaa enforce.hommat sqroot.ympäristössä?
#changedns ja fstab tietysti
if [ -s /etc/sudoers.d/meshuggah ] || [ -f /.chroot ] || [ ${CONF_enforce} -eq 0 ] ; then
	dqb "BYPASSING pre_enforce()"
	csleep 2
else 
	pre_enforce ${d0}
fi

if [ -f /.chroot ] ; then
	dqb "BYPASSING enforce_access()"
	csleep 2
else 
	enforce_access ${n} ${d0}
fi

csleep 2
part1 ${distro} 
[ ${mode} -eq 0 ] && exit

${snt}
csleep 1
dqb "${svm} ${d0}/1c0ns/ \* .desktop ~/Desktop"
csleep 1
${svm} ${d0}/1c0ns/*.desktop ~/Desktop

#===================================================PART 2===================================
#jos tästä hyötyä pulse-kikkareen kanssa: https://wiki.debian.org/PulseAudio#Stuttering_and_audio_interruptions
#TAI vielä parempi?:kts devuanin alsa-ohjeet (https://dev1galaxy.org/viewtopic.php?id=7567) (https://dev1galaxy.org/viewtopic.php?id=6644) (https://wiki.debian.org/ALSA)

function el_loco() {
	#181225;toimiiko kuten pitää vi ei?
	dqb "MI LOCO ${1} , ${2}"
	csleep 1

	if [ ${2} -lt 1 ] ; then #tämä blokki konffaamisen jälkeen+toiminaat?
		#${svm} /etc/default/locale /etc/default/locale.ÅLD		
		fasdfasd /etc/default/locale
		csleep 1

		#menisikö vaikka näin? vai pitäisikö oksentaa vasta tuon yhden if-blokin jälkeen?
		#env | grep LC >> /etc/default/locale
		#env | grep LA >> /etc/default/locale
	
		[ ${debug} -eq 1 ] && tail -n 10 /etc/default/locale
		#jos riittäisi 10 riviä
		csleep 1

		cat /etc/timezone
		csleep 1
		reqwreqw /etc/default/locale
	fi
	
	if [ ${1} -gt 0 ] ; then
		${odio} dpkg-reconfigure locales
		${odio} dpkg-reconfigure tzdata
	else
		${odio} locale-gen
	fi

	#101225:pitäisikö jotain tehdä vielä että nuo sorkitut lokaaliasetukset saa voimaan?
	
#	if [ -s /etc/default/locale ] ; then #miten tämän pitää mennä?
#		. /etc/default/locale #tämä pOis jAtkossa?
#

#211225:pitäisiköhän sitä knftdstpoa($d/conf) pikemminkin muuttaa konffauksen jälkeen? tai jokin ehdollinen asetusten jyrääminen?
		export LC_TIME
		export LANGUAGE
		export LC_ALL

		if [ ${debug} -gt 0 ] ; then
			env | grep LC
			env | grep LAN
			csleep 2
		fi
#	fi
}

c14=0
c13=0
[ ${mode} -eq 1 ] && c14=1

#==============================LOKAALIEN KANSSA HILLITTÖMÄT ARPAJAISET MENOSSA 666========
if [ -v LCF666 ] ; then
	c13=$(grep -v '#' /etc/default/locale | grep LC_TIME | grep -c ${LCF666})
	#c13=$(env | grep LC_TIME | grep -c ${LCF666})
else
	echo "555"
fi

csleep 1

[ ${c13} -lt 1 ] && c14=1
el_loco ${c14} 1 #${c13} #joko jo c13 takaisin?
#=========================================================================================

if [ ${mode} -eq 1 ] || [ ${CONF_changepw} -eq 1 ] ; then 
	dqb "R (in 2 secs)"
	csleep 1
	${odio} passwd

	if [ $? -eq 0 ] ; then
		dqb "L (in 2 secs)"
		csleep 1
		passwd
	fi

	if [ $? -eq 0 ] ; then
		#jnkn ehdon taakse seur 2-3 riviä?		
		${scm} g+rw /dev/tty0
		${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev,tty devuan #,input tämä vai tty?
		csleep 1

		#väärä tapa pakottaa uudelleen_kirjautuminen?
		${whack} xfce4-session
		#HUOM. tässä ei tartte jos myöhemmin joka tap
	else
		dqb "SHOULD NAG ABOUT HAMMAD HERE"
	fi

	exit
fi

pre_part2
c14=$(find ${d} -name '*.deb' | wc -l)
[ ${c14} -gt 0 ] || CONF_removepkgs=0 #eiheuttaak ongelmia sqrootissa?
part2_5 ${CONF_removepkgs} ${CONF_dnsm} ${CONF_iface}

#===================================================PART 3===========================================================
message

#291125:kokeeksi käskyttämään "imp2 3" tässä kohtaa?
part3 ${d}
other_horrors

dqb "BEFORE IMP2"
csleep 2

#141225:mitäjos common_lib ei ajokelpoinen? osaako imp2 toimia oikein silloin?
if [ ! -f /.chroot ] ; then
	[ -x ${d0}/common_lib.sh ] || echo "chmod +x ${d0}/common_lib.sh | import2.sh q ${d0} ";sleep 5
	${scm} 0555 ${d0}/common_lib.sh #toistaiseksi tässä kunnes... Jotain
	${d0}/import2.sh r ${d0} #-v
	#2. ja 3. param. turhia?
fi

jules
${asy}
dqb "GR1DN BELIALAS KYE"

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${CONF_dnsm} ${distro}
	#[ -x $x ] && exit for 
done

${sipt} -L
csleep 1
${scm} 0555 ${d0}/common_lib.sh #JOKO JO LOPPUISI PURPATUS PRKL
${scm} a-wx $0
#===================================================PART 4(final)==========================================================

if [ ${mode} -eq 2 ] ; then
	echo "time to ${sifu} ${CONF_iface} or whåtever"
	csleep 1

	#jnkn ehdon taakse session lahtaamista edelliset rivit?
	#130126:pois kommenteitsa jotta modatun .iso:n testaaminen onnistuu
	#päivän 1. yritys ei oikein lähtenyt lentoon

	${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev,tty devuan #,input tämä vai tty?
	csleep 5
	groups #ryhmiin kuulumisen muutokset eivät tapahtune ennen uloskirjautumista?
	csleep 5
	#140126:aiemmin oli scm ennen usermod, liebneekö merkitystä

	${scm} g+rw /dev/tty0
	csleep 1
	ls -las /dev/tty?
	csleep 5

	#väärä tapa pakottaa uudelleen_kirjautuminen?
	${whack} xfce4-session
 	exit 
fi

#${odio} ${d0}/changedns.sh ${CONF_dnsm} ${distro} röistaiseksi jennaan

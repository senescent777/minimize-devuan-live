#!/bin/bash
mode=2
distro=$(cat /etc/devuan_version)
d0=$(pwd)
#echo "d0=${d0}"
[ -z "${distro}" ] && exit 6
debug=0 #1
d=${d0}/${distro} 

function parse_opts_1() {
	dqb "parseopts_1 ) ${1} ; ${2}"

	if [ -d ${d0}/${1} ] ; then #090326:kuinkahan oleellinen distron yliajo?
		#toimiikohan tämä kohta? pitäiskö tegdä toisin, opts_2() ?
		#distro=${1}
		echo "I1RTS0 CNAGN3H"
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
	dqb "parseopts_2 () ${1} ${2}"
}

function fallback() {
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING OR NOT EXECUTABLE"
	exit 111
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	[ ${debug} -gt 0 ] && ls -las ${d0}
	echo "C0MM0N L1B N0t (AVA1LABL3 AND 3XECUTABL3)"
	exit 55
fi

[ $? -gt 0 ] && exit 56
sleep 1

#https://linuxopsys.com/use-dollar-at-in-bash-scripting
#https://tecadmin.net/bash-special-variables/ nuo ei välttis liity mutta

dqb "b3f0r3 p.076"
dqb "mode= ${mode}"
csleep 1

function dis() {
	dqb "CHAMBERS OF 5HA0 L1N ${1}"
	[ -z "${1}" ] && exit 44
	csleep 1

	${scm} 0755 /etc/network
	${sco} -R root:root /etc/network
	${scm} a+r /etc/network/*

	if [ -f /etc/network/interfaces ] ; then
		if [ ! -h /etc/network/interfaces ] ; then
			${svm} /etc/network/interfaces /etc/network/interfaces.$(date +%F)
		else
			dqb " /e/n/i n0t a l1nk"
		fi
	else
		dqb "/e/n/i n0t f0und"
	fi

	local t
	t=$(echo ${1} | cut -d '/' -f 1 | tr -d -c a-zA-Z)

	if [ -f /etc/network/interfaces.${t} ] ; then
		dqb "LINKS-1-2-3"
		${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
		echo $?		
		csleep 1
	else
		dqb "N0 \$UCH TH1NG A5 /etc/network/interfaces.${t}"
	fi

	${scm} 0555 /etc/network
	[  ${debug} -eq 1 ] && ls -las /etc/network
	csleep 1

	#TEHTY:selvitä mikä kolmesta puolestaan rikkoo dbusin , eka ei, toinen kyllä, kolmas ei, sysctl ei
	if [ -v CONF_iface ] ; then
		if [ ! -z "${CONF_iface}" ] ; then
			${odio} ${sifd} ${CONF_iface}
			csleep 1
	
		#	${odio} ${sifd} -a
			csleep 1

			[ ${debug} -eq 1 ] && ${sifc};sleep 1
			dqb "${sip} link set ${CONF_iface} down"
	
			${sip} link set ${CONF_iface} down
			[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
		fi
	fi
	
	csleep 1
	${odio} sysctl -p
	csleep 1

	dqb "5HAD0W 0F TH3 BA\$T3t D0N3"
}

function part0() {
	dqb "g_doit.common_lib.FART076 ${1}"
	[ -z "${1}" ] && exit 76

	csleep 1
	dis ${1}
	local s

	for s in ${PART175_LIST} ; do
		dqb ${s}
		#HUOM.271125:saisiko tällä tyylillä myös slimin sammutettua? saa, mutta...

		for t in $(find /etc/init.d -name ${s}* ) ; do
			${odio} ${t} stop
			csleep 1
		done

		${whack} ${s}*
	done

	dqb "alm0st d0n3"
	csleep 1
	${whack} nm-applet
	${snt}
	dqb "P.176 DONE"
	csleep 1
}

#150326:miten /proc/cmdline:n lokaaliasetukset vs /e/d/l ja tämän ao. kikkareen jutut

function el_loco() {
	dqb "MI LOCO ${1} , ${2}"
	csleep 1

	if [ ${1} -gt 0 ] ; then
		#uutena seur 2 riviä
		${smr} /etc/timezone
		${smr} /etc/localtime

		${odio} dpkg-reconfigure locales
		${odio} dpkg-reconfigure tzdata
	else
		${odio} locale-gen
	fi

	#pitäisiköhän localtime ja timezone delliä jossain kohtaa jollain ehdolla?

	if [ ${2} -lt 1 ] ; then
		${svm} /etc/default/locale /etc/default/locale.ÅLD
		fasdfasd /etc/default/locale
		csleep 1

		#menisikö vaikka näin? vai pitäisikö oksentaa vasta tuon yhden if-blokin jälkeen?
		#env vai locale minkä oksennukset tdstoon? vissiin env

		env | grep LC >> /etc/default/locale
		env | grep LAN >> /etc/default/locale

		[ ${debug} -eq 1 ] && tail -n 10 /etc/default/locale
		#jos riittäisi 10 riviä
		csleep 1

		cat /etc/timezone
		csleep 1
		reqwreqw /etc/default/locale
	fi

	export LC_TIME
	export LANGUAGE
	export LC_ALL

	if [ ${debug} -gt 0 ] ; then
		env | grep LC
		env | grep LAN
		csleep 5
	fi
}

#140326:tarkkuutta peliin, ao. rivillä oli typo jnkn aikaa
function adieu() {
dqb "AUF W13DERSEHEN"

#	#jnkn ehdon taakse session lahtaamista edelliset rivit?
#
#	${odio} usermod -G devuan,cdrom,floppy,audio,dip,video,plugdev,netdev,tty devuan #,input tämä vai tty?
#	csleep 5
#	groups #ryhmiin kuulumisen muutokset eivät tapahtune ennen uloskirjautumista?
#	csleep 5
#	#140126:aiemmin oli scm ennen usermod, lieneekö järjestyksellä merkitystä
#
#	${scm} g+rw /dev/tty0
#	csleep 1
#	ls -las /dev/tty?
#	csleep 5
#210126:joskohan toimisi ilman näitä kikkailuja?
#	#väärä tapa pakottaa uudelleen_kirjautuminen?
	${whack} xfce4-session
}
#=====================================PART0=========================================================

part0 ${distro}
process_lib ${d}
echo "AFTER PROCESS_LIB";sleep 1

#==================================PART 1============================================================
dqb "mode= ${mode}"
dqb "debug= ${debug}"
[ -v CONF_enforce ] || exit 99

if [ -s ~/xorg.conf.new ] ; then
	if [ ! -s /etc/X11/xorg.conf ] ; then
		${spc} ~/xorg.conf.new /etc/X11/xorg.conf
		reqwreqw /etc/X11/xorg.conf
	fi
fi

if [ -s /etc/sudoers.d/meshuqqah ] || [ -f /.chroot ] || [ ${CONF_enforce} -eq 0 ] ; then
	dqb "BYPASSING pre_enforce()"
	csleep 2
else 
	pre_enforce ${d0}
fi

if [ -f /.chroot ] ; then
	dqb "BYPASSING enforce_access()"
	csleep 2
else 
	enforce_access $(whoami) ${d0}
fi

csleep 2
echo "JUST BEFORE PART1";sleep 1
part1 ${distro} ${d}
[ ${mode} -eq 0 ] && exit
#HUOM.140326:tässä ei vielä alkanut bugittaa

echo "JUST AFTR PRT1";sleep 1
#aivopieru:jtnkin niin että voisi samalla kertaa purkaa paketin ja ajaa tämän skriptin trähän asti. Self-extracting archives?
#KVG "bash here-doc examples"  (olisiko jo katsottu?)

${snt}
csleep 1
dqb "${svm} ${d0}/1c0ns/ \* .desktop ~/Desktop"
csleep 1
${svm} ${d0}/1c0ns/*.desktop ~/Desktop

#===================================================PART 2===================================
#jos tästä hyötyä pulse-kikkareen kanssa: https://wiki.debian.org/PulseAudio#Stuttering_and_audio_interruptions
#TAI vielä parempi?:kts devuanin alsa-ohjeet (https://dev1galaxy.org/viewtopic.php?id=7567) (https://dev1galaxy.org/viewtopic.php?id=6644) (https://wiki.debian.org/ALSA)

c13=0
c14=1

if [ ${mode} -gt 1 ] ; then #nollasta ei tarttisi välittää koska exit aiempana
	if [ -v LCF666 ] ; then
		c13=$(env | grep LC_TIME | grep -c ${LCF666})
		[ $c13 -gt 0 ] && c14=0
		#profit
	else
		echo "NO PREFERRED LC_TIME FOUND" #...ja Sit Jotain?
	fi
fi

el_loco ${c14} ${c13}
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
		adieu
		#HUOM. tässä ei tartte exit jos myöhemmin joka tap
	else
		dqb "SHOULD NAG ABOUT HAMMAD HERE"
	fi

	exit
fi

pre_part2 #ntp-muutokset tarpeellisis tuossa fktiossa vai ei?
c14=$(find ${d} -name '*.deb' | wc -l)

#[ ${c14} -gt 0 ] || CONF_removepkgs=0 #tilap kommentteihin 270226 koska g_pt2_jutut
#... jokohan jo kommenteista 190326? (TODO)

part2 ${CONF_removepkgs} ${CONF_dnsm} ${CONF_iface}
#voisi kai tässä kohta anuo kikialuit palautaa kommenteista (040326)

#===================================================PART 3===========================================================
message

#kokeeksi käskyttämään "imp2 3" tässä kohtaa
#... toimisi kai tuolla toisellakin tavalla muuten mutta pitäisi imp2:sen sha-tarkistuksia vähän laittaa (040326)
#... myös pitäisi olla jotain $d alla että imp2 tekisi jotain
#menkööt toistaiseksi part3 kanssa (040325)
#common_lib.cwfgh() suhteen pitäisi nimittäin tehdä jotain

part3 ${d}
#dqb "JUST BEFORE IMP2 3"
#csleep 10
#${d0}/import2.sh 3 ${d}/f.tar -v

other_horrors
dqb "BEFORE IMP2 r"
csleep 2

if [ ! -f /.chroot ] ; then
	[ -x ${d0}/common_lib.sh ] || echo "chmod +x ${d0}/common_lib.sh | import2.sh q ${d0} ";sleep 5

	${scm} 0555 ${d0}/common_lib.sh
	#toistaiseksi tässä kunnes... Jotain

	${d0}/import2.sh r ${d0} -v
fi

jules
${asy}
dqb "GR1DN BELIALAS KYE"

e_final
e_h $(whoami) ${d0}
echo "KVG:\"how to exit for-loop in bash\" " #TÄSSÄKÖ KUSI PASKAA?
sleep 5

${odio} /opt/bin/tlb.bash ${CONF_dnsm}
${odio} /opt/bin/aftr.bash

${sipt} -L
csleep 1
${scm} 0555 ${d0}/common_lib.sh
#JOKO JO LOPPUISI PURPATUS PRKL
${scm} a-wx $0

#===================================================PART 4(final)==========================================================
if [ ${mode} -eq 2 ] ; then
	echo "time to \$sifu \$CONF_iface or whåtever"
	csleep 1
	adieu
	exit 
fi

#!/bin/bash
mode=2
distro=$(cat /etc/devuan_version)
d0=$(pwd)
[ -z "${distro}" ] && exit 6
debug=0 #1
d=${d0}/${distro} 

#020426:uudelleen_nimeäminen josqs tämän hmistomn tdstoille?

function parse_opts_1() {
	if [ -d ${d0}/${1} ] ; then
		dqb "asdfasd.asdfgh"
	else
		case  "${1}" in
			0|1|2)
				mode=${1}
			;;
			*)
			;;
		esac
	fi
}

function parse_opts_2() {
	dqb "qwertupoy 1 2"
}

function fallback() {
	exit 111
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	[ ${debug} -gt 0 ] && ls -las ${d0}
	exit 55
fi

[ $? -gt 0 ] && exit 56
sleep 1

#https://linuxopsys.com/use-dollar-at-in-bash-scripting
#https://tecadmin.net/bash-special-variables/ nuo ei välttis liity mutta

function dis() {
	[ -z "${1}" ] && exit 44
	[ -z "${2}" ] && echo "SHOULD exit 45"

	${scm} 0755 /etc/network
	${sco} -R root:root /etc/network
	${scm} a+r /etc/network/*

	if [ -f /etc/network/interfaces ] ; then
		if [ ! -h /etc/network/interfaces ] ; then
			${svm} /etc/network/interfaces /etc/network/interfaces.$(date +%F)
		fi	
	fi

	local t
	t=$(echo ${1} | cut -d '/' -f 1 | tr -d -c a-zA-Z) #TARKK PTKL

	if [ -f /etc/network/interfaces.${t} ] ; then
		${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
		echo $?		
		csleep 1
	fi

	${scm} 0555 /etc/network
	[  ${debug} -eq 1 ] && ls -las /etc/network
	csleep 1

	#TEHTY:selvitä mikä kolmesta puolestaan rikkoo dbusin , eka ei, toinen kyllä, kolmas ei, sysctl ei

	if [ ! -z "${2}" ] ; then
		${odio} ${sifd} ${2}
		csleep 1
	
		#${odio} ${sifd} -a
		csleep 1

		[ ${debug} -eq 1 ] && ${sifc};sleep 1
	
		${sip} link set ${2} down
		[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	fi
	
	${odio} sysctl -p
}

function part0() {
	[ -z "${1}" ] && exit 76
	[ -z "${2}" ] && echo "SHOULD exit 78"

	dis ${1} ${2}
	local s
	dqb "смерть шпионам"

	#https://docs.xfce.org/xfce/xfce4-session/advanced
	#https://superuser.com/questions/1222663/how-do-i-use-combine-ssh-agent-forwarding-and-xfce4
	#https://forum.manjaro.org/t/how-to-disable-ssh-agent-autostart/89404
	
	dqb "#VAIH:jospa kokeilisi vähitellen miten xfquery-komennot vaikuttavat? (270426)"
	#... meneekö sinne config.tar.bz2 asti muutokset esim? (TODO:selvitä)	

	xfconf-query -c xfce4-session -p /startup/ssh-agent/enabled -n -t bool -s false
	xfconf-query -c xfce4-session -p /startup/gpg-agent/enabled -n -t bool -s false
	${whack} ssh-agent*

	#060426:tämäkö heittää pihalle ennenaikaisesti? ssh:n kanssa ehkä jotain	
	#2804236:josko ssh-agentin sisältävän paketin voisi poistaa?

	for s in ${PART175_LIST} ; do
		dqb ${s}
		#HUOM.271125:saisiko tällä tyylillä myös slimin sammutettua? saa, mutta...

		for t in $(find /etc/init.d -name "${s}*" ) ; do
			${odio} ${t} stop
			csleep 1
		done

		${whack} ${s}*
	done

	${whack} nm-applet
	${snt}
}

#150326:miten /proc/cmdline:n lokaaliasetukset vs /e/d/l ja tämän ao. kikkareen jutut

function el_loco() {
	if [ ${1} -gt 0 ] ; then
		${smr} /etc/timezone
		${smr} /etc/localtime
		${odio} dpkg-reconfigure locales
		${odio} dpkg-reconfigure tzdata
	else
		${odio} locale-gen
	fi

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
#	pidetäänpä nämä jutut kommenteissa sitä varten että saattuukin tarvitsemaan
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

part0 ${distro} ${CONF_iface}
process_lib ${d}

#==================================PART 1============================================================
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

part1 ${distro} ${d}
[ ${mode} -eq 0 ] && exit

${snt}
${svm} ${d0}/1c0ns/*.desktop ~/Desktop

#===================================================PART 2===================================
#jos tästä hyötyä pulse-kikkareen kanssa: https://wiki.debian.org/PulseAudio#Stuttering_and_audio_interruptions
#TAI vielä parempi?:kts devuanin alsa-ohjeet (https://dev1galaxy.org/viewtopic.php?id=7567) (https://dev1galaxy.org/viewtopic.php?id=6644) (https://wiki.debian.org/ALSA)

c13=0
c14=1

if [ ${mode} -gt 1 ] ; then
	#nollasta ei tarttisi välittää koska exit aiempana
	if [ -v LCF666 ] ; then
		c13=$(env | grep LC_TIME | grep -c ${LCF666})
		#[ $c13 -gt 0 ] && c14=0
		#profit
	fi
fi

#josko sittenkin vain pakottaisi ainakin timezonen sorkinnat joka kerta? kkeillaan
el_loco ${c14} ${c13}
#=========================================================================================

if [ ${mode} -eq 1 ] || [ ${CONF_changepw} -eq 1 ] ; then
	${odio} passwd

	if [ $? -eq 0 ] ; then
		passwd
	fi

	if [ $? -eq 0 ] ; then
		adieu
		#HUOM. tässä ei tartte exit jos myöhemmin joka tap
	fi

	exit
fi

pre_part2
#ntp-muutokset tarpeellisis tuossa fktiossa vai ei?
c14=$(find ${d} -name "*.deb" | wc -l)

#[ ${c14} -gt 0 ] || CONF_removepkgs=0 #tilap kommentteihin 270226 koska g_pt2_jutut
#... jokohan jo kommenteista 190326? (TODO)

part2 ${CONF_removepkgs} ${CONF_dnsm} ${CONF_iface}
#voisi kai tässä kohta anuo kikialuit palautaa kommenteista (040326)

#===================================================PART 3===========================================================
message

#menkööt toistaiseksi part3 kanssa (040325)
#common_lib.cwfgh() suhteen pitäisi nimittäin tehdä jotain?

part3 ${d}
other_horrors

if [ ! -f /.chroot ] ; then
	#[ -x ${d0}/common_lib.sh ] || echo "chmod +x ${d0}/common_lib.sh | import2.sh q ${d0} ";sleep 5
	${scm} 0555 ${d0}/common_lib.sh
	#toistaiseksi tässä kunnes... Jotain
	${d0}/import2.sh r ${d0} -v
fi

jules
${asy}
e_final
e_h $(whoami) ${d0}

if [ -x /opt/bin/mutilatetc.bash ] && [ -v CONF_dnsm ] ; then
	${odio} /opt/bin/mutilatetc.bash ${CONF_dnsm}
fi

#ifup nykyään muuttelee tables-sääntöjä yhdellä jekulla joten ei erikseen tartte käskyttää...

${sipt} -L
csleep 1
${scm} 0555 ${d0}/common_lib.sh
${scm} a-wx $0

#tämä saattaa laukaista pakettien poistelun
${fib}

#===================================================PART 4(final)==========================================================
if [ ${mode} -eq 2 ] ; then
	adieu
	exit 
fi

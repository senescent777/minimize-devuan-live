#!/bin/bash
mode=2
distro=$(cat /etc/devuan_version)
d0=$(pwd)
[ -z "${distro}" ] && exit 6
debug=0 #1
d=${d0}/${distro} 

#020426:uudelleen_nimeäminen josqs tämän hmistomn tdstoille?
#240526:vissiin toimii sudon kautta ok tämä skripti

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
	dqb "g_doit.qwertupoy 1 2"
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

#240526:tämä aiheutti paljon nalkutusta kehitysymp
function dis() {
	dqb "sid $1 ;; $2 ((((("
	[ -z "${1}" ] && exit 44
	[ -z "${2}" ] && echo "SHOULD exit 45"

	dqb "ko.srap"
	csleep 1

	${scm} 0755 /etc/network
	${sco} -R root:root /etc/network
	${scm} a+r /etc/network/*

	dqb "bfore int.faces"

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
	dqb "aftr.int.faces"

	if [ ! -z "${2}" ] ; then
		#TODO?:pitäisi kai huomioida jtnkn että sifd ei välttämättä asetettu
		sifd=/sbin/ifdowm ?
		dqb "${odio} ${sifd} ${2}"	
		csleep 1
		[ -z "${sifd}" ] || ${odio} ${sifd} ${2}
		
		#${odio} ${sifd} -a
		csleep 1

		[ ${debug} -eq 1 ] && ${sifc};sleep 1
	
		${sip} link set ${2} down
		[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	fi
	
	${odio} sysctl -p
	csleep 1
	dqb "d1s.d0n3"
}

function part0() {
	dqb "part0)))( ${1} ;; ${2})(((((("
	[ -z "${1}" ] && exit 76
	[ -z "${2}" ] && echo "SHOULD exit 78"

	dqb "pars.ok"
	csleep 5
	
	dis ${1} ${2}
	local s
	dqb "смерть шпионам"

	#https://docs.xfce.org/xfce/xfce4-session/advanced
	#https://superuser.com/questions/1222663/how-do-i-use-combine-ssh-agent-forwarding-and-xfce4
	#https://forum.manjaro.org/t/how-to-disable-ssh-agent-autostart/89404
	
	dqb "#VAIH:jospa kokeilisi vähitellen miten xfquery-komennot vaikuttavat? (270426)"
	#... meneekö sinne config.tar.bz2 asti muutokset esim?
	#140526:vissiin tdstoon xfce4-session.xml menee tieto että agentit sammuksiin mutta	
	#x-session-manager saattaa liittyä jtnkn

	xfconf-query -c xfce4-session -p /startup/ssh-agent/enabled -n -t bool -s false
	xfconf-query -c xfce4-session -p /startup/gpg-agent/enabled -n -t bool -s false
	${whack} ssh-agent*

	#060426:tämäkö heittää pihalle ennenaikaisesti? ssh:n kanssa ehkä jotain	
	#2804236:josko ssh-agentin sisältävän paketin voisi poistaa?

	#140526:gnome-keyring*. libpam-gnome-keyring liittyvät?
	#kts pkgs_drop jos qsee g_pt2 asjon jölkeen (vissiin ei)

	#TODO:ao. listan mukaiset olisi kiva saada sammutettua myös kehitysymåp eli sudoersin hakkaamista kehiin?
	#... pitäisiköhän koko tämä skripti tunkea sudoersiin sitä vartem?
	
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
	dqb "el_loco ))${1} ; ${2}((((("
	csleep 1

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

pkgcache=$(mktemp -d)
part0 ${distro} ${CONF_iface}
process_lib ${d} ${pkgcache}

#==================================PART 1============================================================
[ -v CONF_enforce ] || exit 99

if [ -s ~/xorg.conf.new ] ; then
	if [ ! -s /etc/X11/xorg.conf ] ; then
		${spc} ~/xorg.conf.new /etc/X11/xorg.conf
		reqwreqw /etc/X11/xorg.conf
	fi
fi

#HUOM. voisi jaksaa ajatella sitäkin että /e/s.d alaisen tdston nimen_muutos vaikuttaa myös g_doit toimintaan?

function pre_enforce() {
	dqb "pre_enforce() "
	[ -z "${1}" ] && exit 98
	[ -d ${1} ] || exit 97
	[ -v mkt ] || exit 99
	dqb "pars_ok"
	csleep 1

	local q
	local f
	q=$(${mkt} -d)
	q=${q}/meshuqqah
	csleep 1
	fasdfasd ${q}
	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 1

	[ -f ${q} ] || exit 33
	#TODO:katso lista läpi että mitä nykyään tarvitaan misssäkin tilanteessa /VED/TOOR/DEFAULT)
	for f in ${CB_LIST1} ; do mangle_s ${f} ${q} ; done

	dqb "BFOR3 testgris"
	csleep 1
	#HUOM:$1/o/b alainen sisältö yulisi tietenkin tarkistaa ennen kopsailua, check_bin hoitaa jälkikäteen?

	if [ "${CONF_env}" == "DEFAULT" ] ; then
		if [ ! -d /opt/bin ] ; then
			${smd} /opt/bin
			[ $? -eq 0 ] || ${odio} ${smd} /opt/bin
		fi
	
		if [ -d ${1}/opt/bin ] ; then
			#tämä mv ok?
			${svm} ${1}/opt/bin/*.bash /opt/bin
			#090326.2:miten /o/b/zxcv ?
			#/o/b oikeudet ja omistajat tulisi jossain asettaa
		fi
	fi

	e_final

	# "semmoinen juttu" 
	if [ "${CONF_env}" == "DEFAULT" ] && [ -d /opt/bin ] ; then
		#1. tämä blokki kai eniten aiheuttaisi ongelmia sqroot-ympstössä?
		#2. o/b sisällön oikeuksia/omistajia varten taisi olla e_final
		#3. changedns.vash: pientä yritystä hukata (exp2 ja update2)

		for f in $(${odio} find /opt/bin -type f -name "*.bash" ) ; do
			mangle_s ${f} ${q}
		done
	fi

	csleep 1

	if [ -s ${q} ] ; then
		csleep 1
		reqwreqw ${q}
		${scm} 0440 ${q}

		#tämä mv ok?
		${svm} ${q} /etc/sudoers.d
		CB_LIST1=""
		unset CB_LIST1
	fi

	q=$(${mkt})
	fasdfasd ${q}
	dinf ${q}
	reqwreqw ${q}
	${scm} 0440 ${q}
	${svm} ${q} /etc/sudoers.d
	csleep 1

	local c4
	c4=0
	csleep 1

	#setup2 mennee vähän päällekkäin ytämän fktion kanssa toiminnallisesti
	if [ -v CONF_dir ] ; then
		c4=$(grep ${CONF_dir} /etc/fstab | wc -l)
	else
		exit 99
	fi

	csleep 1
	#HUOM.261125:typot hyvä pitää minimissä konf-fileissä
	#VAIH:setup2sessa kokeeksi fstab-kikkailut kommentteihin

	if [ ${c4} -lt 1 ] ; then
		csleep 1
		${scm} a+w /etc/fstab
		csleep 1
		${odio} echo "/dev/disk/by-uuid/${CONF_part0} ${CONF_dir} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		csleep 1
		${scm} a-w /etc/fstab
		csleep 1
		[ ${debug} -eq 1 ] && cat /etc/fstab
		csleep 1
	fi

	dqb "pre_enforce() done"
	csleep 1
}

if [ -s /etc/sudoers.d/meshuqqah ] || [ ${CONF_enforce} -eq 0 ] ; then # || [ "${CONF_env}" != "DEFAULT" ]
	dqb "BYPASSING pre_enforce()"
	csleep 2
else 
	pre_enforce ${d0}
fi

if [ "${CONF_env}" != "DEFAULT" ] ; then #240526:saattaa muuttua vielä, nyt näin nalkutuksen minimoinnin takia
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
c14=1
c13=0

if [ ${mode} -gt 1 ] ; then
	#nollasta ei tarttisi välittää koska exit aiempana
	if [ -v LCF666 ] ; then
		c13=$(env | grep LC_TIME | grep ${LCF666} | wc -l)
		 #barm vuoksi näin
		[ $c13 -gt 0 ] && c14=0
	

		#profit
	fi
fi

#josko sittenkin vain pakottaisi ainakin timezonen sorkinnat joka kerta? kokeillaan
el_loco ${c14} ${c13}
#250526:c13 vai jokin muu mikä aiheuttaa lokaalien generoinnin?

#=========================================================================================
#1§405426:vissiin "mode 1"-kiukuttelut toistaiseksi ohi kehitysympstössä

if [ ${mode} -eq 1 ] || [ ${CONF_changepw} -eq 1 ] ; then
	${odio} passwd

	if [ $? -eq 0 ] ; then
		passwd
	fi

	if [ $? -eq 0 ] ; then
		adieu
		#HUOM. tässä ei tartte exit jos myöhemmin joka tap
	fi

	#VAIH:jos C_env== VED ni common_lib +  root.conf omistajaksi root, jälkimmäisen saa vain omistaja lukea, tälle tdstolle vain ajo-oikeus kaikille
	if [ "${CONF_env}" == "VED" ] ; then
		#... aka "hands off" (qhan omega)
		${sco} 0:0 ${d0}/*.conf
		${scm} 0444 ${d0}/*.conf
		#${sca} +ui ${d0}/*.conf

		${sco} 0:0 ${0}
		${scm} 0444 ${0}
		#${sca} +ui ${0}
	fi

	exit
fi

pre_part2

if [ "${CONF_env}" == "DEFAULT" ] ; then
	#ntp-muutokset tarpeellisis tuossa fktiossa vai ei?
	c14=$(find ${d} -name "*.deb" | wc -l)

	#040526:kokeeksi ao. rivi pois kommenteista, mitä tapahtuu
	#... pitäisi kai nollaamisessa huomioida myös /.chroot
	[ ${c14} -gt 0 ] || CONF_removepkgs=0
fi

part2 ${CONF_removepkgs} ${CONF_dnsm} ${CONF_iface}

#===================================================PART 3===========================================================
message

#menkööt toistaiseksi part3 kanssa (0403265)
#common_lib.cwfgh() suhteen pitäisi nimittäin tehdä jotain?

part3 ${d} ${pkgcache}
other_horrors
dqb "AFTER THE HORROR"
csleep 1

#if [ ! -f /.chroot ] ; then #ehto pois jatkossa vai ei?
if [ "${CONF_env}" == "DEFAULT" ] ; then
	#[ -x ${d0}/common_lib.sh ] || echo "chmod +x ${d0}/common_lib.sh | import2.sh q ${d0} ";sleep 5
	${scm} 0555 ${d0}/common_lib.sh

	${d0}/import2.sh r ${d0} -v
	echo $?
	csleep 3
fi

dqb "PR0F IMPORT DONE?"
csleep 5

jules
${asy}
e_final
e_h $(whoami) ${d0}

${sco} 0:0 /opt/bin/*
${scm} 0400 /opt/bin/zxcv*

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

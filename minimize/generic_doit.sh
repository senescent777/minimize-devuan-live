#!/bin/bash

mode=2
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
d=~/Desktop/minimize/${distro} 
[ z"${distro}" == "z" ] && exit 6
debug=0 #1

if [ -d ${d} ] && [ -s ${d}/conf ]; then
	. ${d}/conf
else
	echo "CONFIG MISSING"
	exit 55
fi

function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			mode=${1}
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

. ~/Desktop/minimize/common_lib.sh
echo $?
csleep 3
#HUOM.23525:pitäisiköhän tässä kohtaa jo keskeyttää suoritus jos includointi ei onnistu?

#https://linuxopsys.com/use-dollar-at-in-bash-scripting
#https://tecadmin.net/bash-special-variables/ nuo ei välttis liity mutta

#=====================================PART0=========================================================
dqb "b3f0r3 p.076"
dqb "mode= ${mode}"
csleep 1
part076
#exit

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
	#HUOM.22525:tap mode=0 pitäisi kutsua check_binaries ja sitä kautta pakottaa tablesin asennus... puuttuuko .deb?
else
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING"
	exit 111
fi

#==================================PART 1============================================================

dqb "mode= ${mode}"
csleep 2

#HUOM.13525:pre_e:tä tarttisi ajaa vain kerran, jossain voisi huomioida /e/s.d/m olemassaolon
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
enforce_access ${n}

part1 ${distro} 
[ ${mode} -eq 0 ] && exit

${snt} #HUOM.14525:oli tässä ennen: part175
csleep 1

#jotain perusteellisempia testejä chimaeran kanssa sitten mikäli jksaa sitä kirjautumisongelmaa (josko selvittelisi korjaamista?)
#23525: $0 -v 0 toimii, $0 -v toimii, pt2 kun fiksaa parsetuksen, list175 juttujen kanssa vaikeuksia poistaa pak(conf syynä)
#import2/export2 - testaukset sittenq chimaeraa varten päivityspaketit saatavilla
#===================================================PART 2===================================

#HUOM. välillä mode=0 - testi (22525 viimeksi)

#jos tästä hyötyä pulse-kikkareen kanssa: https://wiki.debian.org/PulseAudio#Stuttering_and_audio_interruptions
function el_loco() {
	dqb "MI LOCO ${1} , ${2}"
	csleep 1
	
	#ennen vai jälkeen "dpkg reconfig"-blokin tämä?
	if [ -s /etc/default/locale.tmp ] ; then
		. /etc/default/locale.tmp

		export LC_TIME
		export LANGUAGE
		export LC_ALL
	fi

	if [ ${2} -lt 1 ]; then
		${scm} a+w /etc/default/locale
		csleep 1

		#/e/d/l voi kasvaa isoksikin näin...
		${odio} cat /etc/default/locale.tmp >> /etc/default/locale
		cat /etc/default/locale
		csleep 1

		cat /etc/timezone
		csleep 1
		${scm} a-w /etc/default/locale

#		#kuuluuko debian-johdannaisilla kalustoon tämä? pitäisikö luoda ensin?
#		#... systemd-maailman juttuja?		
#		echo " stuff > /etc/locale.conf"
#
#		if [ ! -s  /etc/locale.conf ] ; then
#			${odio} touch /etc/locale.conf
#		fi
#
#		${scm} a+w /etc/locale.conf
#		csleep 1
#		
#		grep LC_TIME /etc/default/locale >> /etc/locale.conf
#
#		csleep 1
#		${scm} a-w /etc/locale.conf
#		cat /etc/locale.conf
#		csleep 1
	fi

	if [ ${1} -gt 0 ] ; then #HUOM.9525: /e/d/l kopsailu ei välttämättä riitä, josko /e/timezone mukaan kanssa?
		#client-side session_expiration_checks can be a PITA
		${odio} dpkg-reconfigure locales
		
		#https://tecadmin.net/change-timezone-on-debian/ miten tuo method 2?
		${odio} dpkg-reconfigure tzdata

		#ei vissiin Devuanissa tämmöistä: https://www.tecmint.com/set-time-timezone-and-synchronize-time-using-timedatectl-command/
		#https://pkginfo.devuan.org/cgi-bin/policy-query.html?c=package&q=timedatectl&x=submit
	else
		${odio} locale-gen #oli aiemmin ennen if-blokkia
	fi

	#joskohan kutsuvassa koodissa -v - tark riittäisi toistaiseksi
	if [ ${2} -lt 1 ] && [ ${debug} -eq 1 ] ; then
		ls -las /etc/default/lo*
		csleep 1
	fi

	dqb "DN03"
	csleep 1
}

c14=0
c13=0
[ ${mode} -eq 1 ] && c14=1

if [ -v LCF666 ] ; then
	#HUOM.16525:vissiin urputti kska lcf666 puuttuu konffista, palautettu
	c13=$(grep -v '#' /etc/default/locale | grep LC_TIME | grep -c ${LCF666})
else
	echo "555"
fi

csleep 2
[ ${c13} -lt 1 ] && c14=1
el_loco ${c14} ${c13}

if [ ${mode} -eq 1 ] || [ ${changepw} -eq 1 ] ; then 
	dqb "R (in 2 secs)"
	csleep 2
	${odio} passwd

	#miksi tähän ei mennä? vai mennäänkö? ilmeinen syy?
	if [ $? -eq 0 ] ; then
		dqb "L (in 2 secs)"
		csleep 2
		passwd
	fi

	if [ $? -eq 0 ] ; then
		${whack} xfce4-session
		#HUOM. tässä ei tartte jos myöhemmin joka tap
	else
		dqb "SHOULD NAG ABOUT WRONG PASSWD HERE"
	fi

	exit #varm. vuoksi kesk. suor. jos salakala tyritty
fi

c14=$(find ${d} -name '*.deb' | wc -l)
[ ${c14} -gt 0 ] || removepkgs=0

part2_pre ${removepkgs}
#part2 ${removepkgs} #takaisin jos 2_5 pykii
part2_5 ${removepkgs}

#===================================================PART 3===========================================================
message
part3 ${d} ${dnsm}
other_horrors

#tai sitten käskytetään:import2 (TODO?)
[ -s ~/Desktop/minimize/config.tar.bz2 ] && ${srat} -C / -jxf ~/Desktop/minimize/config.tar.bz2
csleep 2

if [ -x ~/Desktop/minimize/profs.sh ] ; then
	. ~/Desktop/minimize/profs.sh

	#HUOM.21525:miksi varten ilm suoraan /tmp alle firefox-esr? tarttisko tehdä jotain?
	q=$(mktemp -d)
	dqb "${srat} -C ${q} ... 1n 1 s3c5s"
	csleep 1
	tgt=~/Desktop/minimize/fediverse.tar

	if [ -s ${tgt} ] ; then	
		${srat} -C ${q} -xvf ${tgt}

		dqb "${srat} d0me"
		csleep 1

		imp_prof esr ${n} ${q}
	else
		dqb "NO SUCH THING AS ${tgt}"
	fi

	csleep 1
fi

jules
${asy}
dqb "GR1DN BELIALAS KYE"

${scm} 0555 ~/Desktop/minimize/changedns.sh
${sco} root:root ~/Desktop/minimize/changedns.sh
${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}
${sipt} -L
csleep 2

${scm} a-wx $0
#===================================================PART 4(final)==========================================================

if [ ${mode} -eq 2 ] ; then
	echo "time to ${sifu} ${iface} or whåtever"
	csleep 1
	${whack} xfce4-session
 	exit 
fi

${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}

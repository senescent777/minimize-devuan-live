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
else
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING"
	exit 111
fi

#==================================PART 1============================================================

dqb "mode= ${mode}"
csleep 5

#HUOM.13525:pre_e:tä tarttisi ajaa vain kerran, jossain voisi huomioida /e/s.d/m olemassaolon
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
enforce_access ${n}

part1 ${distro} 
[ ${mode} -eq 0 ] && exit

${snt} #HUOM.14525:oli tässä ennen: part175
csleep 3

#jotain perusteellisempia testejä chimaeran kanssa sitten mikäli jksaa sitä kirjautumisongelmaa (josko selvittelisi korjaamista?)
#===================================================PART 2===================================
#HUOM.21525:tekisiköhän jotain daedaluksen audiomixrin suhteen? pois kokonaan tai asetusten import/export

function el_loco() {
	dqb "MI LOCO ${1} , ${2}"
	csleep 3
	
	#ennen vai jälkeen "dpkg reconfig"-blokin tämä?
	if [ -s /etc/default/locale.tmp ] ; then
		. /etc/default/locale.tmp

		export LC_TIME
		export LANGUAGE
		export LC_ALL
	fi

	if [ ${2} -lt 1 ]; then
		${scm} a+w /etc/default/locale
		csleep 3

		#/e/d/l voi kasvaa isoksikin näin...
		${odio} cat /etc/default/locale.tmp >> /etc/default/locale
		cat /etc/default/locale
		csleep 3

		cat /etc/timezone
		csleep 3

		${scm} a-w /etc/default/locale

		#kuuluuko debian-johdannaisilla kalustoon tämä? pitäisikö luoda ensin?
		echo " stuff > /etc/locale.conf"

		if [ ! -s  /etc/locale.conf ] ; then
			${odio} touch /etc/locale.conf
		fi

		${scm} a+w /etc/locale.conf
		csleep 3
		
		grep LC_TIME /etc/default/locale >> /etc/locale.conf

		csleep 3
		${scm} a-w /etc/locale.conf
		cat /etc/locale.conf
		csleep 3
	fi

	${odio} locale-gen

	#joskohan tarkistus pois jatkossa?
	if [ ${1} -gt 0 ] ; then #HUOM.9525: /e/d/l kopsailu ei välttämättä riitä, josko /e/timezone mukaan kanssa?
		#client-side session_expiration_checks can be a PITA
		${odio} dpkg-reconfigure locales
		
		#suattaapi olla olematta tuo --oprio tuolla koennolla tuatanoinnii vuan mitenkä ympäristömuuttuja vaikuttaa?
		#ekalla yrityksellä ei toivottua lopputulosta myöskään pelkällä ympäristömjalla vaikka ncurses-vaihe ohitettiinkin		
		${odio} dpkg-reconfigure tzdata
	fi

	#joskohan kutsuvassa koodissa -v - tark riittäisi toistaiseksi
	if [ ${2} -lt 1 ]; then
		ls -las /etc/default/lo*
		csleep 3
	fi

	dqb "DN03"
	csleep 2
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

csleep 6
[ ${c13} -lt 1 ] && c14=1
el_loco ${c14} ${c13}

if [ ${mode} -eq 1 ] || [ ${changepw} -eq 1 ] ; then 
	dqb "R (in 3 secs)"
	csleep 3
	${odio} passwd

	#miksi tähän ei mennä? vai mennäänkö? ilmeinen syy?
	if [ $? -eq 0 ] ; then
		dqb "L (in 3 secs)"
		csleep 3
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
message #voi muuttua turhaksi jatkossa
part3 ${d} ${dnsm}
other_horrors #HUOM.21525:varm. vuoksi jos dpkg...
[ -s ~/Desktop/minimize/xfce.tar ] && ${srat} -C / -xf ~/Desktop/minimize/xfce.tar
csleep 5

#tai sitten käskytetään:import2 (jatkossa -> part3_post ?)
if [ -x ~/Desktop/minimize/profs.sh ] ; then
	. ~/Desktop/minimize/profs.sh

	#HUOM.21525:miksi caten ilm suoraan /tmp alle firefox-esr? tarttisko tehdä jotain?
	q=$(mktemp -d)
	dqb "${srat} -C ${q} ... 1n 3 s3c5s"
	csleep 3
	tgt=~/Desktop/minimize/fediverse.tar

	if [ -s ${tgt} ] ; then	
		${srat} -C ${q} -xvf ${tgt}

		dqb "${srat} d0me"
		csleep 3

		imp_prof esr ${n} ${q}
	else
		dqb "NO SUCH THING AS ${tgt}"
	fi

	csleep 3
fi

jules
${asy}
dqb "GR1DN BELIALAS KYE"

${scm} 0555 ~/Desktop/minimize/changedns.sh
${sco} root:root ~/Desktop/minimize/changedns.sh
${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}
${sipt} -L
csleep 6

${scm} a-wx $0
#===================================================PART 4(final)==========================================================

if [ ${mode} -eq 2 ] ; then
	echo "time to ${sifu} ${iface} or whåtever"
	csleep 2
	${whack} xfce4-session
 	exit 
fi

${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}

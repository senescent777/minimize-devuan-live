#!/bin/bash

mode=2
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
d=~/Desktop/minimize/${distro} #alkuosa dirname:lla jatkossa?
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
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro} #HUOM.25425:oliko tämän kanssa jotain?
enforce_access ${n}

part1 ${distro} 
[ ${mode} -eq 0 ] && exit

${snt}
csleep 1

#jotain perusteellisempia testejä chimaeran kanssa sitten mikäli jksaa sitä kirjautumisongelmaa (josko selvittelisi korjaamista?)
#23525: $0 -v 0 toimii, $0 -v toimii, pt2 kun fiksaa parsetuksen, list175 juttujen kanssa vaikeuksia poistaa pak(conf syynä)
#import2/export2 - testaukset sittenq saa aikaiseksi (e2 onnistuu jotain paketteja tekemään ainakin)
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

		#export2 ja update sisältää nykyään rajauksen tdstonimiin tähän liittyen
		${odio} cat /etc/default/locale.tmp >> /etc/default/locale
		cat /etc/default/locale
		csleep 1

		cat /etc/timezone
		csleep 1
		${scm} a-w /etc/default/locale
	fi

	if [ ${1} -gt 0 ] ; then
		${odio} dpkg-reconfigure locales
		${odio} dpkg-reconfigure tzdata
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
part2_5 ${removepkgs}

#===================================================PART 3===========================================================
message
part3 ${d} ${dnsm}
other_horrors

#tai sitten käskytetään:import2 (TODO?)
if [ -s ${PREFIX}/config.tar.bz2 ] ; then #prefix vai $d?
	${srat} -C / -jxf ${PREFIX}/config.tar.bz2
	#${NKVD} ${PREFIX}/config.tar.bz2 tämä saa olla toistaiseksi
fi

${NKVD} ${PREFIX}/config.tar #tämä vie turhaan tilaa, pois
csleep 2

if [ -x ~/Desktop/minimize/profs.sh ] ; then
	. ~/Desktop/minimize/profs.sh

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

${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh
${odio} ${PREFIX}/changedns.sh ${dnsm} ${distro}
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

${odio} ${PREFIX}/changedns.sh ${dnsm} ${distro}

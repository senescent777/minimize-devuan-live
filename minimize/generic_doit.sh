#!/bin/bash

mode=2
distro=$(cat /etc/devuan_version)
d0=$(pwd)
echo "d0=${d0}"
[ z"${distro}" == "z" ] && exit 6
debug=0
d=${d0}/${distro}

#VAIH:generic_x - skriptit toimimaan cgroot-ympäristössä, vissiinkin $d täytyisi muuttaa
#... jokin else-haara tuohon alle

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
			if [ -d ${d0}/${1} ] ; then
				distro=${1}
				#HUOM.22725:tässä voisi ladata uudestaan conf?
			else
				mode=${1}
			fi
		;;
	esac
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
part076 ${distro}

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING OR NOT EXECUTABLE"
	exit 111
fi

#==================================PART 1============================================================

dqb "mode= ${mode}"
csleep 1

#HUOM.21725:laitettu konfissa enforce nollaksi jotta ei jäädä junnamaan sudo-juttujen kanssa
if [ -s /etc/sudoers.d/meshuggah ] || [ -f /.chroot ] ; then
	dqb "BYPASSING pre_enforce()"
	csleep 3
else 
	if [ ${enforce} -eq 1 ] ; then
		pre_enforce ${d0}
	fi
fi

#HUOM. jälkimm ehto voisi mennä toisinkin, esim /r/l/m/p olemassaolo

if [ -v veto ] || [ -f /.chroot ] ; then
	dqb "BYPASSING enforce_access()"
	csleep 3
else 
	enforce_access ${n} ${d0}
fi

csleep 3
part1 ${distro} 
[ ${mode} -eq 0 ] && exit

${snt}
csleep 1

dqb "${svm} ${d0}/1c0ns/ * .desktop ~/Desktop"
csleep 1
${svm} ${d0}/1c0ns/*.desktop ~/Desktop
#===================================================PART 2===================================

#jos tästä hyötyä pulse-kikkareen kanssa: https://wiki.debian.org/PulseAudio#Stuttering_and_audio_interruptions
function el_loco() {
	dqb "MI LOCO ${1} , ${2}"
	csleep 1

	if [ -s /etc/default/locale.tmp ] ; then
		. /etc/default/locale.tmp

		export LC_TIME
		export LANGUAGE
		export LC_ALL
	fi

	if [ ${2} -lt 1 ]; then
		${scm} a+w /etc/default/locale
		csleep 1

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
	c13=$(grep -v '#' /etc/default/locale | grep LC_TIME | grep -c ${LCF666})
else
	echo "555"
fi

csleep 1
[ ${c13} -lt 1 ] && c14=1
el_loco ${c14} ${c13}

if [ ${mode} -eq 1 ] || [ ${changepw} -eq 1 ] ; then 
	dqb "R (in 2 secs)"
	csleep 1
	${odio} passwd

	if [ $? -eq 0 ] ; then
		dqb "L (in 2 secs)"
		csleep 1
		passwd
	fi

	if [ $? -eq 0 ] ; then
		${whack} xfce4-session
		#HUOM. tässä ei tartte jos myöhemmin joka tap
	else
		dqb "SHOULD NAG ABOUT WRONG PASSWD HERE"
	fi

	exit
fi

#HUOM.2:pitäisikö huomioida myös e.tar tuossa alla jotenkin? ja miksi?
pre_part2

c14=$(find ${d} -name '*.deb' | wc -l)
[ ${c14} -gt 0 ] || removepkgs=0
part2_5 ${removepkgs} ${dnsm}

#===================================================PART 3===========================================================
message
part3 ${d} ${dnsm}
other_horrors

if [ -s ${d0}/config.tar.bz2 ] ; then
	${srat} -C / -jxf ${d0}/config.tar.bz2
fi

${NKVD} ${d0}/config.tar
csleep 1

#tai sitten käskytetään:import2 (TODO?)
if [ -x ${d0}/profs.sh ] ; then
	. ${d0}/profs.sh

	q=$(mktemp -d)
	dqb "${srat} -C ${q} ... 1n 1 s3c5s"
	csleep 1
	tgt=${d0}/fediverse.tar #VAIH:jotain tarttis edelleen tehdä tälle?

	if [ -s ${tgt} ] ; then	
		${srat} -C ${q} -xvf ${tgt}

		dqb "${srat} d0me"
		csleep 1

		imp_prof esr ${n} ${q}
		dqb "NO SUCH THING AS ${tgt}"
	fi

	csleep 1
fi

jules
${asy}
dqb "GR1DN BELIALAS KYE"

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

${sipt} -L
csleep 1

${scm} a-wx $0
#===================================================PART 4(final)==========================================================

if [ ${mode} -eq 2 ] ; then
	echo "time to ${sifu} ${iface} or whåtever"
	csleep 1
	${whack} xfce4-session
 	exit 
fi

#${odio} ${d0}/changedns.sh ${dnsm} ${distro} roistaiseksi jemmaan

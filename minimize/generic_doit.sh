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
	dqb "parseopts_2 ${1} ${2}"

#	case "${1}" in
#		-v|--v) #tämä vähitellen -> GPO() (joko jo 101225?)
#			debug=1
#		;;
#		*)
			#onkohan hyvä näin?

			if [ -d ${d0}/${1} ] ; then
				distro=${1}
			else
				mode=${1}
			fi
		;;
#	esac
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

#291125:ni3mämistä jos vähän miettisi ao. ja 2_5 suhteen ?
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

if [ -s /etc/sudoers.d/meshuggah ] || [ -f /.chroot ] || [ ${enforce} -eq 0 ] ; then
	dqb "BYPASSING pre_enforce()"
	csleep 3
else 
	pre_enforce ${d0}
fi

if [ -f /.chroot ] ; then
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
dqb "${svm} ${d0}/1c0ns/ \* .desktop ~/Desktop"
csleep 1
${svm} ${d0}/1c0ns/*.desktop ~/Desktop

#===================================================PART 2===================================
#jos tästä hyötyä pulse-kikkareen kanssa: https://wiki.debian.org/PulseAudio#Stuttering_and_audio_interruptions
#271125_/etc/default/locale.tmp: line 1: warning: setlocale: LC_TIME: cannot change locale (fi_FI.UTF-8): No such file or directory

function el_loco() {
	dqb "MI LOCO ${1} , ${2}"
	csleep 1

	if [ -s /etc/default/locale.tmp ] ; then
		. /etc/default/locale.tmp

		export LC_TIME
		export LANGUAGE
		export LC_ALL
	fi

	#HUOM.27725:sq-chroot-ymp perl valittaa LANGUAGE ja ALL , voisi tehdä jotain (vielä opngelma?)
	
	if [ ${2} -lt 1 ]; then
		${scm} a+w /etc/default/locale
		csleep 1
		${odio} cat /etc/default/locale.tmp >> /etc/default/locale

		[ ${debug} -eq 1 ] && tail -n 10 /etc/default/locale
		#jos riittäisi 10 riviä
		csleep 1

		cat /etc/timezone
		csleep 1
		${scm} a-w /etc/default/locale
	fi

	if [ ${1} -gt 0 ] ; then
		${odio} dpkg-reconfigure locales
		${odio} dpkg-reconfigure tzdata
	else
		${odio} locale-gen
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
#TODO:el_locon tai c13/c14 kanssa jokin ongelma?, korjaa jos ed elleen? LCF666 saattaa liittyä
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

pre_part2
c14=$(find ${d} -name '*.deb' | wc -l)
[ ${c14} -gt 0 ] || removepkgs=0
part2_5 ${removepkgs} ${dnsm} ${iface}

#===================================================PART 3===========================================================
message

#291125:kokeeksi käskyttämään "imp2 3" tässä kohtaa?
part3 ${d}
other_horrors

dqb "BEFORE IMP2"
csleep 5

#101225:toimi ainakin kerran, jospa tilaäinen ongelma exp2 puolella?
if [ ! -f /.chroot ] ; then
	${d0}/import2.sh r ${d0} -v #2. ja 3. param. turhia?
fi

jules
${asy}
dqb "GR1DN BELIALAS KYE"

#101225;suattaapi olla että common_lib.sh ajo-oikeuden poistaja löytyi vuan suattaapi ettei
for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

${sipt} -L
csleep 1
${scm} 0555 ${d0}/common_lib.sh #JOKO JO LOPPUISI PURPATUS PRKL
${scm} a-wx $0
#===================================================PART 4(final)==========================================================

if [ ${mode} -eq 2 ] ; then
	echo "time to ${sifu} ${iface} or whåtever"
	csleep 1
	${whack} xfce4-session
 	exit 
fi

#${odio} ${d0}/changedns.sh ${dnsm} ${distro} röistaiseksi jennaan
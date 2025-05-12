#!/bin/bash

mode=2
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
d=~/Desktop/minimize/${distro} 
[ z"${distro}" == "z" ] && exit 6
debug=1

if [ -d ${d} ] && [ -s ${d}/conf ]; then
	. ${d}/conf
else
	echo "CONFIG MISSING"; exit 55
fi

. ~/Desktop/minimize/common_lib.sh

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING"
	exit 111
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

function check_params() {
	case ${debug} in
		0|1)
			dqb "ko"
		;;
		*)
			echo "MEE HIMAAS LEIKKIMÄÄN"
			exit 4
		;;
	esac
}

#VAIH:->g_doit (myös testaus että molemmat salakalat saadaan vaihd)
#HU0OM12525:oli tilanne että g_doit ei löytänyt tätä, toivottavasti menee phi
function vommon() {
dqb "R (in 3 secs)"; csleep 3
${odio} passwd

if [ $? -eq 0 ] ; then
dqb "L (in 3 secs)"; csleep 3
passwd
fi

if [ $? -eq 0 ] ; then
${whack} xfce4-session
#HUOM. tässä ei tartte jos myöhemmin joka tap
else
dqb "SHOULD NAG ABOUT WRONG PASSWD HERE"
fi

exit
}

#==================================PART 1============================================================

if [ $# -gt 0 ] ; then
	for opt in $@ ; do parse_opts_1 $opt ; done
fi

check_params 
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
enforce_access ${n}
 
part1 ${distro} 
#HUOM.190325:part_1_5sessa oli bugi, u+w ei vaan riitä
[ ${mode} -eq 0 ] && exit
part175
part1_post

#TODO:testit chmaeran kanssa, paketit pois ja , let's find out

#===================================================PART 2===================================
#VAIH: josko pakottaisi lokaaliasetukset ehdolla mode==1 ? sen lisäksi että LC_TIME-ehto
c14=0
[ ${mode} -eq 1 ] && c14=1
c13=$(grep -v '#' /etc/default/locale  | grep LC_TIME | grep -c ${LCF666})
[ ${c13} -lt 1 ] && c14=1
el_loco ${c14}

if [ ${mode} -eq 1 ] || [ ${changepw} -eq 1 ] ; then 
	vommon
	exit #varm. vuoksi kesk. suor. jos salakala tyritty
fi

c14=$(find ${d} -name '*.deb' | wc -l)
[ ${c14} -gt 0 ] || removepkgs=0

part2_pre ${removepkgs}
part2 ${removepkgs}

#===================================================PART 3===========================================================
message #voi muuttua turhaksi jatkossa

#HUOM.10525:jossain näillä main oli nalkutusta, ilmeinen korjaus tehty
pre_part3 ${d}
pr4 ${d}
part3 ${d}

[ -s ~/Desktop/minimize/xfce.tar ] && ${srat} -C / -xf ~/Desktop/minimize/xfce.tar
csleep 5

#tai sitten käskytetään:import2 (jatkossa -> part3_post ?)
if [ -x ~/Desktop/minimize/profs.sh ] ; then
	. ~/Desktop/minimize/profs.sh

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

part3_post
${scm} a-wx $0
#===================================================PART 4(final)==========================================================

if [ ${mode} -eq 2 ] ; then
	echo "time to ${sifu} ${iface} or whåtever"
	csleep 5
	${whack} xfce4-session
 	exit 
fi

${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}

#!/bin/bash
distro=$(cat /etc/devuan_version)
debug=0 #1
d="" #$(dirname $0)
loose=1
PREFIX=~/Desktop/minimize #josqo tähän se dirname?

function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
		#tarvisiko tähän sen distron asettamisen?
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}


. ${PREFIX}/common_lib.sh
[ $? -gt 0 ] && exit 7
[ -z ${distro} ] && exit 8
d=${PREFIX}/${distro}
 
[ -d ${d} ] || exit 9
[ -s ${d}/conf ] && . ${d}/conf
[ -s ${d}/lib.sh ] && . ${d}/lib.sh #mihin tuota taas tarvittiinkaan? kutsumaan check_bin varmaankin

${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh
${fib}

dqb "a-e"
csleep 2
#${fib} #jos kerta riittäisi

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_pre 1
	part2_5 1
fi

#VAIH:tähän sitten jotain, tai siis $dustro/lib, tässä kutsutaan
t2p
${whack} xfce4-session

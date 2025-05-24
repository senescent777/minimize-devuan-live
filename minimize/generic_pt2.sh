#!/bin/bash
distro=$(cat /etc/devuan_version)
debug=1 #HUOM.24525:pientä laittoa vielä komentorivioptioiden kanssa
d="" #$(dirname $0)
loose=1
PREFIX=~/Desktop/minimize #josqo tähän se dirname?

#HUOM.24525:meneekö -v perille asti? erit. wrapperin kautta? let's find out?

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function parse_opts_1() {
	echo "gp2.po1( ${1} )"

	case ${1} in
		-v|--v)
			debug=1
		;;
	esac

	#tarvisiko yo.caseen sen distron asettamisen?
}

function parse_opts_2() {
	dqb "gp2.parseopts_2 ${1} ${2}"
}

if [ -x ${PREFIX}/common_lib.sh ] ; then
	. ${PREFIX}/common_lib.sh
	[ $? -gt 0 ] && exit 7
else
	echo "COMMON LIB NOT FOUND"
	exit 11
fi

[ -z ${distro} ] && exit 8
d=${PREFIX}/${distro}
#jos ei muuten lähde niin kopsaa jutut sieltä mistä toimii tai korjoita tyhjästä uusiksi koko paska
[ -d ${d} ] || exit 9
[ -s ${d}/conf ] && . ${d}/conf
[ -x ${d}/lib.sh ] && . ${d}/lib.sh #mihin tuota taas tarvittiinkaan? kutsumaan check_bin varmaankin

${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh
${fib}

dqb "d=${d}"
echo "debug=${debug}"
dqb "distro=${distro}"
dqb "removepkgs=${removepkgs}"
#exit 10

dqb "a-e"
csleep 2

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_pre 1
	part2_5 1
fi

#VAIH:tähän sitten jotain, tai siis $dustro/lib, tässä kutsutaan
t2p
${whack} xfce4-session

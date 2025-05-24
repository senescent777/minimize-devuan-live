#!/bin/bash
d=$(dirname $0)
[ -s ${d}/conf ] && . ${d}/conf

function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

. ~/Desktop/minimize/common_lib.sh
[ -s ${d}/lib.sh ] && . ${d}/lib.sh #mihin tuota taas tarvittiinkaan? kutsumaan check_bin varmaankin

${scm} 0555 ~/Desktop/minimize/changedns.sh
${sco} root:root ~/Desktop/minimize/changedns.sh
${fib}

dqb "a-e"
csleep 2
${fib}

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_pre 1
	part2_5 1 #HUOM.15425: oli part2 1
fi

#TODO:tähän sitten jotain, tai siis $dustro/lib, tässä kutsutaan
#!/bin/bash
d=$(dirname $0)
mode=2

[ -s ${d}/conf ] && . ${d}/conf
. ~/Desktop/minimize/common_lib.sh

if [ -s ${d}/lib.sh ] ; then
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

#===================================================PART 2===================================
part2_pre #TODO:tähän tuon ao. blokin lisäksi vommon():in kutsu kahdella ehdolla (kts daedalus/doit6)
c=$(find ${d} -name '*.deb' | wc -l)
[ ${c} -gt 0 ] || removepkgs=0

#TODO:kuuluisi kai part2_pre()
if [ ${removepkgs} -eq 1 ] ; then
	${sharpy} libopts25
	${sharpy} rpc* nfs* 
fi

part2 ${removepkgs}
#===================================================PART 3===========================================================
message
pre_part3 ${d}
pr4 ${d}
part3 ${d}

if [ -x ~/Desktop/minimize/profs.sh ] ; then
	[ -x ~/Desktop/minimize/middleware.sh ] && . ~/Desktop/minimize/middleware.sh 
	. ~/Desktop/minimize/profs.sh
	prepare ~/Desktop/minimize/someparam.tar
	copyprof esr ${n} ~/Desktop/minimize/someparam.tar
fi

part3_post
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
	csleep 5
	${whack} xfce4-session
 	exit 
fi

${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}
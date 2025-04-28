#!/bin/bash
d=$(dirname $0)
mode=2

distro=$(cat /etc/devuan_version)
n=$(whoami)
#TODO:n,distro->common_lib?

[ -s ${d}/conf ] && . ${d}/conf
. ~/Desktop/minimize/common_lib.sh

if [ -s ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING"
	exit 111
fi

#HUOM.220325:parsetuS kunnossa
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

n=$(whoami)
#==================================PART 1============================================================

if [ $# -gt 0 ] ; then
	for opt in $@ ; do parse_opts_1 $opt ; done
fi

check_params 
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
enforce_access ${n} 
part1 ${distro} 
[ ${mode} -eq 0 ] && exit

for s in avahi-daemon bluetooth cups cups-browsed exim4 nfs-common network-manager ntp mdadm saned rpcbind lm-sensors dnsmasq stubby ; do
	${odio} /etc/init.d/${s} stop
	sleep 1
done

dqb "shutting down some services (4 real) in 3 secs"
sleep 3 

${whack} cups*
${whack} avahi*
${whack} dnsmasq*
${whack} stubby*
${whack} nm-applet
csleep 3

#===================================================PART 2===================================
c=$(find ${d} -name '*.deb' | wc -l)
[ ${c} -gt 0 ] || removepkgs=0

if [ ${removepkgs} -eq 1 ] ; then
	${sharpy} libopts25
	${sharpy} rpc* nfs* 

	part2
fi

${lftr}
csleep 3

${ip6tr} /etc/iptables/rules.v6
${iptr} /etc/iptables/rules.v4

if [ ${debug} -eq 1 ] ; then
	${snt} -tulpan
	sleep 5
fi #

#===================================================PART 3===========================================================
message
pre_part3 ${d} 
pr4 ${d}
part3 ${d} 
ecfx

csleep 5
if [ -x ~/Desktop/minimize/profs.sh ] ; then
	[ -x ~/Desktop/minimize/middleware.sh ] && . ~/Desktop/minimize/middleware.sh	
	. ~/Desktop/minimize/profs.sh
	copyprof ${n} someparam
fi

#TODO:ehto uusiksi jotenkin?
if [ ${mode} -eq 1 ] ; then
	vommon
fi

${asy}
csleep 3

#HUOM.270325:kokeillaan import2dessa enforce_access():ia josko sitten menisi oikeudet kunnolla

${scm} 0555 ~/Desktop/minimize/changedns.sh
${sco} root:root ~/Desktop/minimize/changedns.sh
#TODO:$dnsm käyttööm tähän alle? vaiko mode-riippuvainen exit taas?
${odio} ~/Desktop/minimize/changedns.sh 0 ${distro}
csleep 5

##===================================================PART 4(final)==========================================================
##tulisi olla taas tables toiminnassa tässä kohtaa skriptiä
#${odio} /etc/init.d/dnsmasq restart
#${d}/changedns.sh 1
#ns2 stubby
#ns4 stubby
#
#if [ ${debug} -eq 1 ] ; then 
#	${snt} -tulpan
#	sleep 5
#	pgrep stubby*
#	sleep 5
#fi
#
#echo "time to ${sifu} ${iface} or whåtever"
#echo "P.S. if stubby dies, resurrect it with \"restart_stubby.desktop\" "

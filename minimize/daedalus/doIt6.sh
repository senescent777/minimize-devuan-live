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

#HUOM. mode otetaan jo parametriksi p_o_1:sessä, josko enforce kanssa?
 
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

if [ $# -gt 0 ] ; then
	for opt in $@ ; do parse_opts_1 $opt ; done
fi

check_params 
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
enforce_access ${n}
 
part1 ${distro} 
#HUOM.190325:part_1_5sessa oli bugi, u+w ei vaan riitä
[ ${mode} -eq 0 ] && exit

#HUOM.261224: ntpsec uutena
for s in avahi-daemon bluetooth cups cups-browsed exim4 nfs-common network-manager ntp mdadm saned rpcbind lm-sensors dnsmasq stubby ntpsec ; do
	${odio} /etc/init.d/${s} stop
	csleep 1
done

dqb "shutting down some services (4 real) in 3 secs"
sleep 3 

${whack} cups*
${whack} avahi*
${whack} dnsmasq*
${whack} stubby*
${whack} nm-applet

#ntp ehkä takaisin myöhemmin
${whack} ntp*
csleep 5
${odio} /etc/init.d/ntpsec stop
#K01avahi-jutut sopivaan kohtaan?

#===================================================PART 2===================================
ecfx
csleep 5

#TODO:ehto uusiksi vai ei?
if [ ${mode} -eq 1 ] ; then
	vommon
fi

c=$(find ${d} -name '*.deb' | wc -l)
[ ${c} -gt 0 ] || removepkgs=0

#if [ ${removepkgs} -eq 1 ] ; then
	part2 ${removepkgs}
#fi
#
#VAIH:->part2
#if [ y"${ipt}" != "y" ] ; then 
#	${ip6tr} /etc/iptables/rules.v6
#	${iptr} /etc/iptables/rules.v4
#fi
#
#csleep 5
#${lftr} 
#csleep 3
#
#if [ ${debug} -eq 1 ] ; then
#	${snt} -tulpan
#	sleep 5
#fi #

#===================================================PART 3===========================================================
message
pre_part3 ${d}
pr4 ${d}
part3 ${d}

echo $?
csleep 3

${ip6tr} /etc/iptables/rules.v6
${iptr} /etc/iptables/rules.v4

if [ -x ~/Desktop/minimize/profs.sh ] ; then
	[ -x ~/Desktop/minimize/middleware.sh ] && . ~/Desktop/minimize/middleware.sh 
	. ~/Desktop/minimize/profs.sh
	copyprof ${n} someparam
fi

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

#VAIH:stubby-jutut toimimaan
#ongelmana error: Could not bind on given addresses: Permission denied
dqb "MESSIAH OF IMPURITY AND DARKNESS"
csleep 4

if [ ${debug} -eq 1 ] ; then 
	${snt} -tulpan
	sleep 5
	pgrep stubby*
	sleep 5
fi

echo "time to ${sifu} ${iface} or whåtever"
echo "P.S. if stubby dies, resurrect it with \"restart_stubby.desktop\" "

if [ ${debug} -eq 1 ] ; then 
	sleep 5
	#whack xfce so that the ui is reset
	${whack} xfce4-session
fi
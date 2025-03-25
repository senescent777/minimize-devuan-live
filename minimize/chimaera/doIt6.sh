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

#HUOM.240325:fix_sudo/check_bin/enforce/part1 vaikuttavat paskovan jotain chimaeran kanssa
#s.e. slim jää odottamaan äksää pidemmäksi aikaa
#lisäksi iptables poistuu jostain syystä, ehkä sivuvaikutuksena toisista poistoista
#... joten kunnes tulee jokin kuningasidea miten korjata tilanne, täytynee antaa chimaeran olla/keskittyä daedalukseen mieluummin
#(voi myös olla että chimaeran .iso alkanut lahota, tätä varten sen sha-tarkistuksEN prujaaminen vähitellen, mksums yms.)
#TODO:jokin minimaalinen testiskripti äksän rikkomiseksi, jos vaikka includoisi common_lib+lib ja katsoisi että riittääkö
#
#

check_params 
[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
enforce_access ${n} 

dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary" 
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

#exit
#ntp-jutut tähän?
#K01avahi-jutut sopivaan kohtaan?

#===================================================PART 2===================================
#VAIH:removepkgs riippumaan $distro:n alla olevista -deb-paketeista (jos ei pakettei, ei poistoja)
#HUOM.230235:näytti iptables kadonneen joten changedns:n toiminta kusi

c=$(find ${d} -name '*.deb' | wc -l)
[ ${c} -gt 0 ] || removepkgs=0

#HUOM.2409325:saattaa olla turhaa kikkailua tuo c-juttu yllä
#jos poistaa poakettaja tuossa alla ni tables vaan poistuu ja täts it

if [ ${removepkgs} -eq 1 ] ; then
	#HUOM.240325: ekan rivin 3 ekaa kun poistaa niin iptables löytyy jo "no longer required"-listalta
	#lototaan että network* poistaa tablesin ... NO Ei

	${sharpy} libblu* libcupsfilters* libgphoto* libopts25
	${sharpy} network* avahi* blu* cups* exim*
	${sharpy} rpc* nfs* 
	${sharpy} modem* wireless* wpa* iw lm-sensors
fi

#HUOM. seur 2 riviä lisätty uutena 150325, pois jos qsee
#${sharpy} ntp* #tämäkin liikaa?
#${sharpy} po* #uskaltaakohan tätäkään ajaa? tai siis jos vähän tarkempi...

#${sharpy} pkexec #HUOM.160325:tästä tuli nalkutusta
#lisäksi apt yritti poistaa oleellisia paketteja
#option --allow-remove-essential puutos esti oleellisten poistumisen

#paketin mdadm poisto siirretty tdstoon pt2.sh päiväyksellä 220624

${lftr}
csleep 3

${ip6tr} /etc/iptables/rules.v6
${iptr} /etc/iptables/rules.v4

csleep 3
${lftr} 
csleep 3

if [ ${debug} -eq 1 ] ; then
	${snt} -tulpan
	sleep 5
fi #

#===================================================PART 3===========================================================
dqb "INSTALLING NEW PACKAGES IN 10 SECS"
csleep 3

echo "DO NOT ANSWER \"Yes\" TO A QUESTION ABOUT IPTABLES";sleep 2
echo "... FOR POSITIVE ANSWER MAY BREAK THINGS";sleep 5

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

#toimii
if [ ${mode} -eq 1 ] ; then
	vommon
fi

${asy}
csleep 3

#VAIH:selvitä missä kohtaa x-oikeudet p.oistuvat
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

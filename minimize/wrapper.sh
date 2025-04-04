#!/bin/bash
distro=$(cat /etc/devuan_version)
d=$(dirname $0)
. ${d}/${distro}/conf

case ${1} in
	merde)
		${d}/demerde_toi.sh main		
	;;
	cdns)		
		sudo ${d}/changedns.sh ${dnsm}
	;;
	ifup)
		sudo /sbin/ifup ${iface}
	;;
	ifdown)
		sudo /sbin/ifdown ${iface}
	;;
	import)
		echo "TODO:smthng w/ import2.sh" #HUOM.010425:tässä tarvitaaan käli kysymään ainakin mikä tdsto tuodaan
	;;
	doit)
		${d}/${distro}/doIt6.sh ${2}
	;;
	pt2)
		${d}/${distro}/pt2.sh
	;;	
esac
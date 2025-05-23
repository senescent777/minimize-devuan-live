#!/bin/bash
distro=$(cat /etc/devuan_version)
d=$(dirname $0)

if [ -s ${d}/${distro}/conf ] ; then
	. ${d}/${distro}/conf
else
	echo "NO CONFIG FILE"
fi

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
		${d}/import2.sh -1
		read -p "source?" sorsa

		${d}/import2.sh 0 ${sorsa}
		echo $?
		
		sleep 2
		${d}/import2.sh 2
	;;
	doit)
		${d}/generic_doit.sh
	;;
	pt2)
		${d}/${distro}/pt2.sh
	;;
	pw)
		${d}/generic_doit.sh 1
	;;	
esac

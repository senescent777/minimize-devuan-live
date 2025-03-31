#!/bin/bash
distro=$(cat /etc/devuan_version)
d=$(dirname $0)
. ${d}/${distro}/conf

case ${1} in
	merde)
		echo "${d}/demerde_toi.sh main"		
	;;
	cdns)		
		echo "sudo ${d}/changedns.sh ${dnsm}"
	;;
	ifup)
		echo "sudo /sbin/ifup ${iface}"
	;;
	ifdown)
		echo "sudo /sbin/ifdown ${iface}"
	;;
	import)
		echo "TODO:smthng w/ import2.sh"
	;;
	doit)
		echo "${d}/${distro}/doIt6.sh"
	;;
	pt2)
		echo "${d}/${distro}/pt2.sh"
	;;	
esac
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
		echo "${d}/import2.sh -1"
		echo "read \$file;${d}/import2.sh 0 \${file}"
		echo "${d}/import2.sh 2"
	;;
	doit)
		${d}/${distro}/doIt6.sh
	;;
	pt2)
		${d}/${distro}/pt2.sh
	;;	
esac
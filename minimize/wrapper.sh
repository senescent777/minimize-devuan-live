#!/bin/bash
distro=$(cat /etc/devuan_version)

# HUOM tämä skripti ei välttämttä oleellinen chroot-ymp kannaltaq
d=$(pwd)

if [ -s ${d}/${distro}/conf ] ; then
	. ${d}/${distro}/conf
else
	echo "NO CONFIG FILE"
fi

case ${1} in
#	merde)
#		${d}/demerde_toi.sh main		
#	;;
	cdns)		
		sudo /opt/bin/changedns.sh ${dnsm}
	;;
	ifup)
		sudo /sbin/ifup ${iface}
	;;
	ifdown)
		sudo /sbin/ifdown ${iface}
	;;
	import)
		${d}/import2.sh -1
		[ $? -gt 0 ] && exit 45 #HUOM. jos on jo valmiiksi mountattu ni turha exit
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
		${d}/generic_pt2.sh -v
	;;
	pw)
		${d}/generic_doit.sh 1
	;;
	*)
		echo "$0 [cmd]"
	;;
esac

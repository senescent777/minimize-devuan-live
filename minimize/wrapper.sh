#!/bin/bash
distro=$(cat /etc/devuan_version)

# HUOM tämä skripti ei välttämttä oleellinen chroot-ymp kannaltaq
d=$(pwd)

if [ -s ${d}/${distro}/conf ] ; then
	. ${d}/${distro}/conf
else
	echo "NO CONFIG FILE"
fi

#miten tämän vastaavuudet some_scripts/lib alaisten kanssa?
#liittyy:https://github.com/senescent777/some_scripts/blob/main/lib/export/ui.sh.export

case ${1} in
	merde)
		${d}/demerde_toi.sh main #testattu 08/25 alussa, toimi silloin
	;;
	cdns)		
		sudo /opt/bin/changedns.sh ${dnsm}
	;;

	ifup)
		sudo /sbin/ifup ${iface}
	;;
	ifdown)
		sudo /sbin/ifdown ${iface}
	;;
	import|import2)
		${d}/import2.sh -1
		[ $? -gt 0 ] && exit 45 #HUOM. jos on jo valmiiksi mountattu ni turha exit
		read -p "source?" sorsa #jokin tdston_valinta_dialogi olisi tietysti kiva...
		sleep 2

		if [ "${1}" == "import" ] ; then
			${d}/import2.sh 0 ${sorsa}
			[ $? -eq 0 ] || echo "$0 import2 ?"
			sleep 1
		else
			${d}/import2.sh 3 ${sorsa}
		fi

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
	update)
		echo "TODO:file_dialog+update.sh ?"
	;;
	*)
		echo "$0 [cmd]"
	;;
esac

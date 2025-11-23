#!/bin/bash
distro=$(cat /etc/devuan_version)

#HUOM. tämä skripti ei välttämttä oleellinen chroot-ympäristön kannalta
d=$(pwd)

if [ -s ${d}/${distro}/conf ] ; then
	. ${d}/${distro}/conf
else
	echo "NO CONFIG FILE"
fi

#miten tämän vastaavuudet some_scripts/lib alaisten kanssa?
#liittyy:https://github.com/senescent777/some_scripts/blob/main/lib/export/ui.sh.export

gol=$(which dialog)
#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=dialog=1.3-20230209-1&eXtra=87.95.53.103
[ -x ${gol} ] || echo "apt-get install libtinfo6 libncursesw6 debianutils dialog"

case ${1} in
	merde)
		if [ -x ${d}/../merd2.sh ] ; then
			${d}/../merd2.sh ${2} ${3}
		else
			echo "N0 5H1T 5H3RL0CK"
		fi
	;;
	#VAIH:merd2
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
		#[ $? -gt 0 ] && exit 45 #HUOM. jos on jo valmiiksi mountattu ni turha exit
		read -p "source?" sorsa #jokin tdston_valinta_dialogi olisi tietysti kiva...
		sleep 2

		#https://duckduckgo.com/?q=how+to+make+file+selection+d8ialog+with+ncurses&ia=web
		#https://unix.stackexchange.com/questions/70793/curses-based-program-for-selection-item-from-the-list
		#https://github.com/thenamankumar/ncurses-cheatsheet?tab=readme-ov-file
		#https://linuxconfig.org/how-to-use-ncurses-widgets-in-shell-scripts-on-linux
		#https://invisible-island.net/dialog/manpage/dialog.pdf

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
		echo "TODO:file_dialog+update2.sh ?"
	;;
	*)
		echo "$0 [cmd]"
	;;
esac

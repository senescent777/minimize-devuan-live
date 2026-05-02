#!/bin/bash
distro=$(cat /etc/devuan_version)

#HUOM. tämä skripti ei välttämttä oleellinen chroot-ympäristön kannalta
d=$(pwd)

if [ -s ${d}/${distro}/conf ] ; then
	. ${d}/${distro}/conf
else
	echo "NO CONFIG FILE"
fi

gol=$(which dialog)

if  [ -z "${gol}" ] || [ ! -x ${gol} ] ; then
	echo "apt-get install libtinfo6 libncursesw6 debianutils dialog"
fi

case "${1}" in
	merde)
		if [ -x ${d}/../merd2.sh ] ; then
			${d}/../merd2.sh ${2} ${3}
		else
			echo "N0 5H1T,  5H3RL0CK"
		fi
	;;
	cdns)		
		sudo /opt/bin/mutilatetc.bash ${CONF_dnsm}
	;;
	ifup)
		sudo /sbin/ifup ${CONF_iface}
	;;
	ifdown)
		sudo /sbin/ifdown ${CONF_iface}
	;;
	import|import2)
		${d}/import2.sh -1
		#[ $? -gt 0 ] && exit 45 #HUOM. jos on jo valmiiksi mountattu ni turha exit

		#if [ -x ${gol} ] ; then
		#else
			read -p "source?" sorsa
		#fi

		sleep 2

		#https://duckduckgo.com/?q=how+to+make+file+selection+d8ialog+with+ncurses&ia=web
		#https://unix.stackexchange.com/questions/70793/curses-based-program-for-selection-item-from-the-list
		#https://github.com/thenamankumar/ncurses-cheatsheet?tab=readme-ov-file
		#https://linuxconfig.org/how-to-use-ncurses-widgets-in-shell-scripts-on-linux
		#https://invisible-island.net/dialog/manpage/dialog.pdf

		#VAIH:tätä if-blokkia joutaisi sorkkimaan josqs kosak imp2/sqrot
		if [ "${1}" == "import" ] ; then
			#-v mielellään pois optioista sittenq mahd
			${d}/sq-rot.sh 0 ${sorsa} -v
			[ $? -eq 0 ] || echo "$0 import2 ?"
			sleep 1
		else
			${d}/sq-rot.sh 3 ${sorsa}
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
		#VAIH:file_dialog+update2.sh
		t=$(${gol} --fselect ${dir} 20 20) #vissiin ei näin?
		echo "update2.sh ${t} 1 ?"
	;;
	*)
		echo "$0 [cmd]"
	;;
esac

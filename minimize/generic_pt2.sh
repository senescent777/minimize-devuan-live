#!/bin/bash
debug=0 #1
distro=$(cat /etc/devuan_version) #tämä tarvitaan toistaiseksi
PREFIX=~/Desktop/minimize
loose=1

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function parse_opts_1() {
	echo "popt_1( ${1} )"
	
	case ${1} in
		-v|--v)
			debug=1
		;;
		*)
			if [ -d ${PREFIX}/${1} ] ; then
				distro=${1}
		
			fi

			dqb "0th3r 0tps"
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

if [ -x ${PREFIX}/common_lib.sh ] ; then
	. ${PREFIX}/common_lib.sh
else
	echo "NO COMMON LIB"
	exit 89
fi

[ -z ${distro} ] && exit 6
d=${PREFIX}/${distro}

echo "BEFORE CNF"
echo "dbig= ${debug}"
sleep 5

if [ -d ${d} ] && [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa?
	echo "CONF MISSING"
	exit 56
fi

#TODO:josko tarvittaessa jyräämään konftdston debug-asetus

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo $?
	dqb "NO LIB"
	exit 67
fi

${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh
${fib}

echo "d=${d}"
echo "debug=${debug}"
echo "distro=${distro}"
echo "removepkgs=${removepkgs}"
sleep 2

#HUOM.25525:vaikutti sikäli toimivalta t2pc() että systeemi toimintakuntoinen vielä ajon jälkeen && df näytti sopivahkoa lukemaa
csleep 2
#HUOM.25525.2:koita nyt kuitenkin uudestaan, ei hyvältä näyttänyt viimeksi, ajettiinko t2pc() edes?

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_pre 1
	[ $? -gt 0 ] && exit
	
	part2_5 1
	[ $? -gt 0 ] && exit
fi

#jos ao. fktiot kommentoitu jemmaan syistä ni pysäyttäisikö suorituksen?
t2pc
[ $? -gt 0 ] && exit

t2p
[ $? -gt 0 ] && exit

t2pf
[ $? -gt 0 ] && exit

${asy} #varm. vuoksi

#debug=1
csleep 5 #t2pf kyllä sisälsä csleep

#excaliburin kanssa ei tämäkään tainnut toimia ihan toivotulla tavalla
#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
if [ ${debug} -eq 1 ]; then
	echo "${whack} xfce4-session"
else
	${whack} xfce4-session
fi
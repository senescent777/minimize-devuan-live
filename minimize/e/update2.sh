#!/bin/bash
d0=$(pwd)

tcmd=$(which tar)
[ -z "${tcmd}" ] && exit 11
[ -x ${tcmd} ] || exit 12

spc=$(which cp)
[ -z "${spc}" ] && exit 13
[ -x ${spc} ] || exit 14
n=$(whoami)

par3=""
#250526:kolammen parametrin suhteen toimibta testattu jo?
#260526:testaus jouduttu laittamaan käyntiin

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		#250526:ehkä toimi omegan ajon jälkeen, testaa josqs uudestaan

		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
	fi

	par3=${3}
else
	exit 10
fi

tgt=${1}
[ -z "${tgt}" ] && exit 15
[ -s "${tgt}" ] || exit 16
[ -r "${tgt}" ] || exit 17

echo "PARAMS CHECKED"
sleep 1

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -s ${d0}/../$(whoami).conf ] ; then
		echo "ALT.C0NF1G3"
		. ${d0}/../$(whoami).conf
	fi
fi

#pelkästään .deb-paketteja sisältävien kalojen päivityksestä pitäisi urputtaa	
${tcmd} -tf ${tgt} | grep '.deb' | head -n 5
sleep 1

read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
[ "${confirm}" != "Y" ] && exit 

${spc} ${tgt} ${tgt}.OLD #cp vaiko mv?
[ $? -eq 0 ] || echo "chmod | chown ?"
sleep 1
t=$(pwd)

#VAIH:tunaroinnin varalta lähteestä vkopio ennenq alkaa process_row() hakata
#VAIH:ja sitten oli se "resolv.conf"-juttukin ed. liittyen

if [ "${CONF_env}" == "VED" ] && [ -v CONF_testgris ] && [ -d ${CONF_testgris} ] ; then
	echo "YLIULIULI asb asb ABC"
	cd ${CONF_testgris}

	echo "SHOULD MAKE BACKUP OF SOURCE"
	sleep 1

	echo "SHOULD ALSO AVOID UPFATING RESOLV.CONF"
	sleep 1

	#HUOM:-C olisi myös keksitty
else
	echo "NO TESTGRIS?"
	cd /
fi

#tämä wttuun josqs? vai ei?
xo="*.tar --exclude .chroot --exclude *.deb --exclude changedns.*"

if [ "${CONF_env}" != "DEFAULT" ]; then
	xo="${xo} --exclude resolv.* "
fi

function process_row() {
	echo "TCMD --exclude ${xo} -rvf ${1} ${2}"
	${tcmd} --exclude "${xo}" -rvf ${1} ${2}
}

#HUOM.170426:olisi hyvä keksiä tähänkin jotain siltä varalta että merd2 ei tulisi ylimääräisiä kopioita
#... keksitty jo 260526 mennessä?

if [ ! -s ${d0}/MAN1.F2ST ] ; then
	${tcmd} -tf ${tgt} | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar | grep -v .deb | grep -v resolv > ${d0}/MAN1.F2ST
	${tcmd} -rvf ${tgt} ${d0}/MAN1.F2ST
	sleep 1
fi

echo "BEFOR.E PROCESSING ROWS"
sleep 1
#toimiikohan kehitysynp.tössä niinqu pitää?

#VAIH:ao. riveihin muutoksia koska CONF_env tulosssa käyttöön
if [ -z "${par3}" ] ; then
	g=$(grep -v '#' ${d0}/MAN1.F2ST | grep -v "${n}.conf" | grep -v .tar | grep -v .deb | grep -v .chroot | grep -v resolv)
else
	g=$(grep -v '#' ${d0}/MAN1.F2ST | grep ${par3})
fi

#echo ${g}
#sleep 5
#VAIH:tcmd:lle optioksi nuo pois grepattavat, --exclude

echo "JUST BEFORE FOR-LOOP"
echo ${g}
sleep 5

for f in ${g} ; do
	echo "${f} :"

	if [ -f ${f} ] ; then
		if [ ! -d ${f} ] ; then #"-h" - tark vielä?
			#echo "... processinbfg"
			process_row ${tgt} ${f}
		fi
	fi

	#sleep 1
done

ls -las ${tgt}*
#jottta ehtisi synkata 
sleep 6;sudo /bin/sync;sleep 4

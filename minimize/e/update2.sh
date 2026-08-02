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

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		
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

if [ -s ${d0}/$(whoami).conf ] ; then
	. ${d0}/$(whoami).conf
else
	if [ -s ${d0}/../$(whoami).conf ] ; then
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

#18726:tuossa ylläjo tehdään vkopio ennenq processs_rpw() EDES ESITELLÄÄN

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

xo="*.tar --exclude .chroot --exclude *.deb --exclude changedns.* "

if [ "${CONF_env}" != "DEFAULT" ]; then
	xo="${xo} --exclude resolv.* "
fi

function process_row() {
	${tcmd} --exclude "${xo}" -rvf ${1} ${2}
}

if [ ! -s ${d0}/MAN1.F2ST ] ; then
	${tcmd} -tf ${tgt} | grep -v "${n}.conf" | grep -v .chroot | grep -v .tar | grep -v .deb | grep -v resolv > ${d0}/MAN1.F2ST
	${tcmd} -rvf ${tgt} ${d0}/MAN1.F2ST
	sleep 1
fi

#ao. riveihin muutoksia? koska CONF_env tulosssa käyttöön
if [ -z "${par3}" ] ; then
	g=$(grep -v '#' ${d0}/MAN1.F2ST | grep -v "${n}.conf" | grep -v .tar | grep -v .deb | grep -v .chroot | grep -v resolv)
else
	g=$(grep -v '#' ${d0}/MAN1.F2ST | grep ${par3})
fi

for f in ${g} ; do
	if [ -f ${f} ] ; then
		if [ ! -d ${f} ] ; then
			process_row ${tgt} ${f}
		fi
	fi

	#sleep 1
done

ls -las ${tgt}*
#jottta ehtisi synkata (komento mukaan sudoERSiin?)
sleep 6;sudo /bin/sync;sleep 4

#tktiona vähän turhaq, tarkistuksia enemmän kun varsnsiats koodia, toisaalta voisi prujata fktion sisällön niihin 2 kohtaan export2:sessa
#function e22_dblock() {
#	dqb "e22_dblock(${1} , ${2} , ${3} , ${4} )))) "
#
#	[ -z "${1}" ] && exit 14
#	[ -s ${1} ] || exit 15
#	[ -z "${2}" ] && exit 11
#	[ -d ${2} ] || exit 22
#	[ -w ${2} ] || exit 23
#	[ -z "${3}" ] && exit 33
#	[ -d ${3} ] || exit 34
#	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...
#	[ -z "${4}" ] && exit 37
#
#	dqb ".PARS-OK"
#	csleep 1
#
#	[ ${debug} -eq 1 ] && pwd
#
#	ls -la ${3}/*.deb | wc -l
#	
#	for s in ${PART175_LIST} ; do
#		${sharpy} ${s}*
#		${NKVD} ${3}/${s}*.deb
#	done
#	
#	local t
#	t=$(echo ${2} | cut -d "/" -f 1-6)
#	e22_ts ${t} ${3}
#	dqb "JST B3F0R3 3NF0RC3"
#	csleep 10
#	
#	enforce_access $(whoami) ${t}
#	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
#	csleep 10
#
#	e22_arch ${1} ${2} ${4}
#	e22_cleanpkgs ${2}
#}
#TODO:.hit huomioiva vkpio-skripti?
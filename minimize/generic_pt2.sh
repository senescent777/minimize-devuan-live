#!/bin/bash
distro=$(cat /etc/devuan_version)
d0=$(pwd)

[ -z "${distro}" ] && exit 6
debug=0
d=${d0}/${distro}
mode=3

function parse_opts_1() {
	if [ -d ${d0}/${1} ] ; then #090326:kuinkahan oleellinen distron yliajo?
		echo "#distro=${1}"
	else
		case  "${1}" in
			0|1|2|3) #varsinainen numeerisuustarkistus olisi parempi?
				mode=${1}
			;;
			*)
				dqb "invalid param"
			;;
		esac
	fi
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

function fallback() {
	dqb $?
	echo "NOT (LIB AVAILABLE AND ECXUTABL3)"
	exit 67
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	echo "NO COMMON LIB"
	exit 89
fi

[ -z "${distro}" ] && exit 6
dqb "BEFORE L1B"
process_lib ${d}
csleep 2

e_final
csleep 2
e_h $(whoami) ${d0} 
csleep 2

#VAIH:tbl ja aftr tähän? vai ko TLA()
#if [ -x /opt/bin/changedns.bash ] ; then
#	${odio} /opt/bin/changedns.bash ${CONF_dnsm}
#else
#	if [ -x ${d0}/opt/bin/changedns.bash ] ; then
#		${odio} ${d0}/opt/bin/changedns.bash ${CONF_dnsm}
#	else
#		dqb "changedns not an option"
#		csleep 5
#	fi
#fi

#jos vaikka näin?
${sifd} ${CONF_iface}
csleep 2
${odio} /opt/bin/tlb.bash
csleep 2
${odio} /opt/bin/mutilatetc.bash ${CONF_dnsm}
csleep 2
${fib}
csleep 2

dqb "distro=${distro}"
dqb "removepkgs=${CONF_removepkgs}"
dqb "mode=${mode} "
sleep 1

if [ ${CONF_removepkgs} -eq 1 ] ; then
	dqb "kö"
	TLA
else
	part2 1 ${CONF_dnsm} ${CONF_iface}
	[ $? -gt 0 ] && exit
fi

function t2p_filler() {
	dqb "FILLER"
	${lftr}
	${asy}
	csleep 1
}

#tarpeellinen blokki nykyään?
if [ -f /.chroot ] ; then
	${sharpy} blu*
	${sharpy} nfs*
	${sharpy} rpc*

	t2p_filler

	${sharpy} dmsetup #tässä kohtaa jo gpg hukataan?
	${sharpy} at-spi2-core	
	${sharpy} psmisc

	t2p_filler
fi

#====================================================================

function p2g() {
	dqb "THE_PIG ((((((((((((((((( ${1} )"
	csleep 1

	[ -s ${1}/pkgs_drop ] || exit 66

	local f
	local g
	local h

	#jatkossa jos yhdistelisi common_lib_tool kanssa... paitsi että
	for f in $(grep -v '#' ${1}/pkgs_drop) ; do
		dqb "SOON: \${sharpy} ${f}* "
		csleep 1
		IFS="," read -a g <<< "${f}"

		for h in ${g[@]} ; do
			${sharpy} ${h}*
		done

		csleep 1
		t2p_filler
	done

	dqb "p2g DONE"
	csleep 1
}

#VAIH:selvitä missä kohtaa gpg poistuu nykyään, koita saada epä-poistumaan
#mode:n kanssa kikkailut voivat auttaa selvityksessä
#
#	#libgtk3 ei poistu, libgtk4 kyllä
#
#	if [ -f /.chroot ] ; then
#		dqb "SHOULD \${sharpy} slim* "
#		csleep 1
#
#		#26226:/e/d/network saattaisi olla toimivampi idea kuin se aiempi tässä
#
#		dqb "t2p_filler()"
#		csleep 1
#
#		#081225:jospa se minimal_live pohjaksi vähitellen, dbus+slim vituttaa
#		dqb "Xorg -config ? "
#		csleep 1
#	else
#		dqb "COULD? \${sharpy} slim;sudo /e/i.d/slim stop;sudo /e/i.d/wdm start"
#		csleep 1
#		dqb "WOULD: A.I.C"
#		csleep 1
#	fi
#

function t2pf() {
	dqb "common_lib.T2P.FINAL( ${1} )"
	csleep 1

	${NKVD} ${CONF_pkgdir}/*.deb
	${NKVD} ${CONF_pkgdir}/*.bin 
	[ -d ${1} ] && ${NKVD} ${1}/*.deb 
	${NKVD} /tmp/*.tar
	${smr} -rf /tmp/tmp.*

	#rikkookohan jotain nykyään? eipäkai
	${smr} -rf /usr/share/doc 

	#fiksumpaa olisi kai muutella import2:ssa vastaava kohta
	${NKVD} /OLD.tar
	csleep 1
	${srat} /OLD.tar /etc/X11

	for f in $(find /var/log -type f) ; do ${NKVD} ${f} ; done
	df
	${odio} which dhclient; ${odio} which ifup; csleep 1
}

#====================================================================
dqb "gpg= $(sudo which gpg)" #tässäjo poistunut
csleep 1

${fib}
csleep 1
p2g ${d0}

[ $? -gt 0 ] && exit
[ ${mode} -eq 0 ] && exit

p2g ${d}
[ ${mode} -eq 1 ] && exit

t2pf ${d}
[ $? -gt 0 ] && exit
[ ${mode} -eq 2 ] && exit

echo "BELLvM C0NTRA HUMAN1TAT3M"
csleep 1
${scm} 0555 ${d0}/common_lib.sh 

#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
dqb "${whack} xfce4-session 1n ... s3c5"
sleep 1
${whack} xfce4-session #toimiiko tämä?

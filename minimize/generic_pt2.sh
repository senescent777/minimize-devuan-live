#!/bin/bash
distro=$(cat /etc/devuan_version)
d0=$(pwd)

[ -z "${distro}" ] && exit 6
debug=0
d=${d0}/${distro}
mode=3

#010826:toimiiko tämä eri tavalla -v kanssa kuin ilman? sqroot...

function parse_opts_1() {
	if [ -d ${d0}/${1} ] ; then
		echo "#distro=${1}"
	else
		case  "${1}" in
			0|1|2|3)
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
e_h $(whoami) ${d0}

[ -v CONF_iface ] && ${sifd} ${CONF_iface}
csleep 2

if [ "${CONF_env}" == "DEFAULT" ] ; then
	${odio} ${CONF_DIR2}/tlb.bash
	csleep 2
	${sco} 0:0 ${CONF_DIR2}/*
	${scm} 0400 ${CONF_hashfile3}*
fi

if [ -x ${CONF_DIR2}/mutilatetc.bash ] && [ -v CONF_dnsm ] ; then
	${odio} ${CONF_DIR2}/mutilatetc.bash ${CONF_dnsm}
else
	dqb "FAILURE TO MUTILATE: /etc/resolc. von f "
fi

dqb "BEYOND THE UNHOLY GRAVE"
ls -las /etc/resolv*
sleep 2

csleep 2
${fib}
csleep 2

dqb "distro=${distro}"
dqb "removepkgs=${CONF_removepkgs}"
dqb "mode=${mode} "
sleep 1

#.5: wdm jälk wanha u, sitten omeha -> ei oheisvahinkoa
#lopuksi uuden oemnan kanssa: haluaa hukata äksän
#uudemmankin päivityspak kanssa se hukkaamisongelma kun mennään omegaan, jnties VIELÄ uusi yritys päivbityspak kanssa (kts miten ten1 ja part175 tällä krt)

if [ ${CONF_removepkgs} -eq 1 ] && [ "${CONF_env}" != "TOOR" ] ; then # 2. ehto ok?
	dqb "kö"
	TLA
else
	part2 1 ${CONF_dnsm} ${CONF_iface}
	[ $? -gt 0 ] && exit
fi

function t2p_filler() { #käytössä nykyään? common_lib_tool kautta
	dqb "FILLER"
	${lftr}
	${asy}
	csleep 1
}

#140526 edelleen tarpeellinen blokki, puuttuvat paketit $d alla aiheuttavat? VAIH:joko jo pois 07/26?
#20726:modaamattomalla kiekolla&&DEFAULT rpc "ic"-tilassa, dmsetup ii, myös spi2-cpre ja psmisc myös
#entä TPPR? josko case-esac? tai alempi filler pois?

dqb "BLU NFS ???"
csleep 16
#defalt-tapauksessa psmisc ja rpcbind sisältävät vain konf? varmista

if [ "${CONF_env}" == "TOOR" ] ; then
	${sharpy} blu*
	${sharpy} nfs*
	t2p_filler

	 #tässä kohtaa jo gpg hukataan?
	${sharpy} at-spi2-core	
	
	${sharpy} rpc*
	${sharpy} dmsetup
	${sharpy} psmisc
	t2p_filler
	
	dqb "V1"
	#exit
fi

#kommentoituja paskeita pois vähitellen
#====================================================================
#20726:kts slim liittyen omega
#020826:jos välillä kokeilisi kehitellä .iso:n testausta varten eikä vaan renkata

function t2pf() {
	dqb "gp2t.common_lib.T2P.FINAL( ${1} )"
	csleep 1

	${NKVD} ${CONF_pkgdir}/*.deb
	${NKVD} ${CONF_pkgdir}/*.bin 
	[ -d ${1} ] && ${NKVD} ${1}/*.deb 
	${NKVD} /tmp/*.tar
	${smr} -rf /tmp/tmp.*

	${smr} -rf /usr/share/doc 

	${NKVD} /OLD.tar
	csleep 1
	${srat} -cvf /OLD.tar /etc/X11 #TARKKUUTTA PRKL

	for f in $(find /var/log -type f) ; do ${NKVD} ${f} ; done
	df
	${odio} which dhclient; ${odio} which ifup; csleep 1
}

#====================================================================
dqb "gpg= $(sudo which gpg)" #tässäjo poistunut
csleep 1

${fib}
csleep 1
common_lib_tool ${d0} pkgs_drop

[ $? -gt 0 ] && exit
[ ${mode} -eq 0 ] && exit
#30726:vissiin tähän asti taisteltu toimimaan

common_lib_tool ${d} pkgs_drop 
[ ${mode} -eq 1 ] && exit
#mode 1 hukkaa liikaa? toisaalta modatulla kiekolla ei niin tarpeellista ajaa koko pt2

t2pf ${d}
[ $? -gt 0 ] && exit
[ ${mode} -eq 2 ] && exit

if [ ${mode} -gt 3 ] ; then
	#slimiin liittyen olk muitakin juttuja?
	${fib}
	${odio} /etc/init.d/ntpsec stop
	echo "REMEMBER 2 /etc/init.d/wdm start";sleep 6
	${sharpy} slim
	csleep 5

	${sharpy} dahdi
	${sharpy} dc #mikä tämä on?
	csleep 5

	${sharpy} ed #uskaltaako poistaa? entä e-i?
	${sharpy} empire
	${sharpy} entr #uskaltaako sittebkään? tässä kohtaa tul ijotain ?
	csleep 5

	${sharpy} fbi #ehkä ei tätä pois?
	${sharpy} fbterm
	${sharpy} fetchmail
	csleep 5

	${sharpy} figlet fmtools fortune
	csleep 5

	${sharpy} freesweep gddrescue geoip-bin
	csleep 5

	${sharpy} gnuchess gobject-introspection greed
	csleep 5

	${sharpy} haveged icu-devtools irssi
	csleep 5

	${sharpy} jhead lrzsz matanza
	csleep 5

	${sharpy} mc #?
	${sharpy} minicom moc
	csleep 5

	${sharpy} moria
	${sharpy} netcat #jatkossakin jemmassa vai ei?
	${sharpy} nethack
	csleep 5

	#ntp #jos pitäisi jemmassa koska x
	${sharpy} omega-rpg open-invaders
	csleep 5

	${sharpy} pacman4console pente rpl
	csleep 5

	#jokin näistä paskoo äksän?
	${sharpy} rsstail sensible-utils setnet
	csleep 5

#	${sharpy} taskwarrior tcc toilet
#	csleep 5
#
#	${sharpy} transmission ttyrec w2do
#	csleep 5

#	${sharpy} w3m wamerican wavemon
#	csleep 5
#
#	${sharpy} yasr zile
#	csleep 5
fi

echo "BELLvM C0NTRA HUMAN1TAT3M"
csleep 1
${scm} 0555 ${d0}/common_lib.sh 

#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
dqb "${whack} xfce4-session 1n ... s3c5"
sleep 1
${whack} xfce4-session #toimiiko tämä?

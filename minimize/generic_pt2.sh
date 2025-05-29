#!/bin/bash
debug=0 #1
distro=$(cat /etc/devuan_version) #tämä tarvitaan toistaiseksi
PREFIX=~/Desktop/minimize #dirname?
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

dqb "BEFORE CNF"
echo "dbig= ${debug}"
sleep 5

if [ -d ${d} ] && [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa? ja jos niin miten?
	echo "CONF MISSING"
	exit 56
fi

#TODO:josko tarvittaessa jyräämään konftdston debug-asetus

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	dqb $?
	echo "NO LIB"
	exit 67
fi

${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh
${fib}

dqb "d=${d}"
echo "debug=${debug}"
dqb "distro=${distro}"
dqb "removepkgs=${removepkgs}"
sleep 2

csleep 2
#miten muuten ne cut-jutut? tarvitseeko tässä?

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_5 1
	[ $? -gt 0 ] && exit
fi

#====================================================================
#ao 3 t2p-fktiota voisivat tietenkin sijaita myös g_pt2:sessa
function t2p_filler() {
	${lftr}
	${asy}
	csleep 3
}

#yhteisiä osia daud ja chim t2p
#HUOM.28525:mikä poistaa libgtk3:sen xcaliburissa? se pitäisi estää 
function t2pc() {
	debug=1
	dqb "common_lib.t2p_common()"
	csleep 3

	${sharpy} amd64-microcode at-spi2-core
	t2p_filler

	${sharpy} bubblewrap coinor* cryptsetup*
	t2p_filler

	${sharpy} debian-faq dirmngr discover* doc-debian
	t2p_filler

	#miten dmsetup ja libdevmapper?
	${sharpy} docutils* dosfstools efibootmgr exfalso
	t2p_filler

	#tikkujen kanssa paska tdstojärjestelmä exfat
	${sharpy} exfatprogs fdisk ftp* gcr
	t2p_filler

	${sharpy} gimp-data gir* #ei poista ligtk3, gir-pakettei ei xcalib
	t2p_filler

	${sharpy} gpgsm gpg-agent gpg
	t2p_filler

	#HUOM.28525: grub:in kohdalla tuli essential_packages_nalkutusta kun xcalibur
	#${sharpy} grub* 
	${sharpy} gstreamer* #libgs poist alempana
	t2p_filler

	${sharpy} htop inetutils-telnet intel-microcode isolinux
	t2p_filler

	${sharpy} libreoffice*
	t2p_filler

	#xcaliburissa ao. paketteja ei tässä vaiheesas jäljellä?
	${sharpy} libgstreamer* libpoppler* libsane* #libsasl* poistaa git
	t2p_filler

	${sharpy} lvm2 lynx* mail* #miten mariadb-common?
	t2p_filler

	#excalibur ei sisällä?
	${sharpy} mlocate modem* mtools mythes*
	t2p_filler

	${sharpy} netcat-traditional openssh*
	t2p_filler

	${sharpy} parted pavucontrol #libgtk3 ei poistu, libgtk4 kyllä
	t2p_filler

	${sharpy} ppp plocate pciutils procmail
	t2p_filler

	${sharpy} ristretto screen
	t2p_filler

	${sharpy} shim* speech* syslinux-common
	t2p_filler

	${sharpy} tex* tumbler*
	t2p_filler

	${sharpy} vim*
	t2p_filler

	#miten nämä? poistuuko?
	${sharpy} xorriso xz-utils xfburn xarchiver # yad ei ole kaikissa distr
	#xfce*,xorg* off limits
	t2p_filler

	dpkg -l x*
	csleep 3

	dqb "clib.T2PC.DONE"
	csleep 1
}

function t2pf() {
	debug=1
	dqb "common_lib.T2P.FINAL()"
	csleep 3

	${NKVD} ${pkgdir}/*.deb
	${NKVD} ${pkgdir}/*.bin 
	${NKVD} ${d}/*.deb 
	${NKVD} /tmp/*.tar
	${smr} -rf /tmp/tmp.*

	#rikkookohan jotain nykyään? (vuonna 2005 ei rikkonut)
	${smr} -rf /usr/share/doc 
	
	#squ.ash voisi vilkaista kanssa liittyen (vai oliko mitään hyödyllistä siellä vielä?)
	df
	${odio} which dhclient; ${odio} which ifup; csleep 6
}
#====================================================================
#HUOM.25525:jos ao. fktiot kommentoitu jemmaan syistä ni pysäyttäisikö suorituksen?
#HUOM.26525:nyt sitten debug päälle jotta selviää mihin pysähtyy

t2pc
#[ $? -gt 0 ] && exit #tähän tökkää?

t2p
[ $? -gt 0 ] && exit

t2pf
[ $? -gt 0 ] && exit

${asy} #varm. vuoksi

#debug=1
${scm} a-wx ${0}
csleep 5

#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
if [ ${debug} -eq 1 ]; then
	echo "${whack} xfce4-session"
else
	${whack} xfce4-session
fi
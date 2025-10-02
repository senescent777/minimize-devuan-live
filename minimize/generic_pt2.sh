#!/bin/bash
#TODO:vielä juttuja pakettien poisteluihin liittyen? (daed/lib.sh) vielä tarpeen 29725?
distro=$(cat /etc/devuan_version) #tämä tarvitaan toistaiseksi
d0=$(pwd)
#exit 666 #HUOM.021025:jokin saatttaa qsta tässä, siksi 
[ z"${distro}" == "z" ] && exit 6
debug=0
d=${d0}/${distro}

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#TODO:jokin mode-param mikä määrää mihin asti poistellaan
function parse_opts_1() {
	echo "popt_1( ${1} )"

	case ${1} in
		-v|--v)
			debug=1
		;;
		*)
			if [ -d ${d0}/${1} ] ; then
				distro=${1}
			fi

			dqb "0th3r 0tps"
		;;
	esac
}

#HUOM.021025:initrafs-toolsin ja live-xxx-pakettien kanssa saattaa olla jotain härdellia, korjaa?

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

if [ -f /.chroot ] ; then
	echo "UNDER THE GRAV3YARD"
	sleep 2
	tar -jxvf ${d0}/nekros.tar.bz3

	sleep 3
	rm ${d0}/nekros.tar.bz3
fi

if [ -d ${d} ] && [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa? ja jos niin miten?
	echo "CONF MISSING"
	exit 56
fi

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	echo "NO COMMON LIB"
	exit 89
fi

[ -z ${distro} ] && exit 6
dqb "BEFORE CNF"
echo "dbig= ${debug}" # [  -v ] taakse?
sleep 1

#TODO:josko tarvittaessa jyräämään konftdston debug-asetus tai siis mahd aikaisessa vaiheessa debug päälle oli ideana?

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	dqb $?
	echo "NOT (LIB AVAILABLE AND ECXUTABL3)"
	exit 67
fi

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

${fib}
echo "debug=${debug}"
dqb "distro=${distro}"
dqb "removepkgs=${removepkgs}"
sleep 1
csleep 1

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_5 1
	[ $? -gt 0 ] && exit
fi

#====================================================================

function t2p_filler() {
	${lftr}
	${asy}
	csleep 1
}

#yhteisiä osia daud ja chim t2p
function t2pc() {
	#debug=1
	dqb "common_lib.t2p_common()"
	csleep 1

	${fib} #uutena 29525, xcalibur...
	csleep 1

	${sharpy} amd64-microcode at-spi2-core #toimii systeemi ilmankin näitä mutta ?
	t2p_filler

	${sharpy} bubblewrap coinor* cryptsetup*
	t2p_filler

	${sharpy} debian-faq dirmngr discover* doc-debian
	t2p_filler

	#HUOM.29925: daedaluksessa dmsetup ja libdevmapper? poistuvat jos poistuvat g_doit ajamisen jälkeen
	${sharpy} docutils* dosfstools efibootmgr exfalso
	t2p_filler

	#HUOM.29925: daed kanssa poistuu hos poistuu libsouåp josqs g_doit jälkeen

	#tikkujen kanssa paska tdstojärjestelmä exfat
	${sharpy} exfatprogs fdisk gcr ftp*
	t2p_filler

	${sharpy} gimp-data gir* #ei poista ligtk3, gir-pakettei ei xcalib
	t2p_filler

	#${sharpy} gpgsm gpg-agent gpg #tulossa käyttöä näille ajtkossa
	#t2p_filler

	#HUOM.28525: grub:in kohdalla tuli essential_packages_nalkutusta kun xcalibur
	#${sharpy} grub* 
	${sharpy} gstreamer* #libgs poist alempana
	t2p_filler

	#HUOM.22725:näillä main libsoup poistuu?

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
	${sharpy} xorriso 
	t2p_filler

	${sharpy} xz-utils xfburn xarchiver # yad ei ole kaikissa distr
	#xfce*,xorg* off limits
	t2p_filler

	[ ${debug} -gt 0 ] && ${spd} x*
	csleep 1

	dqb "clib.T2PC.DONE"
	csleep 1
}

function t2pf() {
	dqb "common_lib.T2P.FINAL()"
	csleep 1

	${NKVD} ${pkgdir}/*.deb
	${NKVD} ${pkgdir}/*.bin 
	${NKVD} ${1}/*.deb 
	${NKVD} /tmp/*.tar
	${smr} -rf /tmp/tmp.*

	#rikkookohan jotain nykyään? (vuonna 2005 ei rikkonut)
	${smr} -rf /usr/share/doc 
	
	#uusi ominaisuus 230725
	for f in $(find /var/log -type f) ; do ${smr} ${f} ; done

	#squ.ash voisi vilkaista kanssa liittyen (vai oliko mitään hyödyllistä siellä vielä?)
	df
	${odio} which dhclient; ${odio} which ifup; csleep 3
}

#====================================================================
#HUOM.25525:jos ao. fktiot kommentoitu jemmaan syistä ni pysäyttäisikö suorituksen?
#HUOM.26525:nyt sitten debug päälle jotta selviää mihin pysähtyy

t2pc
[ $? -gt 0 ] && exit #tähän tökkää?
#TODO:mode-kikkailut näille main?
t2p
[ $? -gt 0 ] && exit

t2pf ${1}
[ $? -gt 0 ] && exit

echo "BELLvM C0NTRA HUMAN1TAT3M"
sleep 6

#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
dqb "${whack} xfce4-session 1n 3 s3c5"
sleep 3
${whack} xfce4-session

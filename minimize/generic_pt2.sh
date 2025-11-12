#!/bin/bash
distro=$(cat /etc/devuan_version)
d0=$(pwd)

[ z"${distro}" == "z" ] && exit 6
debug=0
d=${d0}/${distro}
mode=0 #3 nollana kunnes saa bugit korjattua (gui qsee) (joskohan jo 121125 voi si muuttaa takaisin?)
#HUOM.251025:myös excaliburin kanssa se on nimenomaan mode 3 mikä qsee guin?

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
			if [ -d ${d0}/${1} ] ; then
				distro=${1}
			else 
				mode=${1}
			fi

			dqb "0th3r 0tps"
		;;
	esac
}

#edelleen 101025 se ettei uskalla nollaa suurempaa mode:a

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
	 	exit 57
	fi	
fi

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	echo "NO COMMON LIB"
	exit 89
fi

[ -z ${distro} ] && exit 6
dqb "BEFORE CNF"
#echo "dbig= ${debug}"
#sleep 1

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
#echo "debug=${debug}"
dqb "distro=${distro}"
dqb "removepkgs=${removepkgs}"
dqb "mode=${mode} "

sleep 1
csleep 1

if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_5 1 ${dnsm} ${iface}
	[ $? -gt 0 ] && exit
fi

#====================================================================

function t2p_filler() {
	${lftr} #siirto c_lib:stä tähän tdstoon? tai part2_5 käyttää
	${asy}
	csleep 1
}

#yhteisiä osia daud ja chim t2p
function t2pc() {
	#debug=1
	dqb "common_lib.t2p_common()"
	csleep 1

	dqb "shar_py = ${sharpy} ;"
	csleep 5

	${fib} #uutena 29525, xcalibur...
	csleep 1

	#takaisin 161026
	${sharpy} bluez mutt rpcbind nfs-common
	${sharpy} dmsetup
	t2p_filler
	csleep 5

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

	#HUOM.28525: grub:in kohdalla tuli essential_packages_nalkutusta kun xcalibur
	#${sharpy} grub* 
	${sharpy} gstreamer* #libgs poist alempana
	t2p_filler

	#HUOM.22725:näillä main libsoup poistuu?

	${sharpy} htop inetutils-telnet intel-microcode isolinux
	t2p_filler

	${sharpy} libreoffice*
	t2p_filler

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

	spd="${sd0} -l " #jäänyt turhaksi muuten mutta g_pt2
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
t2pc
[ $? -gt 0 ] && exit
[ ${mode} -eq 0 ] && exit

t2p
[ $? -gt 0 ] && exit
[ ${mode} -eq 1 ] && exit #tähän tökkää?

t2pf ${1}
[ $? -gt 0 ] && exit
[ ${mode} -eq 2 ] && exit

echo "BELLvM C0NTRA HUMAN1TAT3M"
sleep 6

#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
dqb "${whack} xfce4-session 1n 3 s3c5"
sleep 3
${whack} xfce4-session
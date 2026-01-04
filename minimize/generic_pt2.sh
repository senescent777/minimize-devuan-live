#!/bin/bash
distro=$(cat /etc/devuan_version)
d0=$(pwd)

[ z"${distro}" == "z" ] && exit 6
debug=0
d=${d0}/${distro}

mode=3
#HUOM.251025:myös excaliburin kanssa se on nimenomaan mode 3 mikä qsee guin? vielä 271125?

#tartteeko näitä 2 oikeastaan?
function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function parse_opts_1() {
	echo "popt_1( ${1} )"

	if [ -d ${d0}/${1} ] ; then
		distro=${1}
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
	${odio} ${x} ${CONF_dnsm} ${distro}
	#[ -x $x ] && exit for 
done

${fib}
#echo "debug=${debug}"
dqb "distro=${distro}"
dqb "removepkgs=${CONF_removepkgs}"
dqb "mode=${mode} "

sleep 1
csleep 1

#151225:sqroot alla osasi poistella paketteja tämä skripti
if [ ${CONF_removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_5 1 ${CONF_dnsm} ${CONF_iface}
	[ $? -gt 0 ] && exit
fi

#====================================================================

function t2p_filler() {
	dqb "FILLER"
	${lftr}
	${asy}
	csleep 1
}

#jatkossa t2p() ja t2pc() listoja prosessoimalla?
#yhteisiä osia daud ja chim t2p
#VAIH:pkgs_drop hyödyntäminen jatkossa, $d0 parametriksi (joko jo 221225?)
function t2pc() {
	dqb "common_lib.t2p_common( ${1})"
	csleep 1

	[ -z ${1} ] && exit 99
	[ -d ${1} ] || exit 98

	dqb "shar_py = ${sharpy} ;"
	csleep 2

	${fib}
	csleep 1

#	#131225:aiheuttaa oheisvahinkoa, ei voida vielä käyttää ennenq selvitetty missä menee pieleen
#	local f
#	for f in $(grep -v '#' ${1}/pkgs_drop | head -n 10) ; do
#		dqb "sharpy ${f} \*"
#		csleep 1
#		${sharpy} ${f}*
#		csleep 1
#	done

	#040126:poistuuko se mutt vai ei? ehkä, mutta nyt bluez...
	${sharpy} blu*
	t2p_filler
	csleep 2

	${sharpy} mutt
	t2p_filler
	csleep 2

	${sharpy} rpcbind nfs-common
	${sharpy} dmsetup
	t2p_filler
	csleep 2

	${sharpy} amd64-microcode at-spi2-core #toimii systeemi ilmankin näitä mutta ?
	t2p_filler

	${sharpy} bubblewrap coinor* cryptsetup*
	t2p_filler

	${sharpy} debian-faq dirmngr discover* doc-debian
	t2p_filler

	#HUOM.29925: daedaluksessa dmsetup ja libdevmapper? poistuvat jos poistuvat g_doit ajamisen jälkeen
	${sharpy} docutils* dosfstools efibootmgr exfalso
	t2p_filler
	csleep 2

	#040126:eloginin poisto näköjään laittaa äksän pois pelistä
	#${sharpy} elogin*
	#t2p_filler
	#csleep 2

	#tikkujen kanssa paska tdstojärjestelmä exfat
	${sharpy} exfatprogs fdisk gcr ftp*
	t2p_filler

	#231225 uutena, pois jos qsee
	${sharpy} gpgv
	t2p_filler

	${sharpy} gimp-data gir* #ei poista ligtk3, gir-pakettei ei xcalib
	t2p_filler

	#HUOM.28525: grub:in kohdalla tuli essential_packages_nalkutusta kun xcalibur
	#${sharpy} grub* 
	${sharpy} gstreamer* #libgs poist alempana
	t2p_filler

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

	${sharpy} parted pavucontrol
	#libgtk3 ei poistu, libgtk4 kyllä
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

	${sharpy} xorriso 
	t2p_filler

	${sharpy} xz-utils xfburn xarchiver # yad ei ole kaikissa distr
	#xfce*,xorg* off limits
	t2p_filler

	#121225:pitäisi se validi xorg.conf ennenq dumppaa:slim
	#071225:pitäisikö tälle ehdolle tehdä jotain?  uuden .iso:n kanssa kun sitä temppuilua

	if [ -f /.chroot ] ; then
		dqb "SHOULD ${sharpy} slim*"
		csleep 5

		#nopeampi boottaus niinqu
		dqb "KVG \"devuan how to skip dhcp on boot\""
		csleep 5

		#tuli uutena 071225, sittenkin niin päin että asentaa seatd:n ? jos korjaisi "VT 0 acces denied" -ongelman?
		dqb "SHOULD DO SOMETHING ABOUT THAT libseat-problem w/ xorg"
		csleep 5

		dqb "t2p_filler()"
		csleep 5

		#081225:jospa se minimal_live pohjaksi vähitellen, dbus+slim vituttaa
		#dqb "dpkg-reconfigure lxdm?"
		dqb "Xorg -config ? "
		csleep 5
	fi

	spd="${sd0} -l "
	[ ${debug} -gt 0 ] && ${spd} x*
	csleep 1

	dqb "gpt2.T2PC.DONE"
	csleep 1
}

function t2pf() {
	dqb "common_lib.T2P.FINAL( ${1} )"
	csleep 1

	${NKVD} ${CONF_pkgdir}/*.deb
	${NKVD} ${CONF_pkgdir}/*.bin 
	[ -d ${1} ] && ${NKVD} ${1}/*.deb 
	${NKVD} /tmp/*.tar
	${smr} -rf /tmp/tmp.*

	#rikkookohan jotain nykyään? (vuonna 2005 ei rikkonut) (no testaappa taas)
	${smr} -rf /usr/share/doc 

	for f in $(find /var/log -type f) ; do ${smr} ${f} ; done
	df
	${odio} which dhclient; ${odio} which ifup; csleep 3
}

#====================================================================
t2pc ${d0}
[ $? -gt 0 ] && exit
[ ${mode} -eq 0 ] && exit

#TODO:$d/pkgs_drop hyödyntäminen jatkossa
t2p
[ $? -gt 0 ] && exit
[ ${mode} -eq 1 ] && exit

t2pf ${d}
[ $? -gt 0 ] && exit
[ ${mode} -eq 2 ] && exit

echo "BELLvM C0NTRA HUMAN1TAT3M"
csleep 3
${scm} 0555 ${d0}/common_lib.sh 

#tämäntyyppiselle if-blokille voisi tehdä fktion jos mahd
dqb "${whack} xfce4-session 1n 3 s3c5"
sleep 3
${whack} xfce4-session #toimiiko tämä?

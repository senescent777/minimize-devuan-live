#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

function pre_part3() {
	dqb "daud.pp3( ${1} , ${2} )"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	dqb "pp3.2"

	csleep 1
	psqa ${1} #HUOM.22525:varm. vuoksi pp3 kutsuvaan koodiin tämä?
	#HUOM.140525:toiminee jo jollain lailla, "no" siihen kysymykseen olisi kuitenkin kiva saada välitettyä dpkg:lle asti

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/netfilter-persistent*.deb  #${NKVD}
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/libip*.deb #${NKVD}
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables_*.deb
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables-*.deb
#pitäisi varmaan se chmod olla kanssa ensin, varm vuoksi
#	${svm} /etc/iptables/rules.v4 /etc/iptables.rules.v4.$(date +%F)
#	${svm} /etc/iptables/rules.v6 /etc/iptables.rules.v6.$(date +%F)

	dqb "pp3 d0n3"
	csleep 1
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
function pr4() {
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1

	#TODO:tähänkin psqa?
	${odio} dpkg -i ${1}/libpam-modules-bin_*.deb
	${odio} dpkg -i ${1}/libpam-modules_*.deb

	${NKVD} ${1}/libpam-modules*
	csleep 1

	${odio} dpkg -i ${1}/libpam*.deb
	${odio} dpkg -i ${1}/perl-modules-*.deb
	${odio} dpkg -i ${1}/libperl*.deb

	${NKVD} ${1}/perl-modules-*.deb
	${NKVD} ${1}/libperl*.deb
	csleep 1

	${odio} dpkg -i ${1}/perl*.deb
	${odio} dpkg -i ${1}/libdbus*.deb
	${odio} dpkg -i ${1}/dbus*.deb
	csleep 1

	${odio} dpkg -i ${1}/liberror-perl*.deb
	${odio} dpkg -i ${1}/git*.deb

	${NKVD} ${1}/git*.deb
	${NKVD} ${1}/liberror-perl*.deb
	csleep 1

	#TODO:libdevmappwr-juttuja? tai mitä olikaan

	${NKVD} ${1}/libpam*
	${NKVD} ${1}/libperl*
	${NKVD} ${1}/libdbus*
	${NKVD} ${1}/dbus*
	${NKVD} ${1}/perl*
	csleep 1
}

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1

	${smr} ${pkgdir}/libx11-xcb1*
	${smr} ${pkgdir}/nfs*
	${smr} ${pkgdir}/rpc*
	${smr} ${pkgdir}/python3.11*
	${smr} ${pkgdir}/xserver-xorg-core*
	${smr} ${pkgdir}/xserver-xorg-legacy*
	${smr} ${pkgdir}/libgtk-3-bin*
	${smr} ${pkgdir}/libpython3.11*
	${smr} ${pkgdir}/librsvg2*
	
	for s in ${PART175_LIST} ; do
		dqb "processing ${s}"
		csleep 1

		${smr} ${pkgdir}/${s}*
		csleep 1
	done

	case ${iface} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 2
		;;
		*)
			${smr} ${pkgdir}/wpa*
		;;
	esac

	dqb "D0NE"
	csleep 1
}

function part2_pre() {
	dqb "dausd.PP2"
}

function t2p() {
	debug=1
	dqb "UNDER CONSTRUCTION"
	csleep 1

	#voisi kai chim kanssa yhteisiä viedä part2_5:seen
	${sharpy} amd64-microcode at-spi2-core #HUOM.25525:atril ei löydy daedaluksesta
	t2p_filler

	#bluez ei löydy
	${sharpy} bc bubblewrap coinor*
	t2p_filler

	${sharpy} cryptsetup*
	#doc-paketteja saattaisi vaikka tarvitakin mutta
	${sharpy} debian-faq  dirmngr discover* doc-debian
	t2p_filler

	${sharpy} docutils* dosfstools efibootmgr exfalso
	t2p_filler

	#exfatprogs, tarvitseeko?
	${sharpy} exfatprogs fdisk ftp* gcr
	t2p_filler

	#gdisk, ghostscript, gnupg* ei löydy
	${sharpy} gimp-data gir*
	#gpg* voi poistaa liikaa
	t2p_filler

	#gparted, gpg-wks* ei löydy, gpgconf EI poistoon
	${sharpy} gpg-agent gpgsm gpg
	t2p_filler

	#gsasl-common, gsfonts, gvfs ei löydy
	${sharpy} grub* gsettings* gstreamer*
	t2p_filler

	${sharpy} htop inetutils-telnet intel-microcode isolinux iucode-tool
	t2p_filler

	${sharpy} libreoffice*
	t2p_filler

	#jos lib* jättäisi enimmäkseeen rauhaan
	${sharpy} libgstreamer* libpoppler* libsane* #libsasl* poistaa git
	t2p_filler

	#linux* , live* off limits
	${sharpy} lvm2 lynx* mail* #mariadb-common ei löytynyt
	t2p_filler

	#mawk off limits, mdadm ei löytynyt, mokutil ei, mobile ei, mutt ei, mysql ei
	${sharpy} mlocate modem* mtools mythes*
	t2p_filler

	#node* ei löydy, notification* ei löydy, orca ei, os-prober ei
	${sharpy} netcat-traditional ntfs-3g openssh*
	t2p_filler

	#pigz ei löydy, packagekit ei löydy
	${sharpy} p7zip parted pavucontrol
	t2p_filler

	#pinentry ei, po* ei
	${sharpy} ppp plocate pciutils procmail
	t2p_filler

	#procps off limits
	${sharpy} psmisc
	t2p_filler

	#python* parempi jättää rauhaan
	#quodlibet ei löydy, refracta* ei

	${sharpy} ristretto rsync
	t2p_filler

	#sane-utils ei löydy
	${sharpy} screen shim* speech* syslinux*
	t2p_filler

	#telnet e löydy
	${sharpy} tex* tumbler* traceroute
	t2p_filler

	#udisks2 ei löydy, uno ei löydy, ure ei
	${sharpy} upower vim*
	t2p_filler

	${sharpy} w3m wget
	#xfce*,xorg* off limits, xfburn ei löydy
	${sharpy} xorriso xarchiver
	t2p_filler

	${sharpy} yad xz-utils
	t2p_filler

	dqb "D0N3"
	csleep 1
}

check_binaries ${PREFIX}/${distro}
check_binaries2



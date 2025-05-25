#=================================================PART 0=====================================
#
#VAIH:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu
#HUOM.23525:voisi jaksaa chimaera-tapauksenkin testatatata taas

function pre_part3() {
	dqb "ch1m.pp3( ${1} , ${2} )"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	dqb "pp3.2"
	csleep 1

	psqa ${1}
	#HUOM.24525:vaikuttaisi toimivan vähän eri tavalla sääntjen tallennuksen sihteen q daedalus
	#löytyi rules.v4 minkä sisältönä kaikkiin ketjuihin DROP (no vähän patrempi qu ACCEPT)

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/netfilter-persistent*.deb
	csleep 2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/libip*.deb
	csleep 2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables_*.deb
	csleep 2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables-*.deb

	${svm} /etc/iptables/rules.v4 /etc/iptables.rules.v4.$(date +%F)
	${svm} /etc/iptables/rules.v6 /etc/iptables.rules.v6.$(date +%F)

	dqb "pp3 d0n3"
	csleep 6
}

function pr4() {
	dqb "ch1m.pr4( ${1} , ${2} )"
	csleep 3

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

	${NKVD} ${1}/libpam*
	${NKVD} ${1}/libperl*
	${NKVD} ${1}/libdbus*
	${NKVD} ${1}/dbus*
	${NKVD} ${1}/perl*
	csleep 1
}

function udp6() {
	dqb "ch1m.lib.UPDP-6"
	csleep 2

	${NKVD} ${pkgdir}/libx11-xcb1*
	${NKVD} ${pkgdir}/nfs*
	${NKVD} ${pkgdir}/rpc*
	${NKVD} ${pkgdir}/python3.11*
	${NKVD} ${pkgdir}/xserver-xorg-core*
	${NKVD} ${pkgdir}/xserver-xorg-legacy*
	${NKVD} ${pkgdir}/libgtk-3-bin*
	${NKVD} ${pkgdir}/libpython3.11*
	${NKVD} ${pkgdir}/librsvg2*
	
	for s in ${PART175_LIST} ; do
		dqb "processing ${s}"
		csleep 1

		${NKVD} ${pkgdir}/${s}*
		csleep 1
	done

	case ${iface} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 6
		;;
		*)
			${NKVD} ${pkgdir}/wpa*
		;;
	esac

	dqb "D0NE"
	csleep 4
}

function part2_pre() {
	dqb "PP2"
	csleep 1
}

function t2p() {
	dqb "DOES NOT YET WORK PROPERLY"
	csleep 1

	${sharpy} amd64-microcode at-spi2-core atril*
	${lftr}
	${sharpy} bc bluez bubblewrap #bluezin saisi aikaisemminkin pois, åart2_5...
	${lftr}
	${asy}
	csleep 3

	${sharpy} coinor* cryptsetup*
	${lftr}
	${asy}
	csleep 3
	
	#dconf,debconf off limits
	${sharpy} debian-faq  dirmngr discover* doc-debian
	${lftr}
	${asy}
	csleep 3

	${sharpy} docutils* dosfstools efibootmgr exfalso
	${lftr}
	${asy}
	csleep 3

	${sharpy} exfat* fdisk 
	${lftr}
	${asy}
	csleep 3

	${sharpy} ftp* gcr ghostscript gimp-data gir*
	${lftr}
	${asy}
	csleep 3
	
	#gnome* , gpg* off limits , gnupg* ei löydy

	${sharpy} gparted* gpgsm gpg-agent gpg
	${lftr}
	${asy}
	csleep 3
	
	#gsettings-desktop-schemas off limits
	${sharpy} grub* gsasl-common gsfonts* gstreamer*
	${lftr}
	${asy}
	csleep 3

	${sharpy} gvfs* #jljellä?
	#inetutils-telnet mukaan?
	${sharpy} htop intel-microcode isolinux
	${lftr}
	${asy}
	csleep 3
	
	${sharpy} libreoffice*
	${lftr}
	${asy}
	csleep 3

	#lib-jutut jos antaisi enimmäkseen olla rauhassa
	#HUOM. jokin noista johtaa git:in poistoon (libsasl)
	${sharpy} libgstreamer* libpoppler* libsane* libsasl*
	${lftr}
	${asy}
	csleep 3
	
	#linux* , live* off limits
	#lp-solve ei löytynyt?
	${sharpy} lvm2 lynx* mail* mariadb-common
	${lftr}
	${asy}
	csleep 3

	${sharpy} mdadm mlocate mobile* modem*
	${lftr}
	${asy}
	csleep 3

	${sharpy} mtools mysql-common mythes*
	${lftr}
	${asy}
	csleep 3

	${sharpy} netcat-traditional notification-daemon openssh*
	${lftr}
	${asy}
	csleep 3

	#pigz, p7zip ?
	${sharpy} orca packagekit* parted pavucontrol
	${lftr}
	${asy}
	csleep 3

	#TODO:openssh

	${sharpy} pciutils pigz po* ppp
	${lftr}
	${asy}
	csleep 3

	#procps off limits
	${sharpy} procmail ristretto rpcbind sane-utils screen
	${lftr}
	${asy}
	csleep 3

	${sharpy} shim* squash* speech* syslinux-common
	${lftr}
	${asy}
	csleep 3

	#traceroute?
	${sharpy} telnet tex* tumbler-common
	${lftr}
	${asy}
	csleep 3

	${sharpy} vim* xorriso yad xz-utils
	#xfce*,xorg* off limits

	${lftr}
	${asy}
	csleep 3
	
	dqb "D0N3"
	csleep 1
} 

check_binaries ${PREFIX}/${distro}
check_binaries2

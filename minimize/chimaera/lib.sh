#=================================================PART 0=====================================
#
#TEHTY?:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
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
#pitäisi varmaan se chmod olla kanssa ensin, varm vuoksi
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
	t2pc
	csleep 5

	dqb "t2p()"
	csleep 1

	#${sharpy} amd64-microcode at-spi2-core
	${sharpy} atril* #daedaluksess poistui aiemmin
	${lftr}
	${sharpy} bc bluez #daed
	#${sharpy} bubblewrap #bluezin saisi aikaisemminkin pois, art2_5...
	t2p_filler

	#${sharpy} coinor* cryptsetup*
	#t2p_filler

	#dconf,debconf off limits
	#${sharpy} debian-faq  dirmngr discover* doc-debian
	#t2p_filler

	#${sharpy} docutils* dosfstools efibootmgr exfalso
	#t2p_filler

#	${sharpy} exfat* fdisk
#	t2p_filler
#
#	${sharpy} ftp* gcr 
	#HUOM. miten gdisk, löytyykö?
	${sharpy} ghostscript #ei daed
#	${sharpy} gimp-data gir*
#	t2p_filler

	#gnome* , gpg* off limits , gnupg* ei löydy

	${sharpy} gparted* #daud ei löydy
	#${sharpy} gpgsm gpg-agent gpg
	t2p_filler
	
	#gsettings-desktop-schemas off limits
	#${sharpy} grub* 
	${sharpy} gsasl-common #eilöydy d
	${sharpy} gsfonts* #eilöydy
	#${sharpy} gstreamer*
	t2p_filler

	${sharpy} gvfs* #eilöydy
	#${sharpy} htop intel-microcode isolinux inetutils-telnet
	t2p_filler
	
	#löytyykö chimaerasta iucode-tool?

	#${sharpy} libreoffice*
	#t2p_filler

	#lib-jutut jos antaisi enimmäkseen olla rauhassa
	#HUOM. jokin noista johtaa git:in poistoon (libsasl)
	#${sharpy} libgstreamer* libpoppler* libsane* #libsasl*
	#t2p_filler
	
	#linux* , live* off limits
	#lp-solve ei löytynyt?
	#${sharpy} lvm2 lynx* mail* 	
	#${sharpy} mariadb-common #ei löytynyt d
	#t2p_filler

	${sharpy} mdadm # ei d
	#${sharpy} mlocate modem*
	${sharpy} mobile* #ei d

	t2p_filler

	#${sharpy} mtools mythes*
	${sharpy} mysql-common #ei d?
	t2p_filler

	#${sharpy} netcat-traditional openssh*
	#ntfs-3g?
	${sharpy} notification-daemon #ei löydy d
	t2p_filler

	${sharpy} orca packagekit* #ei löydy d
	#{sharpy} p7zip ?
	#${sharpy} parted pavucontrol
	t2p_filler

	#${sharpy} pciutils ppp procmail plocate #löytyykö plocate?
	${sharpy} pigz #ei löydy d
	${sharpy} po* #ei löydy d
	t2p_filler

	#procps off limits
	#löytyykö psmisc? entä rsync?
	#${sharpy} ristretto 
	${sharpy} rpcbind #miten rsync?
	${sharpy} sane-utils #ei löydy d
	#${sharpy} screen
	t2p_filler

	#${sharpy} shim* 
	${sharpy} squash* #löytyykö d?
	#${sharpy} speech* syslinux-common
	t2p_filler

	#traceroute?
	${sharpy} telnet #tartteeko erikseen? olisi se inetutils-telnet myös
	#${sharpy} tex* tumbler-common
	t2p_filler

	#upower? w3m? wget? xarchiver?
	#${sharpy} vim* 
	#${sharpy} xorriso yad xz-utils
	#xfce*,xorg* off limits
	#
	#t2p_filler

	dqb "D0N3"
	csleep 1
} 

check_binaries ${PREFIX}/${distro}
check_binaries2

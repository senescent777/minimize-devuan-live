#=================================================PART 0=====================================
#
#VAIH:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu
#HUOM.23525:voisi jaksa chimaera-tapauksenkin testatatata taas

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

	#${svm} /etc/iptables/rules.v4 /etc/iptables.rules.v4.$(date +%F)
	#${svm} /etc/iptables/rules.v6 /etc/iptables.rules.v6.$(date +%F)

	dqb "pp3 d0n3"
	csleep 6
}

#HUOM.14525:pitäisiköhän tässäkin olla se debian_fromtend-juttu?
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
#	${sharpy} python3-cups
#	csleep 5
}

function t2p() {
	#HUOM.24545:näköjään ei poistunut tokan rivin listasta mikään. kts jos toistuu
	#tulisi kai selvittää, onko oikeasti poissa vai kaipaako jokin välimuisti päivitystä

	${sharpy} amd64-microcode iucode-tool arch-test at-spi2-core 
	${sharpy} bubblewrap atril* coinor* cryptsetup* debootstrap

	#HUOM.23525:poistettavien listaa pystyisi ehkä säätämään vielä, dpkg -l

	${asy} 
	${lftr}
	csleep 5

	${sharpy} dmidecode discover* dirmngr #tuleekohan viimeisestä ongelma? vissiin ei
	${sharpy} doc-debian docutils* efibootmgr exfalso 
	${sharpy} fdisk ftp* gdisk gcr

	${asy} 
	${lftr}
	csleep 5

	##gnome-* poisto veisi myös: task-desktop task-xfce-desktop
	##gpg* kanssa: The following packages have unmet dependencies:
	## apt : Depends: gpgv but it is not going to be installed or
	##                gpgv2 but it is not going to be installed or
	##                gpgv1 but it is not going to be installed
	##HUOM. grub* poisto voi johtaa shim-pakettien päivitykseen
	##gsettings* voi viedä paljon paketteja mukanaan

	dqb "g2"
	csleep 5

	${sharpy} ghostscript gir* gnupg* gpg-*
	${sharpy} gpgconf gpgsm gsasl-common shim*
	${sharpy} grub* gsfonts gstreamer* #gs-jutut tilassa ic

	#htop ei poistunut eikä microcode-jutut
	${sharpy} intel-microcode iucode-tool htop inetutils-telnet

	${asy} 
	${lftr}
	csleep 5

	#lib-paketteihin ei yleisessä tapauksessa kande koskea eikä live-
	#libgssapi-krb5 tarpeellinen?
	#HUOM! PAKETIT procps, mtools JA mawk JÄTETTÄVÄ RAUHAAN!!! (tai mtools ehkä uskaltaa kun o muitsa poistettu ensin)

	#HUOM.15525:uutena libcolor, näytti poistavan liikaa joten jemmaan
	#${sharpy} libcolor* 
	#csleep 5

	#libgphoto edelleen läsnä kuten libgssapi
	${sharpy} libpoppler* libuno* libreoffice* libgsm* libgstreamer*
	${sharpy} lvm2 lynx* mdadm mailcap #nämä tilassa ic

	${asy} 
	${lftr}
	csleep 5

	${sharpy} mlocate mokutil mariadb-common mysql-common
	${sharpy} netcat-traditional openssh* os-prober #orca saattaa poistua jo aiemmin
	${sharpy} nfs-common rpcbind
	#policykit-*,  pop-con ja powertop edelleen ii

	csleep 5
	dqb "p"
	csleep 5

	${sharpy} ppp procmail ristretto screen
	${sharpy} pkexec po* refracta* squashfs-tools #reftactat enimmäkseen ii kuten myös squashfs
	
	${asy} 
	${lftr}
	csleep 5

	#HUOM.15525 vaikuttaisi toimivan, ajon jälkeen x toimii edelleen
	${sharpy} samba* system-config* telnet tex*  #nämä edlleen ii

	#VAIH:, python3*, , voisiko niitä karsia?
	${sharpy} syslinux* mythes isolinux libgssapi-krb5-2 #nämä edelleen ii

	${sharpy} uno* ure* upower vim* #upower ja vim edelleen
	${asy} 
	${lftr}
	csleep 5

	dqb "x"
	csleep 5
	${sharpy} xorriso xfburn #edelleen
	${asy} 

	${lftr}
	${NKVD} ${pkgdir}/*.deb
	${NKVD} ${pkgdir}/*.bin 
	${NKVD} ${d}/*.deb 
	${NKVD} /tmp/*.tar
	${smr} -rf /tmp/tmp.*

	${smr} -rf /usr/share/doc 
	#rikkookohan jotain nykyään? (vuonna 2005 ei rikkonut)

	#squ.ash voisi vilkaista kanssa liittyen (vai oliko mitään hyödyllistä siellä vielä?)
	df
	${odio} which dhclient; ${odio} which ifup; csleep 6
} 

check_binaries ${PREFIX}/${distro}
check_binaries2

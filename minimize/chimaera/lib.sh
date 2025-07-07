#=================================================PART 0=====================================
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

#jokin dpkg/apt-jekku kutsuvassa koodissa voisi ajaa saman asian, ehkä
function pr4() {
	dqb "ch1m.pr4( ${1} , ${2} )"
	csleep 1

	${sdi} ${1}/libpam-modules-bin_*.deb
	${sdi} ${1}/libpam-modules_*.deb

	${NKVD} ${1}/libpam-modules*
	csleep 1

	${sdi} ${1}/libpam*.deb
	${sdi} ${1}/perl-modules-*.deb
	${sdi} ${1}/libperl*.deb

	${NKVD} ${1}/perl-modules-*.deb
	${NKVD} ${1}/libperl*.deb
	csleep 1

	${sdi} ${1}/perl*.deb
	${sdi} ${1}/libdbus*.deb
	${sdi} ${1}/dbus*.deb
	csleep 1

	${sdi} ${1}/liberror-perl*.deb
	${sdi} ${1}/git*.deb

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
	csleep 1

	#mahd. yhteisiä osia voisi siirtää
	#HUOM.30525:pitäisikö nämäkin kahlata läpi uudestaan? että mitä niille tekee niinqu
	${NKVD} ${1}/libx11-xcb1*
	${NKVD} ${1}/nfs*
	${NKVD} ${1}/rpc*
	${NKVD} ${1}/python3.11*
	${NKVD} ${1}/xserver-xorg-core*
	${NKVD} ${1}/xserver-xorg-legacy*
	${NKVD} ${1}/libgtk-3-bin*
	${NKVD} ${1}/libpython3.11*
	${NKVD} ${1}/librsvg2*

	dqb "D0NE"
	csleep 1
}

function t2p() {
	csleep 1

	dqb "t2p()"
	csleep 1

	${sharpy} atril* #daedaluksess poistui aiemmin
	${lftr}
	${sharpy} bc bluez #daed
	t2p_filler

	#dconf,debconf off limits
	#HUOM. miten gdisk, löytyykö?
	${sharpy} ghostscript #ei daed

	#gnome* , gpg* off limits , gnupg* ei löydy
	${sharpy} gparted* #daud ei löydy
	t2p_filler
	
	#gsettings-desktop-schemas off limits
	${sharpy} grub* #HUOM.28525:syystä excalibur prujattu tähän
	${sharpy} gsasl-common #eilöydy d
	${sharpy} gsfonts* #eilöydy
	t2p_filler

	${sharpy} gvfs* #eilöydy
	t2p_filler
	
	#löytyykö chimaerasta iucode-tool?
	#lib-jutut jos antaisi enimmäkseen olla rauhassa
	#linux* , live* off limits
	#lp-solve ei löytynyt?	
	#${sharpy} mariadb-common #ei löytynyt d

	${sharpy} mdadm # ei d
	${sharpy} mobile* #ei d
	t2p_filler

	${sharpy} mysql-common #ei d?
	t2p_filler

	#ntfs-3g?
	${sharpy} ntp* #HUOM.28525:syystä excalibur prujattu tähän	
	${sharpy} notification-daemon #ei löydy d
	t2p_filler

	${sharpy} orca packagekit* #ei löydy d
	#{sharpy} p7zip ?
	t2p_filler

	#löytyykö plocate?
	${sharpy} pigz #ei löydy d
	${sharpy} po* #ei löydy d
	t2p_filler

	#procps off limits
	#löytyykö psmisc? entä rsync?
	${sharpy} rpcbind #miten rsync?
	${sharpy} sane-utils #ei löydy d
	t2p_filler

	${sharpy} squash* #löytyykö d?
	t2p_filler

	#traceroute?
	${sharpy} telnet #tartteeko erikseen? olisi se inetutils-telnet myös
	t2p_filler

	#upower? w3m? wget? xarchiver?
	#xfce*,xorg* off limits

	dqb "D0N3"
	csleep 1
} 

function pre_part2() {
	dqb "ch1m.pre_part2()"
	csleep 1

	${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana
}


check_binaries ${PREFIX}/${distro}
check_binaries2

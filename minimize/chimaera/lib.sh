#=================================================PART 0=====================================
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

##VAIH:chimaera-version toiminnnan testaus vähitellen koska syyt
##jokin dpkg/apt-jekku kutsuvassa koodissa voisi ajaa saman asian, ehkä
#function pr4() {
#	dqb "ch1m.pr4( ${1} , ${2} )"
##	csleep 1
##
##	efk1 ${1}/libpam-modules-bin_*.deb
##	efk1 ${1}/libpam-modules_*.deb
##	${NKVD} ${1}/libpam-modules*
##	csleep 1
#
##	efk1 ${1}/libpam*.deb
##	efk1 ${1}/perl-modules-*.deb
##	efk1 ${1}/libperl*.deb
#
##	csleep 1
#
##	efk1 ${1}/perl*.deb
##	efk1 ${1}/libdbus*.deb
##	efk1 ${1}/dbus*.deb
##	csleep 1
#
##	efk1 ${1}/liberror-perl*.deb
##	efk1 ${1}/git*.deb
##	csleep 1
#}
#
#function reficul() {
#	dqb "chim.reticul is UNDER CONSTRUCTION"
#}
#
#HUOM.28925:testaisiko josqs uudestaan tapaus chimaera? entä xcalibur?
function udp6() {
	dqb "ch1m.lib.UPDP-6"
	csleep 1

	dqb "D0NE"
	csleep 1
}

function t2p() {
	csleep 1

	dqb "chim.t2p()"
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

function tpc7() {
	dqb "c.tpc7 UNDER CONSTRUCTION"
}

check_binaries ${d} #globaalit perseestä, $(pwd) tilalle?
check_binaries2
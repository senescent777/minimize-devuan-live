#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

#HUOM. tarvitseeko 2. parametrin? nyt (270525) tietysti $dnsm ettei liikaa glob. mjia (VAIH)
function pre_part3() {
	dqb "daud.pp3( ${1} , ${2} )"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	[ -z ${2} ] && exit
	dqb "pp3.2"

	csleep 1
	psqa ${1} #HUOM.22525:varm. vuoksi pp3 kutsuvaan koodiin tämä?
	
	#HUOM.140525:toiminee jo jollain lailla, "no" siihen kysymykseen olisi kuitenkin kiva saada välitettyä dpkg:lle asti
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=iptables=1.8.9-2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/libip*.deb

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables_*.deb
	
	csleep 3
	${scm} 0755 /etc/iptables

	local s
	local t
	local u

	s=$(${odio} which iptables-restore)
	t=$(${odio} which ip6tables-restore)
	u=${2} #ei sitä echo-cut-jekkua tämän kanssa, ainakaan vielä (jokin tr sen sijaan...)

	${odio} ${s} /etc/iptables/rules.v4.${u}
	${odio} ${t} /etc/iptables/rules.v6.${u}

	csleep 3
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=netfilter-persistent=1.0.20
	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/netfilter-persistent*.deb

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=iptables-persistent=1.0.20
	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables-*.deb

	csleep 1
	${scm} 0550 /etc/iptables	

	dqb "pp3 d0n3"
	csleep 1
}

function c5p() {
	${NKVD} ${1}/xz*
	${NKVD} ${1}/cryptsetup* #jos alkaa leikkiä encrypted-lvm-on-raid5-leikkejä niin sitten pois tämä rivi
	${NKVD} ${1}/libcrypt*
	${NKVD} ${1}/libdevmapper*
	${NKVD} ${1}/libsoup*
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
#HUOM.26525:2. parametri, tartteeko moista?

function pr4() {
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1

	#TODO:tähänkin psqa?
	${sdi} ${1}/libpam-modules-bin_*.deb
	${sdi} ${1}/libpam-modules_*.deb

	${NKVD} ${1}/libpam-modules*

	${sdi} ${1}/libpam*.deb
	${sdi} ${1}/perl-modules-*.deb
	${sdi} ${1}/libperl*.deb

	${NKVD} ${1}/perl-modules-*.deb
	${NKVD} ${1}/libperl*.deb

	${sdi} ${1}/perl*.deb
	${sdi} ${1}/libdbus*.deb
	${sdi} ${1}/dbus*.deb

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
	
	c5p ${1}
	csleep 1
}

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1

	#aiheuttavat nalkutusta (tai miten lienee nykyään? jos kokeilisi)
	${NKVD} ${1}/libx11-xcb1*
	${NKVD} ${1}/nfs*
	${NKVD} ${1}/rpc*
	${NKVD} ${1}/python3.11*
	${NKVD} ${1}/xserver-xorg-core*
	${NKVD} ${1}/xserver-xorg-legacy*
	${NKVD} ${1}/libgtk-3-bin*
	${NKVD} ${1}/libpython3.11*
	${NKVD} ${1}/librsvg2*
	
	c5p ${1}

	dqb "D0NE"
	csleep 1
}

#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=xcvt=0.1.2-1
function t2p() {
	debug=1
	dqb "DAUD.T2P()"
	csleep 3

	#voisi kai chim kanssa yhteisiä viedä part2_5:seen`?
	#HUOM.25525:atril ei löydy daedaluksesta
	#bluez ei löydy, bc taisi poistua aiemmin
	#doc-paketteja saattaisi vaikka tarvitakin mutta
	#exfatprogs, tarvitseeko?
	#gdisk, ghostscript, gnupg* ei löydy
	#gpg* voi poistaa liikaa
	#gparted, gpg-wks* ei löydy, gpgconf EI poistoon

	#gsasl-common, gsfonts, gvfs ei löydy
	${sharpy} arch-test
	${sharpy} grub* #HUOM.28525:syystä excalibur prujattu tähän
	${sharpy} gsettings* #uskaltaako poistaa chimaerassa?
	t2p_filler

	${sharpy} iucode-tool #löytyykö chimaerasta?
	t2p_filler

	#jos lib* jättäisi enimmäkseeen rauhaan
	#linux* , live* off limits
	#mariadb-common ei löytynyt
	#lp-solve? mysql-common?
	#mawk off limits, mdadm ei löytynyt, mokutil ei, mobile ei, mutt ei, mysql ei

	#node* ei löydy, notification* ei löydy, orca ei, os-prober ei
	${sharpy} ntp* #HUOM.280525:excalibur-syistä siirretty tähän
	${sharpy} ntfs-3g #tilassa rc
	t2p_filler

	#pigz ei löydy, packagekit ei löydy
	${sharpy} p7zip
	t2p_filler

	#pinentry ei, po* ei
	#procps off limits

	${sharpy} psmisc
	t2p_filler

	#python* parempi jättää rauhaan
	#quodlibet ei löydy, refracta* ei

	${sharpy} rsync squashfs-tools
	#löytyykö rpcbind?
	t2p_filler

	#sane-utils ei löydy
	#löytyykö squash?

	#telnet e löydy
	${sharpy} traceroute
	t2p_filler

	#udisks2 ei löydy, uno ei löydy, ure ei
	${sharpy} upower 
	t2p_filler

	${sharpy} w3m wget
	#xfce*,xorg* off limits, xfburn ei löydy
	#${sharpy} xarchiver
	t2p_filler

	dqb "D0N3"
	csleep 1
}

check_binaries ${PREFIX}/${distro}
check_binaries2



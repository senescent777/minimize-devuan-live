#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

#HUOM. tarvitseeko 2. parametrin? nyt (270525) tietysti $dnsm ettei liikaa glob. mjia
function pre_part3() {
	dqb "daud.pp3( ${1} , ${2} )"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	[ -z ${2} ] && exit

	local d2
	d2=$(echo ${2} | tr -d -c 0-9)

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

	s=$(${odio} which iptables-restore)
	t=$(${odio} which ip6tables-restore)
	
	${odio} ${s} /etc/iptables/rules.v4.${d2}
	${odio} ${t} /etc/iptables/rules.v6.${d2}

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
	dqb "CCCP( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	${NKVD} ${1}/xz*
	${NKVD} ${1}/cryptsetup* #jos alkaa leikkiä encrypted-lvm-on-raid5-leikkejä niin sitten pois tämä rivi
	${NKVD} ${1}/libcrypt*
	${NKVD} ${1}/libdevmapper*
	${NKVD} ${1}/libsoup*

	${NKVD} ${1}/xserver* #HUOM.31525:nalkutusta, pois
	${NKVD} ${1}/libgtk-3* 
	${NKVD} ${1}/librsvg*

	dqb "...is over"
	csleep 1
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
#HUOM.26525:2. parametri, tartteeko moista?
function pr4() {
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"

	#HUOM.31525:listasta joutaisi vähän karsia loppupäästä
	${sdi} ${1}/gcc-12*.deb
	${sdi} ${1}/libc6_2.36-9+deb12u10_amd64.deb  ${1}/libgcc-s1_12.2.0-14+deb12u1_amd64.deb 
	${sdi} ${1}/libstdc*.deb
	${sdi} ${1}/libglib*.deb ${1}/libmount*.deb ${1}/libblk*.deb
	${sdi} ${1}/lilbwebp*.deb
	${sdi} ${1}/libtiff*.deb ${1}/liblzma5*.deb
	${sdi} ${1}/libgnutls*.deb ${1}/libtasn*.deb
	${sdi} ${1}/libssl3*.deb ${1}/libk*.deb ${1}/libgss*
	${sdi} ${1}/libcups* ${1}/libavahi* ${1}/libdbus*
	${sdi} ${1}/libx11-6*
	${sdi} ${1}/libcap2*
	${sdi} ${1}/libcurl* ${1}/libnghttp*
	${sdi} ${1}/libdav*
	${sdi} ${1}/libeudev*
	${sdi} ${1}/libfdisk* libuuid* #mihin näitä tarvittiin?
	${sdi} ${1}/libfreetype*
	${sdi} ${1}/libgnutls*
	${sdi} ${1}/libisl*
	${sdi} ${1}/libltd*
	${sdi} ${1}/libmpg*
	${sdi} ${1}/libnf*
	${sdi} ${1}/libnss* ${1}/libsqlite*
	${sdi} ${1}/libopen*  ${1}/libpolkit-gobject-* 
	${sdi} ${1}/libpython3.11-*
	${sdi} ${1}/libav* ${1}/libsw*
	#${sdi} ${1}/libvte*.deb

	csleep 1

	${NKVD} ${1}/gcc-12*.deb
	${NKVD} ${1}/libgcc*.deb
	${NKVD} ${1}/libc6*
	${NKVD} ${1}/libstdc*.deb
	${NKVD} ${1}/libglib*.deb
	${NKVD} ${1}/libmount*.deb
	${NKVD} ${1}/libblk*
	${NKVD} ${1}/libtiff*.deb
	${NKVD} ${1}/liblzma5*.deb
	${NKVD} ${1}/libgnutls*.deb 
	${NKVD} ${1}/libtasn*.deb
	${NKVD} ${1}/libssl3*.deb 
	${NKVD} ${1}/libk*.deb 
	${NKVD} ${1}/libgss*
	${NKVD} ${1}/libcups* 
	${NKVD} ${1}/libavahi* 
	${NKVD} ${1}/libdbus*
	${NKVD} ${1}/libx11-6*
	${NKVD} ${1}/libcap2*
	${NKVD} ${1}/libcurl* 
	${NKVD} ${1}/libnghttp*
	${NKVD} ${1}/libdav*
	${NKVD} ${1}/libeudev*
	${NKVD} ${1}/libfreetype*
	${NKVD} ${1}/libgnutls*
	${NKVD} ${1}/libisl*
	${NKVD} ${1}/libltd*
	${NKVD} ${1}/libmpg*
	${NKVD} ${1}/libnss*
	${NKVD} ${1}/libsqlite*
	${NKVD} ${1}/libopen*
	${NKVD} ${1}/libpolkit-gobject-* #voisiko näitä poistaa?
	${NKVD} ${1}/libpython3.11-*
	${NKVD} ${1}/libsw*
	${NKVD} ${1}/libav*
	#${NKVD} ${1}/libvte*.deb
	
	csleep 1	

	#HUOM.31525:vituttava määrä asentelua librsvg2 kanssa edelleen

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
	#${sdi} ${1}/libdbus*.deb
	${sdi} ${1}/dbus*.deb

	${sdi} ${1}/liberror-perl*.deb
	${sdi} ${1}/git*.deb

	${NKVD} ${1}/git*.deb
	${NKVD} ${1}/liberror-perl*.deb
	csleep 1

	${NKVD} ${1}/libpam*
	${NKVD} ${1}/libperl*
	#${NKVD} ${1}/libdbus*
	${NKVD} ${1}/dbus*
	${NKVD} ${1}/perl*
	
	c5p ${1}
	csleep 1
}

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	#aiheuttavat nalkutusta (tai miten lienee nykyään? jos kokeilisi)
#	${NKVD} ${1}/libx11-xcb1* #HUOM.30525:tämä nyt erityisesti aiheuttaa härdelliä, tarttisko tehrä jotain?
#HUOM.tuon poisto poistaa äksän ja xfce:n joten purge ei optio

#	${NKVD} ${1}/nfs*
#	${NKVD} ${1}/rpc*
#	${NKVD} ${1}/python3.11*
#	${NKVD} ${1}/xserver-xorg-core*
#	${NKVD} ${1}/xserver-xorg-legacy*
#	${NKVD} ${1}/libgtk-3-bin*
#	${NKVD} ${1}/libpython3.11*
#	${NKVD} ${1}/librsvg2*
	
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

function pre_part2() {
	dqb "daud.pre_part2()"
	csleep 1

	${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana
	dqb "d0n3"
}

check_binaries ${PREFIX}/${distro}
check_binaries2



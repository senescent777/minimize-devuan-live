#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

function c5p() {
	dqb "CCCP( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	#TODO:josko poistaisi ao. paketit jossain? t2p()? no g_pt2 poistaa 2 ekaa jo valmiiksi
	${NKVD} ${1}/xz* #t2p() poistaa

	${NKVD} ${1}/cryptsetup* #jos alkaa leikkiä encrypted-lvm-on-raid5-leikkejä niin sitten pois tämä rivi
	#g_pt2 poistaa cryptsetup-pakettei
	
	${NKVD} ${1}/libcrypt* #ei uskalla poistaa
	${NKVD} ${1}/libdevmapper* #ei ole sannettuna noita (tilanne 19725)
	${NKVD} ${1}/libsoup* #eiole

	${NKVD} ${1}/xserver* #HUOM.31525:nalkutusta, pois toistaiseksi (ja aptin kautta ei tod poisteta)
	
	# libgtk-3-bin depends on libgtk-3-0 (>= 3.24.38-2~deb12u3); however:
  	#Version of libgtk-3-0:amd64 on system is 3.24.37-2.
	${NKVD} ${1}/libgtk-3-bin* #HUOM.19725:edelleen nalqttaa
	#HUOM.libgtk-3-paketteja ei uskalla poistaa aptilla, liikaa oheisvah

	# librsvg2-common:amd64 depends on librsvg2-2 (= 2.54.7+dfsg-1~deb12u1); however:
	#  Version of librsvg2-2:amd64 on system is 2.54.5+dfsg-1.
	#
	#dpkg: error processing package librsvg2-common:amd64 (--install):
	# dependency problems - leaving unconfigured
	#Processing triggers for libgdk-pixbuf-2.0-0:amd64 (2.42.10+dfsg-1+b1) ...
	#Errors were encountered while processing:
	# librsvg2-common:amd64

	${NKVD} ${1}/librsvg* #eniten nalkutusta vissiin tästä, jos koittaisi uudestaan josqs
	#HUOM.19725:librsvg2 poistaa jnkn verran pak, mm task-desktop, task-xfce-desktop

	dqb "...is over"
	csleep 1
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
#HUOM.26525:2. parametri, tartteeko moista?

function pr4() {
	debug=1
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"

	#TODO:efk()
	#HUOM.31525:listasta joutaisi vähän karsia loppupäästä

	${sdi} ${1}/gcc-12*.deb
	${sdi} ${1}/libc6_2.36-9+deb12u10_amd64.deb ${1}/libgcc-s1_12.2.0-14+deb12u1_amd64.deb 
	${sdi} ${1}/libstdc*.deb
	${sdi} ${1}/libglib*.deb ${1}/libmount*.deb ${1}/libblk*.deb
	${sdi} ${1}/lilbwebp*.deb
	${sdi} ${1}/libtiff*.deb ${1}/liblzma5*.deb
	${sdi} ${1}/libgnutls*.deb ${1}/libtasn*.deb
	${sdi} ${1}/libssl3*.deb ${1}/libk*.deb ${1}/libgss*
	${sdi} ${1}/libcups* ${1}/libavahi* ${1}/libdbus*
	${sdi} ${1}/libx11-6*
	${sdi} ${1}/libcap2*
	${sdi} ${1}/libcurl* ${1}/libnghttp* #mihin näitä tarvittiin?
	${sdi} ${1}/libdav*
	${sdi} ${1}/libeudev*
	${sdi} ${1}/libfdisk* ${1}/libuuid* #mihin näitä tarvittiin?
	${sdi} ${1}/libfreetype*
	${sdi} ${1}/libgnutls*
	${sdi} ${1}/libisl*
	${sdi} ${1}/libltd*
	${sdi} ${1}/libmpg*
	${sdi} ${1}/libnf*
	${sdi} ${1}/libnss* ${1}/libsqlite*
	${sdi} ${1}/libopen* ${1}/libpolkit-gobject-* 
	${sdi} ${1}/libpython3.11-*
	${sdi} ${1}/libav* ${1}/libsw*
	csleep 1

	dqb "LIBVTE"
	${sdi} ${1}/libvte*.deb #TODO:miten tämän kanssa nykyään
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
	csleep 1

	${NKVD} ${1}/libvte*.deb	
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

	#nalqtusta aiheuttavat paketit nykyään:kts. c5p()
#	${NKVD} ${1}/libx11-xcb1* #HUOM.30525:tämä nyt erityisesti aiheuttaa härdelliä, tarttisko tehrä jotain?
#HUOM.tuon poisto poistaa äksän ja xfce:n joten ei
	
	c5p ${1}
	dqb "D0NE"
	csleep 1
}

#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=xcvt=0.1.2-1
function t2p() {
	#debug=1
	dqb "DAUD.T2P()"
	csleep 1

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

	echo "KARTHAGO EST DELENDAM"
	csleep 6

	#JOKO JO PERKELE POISTUISI?
	${sharpy} xorriso*
	${asy} #varm. vuoksi
	csleep 2

	${sharpy} xorriso*
	${asy} #varm. vuoksi
	csleep 2

	${sharpy} xorriso*
	${asy} #varm. vuoksi
	csleep 2

	${sharpy} xz-utils #xz* jatkossa?
	${asy} #varm. vuoksi
	csleep 2
 
	${sharpy} xfburn 
	${asy} #varm. vuoksi
	sleep 2

	${sharpy} xarchiver 
	${asy} #varm. vuoksi
	sleep 2

	#debug=1
	${scm} a-wx ${0}
	csleep 2
}

#josko kuitenkin ntp takaisin listaan?
function pre_part2() {
	dqb "daud.pre_part2()"
	csleep 2

	#${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana

	for f in $(find /etc/init.d -type f -name 'ntp*') ; do 
		${odio} ${f} stop
		csleep 1
	done

	csleep 2
	dqb "d0n3"
}

function tpc7() {
	dqb "d.prc7 UNDER CONSTRUCTION"
}

check_binaries ${PREFIX}/${distro}
check_binaries2



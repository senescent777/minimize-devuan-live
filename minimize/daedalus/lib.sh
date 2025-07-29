#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

function c5p() { #HUOM.28725:testattu, toiminee
	dqb "CCCP( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	${NKVD} ${1}/xz* #toisaalta t2p() poistaa

	${NKVD} ${1}/cryptsetup* #jos alkaa leikkiä encrypted-lvm-on-raid5-leikkejä niin sitten pois tämä rivi
	#g_pt2 poistaa cryptsetup-pakettei
	
	#tästä eteenpäin jos selvittäisi noiden pakettien tilanteen, piostuuko jossain jnkn sivuvakutuksebna?
	${NKVD} ${1}/libcrypt* #ei uskalla poistaa aptilla
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

	#näistä tyli nalkutusta sqush-cgrootin sisällä, uudempi g_py2-kierros paikallaan
	#HUOM.28725:pitäisiköhän vim-paketit poistaa? g_pt2.t2pc() poistaa
	${NKVD} ${1}/vim*
	${NKVD} ${1}/libreoffice*

#HUOM.29725:päivityspakettia rakennettaessa jokin kusi, korjaa (TODO)
#dpkg: dependency problems prevent configuration of libavif15:amd64:
# libavif15:amd64 depends on libgav1-1 (>= 0.18.0); however:
#  Package libgav1-1 is not installed.
# libavif15:amd64 depends on libyuv0 (>= 0.0~git20221206); however:
#  Package libyuv0 is not installed.
#	${NKVD} ${1}/libavi*
#
#	${NKVD} ${1}/libgst* #g_pt2 oikeastaan...
#	${NKVD} ${1}/gstreamer*
#	${NKVD} ${1}/mutt*
#
#	${NKVD} ${1}/libwebkit*
#	${NKVD} ${1}/libzbar0*
#
	dqb "...is over"
	csleep 1
}

function reficul() {
	dqb "NATTA5H3AD 0VERDR1V3 666!"
	csleep 1

	#HUOM.31525:listasta joutaisi vähän karsia loppupäästä
	efk ${1}/gcc-12*.deb

	#tarteeko olla noin tarkka nimestä?
	efk ${1}/libc6_2.36-9+deb12u10_amd64.deb ${1}/libgcc-s1_12.2.0-14+deb12u1_amd64.deb 
	efk ${1}/libstdc*.deb
	efk ${1}/libglib*.deb ${1}/libmount*.deb ${1}/libblk*.deb
	
	#efk ${1}/libwebp*.deb #menikö nimi oikein?
	#myös:https://thehackernews.com/2023/09/new-libwebp-vulnerability-under-active.html
	#tarttisko tehdä jotain vai ei?
	#${NKVD} libwebp*.deb

	efk ${1}/libtiff*.deb ${1}/liblzma5*.deb
	efk ${1}/libgnutls*.deb ${1}/libtasn*.deb

	efk ${1}/libssl3*.deb ${1}/libk*.deb ${1}/libgss*
	efk ${1}/libcups* ${1}/libavahi* ${1}/libdbus* #tartteeko 2 ekaa asentaa? voisik sen sijaan poistaa?
	efk ${1}/libx11-6*

	efk ${1}/libcap2*
	efk ${1}/libcurl* ${1}/libnghttp* #mihin näitä tarvittiin?
	efk ${1}/libdav* #tai tätä?

	efk ${1}/libeudev*
	efk ${1}/libfdisk* ${1}/libuuid* #mihin näitä tarvittiin?
	efk ${1}/libfreetype*

	efk ${1}/libisl*
	efk ${1}/libltd*
	efk ${1}/libmpg*

	efk ${1}/libnf*
	efk ${1}/libnss* ${1}/libsqlite*
	efk ${1}/libopen* ${1}/libpolkit-gobject-* #jälkimm pak pios?

	efk ${1}/libpython3.11-*
	efk ${1}/libav* ${1}/libsw*
	csleep 1

	dqb "LIBVTE"
	efk ${1}/libvte*.deb #VAIH:selv miten tämän kanssa nykyään?
	csleep 1

	#HUOM.31525:vituttava määrä asentelua librsvg2 kanssa edelleen
	dqb "---------------------------------------------------"
	csleep 5
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
#HUOM.26525:2. parametri, tartteeko moista?
#HUOM.21725:pitäisiköhän tätä sorkkia? kun sen yhden päivityspaketin kanssa ongelma (olisikohan jo korjautunut 24725 mennessä?)

function pr4() {
	#debug=1 #josqs pois?
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"

	psqa ${1}
	efk ${1}/libpam-modules-bin_*.deb
	efk ${1}/libpam-modules_*.deb
	${NKVD} ${1}/libpam-modules* #tartteeko enää?

	efk ${1}/libpam*.deb
	efk ${1}/perl-modules-*.deb
	efk ${1}/libperl*.deb

	efk ${1}/perl*.deb
	efk ${1}/dbus*.deb

	efk ${1}/liberror-perl*.deb
	efk ${1}/git*.deb
	csleep 1
	
	c5p ${1}
	csleep 1
}

function udp6() { #HUOM.28725:testattu, toiminee
	dqb "daud.lib.UPDP-6"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	#nalqtusta aiheuttavat paketit nykyään:kts. c5p()
	${NKVD} ${1}/libx11-xcb1* #HUOM.30525:tämä nyt erityisesti aiheuttaa härdelliä, tarttisko tehrä jotain?
#HUOM.tuon poisto(aptilla) poistaa äksän ja xfce:n joten ei
	
	c5p ${1}
	dqb "D0NE"
	csleep 1
}

#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=xcvt=0.1.2-1 (miten taas liittyi mihinkään?)

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

	${sharpy} xz* #jatkossa?
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

#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=netfilter-persistent=1.0.20
#https://pkgs.org/download/linux-image-6.12.27-amd64 ... joskohan ethz kautta
#... tarkistus tosin uusiksi, josko sinne tcdd-blokkiin ylemmäs?

function tpc7() { #e22.sh kutsuu tätä nykyään
	dqb "d.prc7 UNDER CONSTRUCTION"
}

check_binaries ${d}
check_binaries2

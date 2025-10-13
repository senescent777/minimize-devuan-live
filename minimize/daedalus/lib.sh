#=================================================PART 0=====================================

#https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

#HUOM.29925:nalkutukset lib-paketeista tulivat näköjään takaisin kun part3:sessa korvattu ekf find-jekulla, jotain tarttisi tehrä asialle
# (import2 3 $archive aiheuttajana) 

#grep -v '#' daedalus/lib.sh | grep NKVD | awk '{print $2}' > reject_pkgs
#grep -v '#' daedalus/lib.sh | grep efk1 | grep lib | awk '{print $2}' > accept_pkgs_1
#grep -v '#' daedalus/lib.sh | grep efk1 | grep -v lib | awk '{print $2}' > accept_pkgs_2

#iface-riippuvainen pakettien poisto, kts part2_5()
function c5p() { #joskohan jo toimisi (28925)
	dqb "CCCP( ${1} , ${2} )"
	csleep 3
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 3

	local p
	local q
	p=$(pwd)
	cd ${1}
	
#	dqb "xz"
#	${NKVD} xz* #toisaalta t2p() poistaa
#	ls -las xz* 
#	csleep 3
#
#	${NKVD} cryptsetup* #jos alkaa leikkiä encrypted-lvm-on-raid5-leikkejä niin sitten pois tämä rivi
#	#g_pt2 poistaa cryptsetup-pakettei
#
#	#tästä eteenpäin jos selvittäisi noiden pakettien tilanteen, piostuuko jossain jnkn sivuvakutuksebna?
#	${NKVD} libcrypt* #ei uskalla poistaa aptilla
#	#${NKVD} libdevmapper* #asennettuna 28925?
#	#${NKVD} libsoup* #eiole

#	#HUOM.19725:librsvg2 poisto poistaa jnkn verran pak, mm task-desktop, task-xfce-desktop

	#uutena 031025, eivät aivan välttämättömiä ainakaan vielä
	#ja jotain nalkutustakin oli
	#${NKVD} initramfs*
	#${NKVD} live*
	#...varsinaisen poistamisen kanssa saattaa tulla ulinaa
	#HUOM.111025:kokeeksi nuo 2 yo. riviä kommentteihin, lftr muutox liittyvät

	if [ ! -f /.chroot ] ; then
		echo "REJECTING PKGS from dir:"
		pwd
		sleep 3

		for q in $(grep -v '#' reject_pkgs) ; do 
			echo "${NKVD} ${q}"
			${NKVD} ${q}
			sleep 1
		done

		echo "DONE REJECTINF"
		sleep 3
	fi

	cd ${p}
	dqb "...is over"
	csleep 3
}

#VAIH:jatkossa tämä fktio lisäisi ensisijaisen whitelistin mukaiset paketit efk1:lla
function reficul() {
	#debug=1
	dqb "NATTA5H3AD öVERDR1V 666! (a.k.a pr4.libs ?)"
	csleep 3

	[ -z ${1} ] && exit 65	
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 3

	c5p ${1}
	local p
	local q
	p=$(pwd)
	cd ${1}

#	efk1 gcc-12*.deb libgcc-s1*.deb #jatkossa toisin
#
#	efk1 perl-modules-*.deb
#
#	efk1 libstdc*.deb
#	efk1 librsvg2-2*.deb
#	efk1 libicu*.deb
#	efk1 libjxl*.deb
#
#	csleep 3
#	#HUOM.28925:toimiikohan tuolleen että useampi param samalla rivillä? ehkä
#	efk1 libc6*.deb 
#	efk1 libcap2_1*.deb
#	efk1 libdbus*.deb
#
#	csleep 3
#	efk1 libgdk-pixbuf2.0-common*.deb
# 	efk1 libgdk-pixbuf-2.0-0*.deb
#	efk1 libcups*.deb libavahi*.deb
#
#	csleep 5
#	efk1 libglib2*.deb
#	efk1 libgtk-3-common*.deb
#	efk1 libgtk-3-0_*.deb
#
#	efk1 libpython3.11-minimal*.deb
# #ohjeisvahinkona xfce4 jos poist
#
#	efk1 liblzma5*.deb
#	csleep 5
#
#	efk1 libext2fs2*.deb
#	csleep 5
#
#	efk1 libpam-modules-bin_*.deb
#	efk1 libpam-modules_*.deb
#
#	#uutena 011025
#	efk1 libcurl3*.deb
#	efk1 libkrb5*.deb
#	efk1 libgss*.deb
#.
#dpkg: dependency problems prevent configuration of libkrb5-3:amd64:
# libkrb5-3:amd64 depends on libkrb5support0 (= 1.20.1-2+deb12u4); however:
#  Version of libkrb5support0:amd64 on system is 1.20.1-2.
#dpkg: dependency problems prevent configuration of libgssapi-krb5-2:amd64:
# libgssapi-krb5-2:amd64 depends on libkrb5-3 (= 1.20.1-2+deb12u4); however:
#  Package libkrb5-3:amd64 is not configured yet.
#
#	efk1 libfdisk* libuuid*
#	#HUOM.28925:libfdisk ehkö uskaltaa poistaa($sharpy), e2fsprogs tarttee libuuid (e2 parempi olla poistamatta)
#	efk1 libopen* libpolkit-gobject-*
#	#HUOM.28925:xfce4 tarvitse libpolkit-gobject joten ei kande poistaa
#
#	#061025 osoittautui tarpeelliseksi
#	efk1 libeudev*
#
#	#081025
#	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libx11-6=2:1.8.4-2+deb12u2
#	efk1 libxcb1*.deb
#	efk1 libx11-6*.deb
#	efk1 libx11-xcb1*.deb
#
#	#HUOM.081025:oli aiemmin pr4():ssä juuri ennen "efk1 perl*.deb"-riviä, takaisin jos pykuu
#	
#	efk1 libpam*.deb	
#	efk1 libperl*.deb

	for q in $(grep -v '#' accept_pkgs_1) ; do efk1 ${q} ; done
	${NKVD} libpam-modules* #c5p() ? 
	echo "SDHGSKJDHGFSODHGSU"
	sleep 3

	cd ${p}
	dqb "REC1FUL D0N3"
	csleep 5
}

#HUOM.26525:2. parametri, tartteeko moista?
#
#VAIH:josko reficul/pr4/cp5 asetnamat/poistamat jutut erillisiin tdstoihin ja lib sitteb iteroisi
#grep efk1 $0 tai grep NKVD ... olisi noille listoille jokin lähtökohta
#VAIH:jatkossa tämä fktio lisäisi efk1:llä toissijaisen whitelistin mukaiset pak
function pr4() {
	#HUOM.29925:saattaa sittenkin olla tarpeellinen fktio koska X

	#debug=1
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1

	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	psqa ${1}

	local p
	local q
	p=$(pwd)
	cd ${1}
	
	#==============================================================
	#libx11- yms. kirjatsojen masentelut takaisin tähän vai reficul?
	#HUOM.29925:osoittautui tarpeeLLIseksi palauttaa koska part3() muutokset
	#HUOM.081025.2:eudev tarvitsee /boot/vmlinuz johonkin joten jos se poistettu...

	#HUOM.30925:x-jutut mielekkäitä päivittää sq-chroot-ymp lähinnä
	#äksän tappaminen desktop-live-ymp voi aiheuttaa härdelliä, login_manager ...
	#... eli yo. rivejä cgroot-tark taakse (DONE)

	for q in $(grep -v '#' accept_pkgs_2) ; do efk1 ${q} ; done

	if [ -f /.chroot ] ; then
		dqb "under a FUNeral M00N"

#		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=eudev=3.2.12-4+deb12u1
#		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=udev=1:3.2.9+devuan4 (depends:eudev)
#		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=xserver-common=2:21.1.7-3+deb12u10devuan1 (depends x11-common, xkb-data, x11-xkb-utils)
#		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=xserver-xorg-core=2:21.1.7-3+deb12u9devuan1 
#
#		efk1 eudev*.deb
#		efk1 udev*.deb 
#		efk1 xserver-common*.deb
#		efk1 xserver-xorg-core*.deb 
#
#		efk1 dbus-bin*.deb  dbus-daemon*.deb dbus-session-bus-common*.deb
#		#"A reboot is required to replace the running dbus-daemon."
#	else
#		#c5p() ?
#		${NKVD} eudev*.deb
#		${NKVD} udev*.deb
#		${NKVD} xserver-common*.deb HUOM.1212025:kts vieläkö xserver-valituksia tulee?
#		${NKVD} xserver-xorg-core*.deb
#		${NKVD} dbus-bin*.deb
#		${NKVD} dbus-daemon*.deb	
	fi

	csleep 3
	
	#==============================================================
#Unpacking perl (5.36.0-7+deb12u3) over (5.36.0-7) ...
#dpkg: dependency problems prevent configuration of perl:
# perl depends on perl-base (= 5.36.0-7+deb12u3); however:
#  Version of perl-base on system is 5.36.0-7.
#
#dpkg: error processing package perl (--install):
# dependency problems - leaving unconfigured
#Processing triggers for man-db (2.11.2-2) ...
#Errors were encountered while processing:
# perl
#1
#
#	efk1 perl*.deb
#	efk1 liberror-perl*.deb #HUOM.121025:tuleekohan tässä härdelliä?
#	efk1 git*.deb
#	csleep 1
#
#	#uutena 041025
#	efk1 bind9*.deb

#Unpacking bind9-dnsutils (1:9.18.33-1~deb12u2) over (1:9.18.16-1~deb12u1) ...
#dpkg: dependency problems prevent configuration of bind9-dnsutils:
# bind9-dnsutils depends on bind9-libs (= 1:9.18.33-1~deb12u2); however:
#  Version of bind9-libs:amd64 on system is 1:9.18.16-1~deb12u1.
# bind9-dnsutils depends on libkrb5-3 (>= 1.6.dfsg.2); however:
#  Package libkrb5-3:amd64 is not configured yet.
#
#dpkg: error processing package bind9-dnsutils (--install):
# dependency problems - leaving unconfigured
#Processing triggers for man-db (2.11.2-2) ...
#Errors were encountered while processing:
# bind9-dnsutils
#1

#	efk1 e2fsprogs*.deb
	csleep 1

	#c5p ${1} #HUOM.siirretty toiseen fktioon 061025
	csleep 2
	cd ${p}
}

#tähän tai cp5() poistamaan libavahi?
#jatkossa fktioihin cp5() ja udp6() muutoksia? sq-chroot liittyenm tjsp
function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1
	
	c5p ${1}
	dqb "D0NE"
	csleep 1
}

#TODO:jokin listahommeli tätäkin varten?
function t2p() { 
	#libcurl-libdav vaiko ei? (libcurl tai libnghttp vie git:in, libdav ehkä uskaltaa )
	#libavahi pois myös? (tulee kyllä oheisvahinkoa jos tekee)
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

	echo "DERTHAGO 3ST KALENDAM"
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

	${sharpy} xz*
	${asy} #varm. vuoksi
	csleep 2
 
	${sharpy} xfburn 
	${asy} #varm. vuoksi
	sleep 2

	${sharpy} xarchiver 
	${asy} #varm. vuoksi
	sleep 2

	#uutena
	${sharpy} libdav*
	${asy} #varm. vuoksi
	sleep 2

	${scm} a-wx ${0}
	csleep 2
}

#josko kuitenkin ntp takaisin listaan?
function pre_part2() {
	dqb "daud.pre_part2()"
	csleep 2

	${odio} /etc/init.d/ntpd stop
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
#... tarkistus tosin uusiksi, josko sinne tcdd-blokkiin(?) ylemmäs?

function tpc7() { #e22.sh kutsuu tätä nykyään
	dqb "d.prc7 UNDER CONSTRUCTION"
}

check_binaries ${d}
check_binaries2
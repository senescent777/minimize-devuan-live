#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

function c5p() { #joskohan jo toimisi (28925)
	dqb "CCCP( ${1} , ${2} )"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1
#
#	dqb "xz"
#	${NKVD} ${1}/xz* #toisaalta t2p() poistaa
#	ls -las ${1}/xz* 
#	csleep 3
#
#	${NKVD} ${1}/cryptsetup* #jos alkaa leikkiä encrypted-lvm-on-raid5-leikkejä niin sitten pois tämä rivi
#	#g_pt2 poistaa cryptsetup-pakettei
#	
#	#tästä eteenpäin jos selvittäisi noiden pakettien tilanteen, piostuuko jossain jnkn sivuvakutuksebna?
#	${NKVD} ${1}/libcrypt* #ei uskalla poistaa aptilla
#	#${NKVD} ${1}/libdevmapper* #asennettuna 28925?
#	#${NKVD} ${1}/libsoup* #eiole

#	#HUOM.19725:librsvg2 poisto poistaa jnkn verran pak, mm task-desktop, task-xfce-desktop

	dqb "...is over"
	csleep 1
}

function reficul() { #HUOM.28925: valmis?
	dqb "NATTA5H3AD öVERDR1V 666!"

	csleep 5
	efk ${1}/gcc-12*.deb ${1}/libgcc-s1*.deb
	efk ${1}/perl-modules-*.deb
	efk ${1}/libstdc*.deb
	efk ${1}/librsvg2-2*.deb
	efk ${1}/libicu*.deb
	efk ${1}/libjxl*.deb

	csleep 3
#	#HUOM.28925:toimiikohan tuolleen että useampi param samalla rivillä? ehkä
	efk ${1}/libc6*.deb 
	efk ${1}/libcap2_1*.deb
	efk ${1}/libdbus*.deb

	csleep 3
	efk ${1}/libgdk-pixbuf2.0-common*.deb
 	efk ${1}/libgdk-pixbuf-2.0-0*.deb
	efk ${1}/libcups*.deb ${1}/libavahi*.deb

	csleep 5
	efk ${1}/libglib2*.deb
	efk ${1}/libgtk-3-common*.deb #josko nyt loppuisi nalqtus?
	efk ${1}/libgtk-3-0_*.deb
	efk ${1}/libpython3.11-minimal*.deb #ohjeisvahinkona xfce4 jos poist
	efk ${1}/liblzma5*.deb
	efk ${1}/libext2fs2*.deb

	csleep 5
	efk ${1}/libpam-modules-bin_*.deb
	efk ${1}/libpam-modules_*.deb

#	efk ${1}/libeudev*
#	efk ${1}/libfdisk* ${1}/libuuid*
#	#HUOM.28925:libfdisk ehkö uskaltaa poistaa, e2fsprogs tarttee libuuid (e2 parempi olla poistamatta)

#	efk ${1}/libopen* ${1}/libpolkit-gobject-*
#	#HUOM.28925:xfce4 tarvitse libpolkit-gobject joten ei kande poistaa

	dqb "REC1FUL D0N3"
	csleep 5
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
#HUOM.26525:2. parametri, tartteeko moista?

function pr4() { #HUOM.28925:jospa jo ok
	#HUOM.28925.2:tarpeellinen fktio jatkodda?
	#debug=1
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1

	[ -d ${1} ] || exit 66
	dqb "paramz 0k"

	psqa ${1}

#	${NKVD} ${1}/libpam-modules* #tartteeko enää?
#
#	efk ${1}/libpam*.deb
#	
#	efk ${1}/libperl*.deb
#
#	efk ${1}/perl*.deb
#
#
#	efk ${1}/liberror-perl*.deb
#	efk ${1}/git*.deb
#	csleep 1
#	
	c5p ${1}
	csleep 1
}

#tähän tai cp5() poistamaan libavahi?
function udp6() { #HUOM.28725:testattu, toiminee
	dqb "daud.lib.UPDP-6"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1
	
	c5p ${1}
	dqb "D0NE"
	csleep 1
}

#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=xcvt=0.1.2-1 (miten taas liittyi mihinkään?)

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

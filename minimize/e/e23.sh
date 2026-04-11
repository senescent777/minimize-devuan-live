#just_download_not_install-vipu olisi tietysti...

#020426:dgsts.4 ja dgsts.5 , miten niiden kanssa nkuyään?lets find out? EIKU

#010426:muutoksia josqs? dhclient ei tark ottaen pakollinen koska staattisetkin ip-osoitteen keksitty
function aswasw() { #privaatti fktio, tarkpoitus olla
	dqb "aswasw( ${1} )"
	[ -z "${1}" ] && exit 56
	csleep 1

	case "${1}" in
		wlan0)
			#E22:GN="libnl-3-200 ... "
			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2
			#${shary} libdbus-1-3 toistaiseksi jemmaan 280425, sotkee

			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 #libreadline8 # libssl3 adduser
			${shary} wpasupplicant
		;;
		*)
		;;
	esac
}

function e23_tblz() { #taitaa toimia, 070426
	dqb "e23_tblz()"
	csleep 1

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 15
	[ -z "${2}" ] && exit 12
	[ -z "${3}" ] && exit 13
	[ -z "${4}" ] && exit 14 #HUOM.tämän trapeellisuus?

	${fib}
	${asy}
	#csleep 1

	#message() tähän?
	tpc7	#jotain excaliburiin liittyvää
	aswasw ${2}
	${shary} ${E22_GT}

	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}
	csleep 1

	${asy}
	#actually necessary
	e22_pre2 ${1} ${3} ${2} ${4}
	other_horrors

	dqb "e23_tblz()"
}

#btw. mikä muuten syynä libgfortran5-nalkutukseen?
#HUOM.080326:1. param luultavasti tarpeellinen myös jatkossa

#HUOM.110326:common_lib.tool():ille ulkoistaminen josqs? täsäs tdstossa vain määriteltäisiin mitä kys työkalulle syötetään?
#... siinä ulkoistuksessa on kyllä semmoinen juttu

#050426:suattaapi vaikka toimia
function e23_other_pkgs() { 
	dqb "e23_other_pkgs()"
	#toista param? eiole

	[ -z "${1}" ] && exit 11
	dqb "pars.ok"

	#${shary} ${E22_GS} #tämä oli jo kytsuvassa koodissa
	csleep 1

	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?
	${shary} ${E22_GI}
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 git-man git"
	${shary} ${E22_GG}

	#rämän eiirto-> common_lib?
	E23_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"
	${shary} ${E23_GS}  #moni pak tarttee nämä

	#${shary} #bsd 
	##${shary} seatd #130126:paskooko tämä kuitenkin asioita vai ei? ehkä

	message
	jules

	if [ ${1} -eq 1 ] ; then
		${shary} libgmp10 libhogweed6 libidn2-0 libnettle8
		${shary} runit-helper
		${shary} dnsmasq-base dnsmasq dns-root-data #dnsutils

		${lftr} 
		[ $? -eq 0 ] || exit 3

		${shary} libev4
		${shary} libgetdns10 libbsd0 libidn2-0 libssl3 libunbound8 libyaml-0-2 #sotkeekohan libc6 uudelleenas tässä?
		${shary} stubby
	fi

	csleep 1
	${lftr}

	#initrd-nalkutus mutkistanut asioita, josko a) /etc/kernel sisältö b) debian reference auttaisi? (tämä seur)
	dqb "e23_other_pkgs() DONE"
	csleep 1
}

#äksän kanssa "+scm +usermod -seatd" se toimiva jekku?

#280326:saa aikaiseksi paketin, sisällön testaus vielä
function e23_upgp() {
	dqb " e23_upgp() "

	dqb "pars_ok"
	${fib}
	csleep 1

	#LOPPUU SE PURPATUS PRKL
	${shary} ${E22_GS}

	${sag} --no-install-recommends upgrade -u
	echo $?

	#HUOM.081225:pitäisiköhän keskeyttää tässä jos upgrade qsee?
	#csleep 1

	dqb " e23_upgp() done"
	csleep 1
}

#280326:saa aikaiseksi paketin, sisällön testaus vielä
function e23_upgp2() {
	[ -z "${1}" ] && exit 1 
	[ -z "${2}" ] && exit 11

	case "${2}" in
		wlan0)
			csleep 1
		;;
		*)
			${NKVD} ${1}/wpa*
			#HUOM.25725:pitäisi kai poistaa wpa-paketit tässä, aptilla myös?
			#... vai lähtisikö vain siitä että g_pt2 ajettu ja täts it
		;;
	esac

	dqb " e23_upgp2() done"
	csleep 1
}

#170326:taitaa toimia, paketin teko ja sisältö
function e23_qrs() {
	dqb "e23_qrs()"

	[ -z "${1}" ] && exit 77
	[ -s ${1} ] || exit 66
	[ -r ${1} ] || exit 55
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -z "${3}" ] && exit 44
	#[ -f ${3} ] || exit 33
	[ -z "${4}" ] && exit 43
	#[ -f ${4} ] || exit 34
	[ -z "${5}" ] && exit 43
	#[ -f ${5} ] || exit 34

	dqb "pars.0k"
	csleep 1

	e22_config1 ~ ${3}
	${srat} -rvf ${1} ~/${3}
	csleep 1

	#tuleeko mukaan vai ei?
	tar -tf ${1} | grep ${3} | wc -l
	csleep 2

	dqb "BEFORE NVDk"
	[ -f ${4} ] && ${NKVD} ~/${4}
	csleep 1

	e22_settings ${2} ${4} ${5}
	#btw. mikä olikaan syy että q on tässä ekassa switch-case:ssa? pl siis että turha apt-renkkaus

	#jospa ei hipsuja tähän find:iin
	for f in $(find ${2} -maxdepth 1 -type f -name ${4} -or -name ${5} | grep -v pulse) ; do
		${srat} -rvf ${1} ${f}
	done

	[ ${debug} -eq 1 ] && tar -tf ${1} | grep ${4} | wc -l
	csleep 1
}

#VAIH:uusiksi vain tyhjästä (110426 onnSi paketin veto kokeiluja varten, asentiu desktop_liveen urputuksen aknssa)
#VAIH:boisi myös ottaa mallia viimeisimmästä toimivasta paketista että mitä mukaan
#VAIH:myös minimal_liven kanssa uudempi testikierros tämän kanssa
#... modaamattomalla minimalilla boottaus+pakettien veto saattaisi olla idea

#edelleen:
#libwraster6:amd64 depends on libmagickwand-6.q16-6 (>= 8:6.9.10.2); however:
#libwings3:amd64 depends on libpangoxft-1.0-0
#libwings3:amd64 depends on libwraster6
#wdm depends on libwings3 (>= 0.95.0); however:

#.V.M.P.5tna mussunmussun
function e23_dm() {
	dqb "e23_dm())) ${1} )"
	[ -z "${1}" ] && exit 11
	csleep 2

	${fib}
	${shary} ${E22_GS}
	${shary} ${E22_GM}
	csleep 5

	#VAIH:voisi urputtaa että tällä hetkellä vain wdm tuettuna (jos sekään)
	if [ "${2}" == "wdm" ] ; then
		dqb "dm.k0"
	else
		echo "NOT SUPPORTED"
		exit 666
	fi

	#jos ei ala muuten sujua ni ao riveistä mallia accept1:seen
	
	${shary} libpango-1.0-0 libpangoft2 libpangoxft-1.0-0
	[ $? -eq 0 ] || exit 54
	${shary} libmagickcore-6.q16-6 libmagickwand-6.q16-6
	[ $? -eq 0 ] || exit 55
	${shary} libnuma1 libx265-199 libwraster6 libwings3
	[ $? -eq 0 ] || exit 57 #tarkoiytuksella
	csleep 10
	
	${shary} libpango-1.0-0 libpangoft2 libpangoxft-1.0-0
	${shary} libmagickcore-6 libmagickwand-6
	${shary} libnuma1 libx265-199 libwraster6 libwings3
	[ $? -eq 0 ] || exit 57 #tarkoiytuksella
	csleep 10
	
	${shary} libpango-1.0-0 libpangoft2 libpangoxft-1.0-0
	${shary} libmagickcore-6 libmagickwand-6
	${shary} libnuma1 libx265-199 libwraster6 libwings3
	[ $? -eq 0 ] || exit 57 #tarkoiytuksella
	csleep 10

	${shary} libfftw3-double3 libfontconfig1 libfontenc1 libfreetype6 libheif1 libjbig0 libjpeg62-turbo liblcms2-2 liblqr-1-0
	csleep 5

	${shary} liblzma5 libopenjp2-7 libltdl7 libpng16-16 libtiff6 libwebp7 libwebpdemux2 libwebpmux3
	csleep 10

	${shary} libx11-6 libx11-xcb1 libx11-data libxext6 imagemagick-6-common libxmu6 libxmuu1 libgif7 libxpm4
	#[ $? -eq 0 ] || exit 57 #jospa ei tämmöisiä tähän fktioon, tökkii
	csleep 5

	${shary} fontconfig fontconfig-config
	${shary} libdav1d6 libde265-0 libfribidi0 libglib2.0-0 libglib2.0-data libharfbuzz0b
	${shary} libthai0 libxft2 libxrender1 libxrandr2
	csleep 10

	${shary} libdrm2 libexpat1 libgbm1 libglapi-mesa libwayland-client0 libwayland-server0 libwayland-cursor0 libwayland-egl1
	${shary} libxcb1
	csleep 5

	${shary} libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-randr0 libxcb-sync1 libxcb-xfixes0 
	${shary} libxcb-shape0 libxshmfence1 libxcb-damage0 libxcb-shm0 libxcb-render0 #hyvä idea ksekittää nämä inxcb-jutut?
	csleep 10

	${shary} libglvnd0 libegl-mesa0 libgl1 libxaw7 libegl1
	csleep 5

	${shary} libxcomposite1 libxi6 libxinerama1 libxkbfile1
	csleep 10

	${shary} libxt6 libxtst6 libxv1 libxxf86dga1 libxxf86vm1 libsm6
	csleep 5

	${shary} libxcursor1 libwutil5 man-db wmaker-common #libbz2-1.0
	csleep 10

	${shary} libicu72 libxfixes3 libxml2
	${shary} 
	csleep 5

	${shary} libpam-runtime #E22_GM toisi pari libpam-pakettttiaq
	csleep 10

	${shary} libxdmcp6 menu twm libmd0
	csleep 5

 	${shary} libaom3 at-spi2-common libatk1.0-0 libaudit-common libbsd0 libcap-ng0 
	csleep 10

	${shary} libxau6  #C
	${shary} libgdbm6 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common libglx0 
	${shary} libgtk-3-0 libgtk-3-common libice6  #libheif versio ok?
	csleep 5

	${shary} libseat1 libseccomp2 libtinfo6 #libpipeline1?
	${shary} libunwind8
	csleep 10

	${shary} lsb-base psmisc #A
	${shary} bsdextrautils groff-base 
	${shary} init-system-helpers  #xscreensaver?
	csleep 5

	${shary} x11-apps x11-common x11-utils
	csleep 10

	${shary} x11-xserver-utils xserver-xorg #D
	${shary} xterm xauth
	csleep 5

	${shary} wdm 
	dqb "e23_dm( done (((("
	csleep 1
}

#	vieläjotain yhdisteltäbvää?
#
#
#	#varsinainen cpp mukaan tuohon? alempana se tulee mukaan nyt

#
#	${shary} libopengl0O  
#	${shary} cpp procps
#

#	#Depends: adwaita-icon-theme, hicolor-icon-theme, shared-mime-info, 
#
#	 libatk-bridge2.0-0 libcairo-gobject2 libcairo2
#	${shary} libcolord2 libepoxy0
#	${shary} libpangocairo-1.0-0
#	${shary} libxdamage1 
#	${shary} libxkbcommon0
## 
#
#

#	#HUOM.osa riippuvuuksista piytäisi tulla e23_dm() kautta 
#
#	#VAIH:dpkg: dependency problems prevent configuration of libwww-perl:
#	#VAIH:xscreensaver depends on ; however:

#	libstdc++6 (>= 11), 
#	#	${shary}  libgnutls30
#
#	#wdm depends on xserver-xorg | xserver; however:
#
#	case "${1}" in
#		xdm) #010126:pitäisiköhän tämäkin case testata?
#			${shary} xdm
#		;;
#		wdm)
#			#TODO:wdm tartvitsee xserver|xserver-org (minimal_live)
#			${shary}  #audit1 ennen case?
#			${shary} sysvinit-utils 
#			${shary} libpipeline1
#			csleep 1
#
#			${shary} wdm
#		;;
##		lxdm)
##			#jos aikoo dbusista eroon ni libcups2 asennus ei hyvä idea
##			#csleep 1
##			${shary} libdeflate0 debliblerc4 
##			csleep 1
##			#acceptiin ainakin 2-0-common enne 2-0 ja sitten muuta tauhkaa hakien tässä kunnes alkaa riittää
##			${shary}  libgtk2.0-common libgtk2.0-0
##			csleep 1
##			#gdk ennen gtk?
##			${shary}   
##			csleep 1
##			${shary} gtk2-engines-pixbuf gtk2-engines 
##			csleep 1
##			${shary} lxdm 
##			csleep 1

##			#polkit-1-auth-agent:
##			#${shary} lxsession-data libpolkit-agent-1-0 libpolkit-gobject-1-0 policykit-1 laptop-detect lsb-release
##			#csleep 1
##			#	 lxlock | xdg-utils, 
##			# lxpolkit | polkit-1-auth-agent,  lxsession-logout
##			${shary} lxpolkit lxsession-logout lxsession
##			#csleep 1
##		;;
#		*)
#		;;
#	esac
#
#	#VAIH:pitäisiköhän nämäkin junnata läpi?
#	#Depends: perl:any, , ,,,,,,,,, liblwp-mediatypes-perl,, libnet-http-perl, libtry-tiny-perl, liburi-perl, libwww-robotrules-perl, 
#	#  (>= 0.99.7.1), libsystemd0 (>= 243), ,  (>> 2.1.1), (>= 2:1.2.99.4),  (>= 2:1.1.4), 
#
#	#EI JUNALAUTTA
#	E22_GX="netbase"
#	E22_GX="${E22_GX} liblwp-protocol-https-perl libhttp-negotiate-perl libhtml-tagset-perl libhttp-message-perl libhttp-date-perl libhttp-cookies-perl libhtml-tree-perl libhtml-parser-perl libfile-listing-perl libencode-locale-perl"
#	E22_GX="${E22_GX} ca-certificates libwww-perl "
#
#	E22_GX="${E22_GX}  
#	E22_GX="${E22_GX} xscreensaver-data xscreensaver"
#	${shary} ${E22_GX}  #libsystemd0

#150326:teki ainakin kerran jotain toivottua (ehkä joutaa vielä arpoa minne juttuja kopsaillaan) 
function e23_profs() {
	dqb "e23_profs) $1 , $2 , $3 ("
	csleep 1
	dqb "pars.0k"
	csleep 1

	q=$(mktemp -d)
	cd ${q}

	[ $? -eq 0 ] || exit 77
	pwd
	csleep 1

	dqb "SHOULD ifup \$iface BEFORE \${tig} clone"
	csleep 1

	[ -v CONF_BASEURL ] || exit 78
	${tig} clone https://${CONF_BASEURL}/more_scripts.git
	[ $? -eq 0 ] || exit 79

	${svm} more_scripts/profs/${3}* ${2}
	${scm} 0555 ${2}/${3}*
	${sr0} -rvf ${1} ${2}/${3}*
	csleep 1

	dqb "e23_profs() done"
	csleep 1
}

#function e23_xyz() {	
#	${shary} libeudev1 keyboard-configuration #drm2 sekä shmfence _dm() kautta
#	${shary} libpixman-1-0 libxfont2 libpciaccess0 libgcrypt20
#	${shary} libxcvt0 xcvt #vetää vai ei? vssiin menee hi pakettiin 7426
#
#	csleep 30
#	dpkg -l libxcvt*
#	csleep 6
#
#	${shary} xserver-xorg-video-modesetting xserver-xorg-input-evtouch
#	#libopengl0 tarvitaanm, e23() 
#	${shary} libglu1-mesa libgl1-mesa-dri #gl1 muttei mesa löytyy jo aiemmin
#
#	#tässä alla vöib tulla suurempi lottoaminen (jospa jollain livecd:llä selvittäisi mitä oik tarv)
#	${shary} x11-session-utils xfonts-utils xinit xfonts-scalable xfonts-75dpi xfonts-100dpi
#	#{shary} xserver-xorg
#
#	${shary} xbitmaps x11-xfs-utils  xkb-data xfonts-base x11-xkb-utils
#	${shary}  #xterm+xauth voIsi hoitaa e23_dm() kaUTTa? jo dm
#
#	#egl,audit,bsd0,, yms. dm() kautta
#
#	${shary} xserver-common xserver-xorg-core
#	#xserver-xorg #tarvitseeko erikseen sanoa koska xorg?
#	${shary} xorg xorg-docs-core xorg-docs #2. ja 3. oik. tarpeen?
#
#	#${shary} xserver-xorg-input-all xserver-xorg-input-libinput xserver-xorg-input-wacom 
#
#	#Depends:  (>= 2:21.1.7-3devuan1),  (>= 2.34),  (>= 0.5) | 
#	${shary} xserver-xorg-legacy #tarvitsee vai ei?
#	#server-xorg-video-all xserver-xorg-video-amdgpu
#
#	#${shary} xserver-xorg-video-ati xserver-xorg-video-fbdev xserver-xorg-video-intel 
#	#${shary} xserver-xorg-video-nouveau xserver-xorg-video-qxl xserver-xorg-video-radeon xserver-xorg-video-vesa xserver-xorg-video-vmware
#
#		#VAIH:xserver-xorg-video-* ainakin mukaan?
##... "case l" jos kuittaisi äksän lib-jutut (tai sit boottaa minimal-liveen ja asenna x+wdm siihen) (TODO?)
#
#}

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
#120426:minimal_livessä naturlich valitusta xserver- ja libgtk3- pakettien kanssa, tee jotain
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

#TODO:jokin /o/b/skRipti nostamaan äläkän jos /e/resolv.vonf puuttuu

#libseat (aloiteltu)
#libatk (aloiteltu)
#lib-gtk-3 (aloiteltu)
#libgtk3-bin (aloiteltu)
#dconf-service, libdconf /aloiteltu
#dconf-gsettings-backend (selv riipp al/pios josqs?)
#adwaita->gtk-update-icon-cache (aloiteltu)
#libxft2<->libpakgoxft (VAIH?)
#libwayland (vissiin asennusjärjestyksestä kyse?)
#xserver-xorg (liittyy jo e23_upg()?) (VAIH:selv riippuvuudet)
#x11-xkb-utils (VAIH:selv riippuvuudet) (Depends:  (>= 2.33), ,  (>= 2:1.0.14), (>= 1:1.1.0), (>= 2:1.2.99.2), 

function e23_dm() {
	dqb "e23_dm())) ${1} )"
	[ -z "${1}" ] && exit 11
	csleep 2

	${fib}
	${shary} ${E22_GS}
	${shary} ${E22_GM}
	csleep 5

	if [ "${1}" == "wdm" ] ; then
		dqb "dm.k0"
	else
		echo "NOT SUPPORTED"
		exit 666
	fi

	${shary} fontconfig fontconfig-config libfontconfig1 libfontenc1
	${shary} libfribidi0 libglib2.0-0 libglib2.0-data libharfbuzz0b libthai0
	${shary} libfreetype6 libcairo2

	#Depends:  (>= 2.14),  (>= 2.13.0), (>= 2.2.1),  (>= 2.67.3),  (>= 5.1.0), libpango-1.0-0 (= 1.50.12+ds-1)
	#?
	#Depends:  (>= 2.4),  (>= 1.12.10), (>= 2.13.0),  (>= 2.62.0),  (>= 2.6.0), libpango-1.0-0 (= 1.50.12+ds-1), libpangoft2-1.0-0 (= 1.50.12+ds-1)

	#TODO:varm myös että menevät kohde-pakettiin mukaan libpango*.deb
	${shary} libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0 libpangocairo-1.0-0

	#[ $? -eq 0 ] || exit 54 #to state the obvious:initramfs-kikkailujen takia ei kande nöin tehdö
	${shary} libmagickcore-6.q16-6 libmagickwand-6.q16-6
	csleep 5
	${shary} libnuma1 libx265-199 libwraster6 libwings3
	csleep 10

	${shary} libfftw3-double3 libheif1 libjbig0 libjpeg62-turbo liblcms2-2 liblqr-1-0
	csleep 5

	${shary} liblzma5 libopenjp2-7 libltdl7 libpng16-16 libtiff6 libwebp7 libwebpdemux2 libwebpmux3
	csleep 10

	${shary} libx11-6 libx11-xcb1 libx11-data libxext6 imagemagick-6-common libxmu6 libxmuu1 libgif7 libxpm4
	#[ $? -eq 0 ] || exit 57 #jospa ei tämmöisiä tähän fktioon, tökkii
	csleep 5
	
	${shary} libdav1d6 libde265-0
	${shary} libxft2 libxrender1 libxrandr2
	csleep 10

	${shary} libdrm2 libexpat1 libgbm1 libglapi-mesa

	#TODO:varm myös että menevät kohde-pakettiin mukaan libwayland*.deb
	${shary} libffi8 libwayland-client0 libwayland-server0 libwayland-cursor0 libwayland-egl1
	
	${shary} libxcb1
	${shary} libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-randr0 libxcb-sync1 libxcb-xfixes0 
	${shary} libxcb-shape0 libxshmfence1 libxcb-damage0 libxcb-shm0 libxcb-render0 #hyvä idea ksekittää nämä inxcb-jutut?
	csleep 10

	${shary} libgdbm6 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common libglx0
	${shary} libxt6 libxtst6 libxv1 libxxf86dga1 libxxf86vm1 libsm6
	${shary} libglvnd0 libegl-mesa0 libgl1 libxaw7 libegl1
	csleep 5

	${shary} libxcomposite1 libxi6 libxinerama1 libxkbfile1 libxkbcommon0
	csleep 10

	${shary} libxcursor1 libwutil5 man-db wmaker-common #libbz2-1.0
	csleep 10

	${shary} libicu72 libxfixes3 libxml2
	csleep 5

	${shary} libpam-runtime #E22_GM toisi pari libpam-pakettttiaq
	csleep 10

	${shary} libxdmcp6 menu twm libmd0 #tarvitseeko twm takia tehdä accept_juttuihin muutoksia?
	csleep 5

 	${shary} libaom3 at-spi2-common libatk1.0-0 libaudit-common libbsd0 libcap-ng0 
	csleep 10

	${shary} libatspi2.0-0 libatk-bridge2.0-0
	csleep 5

	${shary} libxau6  #C
	${shary} lsb-base psmisc #A
#

	${shary} x11-apps x11-common x11-utils x11-xkb-utils
	csleep 10

	#TODO:dconf-juttujen tilalle jotain muuta jatkossa? gsettings-backend desmes
	#VAIH:selv riipp
	#Depends: dconf-service (<< 0.40.0-4.1~), dconf-service (>= 0.40.0-4), libdconf1 (= 0.40.0-4),  (>= 2.55.2)
	#Depends: default-dbus-session-bus | dbus-session-bus, libdconf1 (= 0.40.0-4),, (>= 2.34),  (>= 2.55.2)
	#Depends: 

	${shary} dconf-gsettings-backend dconf-service libdconf1
	
	${shary} gtk-update-icon-cache
	#Depends: hicolor-icon-theme,
	${shary} adwaita-icon-theme hicolor-icon-theme

	${shary} shared-mime-info libpixman-1-0 libeudev1 libgnutls30 libgssapi-krb5-2



	#Depends: libavahi-client3 (>= 0.6.16), libavahi-common3 (>= 0.6.16),  (>= 2.36), 

	#Depends:

	${shary} libcairo-gobject2 libcolord2 libcups2 libepoxy0 libxdamage1


	${shary} libice6 xkb-data

	#HUOM.120426:mitkä kaikki sen gtk-3-0:n tarvitsivat?
	#Depends: , 
	#Depends: dconf-gsettings-backend | gsettings-backend

		



	#Depends: ,,  (>= 1.14.0), (>= 2.40.0), 


	${shary} libgtk-3-common libgtk-3-0 libgtk-3-bin
	# 


	csleep 5

#lototaan nyt seatd
	#Depends: seatd | logind, libc6 (>= 2.33), libsystemd0 (>= 238)


	${shary} seatd libseat1 libseccomp2 libtinfo6 #libpipeline1?

	${shary} libunwind8
	csleep 10
#
	${shary} bsdextrautils groff-base #tartteeko listä accept1:seen niätä?
	${shary} init-system-helpers  #xscreensaver?
	csleep 10
	${shary} libncursesw6 libproc2-0
	
	${shary} cpp procps cpp-12 #mitä kaikkea nämä vetävät mukaan?

	#Depends: xserver-xorg-core (>= 2:1.17.2-2), xserver-xorg-video-all | xorg-driver-video, xserver-xorg-input-all | xorg-driver-input,

	${shary} x11-xserver-utils xserver-xorg #D
	csleep 10

	${shary} libutempter0 xbitmaps xterm xauth
	csleep 5

	${shary} wdm 
	dqb "e23_dm( done (((("
	csleep 1
}

#	vieläjotain yhdisteltäbvää?
#
#


#
#	${shary} libopengl0O  
#	



#


#	libstdc++6 (>= 11), 

#
#	#wdm depends on xserver-xorg | xserver; however:
#
#	case "${1}" in
#		xdm) #010126:pitäisiköhän tämäkin case testata?
#			${shary} xdm
#		;;
#		wdm)


#			${shary} sysvinit-utils 
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
#	${shary}  keyboard-configuration #drm2 sekä shmfence _dm() kautta
#	${shary}  libxfont2 libpciaccess0 libgcrypt20
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
#	${shary}  x11-xfs-utils   xfonts-base x11-xkb-utils
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

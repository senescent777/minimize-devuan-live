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

function e23_tblz() { #050426:jokohan jo toimisi?
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

	${shary} ${E22_GS}
	csleep 1	

	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?
	${shary} ${E22_GI}
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 git-man git"
	${shary} ${E22_GG}

	#sudo-asia olisi jo kunnossa 120126?	ehkä
	E23_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} ${E23_GS}  #moni pak tarttee nämä

	#${shary} #bsd debconf
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

	#helpompi vain ajaa e23_dm() ennen upgp()
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

#050426:taisipa toimia yhden kerran 
function e23_dm() {
	dqb "e23_dm(${1})"
	[ -z "${1}" ] && exit 11
	csleep 2

	dqb "params ok"
	${fib}
	csleep 1

	#LOPPUU SE PURPATUS PRKL
	${shary} ${E22_GS}
	csleep 1

	${shary} libice6 libsm6 libx11-6 libxext6 libxmu6 libxt6
	${shary} menu twm
	#csleep 1

	#libselinux oikeastaan muualla jo
	${shary} libcrypt1 libpam0g libselinux1 #jemmaan?
	${shary} libxau6 libxaw7 libxdmcp6 libxft2 libxinerama1 
	csleep 1

	${shary} libxpm4 libxrender1 debconf x11-utils cpp lsb-base x11-xserver-utils procps
	#csleep 1

	${shary} libgtk-3-0 libgtk-3-common
	
	${shary} libxxf86vm1 libxrandr2 libxml2 libxi6 libglib2.0-0 libglib2.0-data libatk1.0-0 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common

	${shary} fontconfig libfribidi0 libharfbuzz0b libthai0
	${shary} libfreetype6 libxcb-shape0 libxcb-damage0 libxcb-present0 libxcb-xfixes0 libxcb1
	${shary} libxcb-render0 libxcb-shm0
	${shary} libxkbfile1 libxmuu1 libxt6
	csleep 1
	
	${shary} libexpat1 fontconfig-config libfontconfig1
	${shary} libfontenc1 libglvnd0 libglx0 libgl1  
	${shary} x11-common libxtst6 libxv1 libxxf86dga1 
	${shary} libx11-data libx11-xcb1 libxcomposite1
	csleep 1
	
	${shary} libgbm1 libseat1 libunwind8 libxpm4 # libselinux1
	#TODO:	at-spi2-common,libatk1.0-0 tössö jäörj
	#TODO:libgtk-3-common depends on dconf-gsettings-backend | gsettings-backend; however:
	#TODO:	dependency problems prevent configuration of libgtk-3-0:amd64
	#TODO:	libwraster6:amd64 depends on  (>= 2:1.1.3); however:
	#TODO:libpangoxft-1.0-0:amd64 depends on  (>> 2.1.1);
	#TODO:libwings3:amd64 depends on
	#TODO:libegl1:amd64 depends on
	#TODO:libgbm1:amd64 depends on libwayland-server0
	#HUOM.osa riippuvuuksista piytäisi tulla e23_dm() kautta 
	#TODO: x11-utils depends on ; however:
	#TODO:x11-apps depends on 
	#TODO: x11-xserver-utils depends on  (>= 2:1.0.14); however:

	#x11-xserver-utils depends on cpp; however: pitäisijo 5426

	#TODO:dpkg: dependency problems prevent configuration of libwww-perl:
	#TODO: libegl1:amd64 depends on libegl-mesa0; however:
	#TODO:xscreensaver depends on xscreensaver-data; however:
	#TODO:cpp depends on cpp-12 (>= 12.2.0-1~); however:
	#TODO: wdm depends on x11-xserver-utils; however:
	#Package x11-xserver-utils is not configured yet.
	#wdm depends on xserver-xorg | xserver; however:

	case "${1}" in
		xdm) #010126:pitäisiköhän tämäkin case testata?
			${shary} xdm
		;;
		wdm)
			# zlib1g perl:any xserver-xorg | xserver:tarteeko juuri tässä vetää?
			${shary} libnuma1
			${shary} libwebp7 libaom3 libdav1d6 libde265-0 libx265-199
			${shary} libwebpdemux2 libheif1 libaudit-common libcap-ng0 libaudit1
			csleep 1

			${shary} libdb5.3 libpam-modules-bin libpam-modules libpam-runtime
			${shary} sysvinit-utils libtinfo6 libpng16-16 libx11-xcb1  
			#csleep 1

			${shary} libxfixes3 libxcursor1
			
			#bsdextrautils | bsdmainutils 
			${shary} bsdextrautils groff-base libgdbm6 libpipeline1 libseccomp2 man-db
			csleep 1


			#csleep 1

			${shary} psmisc x11-apps
			${shary} libpcre2-8-0 libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
			csleep 1

			${shary} libgif7 libwraster6 libjpeg62-turbo
			${shary} imagemagick-6-common libmagickwand-6.q16-6 libtiff6
			#csleep 1

			${shary} libbz2-1.0 libfftw3-double3  libjbig0 liblcms2-2 liblqr-1-0 libltdl7 liblzma5 libopenjp2-7 libwebpmux3
			csleep 1
			${shary} libmagickcore-6.q16-6 
			${shary} libwutil5 wmaker-common libwings3
			#csleep 1

			${shary} libmd0 libbsd0
			${shary} wdm
		;;
#		lxdm)
#			${shary} libpixman-1-0
#			#csleep 1
#			#jos aikoo dbusista eroon ni libcups2 asennus ei hyvä idea
#			# (>= 1.28.3),  (>= 1.28.3),(>= 1.28.3),(>= 2:1.4.99.1),  (>= 1:0.4.5), libxcursor1 (>> 1.1.2), libxdamage1 (>= 1:1.1), , libxfixes3,  (>= 2:1.1.4),  (>= 2:1.5.0),  adwaita-icon-theme | gnome-icon-theme, hicolor-icon-theme, shared-mime-info
#			${shary} libpangocairo-1.0-0   
#			#csleep 1
#			${shary} libdeflate0 debliblerc4 
#			csleep 1
#			#acceptiin ainakin 2-0-common enne 2-0 ja sitten muuta tauhkaa hakien tässä kunnes alkaa riittää
#			${shary} libcairo2 libgtk2.0-common libgtk2.0-0
#			csleep 1
#			#gdk ennen gtk?
#			${shary}   
#			csleep 1
#			${shary} gtk2-engines-pixbuf gtk2-engines 
#			csleep 1
#			${shary} lxdm 
#			csleep 1
#			#261225:lxde-juttujrn ja lxpolkit:in riippuvuukisien selvutys saattaa osoittautua tarpeelliskeis?
#			#polkit-1-auth-agent:
#			#${shary} lxsession-data libpolkit-agent-1-0 libpolkit-gobject-1-0 policykit-1 laptop-detect lsb-release
#			#csleep 1
#			#	 lxlock | xdg-utils, 
#			# lxpolkit | polkit-1-auth-agent,  lxsession-logout
#			${shary} lxpolkit lxsession-logout lxsession
#			#csleep 1
#		;;
		*)
		;;
	esac
	
	E22_GX="libwww-perl xscreensaver-data init-system-helpers libegl1 xscreensaver"
	${shary} ${E22_GX}  #libsystemd0
}

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

#sleep 1
#		xserver-common depends on
#			xserver-xorg-legacy depends on xserver-common
#			 dependency problems prevent configuration of xserver-xorg-core
#			 x11-xserver-utils depends on 
#			 dependency problems prevent configuration of xorg
#			 dependency problems prevent configuration of xserver-xorg-video-vmware
#			 dependency problems prevent configuration of xserver-xorg-video-vesa
#			 dependency problems prevent configuration of xserver-xorg-video-all
#			 dependency problems prevent configuration of xserver-xorg-input-wacom
#			 dependency problems prevent configuration of xserver-xorg-core
#			 xserver-xorg-video-radeon depends on libgbm1
#			 
#			 dependency problems prevent configuration of xserver-xorg-video-fbdev
#			 dependency problems prevent configuration of xserver-xorg-video-nouveau
#			 dependency problems prevent configuration of xserver-xorg-video-ati
#			 dependency problems prevent configuration of xserver-xorg-video-amdgpu
#			 dependency problems prevent configuration of xserver-xorg-video-qxl
#			 dependency problems prevent configuration of xorg
#			 x11-xserver-utils depends 
#			 configuration of xserver-xorg-input-libinput
#			 xserver-xorg-input-all
#			 xserver-xorg-video-intel
			 
function e23_xyz() {
#Dependencies: 
#2:21.1.7-3+deb12u11devuan1 - xserver-common (2 2:21.1.7-3+deb12u11devuan1) keyboard-configuration (0 (null)) udev (2 149) libegl1 (0 (null)) libaudit1 (2 1:2.2.1) libbsd0 (2 0.7.0) libc6 (2 2.35) libdrm2 (2 2.4.66) libepoxy0 (2 1.5.4) libeudev1 (2 3.2.12) libgbm1 (2 17.1.0~rc2) libgcrypt20 (2 1.10.0) libgl1 (0 (null)) libpciaccess0 (2 0.12.902) libpixman-1-0 (2 0.30.0) libseat1 (2 0.5.0) libselinux1 (2 3.1~) libunwind8 (0 (null)) libxau6 (2 1:1.0.9) libxcvt0 (2 0.1.0) libxdmcp6 (0 (null)) libxfont2 (2 1:2.0.1) libxshmfence1 (0 (null)) xserver-xorg-input-evtouch (0 (null)) xserver-xorg-video-modesetting (0 (null)) libgl1-mesa-dri (3 18.0.5) systemd (3 226-4~) libgl1-mesa-dri (2 7.10.2-4) xcvt (0 (null)) xfonts-100dpi (16 (null)) xfonts-75dpi (0 (null)) xfonts-scalable (0 (null))  xserver-xorg-video-modesetting (0 (null)) 
#2:21.1.7-3+deb12u10devuan1 - xserver-common (2 2:21.1.7-3+deb12u10devuan1) keyboard-configuration (0 (null)) udev (2 149) libegl1 (0 (null)) libaudit1 (2 1:2.2.1) libbsd0 (2 0.7.0) libc6 (2 2.35) libdrm2 (2 2.4.66) libepoxy0 (2 1.5.4) libeudev1 (2 3.2.12) libgbm1 (2 17.1.0~rc2) libgcrypt20 (2 1.10.0) libgl1 (0 (null)) libpciaccess0 (2 0.12.902) libpixman-1-0 (2 0.30.0) libseat1 (2 0.5.0) libselinux1 (2 3.1~) libunwind8 (0 (null)) libxau6 (2 1:1.0.9) libxcvt0 (2 0.1.0) libxdmcp6 (0 (null)) libxfont2 (2 1:2.0.1) libxshmfence1 (0 (null)) xserver-xorg-input-evtouch (0 (null)) xserver-xorg-video-modesetting (0 (null)) libgl1-mesa-dri (3 18.0.5) systemd (3 226-4~)  libgl1-mesa-dri (2 7.10.2-4) xcvt (0 (null)) xfonts-100dpi (16 (null)) xfonts-75dpi (0 (null)) xfonts-scalable (0 (null))  xserver-xorg-video-modesetting (0 (null)) 

#Dependencies: 
#2:21.1.7-3+deb12u11devuan1 -  (0 (null))  (0 (null))
#2:21.1.7-3+deb12u10devuan1 -  (0 (null)) (0 (null))  (0 (null))

#Dependencies: 
1:7.7+23 -  libgl1 (0 (null)) libgl1-mesa-dri (0 (null)) libglu1-mesa (0 (null))  (2 1:1.0.0-1) xfonts-100dpi (2 1:1.0.0-1) xfonts-75dpi (2 1:1.0.0-1) xfonts-scalable (2 1:1.0.0-1) x11-apps (0 (null))  (0 (null))  (0 (null))  (0 (null)) x11-xserver-utils (0 (null))  (0 (null)) xinit (0 (null)) xfonts-utils (0 (null))  (0 (null))  (0 (null))  (16 (null)) x-terminal-emulator (0 (null))  (0 (null))  (0 (null)) 	


		#tässä alla vöib tulla suurempi lottoaminen (jospa jollain livecd:llä selvittäisi mitä oik tarv)
	${shary} x11-session-utils
	#{shary} xserver-xorg

	${shary} xbitmaps x11-xfs-utils xterm xkb-data xauth xfonts-base x11-xkb-utils
	#${shary} x11-common #xterm+xauth vosi hoitaa e23_dm() kayrra? x11-common jo dm
	${shary} xserver-common xserver-xorg-core
	#xserver-xorg #tarvitseeko erikseen sanoa kosa xorg?		
	${shary} xorg xorg-docs-core xorg-docs #2. ja 3. oik. tarpeen?

		
	#${shary} xserver-xorg-input-all xserver-xorg-input-libinput xserver-xorg-input-wacom 
	#${shary} xserver-xorg-legacy xserver-xorg-video-all xserver-xorg-video-amdgpu
	#${shary} xserver-xorg-video-ati xserver-xorg-video-fbdev xserver-xorg-video-intel 
	#${shary} xserver-xorg-video-nouveau xserver-xorg-video-qxl xserver-xorg-video-radeon xserver-xorg-video-vesa xserver-xorg-video-vmware

	
		
		#VAIH:xserver-xorg-video-* ainakin mukaan?
		
#		#dpkg: dependency problems prevent configuration of x11-apps:







#... "case l" jos kuittaisi äksän lib-jutut (tai sit boottaa minimal-liveen ja asenna x+wdm siihen) (TODO?)
	
}

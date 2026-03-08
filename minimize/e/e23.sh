#TODO:mukaan  e22_ghi , e22_qrs, e22_upgp, e22_other_pkgs , e22_tblz ?

function e22_dm() {
	dqb "e22dm ( ${1} ) "
	csleep 1

	[ -z "${1}" ] && exit 11
	csleep 4

	${fib}
	csleep 2
	
	#LOPPUU SE PURPATUS PRKL
	${shary} cpp-12 gcc-12-base libstdc++6 
	${shary} libgcc-s1 libc6 libgomp1 
	csleep 1

	${shary} libice6 libsm6 libx11-6 libxext6 libxmu6 libxt6
	${shary} menu twm
	csleep 1
	
	#libselinux oikeastaan muualla jo
	${shary} libcrypt1 libpam0g libselinux1 #jemmaan?
	${shary} libxau6 libxaw7 libxdmcp6 libxft2 libxinerama1 
	csleep 1
	
	${shary} libxpm4 libxrender1 debconf x11-utils cpp lsb-base x11-xserver-utils procps
	csleep 1

	${shary} libgtk-3-0 libgtk-3-common
	csleep 1

	${shary} libxxf86vm1 libxrandr2 libxml2 libxi6 libglib2.0-0 libglib2.0-data libatk1.0-0 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common
	csleep 1

	${shary} fontconfig libfribidi0 libharfbuzz0b libthai0
	${shary} libfreetype6 libxcb-shape0 libxcb-damage0 libxcb-present0 libxcb-xfixes0 libxcb1
	${shary} libxcb-render0 libxcb-shm0

	case ${1} in
		xdm) #010126:pitäisiköhän tämäkin case testata?
			${shary} xdm
		;;
		wdm)
			# zlib1g perl:any xserver-xorg | xserver:tarteeko juuri tässä vetää?
			${shary} libnuma1

			${shary} libwebp7 libaom3 libdav1d6 libde265-0 libx265-199
			#csleep 1

			${shary} libwebpdemux2 libheif1 libaudit-common libcap-ng0 libaudit1
			csleep 1

			${shary} libdb5.3 libpam-modules-bin libpam-modules libpam-runtime
			#csleep 1

			${shary} sysvinit-utils libtinfo6 libpng16-16 libx11-xcb1  
			csleep 1

			${shary} libxfixes3 libxcursor1
			#csleep 1

			${shary} libxkbfile1 libxmuu1 
			#bsdextrautils | bsdmainutils 
			${shary} bsdextrautils groff-base libgdbm6 libpipeline1 libseccomp2 man-db
			csleep 1

			${shary} libexpat1 fontconfig-config libfontconfig1
			${shary} libfontenc1 libglvnd0 libglx0 libgl1  
			#csleep 1

			${shary} x11-common libxtst6 libxv1 libxxf86dga1 
			csleep 1

			${shary} psmisc x11-apps
			#csleep 1

			${shary} libpcre2-8-0 libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
			csleep 1

			${shary} libgif7 libwraster6 libjpeg62-turbo
			${shary} imagemagick-6-common libmagickwand-6.q16-6 libtiff6
			#csleep 1

			${shary} libbz2-1.0 libfftw3-double3  libjbig0 liblcms2-2 liblqr-1-0 libltdl7 liblzma5 libopenjp2-7 libwebpmux3
			csleep 1

			${shary} libmagickcore-6.q16-6 
			#csleep 1

			${shary} libwutil5 wmaker-common libwings3
			csleep 1

			${shary} libx11-data libmd0 libbsd0
			#csleep 1 	
		
			${shary} wdm
		;;
#		lxdm)
#			
#			${shary} libpixman-1-0
#			csleep 1
#			
#			#jos aikoo dbusista eroon ni libcups2 asennus ei hyvä idea
#			
#			# (>= 1.28.3),  (>= 1.28.3),(>= 1.28.3),(>= 2:1.4.99.1),  (>= 1:0.4.5), libxcursor1 (>> 1.1.2), libxdamage1 (>= 1:1.1), , libxfixes3,  (>= 2:1.1.4),  (>= 2:1.5.0),  adwaita-icon-theme | gnome-icon-theme, hicolor-icon-theme, shared-mime-info
#			${shary} libpangocairo-1.0-0   
#			csleep 1
#
#			${shary} libdeflate0 debliblerc4 
#			csleep 1
#
#			#acceptiin ainakin 2-0-common enne 2-0 ja sitten muuta tauhkaa hakien tässä kunnes alkaa riittää
#			${shary} libcairo2 libgtk2.0-common libgtk2.0-0
#			csleep 1
#	
#			#gdk ennen gtk?
#			${shary}   
#			csleep 1
#		
#			${shary} gtk2-engines-pixbuf gtk2-engines 
#			csleep 1
#
#			${shary} lxdm 
#			csleep 1
#			
#			#261225:lxde-juttujrn ja lxpolkit:in riippuvuukisien selvutys saattaa osoittautua tarpeelliskeis?
#			
#			#polkit-1-auth-agent:
#			
#			#${shary} lxsession-data libpolkit-agent-1-0 libpolkit-gobject-1-0 policykit-1 laptop-detect lsb-release
#			#csleep 1
#			 
#			#	 lxlock | xdg-utils, 
#
#			# lxpolkit | polkit-1-auth-agent,  lxsession-logout
#			
#			${shary} lxpolkit lxsession-logout lxsession
#			csleep 1
#		;;
		*)
			dqb "sl1m?"
		;;
	esac
	
	E22_GX="libwww-perl xscreensaver-data init-system-helpers libegl1 xscreensaver"
	${shary} ${E22_GX}  #libsystemd0
}

#VAIH:mukaan    e22_tblz+stuff ?

#130126:tehdyn paketin sisältö asentuu ainakin live-ymp, vissiin myös sqrootissa
#HUOM.080326:3. param tarpeellisuus?
#TODO:testaus uusicksi josqs

function e22_tblz() {
	#HUOM.28925:vieläkö asentaa avahin?
	dqb "x2.e22_tblz ${1} , ${2}  , ${3}  , ${4} "

	csleep 1
	dqb "\$shary = ${shary}"
	csleep 2

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 15 
	[ -z "${2}" ] && exit 12
	[ -z "${3}" ] && exit 13
	[ -z "${4}" ] && exit 14

	dqb "parx_ok"
	csleep 2

	dqb "EDIBLE AUTOPSY"
	csleep 1
	${fib}
	${asy}
	csleep 1

	#message() tähän?
	tpc7	#jotain excaliburiin liittyvää
	aswasw ${2}
	${shary} ${E22_GT} 

	dqb "x2.e22_tblz.part2"
	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}
	csleep 2

	${asy}
	dqb "BEFORE e22_pre2"
	csleep 2

	#actually necessary
	e22_pre2 ${1} ${3} ${2} ${4} 
	other_horrors
	dqb "x2.e22_tblz.done"
}


#VAIH:ntp-jutut takaisin josqs?
#tables-säännöt vissiin ok
#ja ainakin oletus-konf löytyy
#niin että

#010326:toimii (testaa josqs uusiksi, TODO) 
#btw. mikä muuten syynä libgfortran5-nalkutukseen?
#HUOM.080326:1. param luultavasti tarpeellinen myös jatkossa

function e22_other_pkgs() { 
	dqb "e22_other_pkgs ${1} ,  ${2}  ASDFASDFASDF"
	#toista param? eiole
	csleep 1

	[ -z "${1}" ] && exit 11
	dqb "paramz_ok"
	csleep 1

	dqb "shary= ${shary}"
	csleep 4

	#LOPPUU SE PURPATUS PRKL
	#jatkossa osa E22_GS ?
	${shary} cpp-12 gcc-12-base libstdc++6 
	${shary} libgcc-s1 libc6 libgomp1 
	csleep 2
	
	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?

	${shary} ${E22GI}
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0  git-man git"
	${shary} ${E22_GG}

	#sudo-asia olisi jo kunnossa 120126?	ehkä
	E22_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"
	
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} ${E22_GS}  #moni pak tarttee nämä
	#${shary} #bsd debconf

	#${shary} seatd #130126:paskooko tämä kuitenkin asioita vai ei? ehkä
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
	[ $? -eq 0 ] && dqb "luBE 0F THE R3S0NATED"
	csleep 2
	dqb "MåGOG"
	
#	#TODO:jos lukaisi debian referencen pitkästä aikaa, että löytyisikö jotain jekkua paketinhallinnan kanssa? ettei tarvitse kikkailla initramfs:n ja muutaman paketin kanssa
#	... package pinning?
#	${lftr}
#	csleep 2

#	vähän aikaa ilman kunnes saa aikaiseksi konffata
#	${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
#	${shary} ntpsec
		
	csleep 2
	dqb "e22_other_pkgs donew"
	csleep 1
}
#äksän kanssa "+scm +usermod -seatd" se toimiva jekku?

function e22_upgp() {
	dqb "e22_upgp ${1}, ${2}, ${3}, ${4}"
	#ei pitäne tulla neljättä

	[ -z "${1}" ] && exit 1 
	#[ -w ${1} ] || exit 44 #man bash taas?
	#[ -s ${1} ] && mv ${1} ${1}.OLD 261225 laitetttu kommentteihin koska aiheutti ongelmia
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -z "${3}" ] && exit 33 #kuinkahan tarpeellista on tämäkin tuoda fktioon?

	dqb "params_ok"
	csleep 5
	
	${fib}
	csleep 1

	#LOPPUU SE PURPATUS PRKL
	${shary} cpp-12 gcc-12-base libstdc++6 
	${shary} libgcc-s1 libc6 libgomp1 

	#helpompi vain ajaa e22_dm() ennen upgp()
	
	#HUOM.27925: "--yes"- vipu pitäisi olla mukana check_bin2 kautta, onko?
	${sag} --no-install-recommends upgrade -u
	echo $?
	#HUOM.081225:pitäisiköhän keskeyttää tässä jos upgrade qsee?
	csleep 1

	# #d-blkissa jatkossa?
	[ ${debug} -eq 1 ] && ls -las ${2}/*.deb
	csleep 5

	dqb "generic_pt2 may be necessary now"	
	csleep 1

	${sifd} ${3}
	csleep 1
	
	dqb " ${3} SHOULD BE Dbtl 1n turq"
	csleep 1

	#HUOM.part076() ja part2_5() on keksitty (tosin e22_dblock() nykyään...)
	[ ${debug} -eq 1 ] && ls -las ${2}/*.deb
	csleep 1
	
	case ${3} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 1
		;;
		*)
			${NKVD} ${2}/wpa*
			#HUOM.25725:pitäisi kai poistaa wpa-paketit tässä, aptilla myös?
			#... vai lähtisikö vain siitä että g_pt2 ajettu ja täts it
		;;
	esac

	csleep 1
	dqb "SIELUNV1H0LL1N3N"
	csleep 1
}


function e22_ghi() {
	dqb "TODO:testaa"
	dqb "${sag_u} | ${fib} , when necessary " 
	exit 44

	echo "${shary} ${E22GI}"
	echo "${svm} ${CONF_pkgdir}/*.deb ${2}/${3}"
	
	echo "$0 f ${1} ${3}"
	#exit 1
}

#VAIH:tdstonnimi parametriksi
#VAIH:param tark
#TODO:testaa

function e22_qrs() {
	[ -z "${1}" ] && exit 77
	[ -s ${1} ] || exit 66
	[ -r ${1} ] || exit 55
	[ -z "${4}" ] && exit 44
	
	e22_config1 ~ ${CONF_default_arhcive2}
	${srat} -rvf $1} ~/${CONF_default_arhcive2} #VAIH:CONBF_def_yhyy

	dqb $?
	csleep 4

	${NKVD} ~/${CONF_default_arhcive}
	csleep 1

	e22_settings ${2} ${CONF_default_arhcive}
	#btw. mikä olikaan syy että q on tässä ekassa switch-case:ssa? pl siis että turha apt-renkkaus

	for f in $(find ${2} -maxdepth 1 -name '${CONF_default_arhcive}' -or -name 'profs.sh' | grep -v pulse) ; do
		${srat} -rvf ${1} ${f}
	done

	e22_ftr ${1}
	dqb "CASE Q D0N3"
	csleep 3
	exit
}

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

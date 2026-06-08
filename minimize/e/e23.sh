#just_download_not_install-vipu olisi tietysti...

function aswasw() {
	dqb "aswasw( ${1} )"
	[ -z "${1}" ] && exit 56
	csleep 1

	case "${1}" in
		wlan0)
			#E22:GN="libnl-3-200 ... "
			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2
			
			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 #libreadline8 # libssl3 adduser
			${shary} wpasupplicant
		;;
		*)
		;;
	esac
}

#TODO:vissiin muistettava toisessa oksassa katsoa kuinka monta param tälle fktiolle siellä menee
function e23_tblz() {
	dqb "; )e23_tblz( ( ${1} ( ${2} (((  ${3} )( (((  ${4}   )"
	csleep 1

	[ -z "${1}" ] && exit 11
	[ -z "${2}" ] && exit 12

	${fib}
	${asy}

	#message() tähän?
	tpc7
	#jotain excaliburiin liittyvää
	#$1 vai $2?
	aswasw ${1}

	e22_pre_e ${E22_GT}

	csleep 1

	${asy}
	csleep 3

	#(riittäisikö 2 param kutsussa?)
	e22_pre2 ${1} ${2}
	other_horrors

	csleep 1
	dqb "e23_tblz() DONE"
}

function e23_other_pkgs() { 
	dqb "e23_other_pkgs()"
	#toista param? eiole

	[ -z "${1}" ] && exit 11
	dqb "pars.ok"

	csleep 1

	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?
	${shary} ${E22_GI}
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 git-man git"
	e22_pre_e ${E22_GG}
	e22_pre_e ${E23_GS}

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
	dqb "e23_other_pkgs() DONE"
	csleep 1
}

function e23_upgp() {
	dqb " e23_upgp() "

	${fib}
	csleep 1

	${shary} ${E22_GS}

	${sag} --no-install-recommends upgrade -u
	echo $?

	dqb " e23_upgp() done"
	csleep 1
}

function e23_upgp2() {
	dqb " e23_upgp2() "
	[ -z "${1}" ] && exit 1 
	[ -z "${2}" ] && exit 11

	case "${2}" in
		wlan0)
			csleep 1
		;;
		*)
			${NKVD} ${1}/wpa*
		;;
	esac

	dqb " e23_upgp2() done"
	csleep 1
}

function e23_qrs() {
	dqb "e23_qrs()"

	[ -z "${1}" ] && exit 77
	[ -s ${1} ] || exit 66
	[ -r ${1} ] || exit 55
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -z "${3}" ] && exit 44

	[ -z "${4}" ] && exit 43

	[ -z "${5}" ] && exit 43


	dqb "pars.0k"
	csleep 1

	e22_config1 ~ ${3}
	${srat} -rvf ${1} ~/${3}
	csleep 1


	tar -tf ${1} | grep ${3} | wc -l
	csleep 2

	dqb "BEFORE NVDk"
	[ -f ${4} ] && ${NKVD} ~/${4}
	csleep 1

	e22_settings ${2} ${4} ${5}
	
	for f in $(find ${2} -maxdepth 1 -type f -name ${4} -or -name ${5} | grep -v pulse) ; do
		${srat} -rvf ${1} ${f}
	done

	[ ${debug} -eq 1 ] && tar -tf ${1} | grep ${4} | wc -l
	csleep 1
}

#pitää sitten jaksaa muistaa että tämän fktion tuotoksen asentuminen riippuu niistä accept-tdstoista kanssa
#P.S. jälleen kerran oli urputusta paketin sisällön asennusvaiheessa accept1 kanssa EDELLEEN jotain numa numa jee
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

	
	${shary} libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
	${shary} libmagickcore-6.q16-6 libmagickwand-6.q16-6

	${shary} libnuma1 libx265-199 libwraster6 libwings3

	csleep 10

	${shary} libfftw3-double3 libfontconfig1 libfontenc1 libfreetype6 libheif1 libjbig0 libjpeg62-turbo liblcms2-2 liblqr-1-0
	csleep 5

	${shary} liblzma5 libopenjp2-7 libltdl7 libpng16-16 libtiff6 libwebp7 libwebpdemux2 libwebpmux3
	csleep 10

	${shary} libx11-6 libx11-xcb1 libx11-data libxext6 imagemagick-6-common libxmu6 libxmuu1 libgif7 libxpm4
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
	${shary} libglx-mesa0 libffi8 libzvbi0 git-man
	${shary} libdb5.3 debconf libdeflate0 liblerc4 #mukaan?	
	${shary} libpam-runtime
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

#TODO:miten se Makefile-idea? kokeilisiko?

function e23_profs() {
	dqb ";e23_profs) ${1} , ${2} , ${3} (()("
	csleep 1

	[ -z "${1}" ] && exit 76
	[ -z "${2}" ] && exit 75
	[ -z "${3}" ] && exit 74

	[ -d "${2}" ] || exit 73
	[ -s ${1} ] || exit 72
	[ -s ${3} ] || exit 71

	dqb "pars.0k"
	csleep 1

	q=$(${mkt} -d)
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

function e23_st() { #josqs tämänkin testaus? (kts toisen repon setup1.bash)
	${shary} liblz4-1 liblzma5 liblzo2-2 libzstd1 squashfs-tools
	${shary} libbz2-1.0 libmagic1 libcap2 genisoimage wodim
	${shary} dmsetup libdevmapper1 libjte2
	${shary} libefiboot1 libefivar1 libfreetype6 libfuse3-3 gettext-base
	${shary} libisoburn1 libburn4 libisofs6 libfuse2 mtools
	${shary} grub-common xorriso  geany  isolinux
	}

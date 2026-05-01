#280426:sai aikaiseksi tdston, sisällön kelpoisuus vielä selvitwettävä
function e23_qrs() {
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

	e22_config1 ~ ${3}
	${srat} -rvf ${1} ~/${3}
	tar -tf ${1} | grep ${3} | wc -l

	[ -f ${4} ] && ${NKVD} ~/${4}
	e22_settings ${2} ${4} ${5}

	for f in $(find ${2} -maxdepth 1 -type f -name ${4} -or -name ${5} | grep -v pulse) ; do
		${srat} -rvf ${1} ${f}
	done
}

#240426 ehkä toimi
function e23_profs() {
	q=$(mktemp -d)
	cd ${q}
	[ $? -eq 0 ] || exit 77
	pwd
	[ -v CONF_BASEURL ] || exit 78
	${tig} clone https://${CONF_BASEURL}/more_scripts.git
	[ $? -eq 0 ] || exit 79
	${svm} more_scripts/profs/${3}* ${2}
	${scm} 0555 ${2}/${3}*
	${sr0} -rvf ${1} ${2}/${3}*
}

function e23_st() {
	${shary} liblz4-1 liblzma5 liblzo2-2 libzstd1 squashfs-tools
	${shary} libbz2-1.0 libmagic1 libcap2 genisoimage wodim
	${shary} dmsetup libdevmapper1 libjte2
	${shary} libefiboot1 libefivar1 libfreetype6 libfuse3-3 gettext-base
	${shary} libisoburn1 libburn4 libisofs6 libfuse2 mtools
	${shary} grub-common xorriso  geany  isolinux
	}

function aswasw() {
	dqb "aswasw()"
	[ -z "${1}" ] && exit 51

	case "${1}" in
		wlan0)
			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1
			${shary} wpasupplicant
		;;
		eth0)
			dqb "sHOULD \${shary} ISC-DHCP-???"
		;;
		*)
			dqb "whåtever"
		;;
	esac

	dqb "aswasw() DONE"
}

function e23_tblz() {
	dqb " e23_tblz( ${1} ; ${2} ; ${3} ; ${4} ))))"
	csleep 10

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 15
	[ -z "${2}" ] && exit 12
	[ -z "${3}" ] && exit 13
	[ -z "${4}" ] && exit 14

	${fib}
	${asy}
	tpc7

	aswasw ${2}
	
	#vähän turha if-blokki tässä?
	if [ "${2}" == "eth0:1" ] ; then
		local p
		local q

		for p in ${E22_GT} ; do
			q=$(echo ${p} | grep -v dhcp)
			[ -z "${q}" ] || ${shary} ${q}
			csleep 1
		done
	else
		${shary} ${E22_GT}
	fi

	${asy}
	#actually necessary
	e22_pre2 ${1} ${3} ${2} ${4}
	other_horrors
}

function e23_other_pkgs() {
	[ -z "${1}" ] && exit 11

	${shary} ${E22_GI}
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 git-man git"
	${shary} ${E22_GG}
	E23_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"
	${shary} ${E23_GS}
	message
	jules

	if [ ${1} -eq 1 ] ; then
		${shary} libgmp10 libhogweed6 libidn2-0 libnettle8
		${shary} runit-helper
		${shary} dnsmasq-base dnsmasq dns-root-data #dnsutils
		${lftr} 
		[ $? -eq 0 ] || exit 3
		${shary} libev4
		${shary} libgetdns10 libbsd0 libidn2-0 libssl3 libunbound8 libyaml-0-2
		${shary} stubby
	fi

	${lftr}
}

function e23_upgp() {
	${fib}
	${shary} ${E22_GS}

	#TODO:varm vuoksi E22_GS duosatus kanssa?
	#TODO:vetämään livavutil- ja libavcodec- paketit riippuvuuksineen mukaan?

	${sag} --no-install-recommends upgrade -u
	echo $?
}

function e23_upgp2() {
	[ -z "${1}" ] && exit 1 
	[ -z "${2}" ] && exit 11

	case "${2}" in
		wlan0)
			csleep 1
		;;
		#miten ne isc-dhcp-paketit tässä?
		*)
			${NKVD} ${1}/wpa*
			#HUOM.25725:pitäisi kai poistaa wpa-paketit tässä, aptilla myös?
			#... vai lähtisikö vain siitä että g_pt2 ajettu ja täts it
		;;
	esac
}

#190426:vissiin toimii, ÄLÄ SORKI (ainakaan enempää kuin aivan välttämätöntä)
#function e23_dm() {
#[ -z "${1}" ] && exit 11
#	${fib}
#	${shary} ${E22_GS}
#	${shary} ${E22_GM}
#
#	if [ "${1}" == "wdm" ] ; then
#		dqb "dm.k0"
#	else
#		echo "NOT SUPPORTED"
#		exit 666
#	fi
#
#	${shary} libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
#	${shary} libmagickcore-6.q16-6 libmagickwand-6.q16-6
#
#	${shary} libnuma1 libx265-199 libwraster6 libwings3
#	csleep 10
#
#	${shary} libfftw3-double3 libfontconfig1 libfontenc1 libfreetype6 libheif1 libjbig0 libjpeg62-turbo liblcms2-2 liblqr-1-0
#	csleep 5
#
#	${shary} liblzma5 libopenjp2-7 libltdl7 libpng16-16 libtiff6 libwebp7 libwebpdemux2 libwebpmux3
#	csleep 10
#
#	${shary} libx11-6 libx11-xcb1 libx11-data libxext6 imagemagick-6-common libxmu6 libxmuu1 libgif7 libxpm4
#	#[ $? -eq 0 ] || exit 57 #jospa ei tämmöisiä tähän fktioon, tökkii
#	csleep 5
#
#	${shary} fontconfig fontconfig-config
#	${shary} libdav1d6 libde265-0 libfribidi0 libglib2.0-0 libglib2.0-data libharfbuzz0b
#	${shary} libthai0 libxft2 libxrender1 libxrandr2
#	csleep 10
#
#	${shary} libdrm2 libexpat1 libgbm1 libglapi-mesa libwayland-client0 libwayland-server0 libwayland-cursor0 libwayland-egl1
#	${shary} libxcb1
#	csleep 5
#
#	${shary} libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-randr0 libxcb-sync1 libxcb-xfixes0 
#	${shary} libxcb-shape0 libxshmfence1 libxcb-damage0 libxcb-shm0 libxcb-render0 #hyvä idea ksekittää nämä inxcb-jutut?
#	csleep 10
#
#	${shary} libglvnd0 libegl-mesa0 libgl1 libxaw7 libegl1
#	csleep 5
#
#	${shary} libxcomposite1 libxi6 libxinerama1 libxkbfile1
#	csleep 10
#
#	${shary} libxt6 libxtst6 libxv1 libxxf86dga1 libxxf86vm1 libsm6
#	csleep 5
#
#	${shary} libxcursor1 libwutil5 man-db wmaker-common libbz2-1.0
#	csleep 10
#
#	${shary} libicu72 libxfixes3 libxml2
#	${shary} libpam-runtime #E22_GM toisi pari libpam-pakettttiaq
#	csleep 10
#
#	${shary} libxdmcp6 menu twm libmd0
#	csleep 5
#
# 	${shary} libaom3 at-spi2-common libatk1.0-0 libaudit-common libbsd0 libcap-ng0 
#	csleep 10
#
#	${shary} libxau6  #C
#	${shary} libgdbm6 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common libglx0 
#	${shary} libgtk-3-0 libgtk-3-common libice6  #libheif versio ok?
#	csleep 5
#
#	${shary} libseat1 libseccomp2 libtinfo6 #libpipeline1?
#	${shary} libunwind8
#	csleep 10
#
#	${shary} lsb-base psmisc #A
#	${shary} bsdextrautils groff-base 
#	${shary} init-system-helpers  #xscreensaver?
#	csleep 5
#
#	${shary} x11-apps x11-common x11-utils
#	csleep 10
#
#	${shary} x11-xserver-utils xserver-xorg #D
#	${shary} xterm xauth
#	${shary} wdm
#}
#

#TODO:miten se Makefile-idea? kokeilisiko?

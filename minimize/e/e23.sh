#150926:jos makefile-jutut kohta ajankohtaisia?

function aswasw() { #14726:dhclient masentelu tähän vai ei? toisaalta pre_e() nykyään
	dqb "aswasw( ${1} )"
	[ -z "${1}" ] && exit 56
	csleep 1


	#VAIH:vähitellen jotain? E22:_GT , GU, GM hyödyntäen? tai siis voiko nykyiselllään hyödyntää?
#			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2

	if [ "${1}" == "wlan0" ] ; then
		${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 #libreadline8 # libssl3 adduser
		${shary} wpasupplicant
	fi

	#TODO?:E22_D?
	if [ "${1}" != "eth0:1" ] ; then
		worf isc-dhcp-client,isc-dhcp-common 2
	fi
}

function e23_tblz() {
	dqb "; )e23_tblz( ( ${1} ( ${2} (((  ${3} )( (((  ${4}   )"
	csleep 1

	[ -z "${1}" ] && exit 11
	[ -z "${2}" ] && exit 12

	dqb "pars ok"
	csleep 1

	${fib}
	${asy}
	csleep 1

	#message() tähän?
	tpc7
	#jotain excaliburiin liittyvää tuo tpc

	#joutaisi kai josqs siirtää dhcp-jutut pre_e -> asw tai siis mitenkä?
	aswasw ${1}	
	e22_pre_e ${1} ${E22_GT}

	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}
	csleep 1

	${asy}
	# (2 param kutsussa sopisi riittää)
	e22_pre2 ${1} ${2}
	other_horrors

	dqb "e23_tblz() DONE"
	csleep 1
}

function e23_other_pkgs() { 
	dqb "e23_other_pkgs()"
	#toista param? eiole

	[ -z "${1}" ] && exit 11
	dqb "pars.ok"
	csleep 6

	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?
	e22_pre_e ${CONF_iface} ${E22_GI}
	e22_pre_e ${CONF_iface} ${E22_GG}
	e22_pre_e ${CONF_iface} ${E23_GS}
	#e22_gs vs e23_gs ? eri asioita

	message
	jules

	if [ ${1} -eq 1 ] ; then
		${shary} libgmp10 libhogweed6 libidn2-0 libnettle8
		${shary} runit-helper
		${shary} dnsmasq-base dnsmasq dns-root-data #dnsutils

		${lftr} 
		[ $? -eq 0 ] || exit 3

		${shary} libev4
		${shary} libgetdns10 libbsd0 libidn2-0 libssl3 libunbound8 libyaml-0-2 #sotkeekohan  uudelleenas tässä?
		${shary} stubby
	fi

	#uutena 30926
	${shary} libmagic-mcg libmagic1 python3-magic apt-offline
	csleep 15
	${lftr}

	dqb "e23_other_pkgs() DONE"
	csleep 10
}

function e23_upgp() {
	dqb " e23_upgp() "
	${fib}
	csleep 1

	#JOKO JO PRKL?
	${shary} libxcb1 libx11-data libx11-6 libx11-xcb1
	#TODO?:libelf,linexpat1 yms mukaan vai ei? (kts accept2)

	#Depends: libc6 (>= 2.14), libgcc1 (>= 1:3.0), 
	#, (>= 6), (>= 1.0.3),  (>= 1.7.3), , 
	#Depends: libc6 (>= 2.34), 


	${shary} libgl1 libva-x11-2 libva2 libxext6 #libx11-6  jo aiemmin
	${shary} libvdpau1 mesa-vdpau-drivers

	e22_pre_e ${CONF_iface} ${E22_GS}
	${sag} --no-install-recommends upgrade -u
	echo $?

	dqb " e23_upgp() done"
	csleep 1
}

#TODO?:tämän se dhcp-karsinta kanssa? (oliko case-esac syntaksin kanssa huomioitavaa? man bash barm vuoksi?) vielä ajank 10/26?

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

	#tuleeko mukaan vai ei?
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
#VAIH:testaus uusicksi josqs koska y (27926 vaikuttaisi siltä että osdaltaan uusi l-paketti aiheuttaa äksän poistumisen)
#29926:eilinen l-paketti vaikutti toimivalta, testaus sqrootissa toivottava
#29926.2:joskus tietenkin kokeiltava jtnknin että vetääkö fktion uusin versio ne toivottavat paketit

#VAIH?: perl, , ,,  mukaanjos puuttuu?
#... siis 1 ekaa lisäten lähinnä? tai siis perl jo qnnossa?

echo "MUISTA : uusi l+wanha u tässä järj, mitä taaphtuu?"
sleep 1
echo "DONE?:libvdpau, mesa-vdpau, mukaan dm() juttuihin?"
sleep 10

#30926:tähän voi tulla isompia muutoksia koska a-offline
#Depends: python3:any, apt, less, python3-magic
#Depends: python3:any, libmagic1 (>= 1:5.39)
#Depends: libbz2-1.0, libc6 (>= 2.33), liblzma5 (>= 5.1.1alpha+20120614), zlib1g (>= 1:1.1.4), libmagic-mgc (= 1:5.44-3)
#

function e23_dm() {
	dqb "e23_dm())) ${1} )"
	[ -z "${1}" ] && exit 11
	csleep 2

	dqb "pars.ök"
	csleep 1

	${fib}
	e22_pre_e ${CONF_iface} ${E22_GS}
	e22_pre_e ${CONF_iface} ${E22_GM}
	csleep 5

	if [ "${1}" == "wdm" ] ; then
		dqb "dm.k0"
	else
		echo "NOT SUPPORTED"
		exit 666
	fi

	#HUOM.jutut ennen libpangoa/666 jälkeen uusia, kommentteihin jos qsee EHKÄ

	#290926:ao. paketitko aiheuttavat äksän poistumisen?
	${shary} libxcb1 libx11-6 libx11-xcb1 libx11-data
	csleep 3

	${shary} libxext6 libffi8 libtinfo6 libxml2 libz3-4 libdrm2
	${shary} fontconfig libfontconfig1 fontconfig fontconfig-config libfribidi0
	${shary} libglib2.0-0 libglib2.0-data libharfbuzz0b libthai0 libfreetype6
	csleep 3

	${shary} libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-randr0 libxcb-sync1 libxcb-xfixes0 libxshmfence1	
	${shary} zlib1g libllvm15 libdrm-radeon1 libdrm-nouveau2 libdrm-amdgpu1 libvdpau1 mesa-vdpau
	csleep 3

	${shary} libfontenc1 libdav1d6 libmagickcore-6.q16-6 libnuma1

	#ao. blokki ehkä kunnossa
	${shary} libxmuu1 libde265-0 
	${shary} libexpat1 libwayland-client0 libglvnd0 #glvnd vai glvnd0?
	csleep 3
	
	${shary} libxft2 libxrender1 libxrandr2
	${shary} libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
	${shary} libbz2-1.0 libfftw3-double3 libheif1 libjbig0 libjpeg62-turbo liblcms2-2
	csleep 3

	${shary} liblqr-1-0 libltdl7 liblzma5 libopenjp2-7 libpng16-16 libtiff6 libwebp7 libwebpdemux2 libwebpmux3 libxt6
	csleep 3

	#ao. blokki qnnnosa?
	${shary} imagemagick-6-common 
	${shary} libgif7 libmagickwand-6.q16-6 libxmu6 libxpm4
	csleep 3

	#ao. blokki qnnossa?
	${shary} libx265-199 libwraster6 libwings3 libwutil5 wmaker-common
	csleep 3

	#ao. blokki qnnossa?
	${shary} libgbm1 libglapi-mesa  libwayland-server0 libwayland-cursor0 libwayland-egl1
	csleep 3

	#ao blokki qnnossa?
	${shary} libxcb-shape0 libxcb-damage0 libxcb-shm0 libxcb-render0
	csleep 3

	#ao. blokki qnnossa?
	${shary} libglx0 libegl-mesa0 libgl1 libxaw7 libegl1
	csleep 3

	#ao. blokki qnnossa?
	${shary} libxcomposite1 libxi6 libxinerama1 libxkbfile1
	csleep 3

	#ao. blokki qnnossa?
	${shary} libice6 libsm6 x11-common libuuid1
	${shary} libxtst6 libxv1 libxxf86dga1 libxxf86vm1
	csleep 3

	#ao. blokki ehkä qnnossa
	${shary} debconf bsdextrautils groff-base libgdbm6 libpipeline1 libseccomp2
	${shary} libicu72 libxfixes3 
	csleep 3

	${shary} libxcursor1 man-db
	csleep 3

	#28926:ehkä lingl1-libpam-runtime -pakettiewn riippuvuudet nyt kunnossa
	${shary} libgl1-mesa-dri libxcb-glx0 libglx-mesa0 libzvbi-common libzvbi0 git-man
	${shary} libdb5.3 libdeflate0 liblerc4
	${shary} libpam-runtime
	csleep 3

	#qnnossa?
	${shary} libbsd0 libxdmcp6 menu twm libmd0
	csleep 3

	#qnnossa tähän atsi?
 	${shary} libaom3 at-spi2-common libatk1.0-0 libaudit-common libcap-ng0
	csleep 3

	#Depends:  (>= 2.4)
	#Depends:  (>= 2.42.10+dfsg-1), , 
	# (>= 2.34), (>= 2.59.0),  (>= 1.3.1),  (>= 1.6.2-1), (>= 4.0.3)
	#-
	#Depends: , , ,  (>= 2.15.1),  (>= 2.35.1), 
	# (>= 2.34),  (>= 1.14.0),  (>= 1.14.0),  (>= 0.1.10),  (>= 1.7.0),  (>= 1.4.3), 
	# (>= 2.12.6),  (>= 0.19.7),  (>= 2.40.0),(>= 2.59.0),  (>= 2.2.0), 
	#(>= 1.45.5),  (>= 1.44.0), (>= 1.44.0),  (>= 1.20.0), (>= 1.14.91),  (>= 1.15.0),
	#  (>= 2:1.4.99.1),  (>= 1:0.4.5),  (>> 1.1.2),  (>= 1:1.1), ,
	# , (>= 2:1.2.99.4),  (>= 2:1.1.4),  (>= 0.5.0), (>= 2:1.5.0),  (>= 3.24.37-2)
	#Depends:  | gsettings-backend

	#pangot ja cairot aiemmaksi?
	${shary} dconf-gsettings-backend libxau6 libatk-bridge2.0-0 libcairo-gobject2 libcairo2 libcolord2 libcups2 libepoxy0 libpangocairo-1.0-0 #C
	${shary} adwaita-icon-theme hicolor-icon-theme shared-mime-info libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common libxdamage1 libxkbcommon0
	${shary} libgtk-3-0 libgtk-3-common 
	csleep 3

	#mitä näiden kanssa tekee?
	#Depends: seatd | logind, (>= 2.33), libsystemd0 (>= 238)
	#Depends:  (>= 2.34),  (>= 5.1.1alpha+20110809)
	#Depends: sysvinit-utils (>= 3.05-4~)
	#Depends:  (>= 2.34), 
	#-

	${shary} libseat1 libunwind8
	${shary} lsb-base psmisc #A	
	${shary} init-system-helpers  #xscreensaver?
	csleep 3

	#Depends: ,  (>= 1.6.2-1), ,,  (>= 2:1.7.5),  (>= 2:1.0.14), , 
	#, , ,  (>> 1.1.2), ,  (>> 2.1.1),(>= 2:1.2.99.4),  (>= 1:1.1.0),
	# (>= 2:1.1.3),  (>= 2:1.1.3), ,  (>= 1:1.1.0),
	#Depends: , (>= 2.12.6), , , , (>= 2:1.6.9), , ,  (>= 1.6),
	# (>= 1:0.3-1), , (>> 2.1.1),, , , , ,  (>= 2:1.2.0), ,
	# (>= 1:1.1.0), , 

	${shary} x11-apps x11-utils
	csleep 3

	${shary} x11-xserver-utils xserver-xorg #D
	${shary} xterm xauth
	csleep 3

	${shary} wdm
	dqb "e23_dm( done (((("
	csleep 3
}

function e23_profs() {
	dqb ";e23_profs) ${1} , ${2} , ${3} (()("
	csleep 1

	[ -z "${1}" ] && exit 76
	[ -z "${2}" ] && exit 75
	[ -z "${3}" ] && exit 74

	[ -d "${2}" ] || exit 73
	[ -s ${1} ] || exit 72
	#[ -s ${3} ] || exit 71 #mikä tässä pykii?

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

function e23_st() {
	#TODO:joitain git-juttuha mukaan myös (git.-cola ja mitäö näitä olikaan)

	${shary} liblz4-1 liblzma5 liblzo2-2 libzstd1 squashfs-tools
	${shary} libbz2-1.0 libmagic1 libcap2 genisoimage wodim
	${shary} dmsetup libdevmapper1 libjte2
	${shary} libefiboot1 libefivar1 libfreetype6 libfuse3-3 gettext-base
	${shary} libisoburn1 libburn4 libisofs6 libfuse2 mtools
	${shary} grub-common xorriso geany isolinux
	}

#tktiona vähän turhaq, tarkistuksia enemmän kun varsnsiats koodia, toisaalta voisi prujata fktion sisällön niihin 2 kohtaan export2:sessa
#function e22_dblock() {
#	dqb "e22_dblock(${1} , ${2} , ${3} , ${4} )))) "
#
#	[ -z "${1}" ] && exit 14
#	[ -s ${1} ] || exit 15
#	[ -z "${2}" ] && exit 11
#	[ -d ${2} ] || exit 22
#	[ -w ${2} ] || exit 23
#	[ -z "${3}" ] && exit 33
#	[ -d ${3} ] || exit 34
#	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...
#	[ -z "${4}" ] && exit 37
#
#	dqb ".PARS-OK"
#	csleep 1
#
#	[ ${debug} -eq 1 ] && pwd
#
#	ls -la ${3}/*.deb | wc -l
#
#	for s in ${PART175_LIST} ; do
#		${sharpy} ${s}*
#		${NKVD} ${3}/${s}*.deb
#	done
#
#	local t
#	t=$(echo ${2} | cut -d "/" -f 1-6)
#	e22_ts ${t} ${3}
#	dqb "JST B3F0R3 3NF0RC3"
#	csleep 10
#
#	enforce_access $(whoami) ${t}
#	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
#	csleep 10
#
#	e22_arch ${1} ${2} ${4}
#	e22_cleanpkgs ${2}
#}

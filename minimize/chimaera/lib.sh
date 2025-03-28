#=========================PART 0 ENDS HERE=================================================================
function pr4() {
	#HUOM. stubby,dns-siivoamiset voisi olla riippuvaisIa konfiguraatiosta
	dqb "pr4 (${1})"

	#sha512sums ole massaolo kuuluIsi kai tarkistaa ensin jos on niinqu pedantti
	#TODO:psqa() käyttöön	
	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		p=$(pwd)
		cd ${1}
		${sah6} -c sha512sums.txt --ignore-missing
		echo $? #exit jos ei nolla
		csleep 6
		cd ${p}
	else
		dqb "NO SHA512SUMS"
		csleep 1
	fi

	if [ ${dnsm} -eq 1 ] ; then
		${NKVD} ${1}/stubby*
		${NKVD} ${1}/libgetdns*
		${NKVD} ${1}/dnsmasq*
	fi

	dqb "d0n3"
}

#HUOM.170325:git näköjään asentuu pr4((), pre3() - vaiheiden aikana vaikka vähän nalkutusta tuleekin(josko nalkutuksen poistaisi)
#HUOM.21035: toimiiko nuo sdi-jutut tädssä myös check_bin() kautta? pitäisikö?
#HUOM.230325:tuoreemmat nalkutukset import2.sh kautta, josko tekisi jotain? (VAIH)

#libx11-xcb1:amd64
#dpkg: regarding .../iptables-persistent_1.0.15_all.deb containing iptables-persistent, pre-dependency problem:
# iptables-persistent pre-depends on iptables
#  iptables is not installed.
#
#dpkg: error processing archive /home/devuan/Desktop/minimize/chimaera/iptables-persistent_1.0.15_all.deb (--install):
# pre-dependency problem - not installing iptables-persistent
#Errors were encountered while processing:
# /home/devuan/Desktop/minimize/chimaera/iptables-persistent_1.0.15_all.deb
#dpkg: dependency problems prevent configuration of python3.9:
# python3.9 depends on libpython3.9-stdlib (= 3.9.2-1+deb11u2); however:
#  Package libpython3.9-stdlib:amd64 is not configured yet.
#dpkg: dependency problems prevent configuration of xserver-xorg-legacy:
# xserver-xorg-legacy depends on xserver-common (>= 2:1.20.11-1+deb11u15); however:
#  Version of xserver-common on system is 2:1.20.11-1+deb11u6.
#
#dpkg: error processing package xserver-xorg-legacy (--install):
# dependency problems - leaving unconfigured
#Processing triggers for man-db (2.9.4-2) ...
#Errors were encountered while processing:
# xserver-xorg-legacy
#(Reading database ... 68619 files and directories currently installed.)
#Preparing to unpack .../xserver-xorg-core_2%3a1.20.11-1+deb11u15_amd64.deb ...
#Unpacking xserver-xorg-core (2:1.20.11-1+deb11u15) over (2:1.20.11-1+deb11u6) ...
#dpkg: dependency problems prevent configuration of xserver-xorg-core:
# xserver-xorg-core depends on xserver-common (>= 2:1.20.11-1+deb11u15); however:
#  Version of xserver-common on system is 2:1.20.11-1+deb11u6.
#
#dpkg: error processing package xserver-xorg-core (--install):
# dependency problems - leaving unconfigured
#Processing triggers for man-db (2.9.4-2) ...
#Errors were encountered while processing:
# xserver-xorg-core
#dpkg: dependency problems prevent configuration of libgail-common:amd64:
# libgail-common:amd64 depends on libgail18 (= 2.24.33-2+deb11u1); however:
#  Version of libgail18:amd64 on system is 2.24.33-2.
#
#dpkg: error processing package libgail-common:amd64 (--install):
# dependency problems - leaving unconfigured
#Errors were encountered while processing:
# libgail-common:amd64
#dpkg: dependency problems prevent configuration of libgtk2.0-bin:
# libgtk2.0-bin depends on libgtk2.0-0 (= 2.24.33-2+deb11u1); however:
#  Version of libgtk2.0-0:amd64 on system is 2.24.33-2.
#
#dpkg: error processing package libgtk2.0-bin (--install):
# dependency problems - leaving unconfigured
#Processing triggers for man-db (2.9.4-2) ...
#Errors were encountered while processing:
# libgtk2.0-bin
#dpkg: dependency problems prevent configuration of libgtk-3-bin:
# libgtk-3-bin depends on libgtk-3-0 (>= 3.24.24-4+deb11u4); however:
#  Version of libgtk-3-0:amd64 on system is 3.24.24-4+deb11u3.
#
#dpkg: error processing package libgtk-3-bin (--install):
# dependency problems - leaving unconfigured
#Processing triggers for man-db (2.9.4-2) ...
#Errors were encountered while processing:
# libgtk-3-bin
#dpkg: dependency problems prevent configuration of libpython3.9-stdlib:amd64:
# libpython3.9-stdlib:amd64 depends on libpython3.9-minimal (= 3.9.2-1+deb11u2); however:
#  Version of libpython3.9-minimal:amd64 on system is 3.9.2-1.
#
#dpkg: error processing package libpython3.9-stdlib:amd64 (--install):
# dependency problems - leaving unconfigured
#Errors were encountered while processing:
# libpython3.9-stdlib:amd64
#dpkg: dependency problems prevent configuration of librsvg2-common:amd64:
# librsvg2-common:amd64 depends on librsvg2-2 (= 2.50.3+dfsg-1+deb11u1); however:
#  Version of librsvg2-2:amd64 on system is 2.50.3+dfsg-1.
#
#dpkg: error processing package librsvg2-common:amd64 (--install):
# dependency problems - leaving unconfigured
#Processing triggers for libgdk-pixbuf-2.0-0:amd64 (2.42.2+dfsg-1+deb11u1) ...
#Errors were encountered while processing:
# librsvg2-common:amd64
#dpkg: dependency problems prevent configuration of libsoup-gnome2.4-1:amd64:
# libsoup-gnome2.4-1:amd64 depends on libsoup2.4-1 (= 2.72.0-2+deb11u1); however:
#  Version of libsoup2.4-1:amd64 on system is 2.72.0-2.
#
#dpkg: error processing package libsoup-gnome2.4-1:amd64 (--install):
# dependency problems - leaving unconfigured
#Processing triggers for libc-bin (2.31-13+deb11u6) ...
#Errors were encountered while processing:
# libsoup-gnome2.4-1:amd64
#dpkg: dependency problems prevent configuration of libx11-xcb1:amd64:
# libx11-xcb1:amd64 depends on libx11-6 (= 2:1.7.2-1+deb11u2); however:
#  Version of libx11-6:amd64 on system is 2:1.7.2-1.
#
#dpkg: error processing package libx11-xcb1:amd64 (--install):
# dependency problems - leaving unconfigured
#Processing triggers for libc-bin (2.31-13+deb11u6) ...
#Errors were encountered while processing:
# libx11-xcb1:amd64

function pre_part3() {
	dqb "pre_part3( ${1})"

	if [ ${dnsm} -eq 1 ] ; then
		${sdi} ${1}/dns-root-data*.deb
		${NKVD} ${1}/dns-root-data*.deb
	fi

	${sdi} ${1}/perl-modules-*.deb
	${NKVD} ${1}/perl-modules-*.deb

#	#240325:quick and dirty way of suppressing complaints from dpkg
#	#...except that it didnt work
#	#it is a fatal illusion 
#
#	${NKVD} libpython3.9*
#	${NKVD} python3.9*
#	${NKVD} xserver*
#	${NKVD} libgail*
#	${NKVD} libgtk*
#	${NKVD} librsvg*
#	${NKVD} libsoup*
#	${NKVD} libx11*
#	${NKVD} libgdk*
#
}

dqb "BIL-UR-SAG"
check_binaries ${distro}
check_binaries2 
dqb "UMULAMAHRI"

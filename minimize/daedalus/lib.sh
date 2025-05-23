#=================================================PART 0=====================================

#TEHTY:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#... joskohan --force-confold olisi se haettu juttu

function pre_part3() {
	dqb "daud.pp3( ${1} , ${2} )"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	dqb "pp3.2"
	csleep 1

#	c=$(find ${1} -type f -name '*.deb' | wc -l) #oli:ls -las ip*.deb
#
#	if [ ${c} -lt 1 ] ; then
#		#HUOM.23525:kuuluisi varmaankin ohjeistaa kutsuvassa koodissa
#		echo "SHOULD REMOVE ${1}/sha512sums.txt"
#		echo "\"${scm} a-x ${1}/../common_lib.sh;import2 1 \$something\" MAY ALSO HELP"
#	fi

	csleep 1

	psqa ${1} #HUOM.22525:varm. vuoksi pp3 kutsuvaan koodiin tämä?
	#HUOM.140525:toiminee jo jollain lailla, "no" siihen kysymykseen olisi kuitenkin kiva saada välitettyä dpkg:lle asti

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/netfilter-persistent*.deb  #${NKVD}
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/libip*.deb #${NKVD}
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/iptables_*.deb
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/iptables-*.deb

	dqb "pp3 d0n3"
	csleep 1
}

#HUOM.19525:pitäisiköhän tässäkin olla se debian_froNtend-juttu? ehkä ei ole pakko
function pr4() {
	dqb "daud.pr4( ${1} , ${2} )"
	csleep 1

	#TODO:tähänkin psqa?
	${odio} dpkg -i ${1}/libpam-modules-bin_*.deb
	${odio} dpkg -i ${1}/libpam-modules_*.deb

	${NKVD} ${1}/libpam-modules*
	csleep 1

	${odio} dpkg -i ${1}/libpam*.deb
	${odio} dpkg -i ${1}/perl-modules-*.deb
	${odio} dpkg -i ${1}/libperl*.deb

	${NKVD} ${1}/perl-modules-*.deb
	${NKVD} ${1}/libperl*.deb
	csleep 1

	${odio} dpkg -i ${1}/perl*.deb
	${odio} dpkg -i ${1}/libdbus*.deb
	${odio} dpkg -i ${1}/dbus*.deb
	csleep 1

	${odio} dpkg -i ${1}/liberror-perl*.deb
	${odio} dpkg -i ${1}/git*.deb

	${NKVD} ${1}/git*.deb
	${NKVD} ${1}/liberror-perl*.deb
	csleep 1

	#TODO:libdevmappwr-juttuja? tai mitä olikaan

	${NKVD} ${1}/libpam*
	${NKVD} ${1}/libperl*
	${NKVD} ${1}/libdbus*
	${NKVD} ${1}/dbus*
	${NKVD} ${1}/perl*
	csleep 1
}

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1

	${smr} ${pkgdir}/libx11-xcb1*
	${smr} ${pkgdir}/nfs*
	${smr} ${pkgdir}/rpc*
	${smr} ${pkgdir}/python3.11*
	${smr} ${pkgdir}/xserver-xorg-core*
	${smr} ${pkgdir}/xserver-xorg-legacy*
	${smr} ${pkgdir}/libgtk-3-bin*
	${smr} ${pkgdir}/libpython3.11*
	${smr} ${pkgdir}/librsvg2*
	
	for s in ${PART175_LIST} ; do
		dqb "processing ${s}"
		csleep 1

		${smr} ${pkgdir}/${s}*
		csleep 1
	done

	case ${iface} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 2
		;;
		*)
			${smr} ${pkgdir}/wpa*
		;;
	esac

	dqb "D0NE"
	csleep 1
}

function part2_pre() {
	dqb "dausd.PP2"
	${sharpy} python3-cups
	csleep 1
}

check_binaries ${distro}
check_binaries2



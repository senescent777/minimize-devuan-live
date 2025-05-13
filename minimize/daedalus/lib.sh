##=================================================PART 0=====================================
#
##VAIH:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
##https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

#VAIH:man dpkg, man apt, josqo saisi pakotettua sen vastauksen... tai ensin https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
function pre_part3() {
	[ y"${1}" == "y" ] && exit
	dqb "pp3( ${1} )"
	[ -d ${1} ] || exit
	dqb "pp3.2"

	psqa ${1}

	#HUOM.110525:ei ihan vielä toimi kuten tarkoitus
	${odio} DEBIAN_FRONTEND=noninteractive dpkg -i ${1}/netfilter-persistent*.deb
	#${odio} dpkg -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/netfilter-persistent*.deb  #${NKVD}
	csleep 2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg -i ${1}/libip*.deb
	#${odio} dpkg -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/libip*.deb #${NKVD}
	csleep 2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg -i ${1}/iptables_*.deb
	#${odio} dpkg -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${smr} -f ${1}/iptables_*.deb
	csleep 2

	${odio} DEBIAN_FRONTEND=noninteractive dpkg -i ${1}/iptables-*.deb
	#${odio} dpkg -i ${1}/iptables-*.deb

	[ $? -eq 0 ] && ${smr} -f ${1}/iptables-*.deb
	#[ ${debug} -eq 1 ] && ls -las ${1}/iptables-*.deb

	dqb "pp3 d0n3"
	csleep 6
}

function pr4() {
dqb "pr4( ${1})"
csleep 3

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

${NKVD} ${1}/libpam*
${NKVD} ${1}/libperl*
${NKVD} ${1}/libdbus*
${NKVD} ${1}/dbus*
${NKVD} ${1}/perl*
csleep 1
}

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 2

	${smr} ${pkgdir}/libx11-xcb1*
	${smr} ${pkgdir}/nfs*
	${smr} ${pkgdir}/rpc*
	${smr} ${pkgdir}/python3.11*
	${smr} ${pkgdir}/xserver-xorg-core*
	${smr} ${pkgdir}/xserver-xorg-legacy*
	${smr} ${pkgdir}/libgtk-3-bin*
	${smr} ${pkgdir}/libpython3.11*
	${smr} ${pkgdir}/librsvg2*
	
	#TODO:kts part2 (?)
	${smr} ${pkgdir}/avahi*
	${smr} ${pkgdir}/blu*
	${smr} ${pkgdir}/cups*
	${smr} ${pkgdir}/exim*

	case ${iface} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 6
		;;
		*)
			${smr} ${pkgdir}/wpa*
		;;
	esac

	dqb "D0NE"
	csleep 4
}

function part2_pre() {
	dqb "PP2"
	${sharpy} python3-cups
	csleep 5
}

#uusien fktioiden sisältöä saattaa mennä takaisinkin ->g_doit
function part1_post() {
	#ntp ehkä takaisin myöhemmin
	${whack} ntp*
	csleep 5
	${odio} /etc/init.d/ntpsec stop
	#K01avahi-jutut sopivaan kohtaan?
}

function part2_pre() {
	${sharpy} python3-cups
}

#TODO:seuraavaksi tämä takaisin > h_doit?
function part3_post() {
	#seur. 2 riviä turhia koska chagedns
	${ip6tr} /etc/iptables/rules.v6
	${iptr} /etc/iptables/rules.v4
	
	${asy}
	dqb "GR1DN BELIALAS KYE"

	${scm} 0555 ~/Desktop/minimize/changedns.sh
	${sco} root:root ~/Desktop/minimize/changedns.sh
	${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}
	${sipt} -L
	csleep 6
}

check_binaries ${distro}
check_binaries2

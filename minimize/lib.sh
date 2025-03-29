#=================================================PART 0=====================================

function pre_part3() {
	[ y"${1}" == "y" ] && exit
	dqb "pp3( ${1} )"
	[ -d ${1} ] || exit
	dqb "pp3.2"

	psqa ${1}

	#HUOM.290325:vähemmän nalkutusta rm_:n kanssa, kai
	${odio} dpkg -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${smr}${1}/netfilter-persistent*.deb  #${NKVD} 
	csleep 2

	${odio} dpkg -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${smr} ${1}/libip*.deb #${NKVD}
	csleep 2

	${odio} dpkg -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${smr} ${1}/iptables_*.deb
	csleep 2

	${odio} dpkg -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${smr} ${1}/iptables-*.deb

	[ ${debug} -eq 1 ] && ls -las ${1}/iptables-*.deb

	dqb "pp3 d0n3"
	csleep 2
	#VAIH:josko selvittäisi poistuuko nuo asennetut tässä tai pr4():sessa
}

pr4() {
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

	#280325 uutena 
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

check_binaries ${distro}
check_binaries2
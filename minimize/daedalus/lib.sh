#=================================================PART 0=====================================

function pre_part3() {
	[ y"${1}" == "y" ] && exit
	echo "pp3( ${1} )"
	[ -d ${1} ] || exit
	echo "pp3.2"

	#josko vielä testaisi löytyykö asennettavia ennenq dpkg	(esim find)
	#HUOM.20325:sittenkin varmempi ettei käytä sdi:tä tässä koska check_binaries() kutsuu pp3 ja pr4

	#sha512sums ole massaolo kuuluISI kai tarkistaa ensin jos on niinqu pedantti
	#HUOM.2490325:jotain urputusta oli -c:stä , pitäisi kai asettaa sah6 jos tyHJä	
	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		p=$(pwd)
		cd ${1}
		${sah6} -c sha512sums.txt --ignore-missing
		echo $?
		csleep 6
		cd ${p}
	else
		dqb "NO SHA512SUMS"
		csleep 1
	fi

	${odio} dpkg -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/netfilter-persistent*.deb
	csleep 3

	${odio} dpkg -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/libip*.deb
	csleep 3

	${odio} dpkg -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/iptables_*.deb
	csleep 3

	${odio} dpkg -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/iptables-*.deb

	dqb "pp3 d0n3"
	csleep 3
}

#HUOM.190325: git näyttäisi asentuvan
#(olikohan näiden pp3 ja pre4 kanssa jotain säätämistä vielä?)

pr4() {
	dqb "pr4( ${1})"
	csleep 5

	${odio} dpkg -i ${1}/libpam-modules-bin_*.deb
	${odio} dpkg -i ${1}/libpam-modules_*.deb
	${NKVD} ${1}/libpam-modules*
	csleep 5
	${odio} dpkg -i ${1}/libpam*.deb

	${odio} dpkg -i ${1}/perl-modules-*.deb
	${odio} dpkg -i ${1}/libperl*.deb 
	${NKVD} ${1}/perl-modules-*.deb 
	${NKVD} ${1}/libperl*.deb
	csleep 5

	${odio} dpkg -i ${1}/perl*.deb
	${odio} dpkg -i ${1}/libdbus*.deb
	${odio} dpkg -i ${1}/dbus*.deb

	${NKVD} ${1}/libpam*
	${NKVD} ${1}/libperl*
	${NKVD} ${1}/libdbus*
	${NKVD} ${1}/dbus*
	${NKVD} ${1}/perl*
}

check_binaries ${distro}
check_binaries2



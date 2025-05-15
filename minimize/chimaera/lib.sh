function pr4() {
	dqb "pre4 ${1} ${2}"
	csleep 2
	psqa ${1}
	#TODO:dnsm-jutuille jos tekisijojo tain , esim. stubby+dnsmasq toimimaan ni ei tartte noita poistella

	#if [ ${dnsm} -eq 1 ] ; then #VAIH:dnsm paraetriksi
	if [ ${2} -eq 1 ] ; then
		${NKVD} ${1}/stubby*
		${NKVD} ${1}/libgetdns*
		${NKVD} ${1}/dnsmasq*
	fi

	csleep 1
}

function pre_part3() {
	dqb "PER3 ${1} ${2}"
	csleep 1

	if [ ${2} -eq 1 ] ; then #VAIH:dnsm parametriksi
		${sdi} ${1}/dns-root-data*.deb
		${NKVD} ${1}/dns-root-data*.deb
	fi

	csleep 1

	${sdi} ${1}/perl-modules-*.deb
	${NKVD} ${1}/perl-modules-*.deb

	dqb "PER3.D0EN"
	csleep 1
}

#TODO:testaa tämän toiminta
function udp6() {
	dqb "UDPD6"
	csleep 4

	${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11
	${shary} iptables
	${shary} iptables-persistent init-system-helpers netfilter-persistent

	pre2 ${2}
	csleep 6
}

function part2_pre() {
	dqb "PART2PRE"
	csleep 2

	if [ ${1} -eq 1 ] ; then
		${sharpy} libopts25
		${sharpy} rpc* nfs*
	fi

	csleep 3
}

check_binaries ${distro}
check_binaries2
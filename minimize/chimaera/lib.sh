#=========================PART 0 ENDS HERE=================================================================
function pr4() {
	dqb "pr4 (${1})"
	psqa  ${1}

	#TODO:dnsm-jutuille jos tekisijojo tain , esim. stubby+dnsmasq toimimaan ni ei tartte noita poistella
	if [ ${dnsm} -eq 1 ] ; then
		${NKVD} ${1}/stubby*
		${NKVD} ${1}/libgetdns*
		${NKVD} ${1}/dnsmasq*
	fi

	dqb "d0n3"
}

function pre_part3() {
	dqb "pre_part3( ${1})"

	if [ ${dnsm} -eq 1 ] ; then
		${sdi} ${1}/dns-root-data*.deb
		${NKVD} ${1}/dns-root-data*.deb
	fi

	${sdi} ${1}/perl-modules-*.deb
	${NKVD} ${1}/perl-modules-*.deb

}

function udp6() {
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=netfilter-persistent=1.0.20
	${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11 
	${shary} iptables 	
	${shary} iptables-persistent init-system-helpers netfilter-persistent
	pre2 ${2} #vissiin tarvitsi tämän

	#avahi-exim roskikseen tässä?
}

dqb "BIL-UR-SAG"
check_binaries ${distro}
check_binaries2 
dqb "UMULAMAHRI"

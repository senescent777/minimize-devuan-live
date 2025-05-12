#=========================PART 0 ENDS HERE=================================================================
function pr4() {
	dqb "pr4 (${1})"
	psqa ${1}

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

function part1_post() {
	dqb "UNDER CONSTRUCTION"
}

function part2_pre() {
	if [ ${1} -eq 1 ] ; then
		${sharpy} libopts25
		${sharpy} rpc* nfs* 
	fi
}

#TODO:tämä fktio pois jatkossa(?)
function part3_post() {
	${asy}
	csleep 3

	#HUOM.270325:kokeillaan import2dessa enforce_access():ia josko sitten menisi oikeudet kunnolla

	${scm} 0555 ~/Desktop/minimize/changedns.sh
	${sco} root:root ~/Desktop/minimize/changedns.sh

	${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}
	csleep 5
}

dqb "BIL-UR-SAG"
check_binaries ${distro}
check_binaries2 
dqb "UMULAMAHRI"

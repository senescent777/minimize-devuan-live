#=========================PART 0 ENDS HERE=================================================================
function pr4() {
	dqb "pr4 (${1})"
	psqa  ${1}

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

dqb "BIL-UR-SAG"
check_binaries ${distro}
check_binaries2 
dqb "UMULAMAHRI"

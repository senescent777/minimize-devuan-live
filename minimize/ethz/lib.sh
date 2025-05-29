#
#
#function efk() {
#	${sdi} ${1} #$@ pikemminkin
#	[ $? -eq 0 ] && ${smr} ${1}
#}

function pre_part3() {
	dqb "ethz.pp3( ${1} , ${2} )"
	csleep 1
	dqb "ethz.pp3.d0n3()"
	csleep 1
}

function pr4() {
	dqb "ethz.pr4( ${1} , ${2} )"
	csleep 1
	#TODO
}

function udp6() {
	dqb "ethz.lib.UPDP-6"
	csleep 1
	#TODO
}

function t2p() {
	debug=1

	dqb "ethz.T2P (VAIH)"
	dqb "ethz.T2P.DONE"
	csleep 1
}

function pre_part2() {
	dqb "3Thz.pre_part2()"
	csleep 1

	#${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana
}

check_binaries ${PREFIX}/${distro}
check_binaries2
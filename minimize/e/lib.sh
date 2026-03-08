#VAIH:ne xcalib omat paketit asentaen koska: "iptables: Failed to initialize nft: Protocol not supported"
#https://superuser.com/questions/1480986/iptables-1-8-2-failed-to-initialize-nft-protocol-not-supported
#https://hatchjs.com/iptables-1-8-7-failed-to-initialize-nft-protocol-not-supported/
#HUOM.16126:ennen g_pt2 ajamista tehtävä pakettien haku

#jotain tämmöistä tähänn fktioon olisi tarkoitus tulla jatkossa
#HUOM. tablesiin liittyviä säätöjä olisi parent-hmiston skripteissä (export2?)
function tpc7() {
	dqb "UNDER CONSTRUCTION"

	${shary} nftables #excalibur-spesifisiä?
	${shary} isc-dhcp-client isc-dhcp-common
}

#function t2p() {
#	dqb "XC.T2P"
#	
#
#
##	#mitä tekee luit? entä libngtcp2? ocl-icd-jotain ?
#
#	#${sharpy} libgssapi*
#	t2p_filler
#
#
#	dqb "XC.T2P.DONE"
#	csleep 1
#}
#
function pre_part2() {
	dqb "XC.pre_part2()"
	csleep 1
}

function tpc7() {
	dqb "6.12....27 ?"
	csleep 2

	local fname
	fname=linux-image-6.12.27-amd64
	fasdfasd ${CONF_pkgdir}/${fname}	
	
	curl -o ${CONF_pkgdir}/${fname} https://packages.debian.org/trixie/${fname}
	#${shary} nftables #excalibur-spesifisiä?	
}

check_binaries ${d}
#lftr-jutut josqs?
check_binaries2
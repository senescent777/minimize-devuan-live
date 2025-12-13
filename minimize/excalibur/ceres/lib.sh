#VAIH:ne xcalib omat paketit asentaen koska: "iptables: Failed to initialize nft: Protocol not supported"
#https://superuser.com/questions/1480986/iptables-1-8-2-failed-to-initialize-nft-protocol-not-supported
#https://hatchjs.com/iptables-1-8-7-failed-to-initialize-nft-protocol-not-supported/

function udp6() {
	dqb "xc.lib.UPDP-6"
	csleep 1

	#cp5 
	clib5p ${1}

	dqb "...done"
	csleep 1
}

#jotain tämmöistä tähänn fktioon olisi tarkoitus tulla jatkossa
#HUOM. tablesiin liittyviä säätöjä olisi parent-hmiston skripteissä (export2?)
function tpc7() {
	dqb "UNDER CONSTRUCTION"

	${shary} nftables #excalibur-spesifisiä?
	${shary} isc-dhcp-client isc-dhcp-common
}

function t2p() {
	dqb "XC.T2P"
	
	${sharpy} bsdextrautils*  # util-linux
	${sharpy} rfkill uuid-runtime
	t2p_filler	

	${sharpy} arch-test debootstrap #eipä poistunut aiemmin
	t2p_filler

	#HUOM.28525:a) grubiin liitt. nalkutukset b) ainakin osa noista pitäisi poistua jo aiemmin
	${sharpy} fuse3 gir* gsettings* gstreamer* # grub*
	t2p_filler #ei poista libgtk3?

#	#mitä tekee luit? entä libngtcp2? ocl-icd-jotain ?

	${sharpy} libgstreamer* lm-sensors ocl-icd*
	#${sharpy} libgssapi*
	t2p_filler

	${sharpy} mc* os-prober rsync # mythes* poistuu muualla
	t2p_filler

	${sharpy} squashfs-tools upower w3m wget #upower meni jo tilaan rc
	t2p_filler

	dqb "XC.T2P.DONE"
	csleep 1
}

function pre_part2() {
	dqb "XC.pre_part2()"
	csleep 1
}

function tpc7() {
	dqb "6.12....27 ?"
	csleep 2

	local fname
	fname=linux-image-6.12.27-amd64

	#${odio} touch ${CONF_pkgdir}/${fname}
	#${scm} 0644 ${CONF_pkgdir}/${fname}
	#${sco} $(whoami):$(whoami) ${CONF_pkgdir}/${fname}
	fasdfasd ${CONF_pkgdir}/${fname}	
	
	curl -o ${CONF_pkgdir}/${fname} https://packages.debian.org/trixie/${fname}
	#${shary} nftables #excalibur-spesifisiä?	
}

check_binaries ${d} 
check_binaries2
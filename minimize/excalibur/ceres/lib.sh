#VAIH:ne xcalib omat paketit asentaen koska: "iptables: Failed to initialize nft: Protocol not supported"
#https://superuser.com/questions/1480986/iptables-1-8-2-failed-to-initialize-nft-protocol-not-supported
#https://hatchjs.com/iptables-1-8-7-failed-to-initialize-nft-protocol-not-supported/

function cp5() {
	dqb "7391"

	#31525:näistä tuli nalqtus
	#${NKVD} ${1}/libmount*
	#${NKVD} ${1}/libfdisk*
	#${NKVD} ${1}/libblkid*
	#${NKVD} ${1}/libsmartcols*
	#${NKVD} ${1}/liblastlog* #poistuuko?
	#${NKVD} ${1}/libuuid*
	#${NKVD} ${1}/eject*
	#${NKVD} ${1}/mount*
	#${NKVD} ${1}/util-linux* #poistuuko?
	#${NKVD} ${1}/base-files*
	#${NKVD} ${1}/fdisk*
	#${NKVD} ${1}/bsdextrautils*
	#${NKVD} ${1}/uuid*
	#${NKVD} ${1}/rfkill*

	csleep 1
}

#TODO:efk
function pr4() {
	debug=1
	dqb "xc.pr4( ${1} , ${2} )"
	csleep 1

	cp5 ${1}
	csleep 1
	dqb "XC.PR4.PART2"

	${sdi} ${1}/isc-dhcp-*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/isc-dhcp-*.deb

	dqb "...done"
	csleep 1
}

function udp6() {
	dqb "xc.lib.UPDP-6"
	csleep 1

	cp5 ${1}

	dqb "...done"
	csleep 1
}

#jotain tämmöistä tähänn fktioon olisi tarkoitus tulla jatkossa
function tpc7() {
	dqb "UNDER CONSTRUCTION"
	#${shary} linux-modules-6.12.27-amd64 #31525 uutena

	#nopeasti lähimpiä vastineita:
	#https://packages.debian.org/trixie/linux-image-6.12.27-amd64 miten tämä?
	#https://debian.ethz.ch/debian/pool/main/l/linux-signed-amd64/linux-image-cloud-amd64_6.12.27-1_amd64.deb
	#wget/curl jos ei muuten

	${shary} nftables #excalibur-spesifisiä?
	${shary} isc-dhcp-client isc-dhcp-common
}

function t2p() {
	debug=1
	dqb "XC.T2P"
	
	#31525 lisäyksiä (util-linux ei uskalla poistaa, miten nuo muut?)
	#${sharpy} libsmartcols1 libuuid1 liblastlog2-2
	${sharpy} bsdextrautils*  # util-linux
	${sharpy} rfkill uuid-runtime
	t2p_filler	

	${sharpy} arch-test debootstrap #eipä poistunut aiemmin
#	${sharpy} dmsetup dracut-install aiheuttaa ongelmia
	t2p_filler

	#HUOM.28525:a) grubiin liitt. nalkutukset b) ainakin osa noista pitäisi poistua jo aiemmin
	${sharpy} fuse3 gir* gsettings* gstreamer* # grub*
	t2p_filler #ei poista libgtk3?

#	#mitä tekee luit? entä libngtcp2? ocl-icd-jotain ?
#HUOM.28525.3:tässä poistunee libgtk3, miten estää? libgssapi pois listasta?

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
	dqb "6.12....27"
	csleep 2
	
	#${shary} linux-modules-6.12.27-amd64 #31525 uutena

	#nopeasti lähimpiä vastineita:
	#https://packages.debian.org/trixie/linux-image-6.12.27-amd64 miten tämä?
	#https://debian.ethz.ch/debian/pool/main/l/linux-signed-amd64/linux-image-cloud-amd64_6.12.27-1_amd64.deb
	#wget/curl jos ei muuten

	local fname
	fname=linux-image-6.12.27-amd64

	${odio} touch ${pkgdir}/${fname} #seur rivit toistuvat usein, fktioksi?
	${scm} 0644 ${pkgdir}/${fname}
	${sco} $(whoami):$(whoami) ${pkgdir}/${fname}
		
	curl -o ${pkgdir}/${fname} https://packages.debian.org/trixie/${fname}
	#${shary} nftables #excalibur-spesifisiä?	
}

check_binaries ${PREFIX}/${distro} #TODO:prefixin kanssa ehkä jotain
check_binaries2
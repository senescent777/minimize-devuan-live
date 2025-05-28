#koitetaanpa jyrätä tämä aiempi määrittely (ntp kusi)
#TODO:ntp:n siirtäminen distro-spesifisiin fktioihin?
PART175_LIST="avahi blue cups exim4 nfs network mdadm"

#TODO:ne xcalib omat paketit asentaen koska: "iptables: Failed to initialize nft: Protocol not supported"
function pre_part3() {
	dqb "xc.pp3( ${1} , ${2} )"
	csleep 1

	#VAIH
	sudo dpkg -i ~/Desktop/minimize/daedalus/libip*.deb
	sudo rm ~/Desktop/minimize/daedalus/libip*.deb
	csleep 1

	#TODO:se efk()
	sudo dpkg -i ~/Desktop/minimize/daedalus/libxtables12_1.8.9-2_amd64.deb 
	sudo rm ~/Desktop/minimize/daedalus/libxtables12_1.8.9-2_amd64.deb 
	csleep 1

	sudo dpkg -i ~/Desktop/minimize/daedalus/iptables_*.deb
	sudo rm ~/Desktop/minimize/daedalus/iptables_*.deb
	csleep 1

	#näin mennään kunnes saa export2 toimimaan
	dqb "xc.pp3.d0n3()"
	csleep 1
}

function pr4() {
	dqb "xc.pr4( ${1} , ${2} )"
	csleep 1
	#TODO
}

function udp6() {
	dqb "xc.lib.UPDP-6"
	csleep 1
	#TODO
}

#joskohan näiden jälkeen on excalibur vielä hengissä?
#HUOM.28525.1:hengissä, mutta vähän liikaa leikattuna vissiin
#tämmöistäkin tuli:"ERROR: ld.so: object 'libgtk3-nocsd.so.0' from LD_PRELOAD cannot be preloaded "
#kokeeksi kommentoidaan jlkimmäinen puoli, ainakin osa, jotta selviäisi missä kosahtaa
function t2p() {
	debug=1

	dqb "XC.T2P (VAIH)"
	${sharpy} arch-test debootstrap dmsetup dracut-install
	t2p_filler

	#HUOM.28525:a) grubiin liitt. nalkutukset b) ainakin osa noista pitäisi poistua jo aiemmin
	${sharpy} fuse3 gir* gsettings* gstreamer* # grub*
	t2p_filler

#	#mitä tekee luit? entä libngtcp2? ocl-icd-jotain ?
#HUOM.28525.2:sallitaan seuraavaksi l-juttujen poisto
	${sharpy} libgstreamer* libgssapi* lm-sensors ocl-icd*
	t2p_filler

#	${sharpy} mc* mythes* os-prober rsync
#	t2p_filler
#
#	${sharpy} squashfs-tools upower w3m wget
#	t2p_filler
#
	dqb "XC.T2P.DONE"
	csleep 1
}

check_binaries ${PREFIX}/${distro}
check_binaries2
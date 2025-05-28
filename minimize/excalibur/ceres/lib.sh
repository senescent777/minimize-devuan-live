#VAIH:ne xcalib omat paketit asentaen koska: "iptables: Failed to initialize nft: Protocol not supported"
#https://superuser.com/questions/1480986/iptables-1-8-2-failed-to-initialize-nft-protocol-not-supported
#https://hatchjs.com/iptables-1-8-7-failed-to-initialize-nft-protocol-not-supported/
#elikkäs update-alternatives vaikka kokeillen ensin

function pre_part3() {
	dqb "xc.pp3( ${1} , ${2} )"
	csleep 1

	#jatkossa ne ympäristömjat ja muut leikit
	#... tai vielä tärkempi ensin: SELVITÄ ONKO IPTABLES EDES MUODISSA TÄLLÄ VIIKOLLA VAI MITÄ VITTUA?
	#koskapa "iptables: Failed to initialize nft: Protocol not supported"
	
	sudo dpkg -i ${1}/libip*.deb
	[ $? -eq 0 ] && sudo rm ${1}/libip*.deb
	csleep 1

	sudo dpkg -i ${1}/libxtables12_1.8.9-2_amd64.deb 
	[ $? -eq 0 ] && sudo rm ${1}/libxtables12_1.8.9-2_amd64.deb 
	csleep 1

	#libnftnl, siitä tuli valitusta, asentaako vai poistaako?
	sudo dpkg -i ${1}/libnftnl*.deb 
	[ $? -eq 0 ] && sudo rm ${1}/libnftnl*.deb
	csleep 1
 
	sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
	sudo update-alternatives --set iptables-restore /usr/sbin/iptables-legacy-restore	
	#vissiin tuo ei riitä, jotain muutakin yarttis tehrä

	sudo dpkg -i ${1}/iptables_*.deb 
	[ $? -eq 0 ] && sudo rm ${1}/iptables_*.deb
	csleep 1

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

function t2p() {
	debug=1

	dqb "XC.T2P (VAIH)"
	${sharpy} arch-test debootstrap #eipä poistunut aiemmin
#	${sharpy} dmsetup dracut-install aiheuttaa ongelmia
	t2p_filler

	#HUOM.28525:a) grubiin liitt. nalkutukset b) ainakin osa noista pitäisi poistua jo aiemmin
	${sharpy} fuse3 gir* gsettings* gstreamer* # grub*
	t2p_filler #ei poista lingtk3?

#	#mitä tekee luit? entä libngtcp2? ocl-icd-jotain ?
#HUOM.28525.3:tässä poistunee lingtk3, miten estää? libgssapi pois listasta?

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

check_binaries ${PREFIX}/${distro}
check_binaries2
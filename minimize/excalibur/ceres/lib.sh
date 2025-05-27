#koitetaanpa jyrätä tämä aiempi määrittely (ntp kusi)
#TODO:ntp:n siirtäminen distro-spesifisiin fktioihin?
PART175_LIST="avahi bluetooth cups exim4 nfs network mdadm"

function pre_part3() {
	dqb "xc.pp3( ${1} , ${2} )"
	csleep 1

	#VAIH
	sudo dpkg -i ~/Desktop/minimize/daedalus/libip*.deb
	sudo dpkg -i ~/Desktop/minimize/daedalus/daedalus/libxtables12_1.8.9-2_amd64.deb 
	sudo dpkg -i ~/Desktop/minimize/daedalus/daedalus/iptables_*.deb
	#kunnes saa export2 toimimaan 
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

#HUOM.27525:debug tuntui määräävän, ajetaanko esim. part2_5 , toivottavasti ei toistu
function part2_pre() {
	debug=1
	dqb "xc.PP2"
	#TODO
}

function t2p() {
	dqb "TODO"
}

check_binaries ${PREFIX}/${distro}
check_binaries2
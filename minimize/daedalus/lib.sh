#=================================================PART 0=====================================

#https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

#iface-riippuvainen pakettien poisto, kts part2_5
function c5p() {
	dqb "CCCP ${1} , ${2} "
	csleep 3
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 3

	local p
	local q
	p=$(pwd)
	cd ${1}
	
	if [ ! -f /.chroot ] ; then
		echo "REJECTING PKGS from dir:"
		pwd
		sleep 3

		for q in $(grep -v '#' reject_pkgs) ; do 
			echo "${NKVD} ${q}"
			${NKVD} ${q}
			sleep 1
		done

		echo "DONE REJECTINF"
		sleep 3
	fi

	cd ${p}
	dqb "...is over"
	csleep 3
}

function reficul() {
	dqb "NATTA5H3AD öVERDR1V 666! a.k.a pr4.libs ?"
	csleep 3

	[ -z ${1} ] && exit 65	
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 3

	c5p ${1}
	local p
	local q
	p=$(pwd)
	cd ${1}

	for q in $(grep -v '#' accept_pkgs_1) ; do efk1 ${q} ; done
	${NKVD} libpam-modules*
	#c5p ? 

	echo "SDHGSKJDHGFSODHGSU"
	sleep 3

	cd ${p}
	dqb "REC1FUL D0N3"
	csleep 5
}

function pr4() {
	dqb "daud.pr4 ${1} , ${2} "
	csleep 1

	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	psqa ${1}

	local p
	local q
	p=$(pwd)
	cd ${1}
	

	for q in $(grep -v '#' accept_pkgs_2) ; do efk1 ${q} ; done

	if [ -f /.chroot ] ; then
		dqb "under a FUNeral M00N"	
	fi

	csleep 3
	cd ${p}
}

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1
	
	c5p ${1}
	dqb "D0NE"
	csleep 1
}

function t2p() {
	dqb "DAUD.T2P"
	csleep 1

	${sharpy} bluez mutt rpcbind nfs-common
	${sharpy} dmsetup
	t2p_filler
	csleep 5

	${sharpy} arch-test
	${sharpy} grub*
	${sharpy} gsettings*
	t2p_filler

	${sharpy} iucode-tool
	t2p_filler

	${sharpy} ntp*
	${sharpy} ntfs-3g
	t2p_filler

	${sharpy} p7zip
	t2p_filler

	${sharpy} psmisc
	t2p_filler

	${sharpy} rsync squashfs-tools
	t2p_filler

	${sharpy} traceroute
	t2p_filler

	${sharpy} upower 
	t2p_filler

	${sharpy} w3m wget
	t2p_filler

	dqb "D0N3"
	csleep 1

	echo "DERTHAGO 3ST KALENDAM"
	csleep 6

	${sharpy} xorriso*
	${asy}
	csleep 2

	${sharpy} xorriso*
	${asy}
	csleep 2

	${sharpy} xorriso*
	${asy}
	csleep 2

	${sharpy} xz*
	${asy}
	csleep 2
 
	${sharpy} xfburn 
	${asy}
	sleep 2

	${sharpy} xarchiver 
	${asy}
	sleep 2

	${sharpy} libdav*
	${asy}
	sleep 2

	${scm} a-wx ${0}
	csleep 2
}

function pre_part2() {
	dqb "daud.pre_part2"
	csleep 2

	${odio} /etc/init.d/ntpd stop

	for f in $(find /etc/init.d -type f -name 'ntp*') ; do 
		${odio} ${f} stop
		csleep 1
	done

	csleep 2
	dqb "d0n3"
}

function tpc7() {
	dqb "d.prc7 UNDER CONSTRUCTION"
}

check_binaries ${d}
check_binaries2
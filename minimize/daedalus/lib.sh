#=================================================PART 0=====================================

#https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

function udp6() {
	dqb "daud.lib.UPDP-6"
	csleep 1
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1
	
	#c5p ${1}
	clib5p ${1} reject_pkgs

	dqb "D0NE"
	csleep 1
}

function t2p() {
	dqb "DAUD.T2P"
	csleep 1

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

	#uutena
	${sharpy} libdav*
	${asy} #varm. vuoksi
	sleep 2

	${scm} a-wx ${0}
	csleep 2
}

#josko kuitenkin ntp takaisin listaan?
function pre_part2() {
	dqb "daud.pre_part2()"
	csleep 2

	${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana

	for f in $(find /etc/init.d -type f -name 'ntp*') ; do 
		${odio} ${f} stop
		csleep 1
	done

	csleep 2
	dqb "d0n3"
}

#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=netfilter-persistent=1.0.20
#https://pkgs.org/download/linux-image-6.12.27-amd64 ... joskohan ethz kautta
#... tarkistus tosin uusiksi, josko sinne tcdd-blokkiin(?) ylemmäs?

function tpc7() { #e22.sh kutsuu tätä nykyään
	dqb "d.prc7 UNDER CONSTRUCTION"
}

check_binaries ${d}
check_binaries2
#=================================================PART 0=====================================

#https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

function udp6() { #on käytössä
	dqb "daud.lib.UPDP-6 ${1}"
	csleep 1

	#jokin syy miksi ei -z ?
	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	dqb "${1} :"
	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb | wc -l
	csleep 3

	dqb "${pkgdir} :"
	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}/*.deb | wc -l
	csleep 3

	common_lib_tool ${1} reject_pkgs
	dqb "D0NE"
	csleep 1
}

#common_lib_tool-tyylillä jatkossa tämänkin fktion hommat? kts g_pt2
#251225:poistetaanko täsäs kohtaa liikaa?
#130126:sqrot-tstissä psmisc ei poistunut
function t2p() { #on käytössä
	dqb "DAUD.T2P"
	csleep 1

	${sharpy} arch-test
	${sharpy} grub*
	${sharpy} gsettings* #tähän asti ok?
	t2p_filler

	${sharpy} iucode-tool
	t2p_filler

	${sharpy} ntp* #121125:tässä base-passwd- ja init-valitusta. vielä 231125?
	${sharpy} ntfs-3g
	t2p_filler

	${sharpy} p7zip
	t2p_filler

	${sharpy} psmisc #tästä tuli initramfs-valitus
	t2p_filler

	${sharpy} rsync squashfs-tools #eiole?
	t2p_filler

	${sharpy} traceroute #eiole?
	t2p_filler

	${sharpy} upower #tästä tuli initramfs-valitus
	t2p_filler

	${sharpy} w3m wget #eiole?
	t2p_filler

	dqb "D0N3"
	csleep 1

	echo "DERTHAGO 3ST KALENDAM"
	csleep 6

	${sharpy} xorriso* #eiole?
	${asy} #initramfs...
	csleep 2

	${sharpy} xorriso*
	${asy}
	csleep 2

	${sharpy} xz* #initramfs
	${asy}
	csleep 2
 
	${sharpy} xfburn  #eiole
	${asy}
	sleep 2

	${sharpy} xarchiver #¤eiole+initranmfs
	${asy}
	sleep 2

	#${sharpy} libdav* #121125:tämä näyttää poistavan paljon tapauksessa daed, ehkä jopa liikaa
	#ÄLÄ SIIS WTUN PÖSILÖ POISTA libdav-PAKETTEJA ELLEI KIINNOSTA SELVITELLÄ "ERROR: ld.so: object 'libgtk3-nocsd.so.0' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored."-NALKUTUSTA
	#${asy} #varm. vuoksi
	#sleep 2

	${scm} a-wx ${0}
	csleep 2
}

#josko kuitenkin ntp takaisin part2_5_listaan?
function pre_part2() { #käytössä
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
lftr="echo # \${smr} -rf  / run / live / medium / live / initrd.img\* " 	
check_binaries2

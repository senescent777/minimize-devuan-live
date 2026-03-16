#=================================================PART 0=====================================

#https://askubuntu.com/questions/952113/how-to-bypass-dpkg-prompt
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#130126:sqrot-tstissä psmisc ei poistunut (miten nkyään?)

#020326:annetaanpa toistaiseksi olla PART175_LIST kuten on ja p_p2 myös
function pre_part2() { #käytössä
	dqb "daud.pre_part2()"
	csleep 2

	${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana

	for f in $(find /etc/init.d -type f -name 'ntp*' ) ; do 
		${odio} ${f} stop
		csleep 1
	done

	csleep 2
	dqb "d0n3"
}

function tpc7() {
	dqb "d.prc7 UNDER CONSTRUCTION"
}

lftr="echo # \${smr} -rf  / run / live / medium / live / initrd.img\* " 	

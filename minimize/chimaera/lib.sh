#=================================================PART 0=====================================
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values
#
#VAIH:siirto siihen tdstoon mikä tarvitsee?
#function cg_pp2() {
#	dqb " GENERIC REPLACEMENT FOR daud.lib.pre_part2 ${1}"
#	csleep 1
#
#	${odio} /etc/init.d/ntpd stop
#	#$sharpy ntp* jo aiempana
#
#	for f in $(find /etc/init.d -type f -name "ntp*" ) ; do 
#		${odio} ${f} stop
#		csleep 1
#	done
#
#	csleep 2
#	dqb "d0n3"
#}
function pre_part2() { #175-listan päivitys fktion ulkpuolella? ehkä ei?
		cg_pp2
#	dqb "ch1m.pre_part2()"
#	csleep 1
#
	#${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana
}

function tpc7() {
	dqb "c.tpc7 UNDER CONSTRUCTION"
}
	
lftr="${smr} -rf /run/live/medium/live/initrd.img* " 


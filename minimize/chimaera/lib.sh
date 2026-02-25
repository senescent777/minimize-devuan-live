#=================================================PART 0=====================================
#https://askubuntu.com/questions/254129/how-to-display-all-apt-get-dpkgoptions-and-their-current-values

#250226:tämän fktion voisi vähitellen hukata? cg_udp6() tilalle jo?
#function udp6() {
#	dqb "ch1m.lib.UPDP-6"
#	csleep 1
#
#	dqb "do_Something() ?"
#
#	dqb "D0NE"
#	csleep 1
#}
#
#function t2p() { 
#	csleep 1
#
#	dqb "chim.t2p()"
#	csleep 1
#
#
#	
#
#	
#	
#
#
#
#
#	
#
#
#
#	dqb "D0N3"
#	csleep 1
#} 

function pre_part2() {
	dqb "ch1m.pre_part2()"
	csleep 1

	${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana
}

function tpc7() {
	dqb "c.tpc7 UNDER CONSTRUCTION"
}

	
check_binaries ${d} # toimiiko? $(pwd) nimittäin? ei toivotulla tavalla
lftr="${smr} -rf /run/live/medium/live/initrd.img* " 
check_binaries2

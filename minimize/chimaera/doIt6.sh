##!/bin/bash
#d=$(dirname $0)
#mode=2
#
#[ -s ${d}/conf ] && . ${d}/conf
#. ~/Desktop/minimize/common_lib.sh
#
#if [ -s ${d}/lib.sh ] ; then
#	. ${d}/lib.sh
#else
#	echo "TO CONTINUE FURTHER IS POINTLESS, ESSENTIAL FILES MISSING"
#	exit 111
#fi
#
##HUOM.220325:parsetuS kunnossa
#function parse_opts_1() {
#	case "${1}" in
#		-v|--v)
#			debug=1
#		;;
#		*)
#			mode=${1}
#		;;
#	esac
#}
#
#function check_params() {
#	case ${debug} in
#		0|1)
#			dqb "ko"
#		;;
#		*)
#			echo "MEE HIMAAS LEIKKIMÄÄN"
#			exit 4
#		;;
#	esac
#}
#
##==================================PART 1============================================================
#
#if [ $# -gt 0 ] ; then
#	for opt in $@ ; do parse_opts_1 $opt ; done
#fi
#
#check_params 
#[ ${enforce} -eq 1 ] && pre_enforce ${n} ${distro}
#enforce_access ${n} 
#part1 ${distro} 
#[ ${mode} -eq 0 ] && exit
#part175
#
##===================================================PART 2===================================
#c=$(find ${d} -name '*.deb' | wc -l)
#[ ${c} -gt 0 ] || removepkgs=0
#
#if [ ${removepkgs} -eq 1 ] ; then
#	${sharpy} libopts25
#	${sharpy} rpc* nfs* 
#fi
#
#part2 ${removepkgs}
#
##===================================================PART 3===========================================================
#message
#pre_part3 ${d} 
#pr4 ${d}
#part3 ${d} 
##VAIH:lib.part3_post() , ecfx und vommon + el_loco
#ecfx
#
#csleep 5
#
#if [ -x ~/Desktop/minimize/profs.sh ] ; then
#	. ~/Desktop/minimize/profs.sh
#	q=$(mktemp -d)
#	${srat} -C ${q} -xvf ~/Desktop/minimize/someparam.tar
#	imp_prof esr ${n} ${q}
#fi
#
#if [ ${mode} -eq 1 ] ; then
#	el_loco
#	vommon
#fi
#
##asy-cdns voisi olla yhteistä, jotenkin
#${asy}
#csleep 3
#
##HUOM.270325:kokeillaan import2dessa enforce_access():ia josko sitten menisi oikeudet kunnolla
#
#${scm} 0555 ~/Desktop/minimize/changedns.sh
#${sco} root:root ~/Desktop/minimize/changedns.sh
#
#${odio} ~/Desktop/minimize/changedns.sh ${dnsm} ${distro}
#csleep 5
#

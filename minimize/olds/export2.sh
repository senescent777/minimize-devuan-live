#!/bin/bash
debug=0
distro=$(cat /etc/devuan_version | cut -d '/' -f 1)
d0=$(pwd)
mode=-2
tgtfile=""

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \$ {d0} /\${distro}" 
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 c is sq-Chroot-env-related option"
	echo "$0 g adds Gpg for signature checks, maybe?"
	echo "$0 t ... option for ipTables"	
	echo "$0 -h: shows this message about usage"	
}

if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

function parse_opts_1() {
	dqb "exp2.patse_otps8( ${1}, ${2})"

	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			if [ -d ${d}/${1} ] ; then
				distro=${1}
				d=${d0}/${distro}
			fi
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

d=${d0}/${distro}

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
	 	exit 57
	fi	
fi

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
	dqb "FALLBACK"
	dqb "chmod +x ${d0}/common_lib.sh may be a good idea now"
	exit 56
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 2

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else 
	exit 57
fi

dqb "tar = ${srat} "

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
done

dqb "AFTER GANGRENE SETS IN"
csleep 1

if [ -z "${tig}" ] ; then
	echo "sudo apt-get update;sudo apt-get install git"
	exit 7
fi

if [ -z "${mkt}" ] ; then
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

dqb "${sco} -Rv _apt:root ${pkgdir}/partial"
csleep 1
${sco} -Rv _apt:root ${pkgdir}/partial/
${scm} -Rv 700 ${pkgdir}/partial/
csleep 1

dqb "e22_pre0"
csleep 1

if [ -x $(dirname $0)/e22.sh ] ; then
	dqb "222"
	.  $(dirname $0)/e22.sh
	csleep 2
else
	exit 58
fi

dqb "mode= ${mode}"
dqb "tar= ${srat}"
csleep 1
[ -z "${tgtfile}" ] && exit 99
[ -z "${srat}" ] && exit 66
t=$(echo ${d} | cut -d '/' -f 1-5)

case ${mode} in
	f) 
		enforce_access ${n} ${t}
		e22_arch ${tgtfile} ${d}
		e22_ftr ${tgtfile}
		exit
	;;
	q)
		${sifd} ${iface}
		e22_settings ~ ${d0}

		for f in $(find ~ -maxdepth 1 -name '*.tar' -or -name '*.bz2' -or -name 'profs.sh') ; do
			${srat} -rvf ${tgtfile} ${f}
		done

		e22_ftr ${tgtfile}
		dqb "CASE Q D0N3"
		csleep 3
		exit
	;;
	c)
		cd ${d0}
		for f in $(find . -type f -name '*.sh' | grep -v 'e/') ; do ${srat} -rvf ${tgtfile} ${f} ; done
		for f in $(find . -type f -name '*_pkgs*' | grep -v 'e/')  ; do ${srat} -rvf ${tgtfile} ${f} ; done
				
		bzip2 ${tgtfile}
		mv ${tgtfile}.bz2 ${tgtfile}.bz3
		tgtfile="${tgtfile}".bz3

		e22_ftr ${tgtfile}
		exit
	;;
	g)
		dqb "sudo apt-get update"

		echo "${shary} ${E22GI}"
		echo "${svm} ${pkgdir}/*.deb ${d}"
		echo "$0 f ${tgtfile} ${distro}"
		exit 1
	;;
	-h)
		usage
	;;
esac

e22_pre1 ${d} ${distro}
[ ${debug} -eq 1 ] && pwd;sleep 6
[ -x /opt/bin/changedns.sh ] || echo "SHOULD exit 59"
e22_hdr ${tgtfile}
e22_pre2 ${d} ${distro} ${iface} ${dnsm}

case ${mode} in
	0|4) 
		[ ${debug} -eq 1 ] && ${srat} -tf ${tgtfile} 
		csleep 3

		e22_ext ${tgtfile} ${distro} ${dnsm}
		dqb "e22_ext DON3, next:rm some rchives"
		csleep 3

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar
		dqb "srat= ${srat}"
		csleep 5

		e22_hdr ${d}/f.tar
		e22_cleanpkgs ${d}

		if [ ${mode} -eq 0 ] ; then
			e22_tblz ${d} ${iface} ${distro} ${dnsm}
			e22_other_pkgs ${dnsm}
	
			if [ -d ${d} ] ; then
				e22_dblock ${d}/f.tar ${d}
			fi

			e22_cleanpkgs ${d}
			[ ${debug} -eq 1 ] && ls -las ${d}
			csleep 5
		fi

		${sifd} ${iface}
		[ ${debug} -eq 1 ] && ls -las ${d}
		csleep 5
 	
		e22_home ${tgtfile} ${d} ${enforce} 
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}
		csleep 4
		${NKVD} ${d}/*.tar
		e22_pre1 ${d} ${distro}
		dqb "B3F0R3 RP2	"
		csleep 5	
		e22_elocal ${tgtfile} ${iface} ${dnsm} ${enforce}
	;;
	1|u|upgrade)
		e22_upgp ${tgtfile} ${d} ${iface}

		e22_ts ${d}
		${srat} -cf ${1} ${d}/tim3stamp
		t=$(echo ${d} | cut -d '/' -f 1-5)
	
		enforce_access ${n} ${t}
		e22_arch ${tgtfile} ${d}
	;;
	p) 
		e22_settings2 ${tgtfile} ${d0} 
	;;
	e)
		e22_cleanpkgs ${d}
		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_other_pkgs ${dnsm}

		if [ -d ${d} ] ; then
			e22_dblock ${tgtfile} ${d}
		fi
	;;
	t) 
		e22_cleanpkgs ${d}
		e22_cleanpkgs ${pkgdir}
			
		message
		csleep 6

		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_ts ${d}

		t=$(echo ${d} | cut -d '/' -f 1-5)
		enforce_access ${n} ${t}
		e22_arch ${tgtfile} ${d}
	;;
	*) 
		echo "-h"
		exit
	;;
esac

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi
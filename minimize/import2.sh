#!/bin/bash
debug=0 #1
srcfile=""

distro=$(cat /etc/devuan_version)
dir=/mnt
part0=ABCD-1234
mode=-2
d0=$(pwd)
[ z"${distro}" == "z" ] && exit 6
d=${d0}/${distro}

#HUOM.30925:jospa ei pilkkoisi tätä tdstoa ainakaan ihan vielä

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "${0} <mode> <srcfile> [distro] [debug] "
}

if [ $# -gt 0 ] ; then
	mode=${1}
	srcfile=${2}
fi

#HUOM.041025:debug-riippuvaisen käytöksen syy löytynee tästä fktiosta, ehkä
function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			if [ -d ${d0}/${1} ] ; then
				distro=${1}
				d=${d0}/${distro}
			fi
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

if [ -f /.chroot ] ; then #HUOM.171025:tämä blokki kunnossa?
	echo "UNDER THE GRAV3YARD"
	sleep 2

	#HUOM.141025:oikeastaan pitäisi tarkistaa ennen purkua
	for f in $(find ${d0} -type f -name 'nekros?'.tar.bz3) ; do
		tar -jxvf ${f}
		sleep 1
		rm ${f}
		sleep 1
	done
fi

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	sleep 5
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
	#HUOM.151025:tässä haarassa jokin qsee? koita selvittää mikä (TODO)
	srat="/bin/tar" #which mukaan?
	debug=1

	som="sudo /bin/mount"
	uom="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	odio=$(which sudo) #chroot-ynmp tulee nalqtusta tästä

	#jos näillä lähtisi aiNAKin case q toimimaan
	n=$(whoami)
	smr=$(${odio} which rm)
	NKVD=$(${odio} which shred)
	NKVD="${NKVD} -fu "

	whack=$(${odio} which pkill)
	whack="${odio} ${whack} --signal 9 " #P.V.H.H
	sah6=$(${odio} which sha512sum)
	mkt=$(which mktemp) #arpoo arpoo

	function check_binaries() {
		dqb "imp2.ch3ck_b1nar135 \${1} "
	}

	function check_binaries2() {
		dqb "imp2.ch3ck_b1nar135_2 \${1} "
	}

	function fix_sudo() {
		dqb "imp32.fix.sudo"
	}

	function enforce_access() {
		dqb "imp32.enf_acc"
	}

	#HUOM.26525:tämä versio part3:sesta sikäli turha että common_lib urputtaa koska sha512sums muttei deb?
	function part3() {
		dqb "imp2.part3 :NOT SUPPORTED"
		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount:in tapahtumaan silloin kun varsinainen instailu ei onnaa
	}

	function ppp3() {
		dqb "imp32.ppp3"
	}

	#kutsutaanko tätä? no yhdestä kohdasta ainakin 
	#tarvitaanko?
	function other_horrors() {
		dqb "AZATHOTH AND OTHER HORRORS"
	}

	function ocs() {
		${odio} which ${1}
		csleep 1
	}

	dqb "FALLBACK"
	dqb "${scm} may be a good idea now"
	prevopt=""

	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
fi

[ -z ${distro} ] && exit 6
[ -v mkt ] || exit 7
[ -z "${mkt}" ] && exit 9
echo "mkt= ${mkt} "
sleep 6

#deMorgan
if [ -f /.chroot ] || [ -x ${mkt} ] ; then
	dqb "MTK"
else
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

echo "in case of trouble, \"chmod a-x common_lib.sh\" or \"chmod a-x \${distro}/lib.sh\" may help"

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo $?
	dqb "NO LIB"
	csleep 1

	function pr4() {
		dqb "imp2.pr4 \${1}" 
	}

	check_binaries ${d}
	echo $?
	[ $? -eq 0 ] || exit 7
	csleep 1

	check_binaries2
	[ $? -eq 0 ] || exit 8
	csleep 1
fi

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}
ocs tar
srat=$(${odio} which tar) #JOKO NYT PRKL
[ -z "{srat}" ] && exit 666
dqb "LHP"

#deMOrgan
if [ -f /.chroot ] || [ -s /OLD.tar ] ; then
	dqb "OLD.TAR OK"
else
	#jotain exclude-juttuja voisi olla sikäli mikäli tuota oikeasti tarttee johonkin
	${srat} -cf /OLD.tar /etc /sbin /home/stubby ~/Desktop
fi

function common_part() {
	dqb "common_part ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 2 #HUOM.151025:osa tarkistuksista voi olla redundantteja
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}"  ] && exit 11
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 33

	dqb "paramz_0k"
	csleep 3
	cd /

	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"

		cat ${1}.sha
		${sah6} -c ${1}
		csleep 3

		if [ -x ${gg} ] ; then
			dqb " ${gg} --verify ${1}.sha.sig "
			${gg} --verify ${1}.sha.sig
		fi
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	csleep 1
	dqb "NECKST:${srat} ${TARGET_TPX} -C ${3} -xf ${1}" #TODO:pitäisi selvittää toimiiko --exclude kuten pitää
	csleep 1

	${srat} -C ${3} ${TARGET_TPX} -xf ${1}
	[ $? -eq 0 ] || exit 36

	csleep 1
	dqb "tar DONE"
	local t
	t=$(echo ${2} | cut -d '/' -f 1-5)

	if [ -x ${t}/common_lib.sh ] ; then
		enforce_access ${n} ${t} 
		dqb "running changedns.sh maY be necessary now to fix some things"
	else
		dqb "n s t as ${t}/common_lib.sh "	
	fi

	csleep 3
	
	if [ -d ${t} ] ; then
		dqb "HAIL UKK"
	
		${scm} 0755 ${t}
		${scm} a+x ${t}/*.sh
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb

		csleep 1
	fi

	[ ${debug} -eq 1 ] && ls -las ${2}
	csleep 1
	dqb "ALL DONE"
}

#pavucontol:iin liittyy "exp2 å"

#TODO:ffox 147
function tpr() {
	dqb "UPIR  ${1}" #tulisi kai olla vain 1 param tälle fktiolle
	csleep 1

	[ -z ${1} ] && exit 11
	[ -d ${1} ] || exit 12

	dqb "pars_ok"
	csleep 1

	dqb "stat= ${srat}"
	csleep 3

	local t
	for t in ${1}/config.tar.bz2 ~/config.tar.bz2 ; do ${srat} ${TARGET_TPX} -C ~ -xvf ${t} ; done
	for t in ${1}/pulse.tar ~/pulse.tar ; do ${srat} ${TARGET_TPX} -C / -xvf ${t} ; done

	dqb "PROFS?"
	csleep 1

	if [ -x ${1}/profs.sh ] ; then
		#fktioiden importointia jos kokeilisi? man bash...
		. ${1}/profs.sh
		[ $? -gt 0 ] && exit 33
			
		dqb "INCLUDE OK"
		csleep 1
		local q
		q=$(mktemp -d)

		#jatkossa kutsuvaan koodiin tämä if-blokki?
		if [ -s ~/fediverse.tar ] ; then
			${srat} ${TARGET_TPX} -C ${q} -xvf ~/fediverse.tar
		else
			${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/fediverse.tar
		fi

		imp_prof esr ${n} ${q}
	else
		dqb "CANNOT INCLUDE PROFS.HS"
		dqb "$0 1 \$srcfile ?"
	fi

	dqb "UP1R D0N3"
	csleep 1
}

case "${mode}" in
	-1) 
		part=/dev/disk/by-uuid/${part0}		
		[ -b ${part} ] || dqb "no such thing as ${part}"
		c=$(grep -c ${dir} /proc/mounts)

		if [ ${c} -lt 1 ] ; then
			${som} -o ro ${part} ${dir}
			csleep 1
			${som} | grep ${dir}
		fi

		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] unpack AND install | $0 1 <source> just unpacks the archive | $0 3 ..."
		#mode=-3 #remember:to_umount olisi hyvä muistuttaa kyitenkin
	;;
	2)
		${uom} ${dir}
		csleep 1
		${som} | grep ${dir}

		[ $? -eq 0 ] && echo "NEXT:  \${distro}/doIt6.sh maybe | sleep \$delay;ifup \$iface;changedns if necessary"
		#mode=-3
	;;
	-h)
		usage
		#mode=-3
		exit
	;;
esac

[ -z "${srcfile}" ] && exit 44

if [ -s ${srcfile} ] || [ -d ${srcfile} ] ; then
	dqb "SD"
else
	dqb "SMTHING WRONG WITH ${srcfile} "
	exit 55
fi

[ -r ${srcfile} ] || exit 35

if [ "${mode}" == "-3" ] || [ "${mode}" == "r" ] ; then
	dqb "asia kunnossa"
else
	read -p "U R ABT TO INSTALL ${srcfile} , SURE ABOUT THAT?" confirm
	[ "${confirm}" == "Y" ] || exit 33
fi

dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "srcfile=${srcfile}"
csleep 6

case "${mode}" in
	r)
		[ -d ${srcfile} ] || exit 22
		tpr ${srcfile}
	;;
	1) #vissiin toimii 
		common_part ${srcfile} ${d} /
		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
		csleep 1
	;; 
	0|3)
		echo "ZER0 S0UND"
		csleep 1
		dqb " ${3} ${distro} MN" #mikä pointti?
		csleep 1

		if [ ${1} -eq 0 ] ; then
			common_part ${srcfile} ${d} / #voi tietystI mennä mettään tuon $d/common_lib kanssa?
		else
			common_part ${srcfile} ${d} ${d}
		fi

		csleep 1

		if [ ${1} -eq 0 ] ; then
			#HUOM.30925:jospa antaisi efk2-kikkailujen olla toistaiseksi
			if [ -s ${d}/e.tar ] ; then
				common_part ${d}/e.tar ${d} /
			else
				dqb " ${d}/e.tar CANNOT BE FOUND"

				if [ -s ${d}/f.tar ] ; then
					common_part ${d}/f.tar ${d} ${d} 				
				fi
			fi
			#for t in ${d}/e.tar ... No Ei
		fi
		
		csleep 5
		dqb "c_p_d0n3, NEXT: pp3"
		csleep 1	

		part3 ${d} ${dnsm}
		other_horrors
		csleep 1
		
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	q) 
		#toimiiko tämä vielä/taas? ffox versio 147 saattaa tuoda muutoksia

		c=$(tar -tf ${srcfile} | grep fediverse.tar  | wc -l)
		[ ${c} -gt 0 ] || exit 77
		common_part ${srcfile} ${d} /
		tpr ${d0}
	;;
	k)	
		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		ridk=${srcfile}

		if [ -x ${gg} ] && [ -v TARGET_Dkname1 ] && [ -v TARGET_Dkname2 ] ; then #/.chroot vielä?
			dqb "NOP"
		
			for f in ${TARGET_Dkname1} ${TARGET_Dkname2} ; do 			
				dqb "dbg: ${gg} --import ${ridk}/${f}"
				${gg} --import ${ridk}/${f}
			done
		fi	
	;;
	-3)
		dqb "do_Nothing()"
	;;
	*)
		echo "-h"
	;;
esac

cd ${olddir}
#ettei umount unohdu 

if [ -v part ] || [ -v dir ] ; then
	echo "REMEMBER 2 UNM0UNT TH3S3:"
	[ -z ${part} ] || grep ${part} /proc/mounts #greppaus voi jäädä junnaamaan?
	[ -z ${dir} ] || grep ${dir} /proc/mounts
fi

${scm} 0755 $0
#HUOM.290925: tämän skriptin olisi kuvakkeen kanssa tarkoitus löytyä filesystem.squashfs sisältä
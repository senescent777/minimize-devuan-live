#!/bin/bash
debug=1
srcfile=""
distro=$(cat /etc/devuan_version) #tämä tarvitaan toistaiseksi (leikeltynä vai ei?)
dir=/mnt
part0=ABCD-1234
mode=-2
d0=$(pwd)

#echo "d0=${d0}"
[ z"${distro}" == "z" ] && exit 6
d=${d0}/${distro}

#pitäisikö vielä minimoida latensseja tästä skriptistä? ja sen käyttämistä?
#... optiota -v ei ole pakko käyttää, toisaalta
#HUOM.28725:testailtu, vaikuttaisi toimivalta ainakin enimmäkseen (q myöhemmin)

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
else
	usage
	exit 1	
fi


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

if [ -f /.chroot ] ; then
	echo "UNDER THE GRAV3YARD"
	sleep 2

	tar -jxvf ${d0}/necros.tar.bz2
	sleep 3
	rm ${d0}/necros.tar.bz2
fi

#HUOM.21725:oliko jotain erityistä syyt miksi conf cmmon_lib jälkeen? $distroon liittyvät kai, pitäisi miettiä, nyt näin
if [ -d ${d} ] && [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa?
	echo "CONF ( ${d}/conf ) MISSING"
	exit 56
fi

if [ -x ${d0}/common_lib.sh ] ; then #saattaa jo toimia chroot-ymp sisällä
	#... saattaa olla että sq-chroot:in sisällä ei tarvitsekaan:import2.sh mutta vägän kätevänou ehgkä
	. ${d0}/common_lib.sh
else
	#HUOM. demerde_toi.sh tekisi vähän turhaksi tämän "minikirjaston"
	srat="sudo /bin/tar" #which mukaan?
	som="sudo /bin/mount"
	uom="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	odio=$(which sudo)

	#jos näillä lähtisi aiNAKin case q toimimaan
	n=$(whoami)
	smr=$(${odio} which rm)
	NKVD=$(${odio} which shred)
	NKVD="${NKVD} -fu "
	whack=$(${odio} which pkill)
	whack="${odio} ${whack} --signal 9 "
	sah6=$(${odio} which sha512sum)

	function check_binaries() {
		dqb "imp2.ch3ck_b1nar135( \${1} )"
	}

	function check_binaries2() {
		dqb "imp2.ch3ck_b1nar135_2( \${1} )"
	}

	function fix_sudo() {
		dqb "imp32.fix.sudo"
	}

	function enforce_access() {
		dqb "imp32.enf_acc()"
	}

	#HUOM.26525:tämä versio part3:sesta sikäli turha että common_lib urputtaa koska sha512sums muttei deb?
	function part3() {
		dqb "NOT SUPPORTED"
		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount:in tapahtumaan silloin kun varsinainen instailu ei onnaa
	}

	function ppp3() {
		dqb "imp32.ppp3()"
	}

	#kutsutaanko tätä? no yhdestä kohdasta ainakin
	function other_horrors() {
		dqb "AZATHOTH AND OTHER HORRORS"

		#HUOM. /e/i tarvitsisi kirjoitusokeude että onnaa
		#${spc} /etc/default/rules.* /etc/iptables #takaisin jos pykii 
	
		${scm} 0400 /etc/iptables/*
		${scm} 0550 /etc/iptables
		${sco} -R root:root /etc/iptables
		${scm} 0400 /etc/default/rules*
		${scm} 0555 /etc/default
		${sco} -R root:root /etc/default
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
dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "srcfile=${srcfile}"
mkt=$(${odio} which mktemp)
#exit

if [ x"${mkt}" == "x" ] ; then
	#coreutils vaikuttaisi olevan se paketti mikä sisältää mktemp
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
		dqb "imp2.pr4 (\${1})" 
	}

	check_binaries ${d} #parametrit kunnossq?
	echo $?
	[ $? -eq 0 ] || exit 7
	csleep 1

	check_binaries2
	[ $? -eq 0 ] || exit 8
	csleep 1
fi

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}

if [ ! -f /.chroot ] ; then
	if [ ! -s /OLD.tar ] ; then 
		${srat} -cf /OLD.tar /etc /sbin /home/stubby ~/Desktop
	fi
fi

dqb "b3f0r3 par51ng tha param5"
csleep 1

#VAIH:a) pavucontrol-asetukset, missä? (1 arvaus olisi jo)
#b) firefoxin käännösasetukset, missä? (jokin .json varmaan)

#glorified "tar -x" this function is - Yoda
#TODO:jos ei jatkossa purkaisi kaikkea paketin sisältä kaikissa tilanteissa?
function common_part() {
	#debug=1

	dqb "common_part( ${1}, ${2}, ${3})"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2
	[ y"${3}" == "y" ] && exit 1

	[ y"${2}" == "y" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 33
	dqb "paramz_0k"

	cd /
	dqb "DEBUG:${srat} -xf ${1} "
	csleep 1
	
	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"
		cat ${1}.sha
		${sah6} ${1}
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	#TODO:jatkossa voisi -C - option parametrin johtaa $2:sesta?
	csleep 1
	${srat} -C ${3} -xf ${1} #HUOM.23725:C-option voisi josqs jyrätä?
	[ $? -eq 0 ] || exit 35  
	csleep 1
	dqb "tar DONE"

	local t
	t=$(echo ${2} | cut -d '/' -f 1-5) #tr mukaan?
	#HUOM.25725:voi periaatteessa mennä metsään tuo $t josqs, mutta tuleeko käytännössä sellaista tilannetta vastaan?

	if [ -x ${t}/common_lib.sh ] ; then
		enforce_access ${n} ${t} 
		dqb "running changedns.sh maY be necessary now to fix some things"
	else
		dqb "n s t as ${t}/common_lib.sh "	
	fi

	csleep 3
	
	if [ -d ${t} ] ; then
		dqb "HAIL UKK"

		#vissiinkin tässä kohtaa common_lib taas käyttöön EIKU
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

#HUOM.31725:jos nyt jnkn aikaa riittäisi $1 parametrina
function tpr() {
	dqb "UPIR ( ${1}, ${2})"
	csleep 1

	[ -z ${1} ] && exit 11
	[ -d ${1} ] || exit 12

	dqb "pars_ok"
	csleep 1

	if [ -s ~/config.tar.bz2 ] ; then
		${srat} -C / -jxf ~/config.tar.bz2
	else
		${srat} -C / -jxf ${1}/config.tar.bz2
	fi

	if [ -x ${1}/profs.sh ] ; then
		. ${1}/profs.sh
		[ $? -gt 0 ] && exit 33
			
		dqb "INCLUDE OK"
		csleep 1
		local q
		q=$(${mkt} -d)

		if [ -s  ~/fediverse.tar ] ; then
			${srat} -C ${q} -xvf ~/fediverse.tar
		else
			${srat} -C ${q} -xvf ${1}/fediverse.tar
		fi

		imp_prof esr ${n} ${q}
	else
		dqb "CANNOT INCLUDE PROFS.HS"
		dqb "$0 1 \$srcfile ?"
	fi
}

case "${mode}" in
	-1) #jatkossa jokim fiksumpi kuin -1
		part=/dev/disk/by-uuid/${part0}		
		[ -b ${part} ] || dqb "no such thing as ${part}"
		c=$(grep -c ${dir} /proc/mounts)

		if [ ${c} -lt 1 ] ; then
			${som} -o ro ${part} ${dir}
			csleep 1
			${som} | grep ${dir}
		fi

		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] (unpack AND install) | $0 1 <source> (just unpacks the archive)"
	;;
	2)
		${uom} ${dir}
		csleep 1
		${som} | grep ${dir}

		[ $? -eq 0 ] && echo "NEXT:  \${distro}/doIt6.sh (maybe) | sleep \$delay;ifup \$iface;changedns (if necessary)"
	;;
	1)
		[ x"${srcfile}" == "x" ] && exit 44
		[ -s ${srcfile} ] || exit 55

		read -p "U R ABT TO EXTRACT ${srcfile} , SURE ABOUT THAT?" confirm
		[ "${confirm}" == "Y" ]  || exit 77
		common_part ${srcfile} ${d} /

		csleep 1
		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;; #HUOM.nollaa edeltävät caset:ei ole sorkittu viime aikoina, pitäisi toimia ok
	0|3)
		#HUOM.mikä pointti tuolla 3:sella taas olikaan?
		dqb "ZER0 S0UND"
		csleep 1

		[ x"${srcfile}" == "x" ] && exit 55
		dqb "KL"
		csleep 1

		[ -s ${srcfile} ] || exit 66
		dqb "${srcfile} IJ"
		csleep 1

		[ z"{distro}" == "z" ] && exit 77
		dqb " ${3} ${distro} MN"
		csleep 1

		read -p "U R ABT TO INSTALL ${srcfile} , SURE ABOUT THAT?" confirm
		[ "${confirm}" == "Y" ] || exit 33
		[ -s ${srcfile} ]  || exit 34

		if [ ${1} -eq 0 ] ; then
			common_part ${srcfile} ${d} / #voi tietystI mennä mettään tuon $d/common_lib kanssa?
		else
			common_part ${srcfile} ${d} ${d}
		fi

		#VAIH:jokin tarkistus tähän? että $srcfile löytyi ha sen sau pirettua 
		csleep 5
		#sen yhden tar:in kanssa pitäisi selvittää mikä kusee (vai kuseeko vielä 23.7.25?)

		if [ ${1} -eq 0 ] ; then
			if [ -s ${d}/e.tar ] ; then
				common_part ${d}/e.tar ${d} /
			else
				dqb " ${d}/e.tar CANNOT BE FOUND"

				if [ -s ${d}/f.tar ] ; then
					common_part ${d}/f.tar ${d} ${d} 				
				fi
			fi
		fi
		
		csleep 5
		dqb "c_p_d0n3, NEXT: pp3()"
		csleep 1	

		part3 ${d} ${dnsm} #HUOM.21725:tämän toiminta pitäisi selvittää
		other_horrors #HUOM.21525:varm. vuoksi jos dpkg...
		csleep 1

		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	q)
		#VAIH:testaa toiminta vielä kerran

		#HUOM.vihjeeksi:parametrina olisi hyvä olla se fediverse.tar , missä sijaitseekaan, tai siis näin oli kunnes toiminta myyttyu
		#... pitäisi kai jatkossa testata että $srcfile:n sisältä löytyy fediverse.tar(VAIH) ... ja sit jotain		

		[ x"${srcfile}" == "x" ] && exit 55
		dqb "KL"
		csleep 1

		[ -s ${srcfile} ] || exit 66
		dqb "${srcfile} IJ"
		csleep 1
	
		c=$(tar -tf ${srcfile} | grep fediverse.tar  | wc -l)
		[ ${c} -gt 0 ]  || exit 77
		common_part ${srcfile} ${d} /
		tpr ${d0}
	;;
	r)
		tpr ${d0}
	;;
#	u)
#		echo "reficul (TODO?)" ehkei päivityspakettien kanssa tartte suurempia kikkailuja
#	;;
	-h) #HUOM.27725:ilman param kuuluisi kai keskeyttää suor mahd aik
		usage
	;;
	*)
		echo "-h"
	;;
esac

#ettei umount unohdu
echo "REMEMBER 2 UNM0UNT TH3S3:"
grep ${part} /proc/mounts
grep ${dir} /proc/mounts

${scm} 0755 $0
#HUOM. tämän olisi kuvakkeen kanssa tarkoitus mennä jatkossa filesystem.squashfs sisälle

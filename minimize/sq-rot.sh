#!/bin/bash
debug=0
srcfile=""

distro=$(cat /etc/devuan_version)
CONF_dir=/media
CONF_part0=ABCD-1234
mode=-2
d0=$(pwd)
[ -z "${distro}" ] && exit 6
d=${d0}/${distro}

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "${0} <mode> <srcfile> [distro?] [debug] "
	echo "when mode=k , this imports PUBLIC_KEYS , u have to import private keys another way!!!"
	echo "	\t also in that case, srcfile=the_dir_that_contains_some_named_keys"
}

function parse_opts_1() {
	dqb "rot.parse_opts_1() ${1} ((()"
	
	if [ "${mode}" == "-2" ] ; then
		mode=${1}
	fi
}

function parse_opts_2() {
	dqb "rot.parseopts_2 )) ${1} ; ${2} (("
	
	if [ -f ${2} ] || [ -d ${2} ] ; then
		srcfile=${2}
	fi
}

if [ -f /.chroot ] ; then #vähän turha tarkistus koska y
	echo "UNDER THE GRAV3YARD"
	sleep 1
	#debug=1
	
	#gpgtar jos mahd, muuten normi-tar?

	echo "A"
	p=$(pwd)
	g=$(which sha512sum)

	if [ ! -z "${g}" ] ; then
		q=$(find . -name 'dgsts.?')
		cd ..
		
		#110326:jotain urputusta oli, mksums bugittaa?
		#010426:jotain urputusta oli edelleen ennen "B"-osaa, selvitä 
		#... vissiin vain se että sqroot sisällä ei tdstojen sisältö täsmää listan sisältöön
		
		for r in ${q} ; do
			dqb " -c ./${p}/${r}"
			csleep 1
			${g} -c ./${p}/${r} --ignore-missing
			sleep 1
		done

		cd ${p}
	fi

	#gpg-tark kuitenkin ensin?
	#090326:pitäisiköhän myös tämä tarkistus-osuus muuttaa fktioksi, ennen chroot-tark ?

	g=$(which gpg)
	sleep 1
	cd ${p}

	if [ ! -z "${g}" ] ; then
		echo "B"
		q=$(find . -name '*.sig')
		
		for r in ${q} ; do
			${g} --verify ${r}
		done
		
		sleep 1
	fi
	#

	unset q
	unset r
	unset g
	sleep 1
	echo "C"

	#030426:huom. kts commn_lib , E22_M , tarpeellinen

	for f in $(find ${d0} -type f -name 'nekros?'.tar.bz3) ; do
		tar -jxvf ${f}
		sleep 1
		rm ${f}
		sleep 1
	done

	#jos löytyy common_lib.sh.sig ni voiusi tässä tarkistaa?
fi

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
	[ $? -eq 0 ] || exit
else
	echo "5L33P1NG UND3RR T4RTARU5"
	sleep 66

	if [ -s ${d0}/$(whoami).conf ] ; then
		echo "ALT.C0NF1G"
		sleep 2
		. ${d0}/$(whoami).conf
	else
		if [ -d ${d} ] && [ -s ${d}/conf ] ; then
			echo "ordnary cqf"
			. ${d}/conf
		else
		 	exit 57
		fi	
	fi

	odio=""	
	echo "MAYBE U SHOULD chmod a+x ${d0}/common_lib.sh"
	sleep 5
	
	function check_binaries() {
		dqb "rot.check1"

		mkt=$(${odio} which mktemp)
		scm=$(${odio} which chmod)
		sah6=$(${odio} which sha512sum)

		srat=$(${odio} which tar)
		#eXit jos srat ei?

		gg=$(${odio} which gpg)
		som=$(${odio} which mount)
		uom=$(${odio} which umount)
	}

	function check_binaries2() {
		echo "irot.check2"
	
		som="${odio} ${som}"
		uom="${odio} ${uom}"
		srat="${odio} ${srat}"
	}
	
	function part3() {
		dqb "rot.part3 :NOT SUPPORTED"
	}

	function other_horrors() {
		dqb "R0TT1NG W4Y5 T0 M153RY"
	}	
	
	#TODO:tähän se gpo() varm. vuoksi
fi

#050426:tämänkin skriptin kanssa se debug-riippuvuus? common_lib saattaisi liittyä
#TODO:jos tekisi asialle jotain (part3)

dqb "rot:AFTR common_lib"
csleep 1
[ -z "${distro}" ] && exit 6 #vähempikin tarkistelu riittäisi?
csleep 1

if [ -f /.chroot ] || [ -x ${mkt} ] ; then
	dqb "rot.MTK"
else
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
	[ $? -eq 0 ] || exit
else	
	echo $?
	dqb "N 0 L1.B"
	csleep 1
fi

check_binaries ${d}
[ $? -eq 0 ] || exit 

check_binaries2
[ $? -eq 0 ] || exit

[ -z "${srcfile}" ] && exit 44
[ -z "${distro}" ] && exit 46

if [ -s ${srcfile} ] || [ -d ${srcfile} ] ; then
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	dqb "SD"
else	
	[ -d ${srcfile} ] || dqb "NOT A MAN"
	[ -f ${srcfile} ] || dqb "NOT A CYBORG"
	dqb "SMTHING WRONG WITH ${srcfile} "
	exit 55
fi

#HUOM.olisi hyväksi siivota aiemmat tar:it kummittelemasta

function common_part() {
	dqb "rot.common_part ${1} , ${2} , ${3}"

	[ -z "${1}" ] && exit 1 #pitäisi kai keskEyttää suoritus aiemmin tässä tap
	[ -s ${1} ] || exit 2
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}"  ] && exit 11
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 45

	dqb "paramz_0k"
	csleep 1

	cd /

	local r
	r=0

	if [ -v gg ] && [ -s ${1}.sha.sig ] ; then
		dqb "A"
		dqb "gg= ${gg}"

		#jos pikemminkin tutkisi sen ~/.gnupg-hmiston array:n olemassssaolon sijaan?
		if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
			dqb "B"

			if [ -x ${gg} ] ; then
				dqb "C"

				dqb " ${gg} --verify ${1}.sha.sig "
				${gg} --verify ${1}.sha.sig
				r=$?

				[ -f ${1}.sha.sig.1 ] && ${gg} --verify ${1}.sha.sig.1
				#csleep 1
			fi
		fi

		[ ${r} -eq 0 ] || exit ${r}
	fi

	csleep 1
	#kts. common_lib.psqa()
	local cfk=1

	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"
		dqb "gg= ${gg}"

		#tuon .sha:n kanssa 1 lisätarkistus ehkä? yhteistä mjonoa löytyykö? $1 vs $1.sha ?
		local aa=$(cat ${1}.sha | awk '{print $1}' | tr -d -c 0-9a-f)
		local ab=$(${sah6} ${1} | awk '{print $1}' | tr -d -c 0-9a-f)

		if [ "${aa}" == "${ab}" ] ; then
			dqb "aa=ab= ${aa}"
			cfk=0
		fi

		csleep 1
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	if [ ${cfk} -gt 0 ] ; then
		read -p " U  SURE ?" confirm
		[ "${confirm}" == "Y" ] || exit 33
	fi
	
	csleep 1
	dqb "NECKST: ${srat} ${TARGET_TPX} -C ${3} -xf ${1}"

	csleep 1
	${srat} ${TARGET_TPX} -C ${3} -xf ${1}
	[ $? -eq 0 ] || exit 36	
	
	csleep 1
	dqb "${srat} DONE"
}

#TODO:cptp2 prujaaminen
#TODO:kysymöön kähteen poistosta purkamisen jälkeen?

case "${mode}" in
	1) #
		common_part ${srcfile} ${d} /
		#[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
		csleep 1
	;; 
	3)  #0 poistettu 040426 (takaisin josqs vai rei?)
		
		e=${d}
		common_part ${srcfile} ${d} ${e}
		part3 ${d}
		other_horrors
	;;
	k)
		#HUOM. TÄMÄ MUISTETTAVA AJAA JOS HALUAA ALLEKIRJOITUKSET TARKISTAA

		#VAIH:tuotaville avaimille jotain tark? jos on jo ennestään jotain av ni niitä vasten testaa uudet, esim.
		#man gpg voisio lla jankohtainen vähitellen

		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		#avaInten allekirjoittamiseen oli muuten omakin optio (gpg --edit-key ? letd find out?)

		if [ -v gg ] ; then
			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
				dqb "NOP"
				csleep 1

				#for f in $(fnid $srcfile -type f -name '*.sig') ; do
				#	g=$(echo $f | cut -d . -f 1,2)
				#	check=$(smthing)
				#	[ $check ] && gg --import $g
				#	rm $g	
				#done

				dqb "${gg} --import ${srcfile}/*.gpg soon"
				csleep 1

				${gg} --import ${srcfile}/*.gpg
				csleep 1

				[ ${debug} -eq 1 ] && ${gg} --list-keys
				csleep 2
			fi
		else
			dqb "NO-GO-THEOREM"
		fi
	;;
	-h)
		usage
		#mode=-3
		exit
	;;
	*)
		echo "-h"
	;;
esac

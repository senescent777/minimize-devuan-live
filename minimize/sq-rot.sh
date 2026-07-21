#!/bin/bash
debug=0 #tilapäisesti nollakei että asialliset hommat EHKÄ
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

#"$0 1 tgtfile -v" - ajankohtainen 06/26?
#
#function parse_opts_1() {
#	dqb "rot.parse_opts_1() ${1} ((()"
#
#	if [ "${mode}" == "-2" ] ; then
#		dqb "å"
#		mode=${1}
#	fi
#}
#
#TODO:NOSE PARSETUS PRKL
#function parse_opts_2() {
#	dqb "fish.rot.parseopts_2 )) ${1} ; ${2} (("
#
#	if [ -f ${2} ] || [ -d ${2} ] ; then
#		dqb "a"
#		if [ -z "${srcfile}" ] ; then
#			dqb "b"
#			if [ "${2}" != "-v" ] ; then
#				dqb "srcfile=${2}"			
#				srcfile=${2}
#			fi
#		fi
#	fi
#}

[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
csleep 5
#tuossa yllä tosin turhahko ls

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
	#[ $? -eq 0 ] || exit #tähänkö kosahtanut viime_aikoina?
else
	echo "W33P1NG UND3RR G4L4CTU5"
	sleep 6
	
	if [ -s ${d0}/$(whoami).conf ] ; then
		echo "ALT.C0fn.1G"
		sleep 2
		. ${d0}/$(whoami).conf
	else
		if [ -d ${d} ] && [ -s ${d}/conf ] ; then
			echo "ord1nary cqf"
			. ${d}/conf
		else
		 	exit 57
		fi
	fi

	odio=""	
	echo "MAYBE U SHOULD chmod a+x ${d0}/common_lib.sh"
	sleep 5

	function ocs() {
		local t=$(${odio} which ${1})

		if [ -z "${t}" ] ; then
			echo "SMTHIN1G 15 WR0NG: ${1} ?"
			exit 666
		fi
	}

	function check_binaries() {
		echo "fish.rot.1"
		scm=$(${odio} which chmod)
		[ -v CONF_algo ] || exit 77

		case "${CONF_algo}" in
			sha256)
				sah6=$(${odio} which sha256sum)
				ocs sha256sum
			;;
			sha512)
				sah6=$(${odio} which sha512sum)
				ocs sha512sum
			;;
			*)
				exit 99
			;;
		esac

		srat=$(${odio} which tar)
		srat="${odio} ${srat}"

		gg=$(${odio} which gpg) #suattaapi olla että tähän tökkää, taisiis myöhemmin
		[ -z "${gg}" ] && echo "SH0ULD.1NST.GPG"
		NKVD=$(${odio} which shred)
	}

	function check_binaries2() {
		echo "fish.rot.2"
		srat="${odio} ${srat}"
		NKVD="${odio} ${NKVD} -fu "
	}

	function part3() {
		dqb "fish.rot.part3 :NOT SUPPORTED"
	}

	function other_horrors() {
		dqb "R0TT1NG W4Y5 T0 M153RY"
	}
	
	function enforce_access() {
		dqb "W T F ???"
	}

#	for opt in $@ ; do
#		parse_opts_1 ${opt}
#		parse_opts_2 ${prevopt} ${opt}
#		prevopt=${opt}
#	done
fi

dqb "rot:AFTR common_lib"
csleep 1
[ -z "${distro}" ] && exit 26
[ -v CONF_env ] || exit 66

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
	[ $? -eq 0 ] || exit
else
	echo $?
	echo "N 0 L1.B"
	csleep 1
fi

check_binaries ${d}
#[ $? -eq 0 ] || exit saattaa aiheuttaa ongelmia liialliset tarkistukset

check_binaries2
#[ $? -eq 0 ] || exit
[ -v CONF_env ] || exit 96

if [ $# -gt 0 ] ; then
	mode=${1}
	[ -f ${1} ] && exit 99
	[ "${2}" == "-v" ] || srcfile=${2}

	#parse_opts pitäisi
	if [ "${3}" == "-v" ] || [ "${4}" == "-v" ] ; then
		debug=1
	fi
fi

if [ "${CONF_env}" == "TOOR" ] ; then
function pre() {
	echo "UNDER THE GRAV3YARD"
	sleep 1

	echo "A"
	p=$(pwd)

	if [ ! -z "${sah6}" ] ; then
		q=$(find . -name "dgsts.?" )
		cd ..

		for r in ${q} ; do
			dqb " -c ./${p}/${r}"
			csleep 1
			${sah6} -c ./${p}/${r} --ignore-missing
			sleep 1
		done

		cd ${p}
	fi

	sleep 1
	cd ${p}

	if [ ! -z "${gg}" ] ; then
		echo "B"
		q=$(find . -name "*.sig" )

		for r in ${q} ; do
			${gg} --verify ${r}
			#[ $? -eq 0 ] || exit 66 ei vielä?
		done

		sleep 1
	fi

	unset q
	unset r
	sleep 1
	echo "C"

	for f in $(find ${d0} -type f -name "nekros?".tar.bz3 ) ; do	
		tar --exclude import2.sh -jxvf ${f}

		sleep 1
		rm ${f}
		sleep 1
	done

	if [ ! -z "${gg}" ] ; then
		if [ -s ${d0}/common_lib.sh.sig ] ; then
			${gg} --verify ${d0}/common_lib.sh.sig
			[ $? -eq 0 ] || exit 67
		fi
	fi
}
	
fi

[ -z "${srcfile}" ] && exit 44
[ -z "${distro}" ] && exit 46

if [ -s ${srcfile} ] || [ -d ${srcfile} ] ; then
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	dqb "SD"
else
	[ -d ${srcfile} ] || dqb "NOT A MAN"
	[ -f ${srcfile} ] || dqb "NOT A CYBORG"

	echo "SMTHING WRONG WITH ${srcfile} "
	exit 65
fi

#VAIH:purkaessa voisi ohittaa rnd, .rnd jos ei siis niin jo tee (eli mitä TPX syönyt?)
#... jotain pientä laittoa vielä tarvitsee (230326)
#josko jkpo 07/26 valmiiksi asti?

function common_part() {
	echo "rot.common_part ))))) ${1} , ${2} , ${3} ))))))"

	[ -z "${1}" ] && exit 91 #pitäisi kai keskEyttää suoritus aiemmin tässä tap
	[ -s ${1} ] || exit 92
	[ -r ${1} ] || exit 93
	[ -z "${3}" ] && exit 94

	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 43

	[ "${1}" == "/" ] && exit 56
	[ -v CONF_hashfile ] || exit 98
	[ -z "${CONF_hashfile}" ] && exit 99
	echo "paramz_0k"
	sleep 1

	cd /
	local r
	r=0

	if [ -v gg ] ; then
		if  [ -s ${1}.sig ] ; then
			dqb "A"
			dqb "gg= ${gg}"

			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
				dqb "B"

				if [ -x ${gg} ] ; then
					dqb "C"

					dqb " ${gg} --verify ${1}.sig "
					${gg} --verify ${1}.sig
					r=$?

					#[ -f ${1}.sha.sig.1 ] && ${gg} --verify ${1}.sha.sig.1 mikäö idea tässä?
					#csleep 1
				fi
			fi

			[ ${r} -eq 0 ] || ${NKVD} ${1}*
		fi
	fi

	csleep 1
	#kts. common_lib.psqa()
	local cfk=1

	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"
		dqb "gg= ${gg}"

		#tuon .sha:n kanssa 1 lisätarkistus ehkä? yhteistä mjonoa löytyykö? $1 vs $1.sha ?
		local aa=$(cat ${1}.sha | awk '{print $1}' | tr -d -c 0-9a-f) #HUOM.TARKKANA SITTEN HIPSUHEN KANSSA 666!!!
		local ab=$(${sah6} ${1} | awk '{print $1}' | tr -d -c 0-9a-f)

		if [ "${aa}" == "${ab}" ] ; then
			dqb "aa=ab= ${aa}"
			cfk=0
		fi

		[ ${cfk} -eq 0 ] || ${NKVD} ${1}*
		csleep 1
	else
		echo "NO ${CONF_hashfile}   CAN BE F0UND FOR ${1}"
	fi

	if [ ${cfk} -gt 0 ] ; then
		read -p " U  SURE ?" confirm

		if [ "${confirm}" == "Y" ] ; then
			dqb "ko"		
		else	
			#ekan param lisätarkistukset yllä riittävät? entä destroy()?
			${NKVD} ${1}* 
			${NKVD} ${2}/*.deb

			#destrpy()?

			${NKVD} ${2}/${CONF_hashfile}*
			${NKVD} ${2}/*.tar*

			exit 33
		fi
	fi

	csleep 1
	dqb "NECKST: ${srat}  ( ${TARGET_TPX} ) -C ${3} -xf ${1}"

	csleep 1
	${srat} --exclude rnd --exclude ./rnd -C ${3} -xf ${1} #vielä pientä laittoa "${TARGET_TPX}" liittyen?
	[ $? -eq 0 ] || exit 36	

	sleep 1
	echo "${srat} DONE"
}

#cptp2 -> common_lib vai ei?
function cptp2() {
	dqb "rot.c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 10

	#tr-kikkailu tässä ei niitä parhaimpia ideoita 
	local t
	t=$(echo ${1} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)

	if [ -f ${t}/common_lib.sh ] ; then
		#onkohan tuossa tarkistuksessa pointtia?
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			${gg} --verify ${t}/common_lib.sh.sig 
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		fi

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t}
		
			dqb "TRO: running mutilatetc.bash maY be necessary now to fix some things"
		else
			dqb "n s 3x3cutabl3 as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
		fi
		
		csleep 10
	fi

	csleep 1

	if [ -d ${t} ] ; then
		dqb "HAIL2 TH3 TH13F"

		${scm} 0755 ${t}
		${scm} 0555 ${t}/*.sh
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb

		csleep 1
	fi

	[ ${debug} -eq 1 ] && ls -las ${1}
	csleep 1
	dqb "ALL DONE"
}

case "${mode}" in
	1)
		[ "${CONF_env}" == "VED" ] && exit 47 #varm. vältt.- est (josko voisi vähitellen...)
		common_part ${srcfile} ${d} /
	;;
	#... exp2 rp vähän yritetty testailla 05/26
	0)
		#[ "${CONF_env}" == "VED" ] && exit 49 #varm. vältt.- est (josko voisi vähitellen...)
		
		e="/"
		[ ${mode} -eq 0 ] || e=${d}
		f=$(tar -tf ${srcfile} | grep '.tar' | head -n 1)
		f=$(dirname ${f})

		echo "bfore sqr.comm_p: $?"
		sleep 6

		common_part ${srcfile} ${d} ${e}
		echo "sq.FART3: $?"
		[ $? -eq 0 ] && ocs gpg
		
		[ $? -eq 0 ] && part3 ${f}
		[ $? -eq 0 ] && other_horrors
	;;
	3)
		#TODO:puoliksi onnistuneen "$0 0" masentelun jatkaminen (common_part edeltävät tark se ilmeisin este)

		e=${d}
		common_part ${srcfile} ${d} ${e}
		ocs gpg
		part3 ${d}
		other_horrors
	;;
	k)
		#HUOM. TÄMÄ MUISTETTAVA AJAA JOS HALUAA ALLEKIRJOITUKSET TARKISTAA

		[ "${CONF_env}" == "TOOR" ] && pre

		#VAIH:tuotaville avaimille jotain tark? jos on jo ennestään jotain av ni niitä vasten testaa uudet, esim.
		#... valmiiksi josqs?

		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		#avaInten allekirjoittamiseen oli muuten omakin optio (gpg --edit-key ? letd find out?)

		if [ -v gg ] ; then
			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
				dqb "NOP"
				csleep 1

				#for f in $(fnid $srcfile -type f -name "*.sig" ) ; do
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
	-h) #miten tämä+seur case toimii nykyään?
		usage
		#mode=-3
		exit
	;;
	*)
		echo "-h"
	;;
esac

echo "atfr.esac"
sleep 1

#poistelu ajank vain jos tehty lähteelle jotain sitä ennen? vissiin pitäisi jokin tarkistus lisätä (VAIH?)
if [ $? -eq 0 ] ; then
	if [ -s ${srcfile} ] && [ -f ${srcfile} ] ; then
		read -p " U  WANT 2 RM SOURCE ?" confirm
		[ "${confirm}" == "Y" ] && ${NKVD} ${srcfile}
	fi
fi

cptp2 ${d0}

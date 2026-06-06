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

#VAIH:"$0 1 tgtfile -v" - osaako menetellä oikein? (vielä 05/26?)

function parse_opts_1() {
	dqb "rot.parse_opts_1() ${1} ((()"

	if [ "${mode}" == "-2" ] ; then
		mode=${1}
	fi
}

function parse_opts_2() {
	dqb "rpus.ot.parseopts_2 )) ${1} ; ${2} (("

	if [ -f ${2} ] || [ -d ${2} ] ; then
		if [ -z "${srcfile}" ] ; then
			if [ "${2}" != "-v" ] ; then			
				srcfile=${2}
			fi
		fi
	fi
}

[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
csleep 5

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
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
		 	exit 75
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

		#mkt=$(${odio} which mktemp) #onkohan import2:sessakaan tarpeellinen?
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

		gg=$(${odio} which gpg)
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

	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
fi

dqb "rot:AFTR common_lib"
csleep 1
[ -z "${distro}" ] && exit 26
[ -v CONF_env ] || exit 66

if [ "${CONF_env}" == "TOOR" ] ; then

	
function pre() {
	echo "UNDER THE GRAV3YARD"
	sleep 1

	echo "A"
	p=$(pwd)

		q=$(find . -name "dgsts.?" )
		cd ..

		for r in ${q} ; do
			dqb " -c ./${p}/${r}"
			csleep 1
			${sah6} -c ./${p}/${r} --ignore-missing
			sleep 1
		done

		cd ${p}


	sleep 1
	cd ${p}
	
	if [ ! -z "${gg}" ] ; then
		echo "B"
		q=$(find . -name "*.sig" )
	
		for r in ${q} ; do
			${gg} --verify ${r}
			#TODO:exit jos vrheitä
		done
	
		sleep 1
	fi
	
	unset q
	unset r
	
	sleep 1
	echo "C"

	for f in $(find ${d0} -type f -name "nekros?".tar.bz3 ) ; do
		tar  -jxvf ${f} #--exclude import2.sh
		sleep 1
		rm ${f}
		sleep 1
	done

	if [ ! -z "${gg}" ] ; then
		if [ -s ${d0}/common_lib.sh.sig ] ; then
			${gg} --verify ${d0}/common_lib.sh.sig
			#exit jos ei ok
		fi
	fi

}

	pre
fi

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
	[ $? -eq 0 ] || exit
else
	echo $?
	echo "N 0 L1.B"
	csleep 1
fi

check_binaries ${d}
check_binaries2
#[ $? -eq 0 ] || exit

[ -z "${srcfile}" ] && exit 104
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

#TODO:purkaessa voisi ohittaa rnd, .rnd jos ei siis niin jo tee (eli mitä TPX syönyt?)

function common_part() {
	dqb "rot.common_part ))))) ${1} , ${2} , ${3} ))))))"

	[ -z "${1}" ] && exit 91
	[ -s ${1} ] || exit 2
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}"  ] && exit 11 # truhra parm? melkein
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 45
	
	[ "${1}" == "/" ] && exit 56
	echo "paramz_0k"
	csleep 1

	cd /
	local r
	local s
	r=0
	s=1

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

			if [ ${r} -eq 0 ] ; then
				echo "SHOULD \$ {NKVD} \${1} * NOW"
			fi
		fi
	fi

	echo "AFTR GPG $?"
	csleep 1

	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"
		dqb "gg= ${gg}"
		echo "sah: ${sah6}"
		sleep 1

		local aa=$(cat ${1}.sha | awk '{print $1}' | tr -d -c 0-9a-f) #HUOM.TARKKANA SITTEN HIPSUjEN KANSSA 666!!!
		local ab=$(${sah6} ${1} | awk '{print $1}' | tr -d -c 0-9a-f)

		echo "AFTER ABC: $?"
		sleep 5

		if [ "${aa}" == "${ab}" ] ; then
			dqb ${aa}
			s=0
		else
			echo "aa: ${aa}"
			echo "ab: ${ab}"

			echo "SHOULD: \$ {NKVD} ${1}* "
			sleep 1
			exit 43
		fi

		echo "BEFORE NKVD: $?"
		sleep 1
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	echo "AFTR SHA $?"
	sleep 1

	if [ ${s} -gt 0 ] ; then
		read -p " U  SURE ?" confirm

		if [ "${confirm}" == "Y" ] ; then
			dqb "ko"		
		else
			echo "SHOULD DO SOME NKVD-STUFF AROUND HERE"
			#${NKVD} ${1}* 
			#${NKVD} ${2}/*.deb
		
			#${NKVD} ${2}/${CONF_hashfile}*
			#${NKVD} ${2}/*.tar*

			exit 33
		fi
	fi

	sleep 1
	echo "NECKST: ${srat} ${TARGET_TPX} -C ${3} -xf ${1}"
	
	sleep 1
	${srat} ${TARGET_TPX} -C ${3} -xf ${1}
	[ $? -eq 0 ] || exit 36	

	sleep 1
	echo "common_part_DONE"
}

function cptp2() {
	dqb "rot.c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 10

	local t
	t=$(echo ${1} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)

	if [ -f ${t}/common_lib.sh ] ; then
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			#csleep 1
			${gg} --verify ${t}/common_lib.sh.sig 
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		fi

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t}
			#TODO:tuota ao. tekstiä voisi varmaan päiuvittää koska x
			dqb "TRO: running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s 3x3cutabl3 as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
		fi
		
		csleep 10
	fi

	csleep 1

	if [ -d ${t} ] ; then
		dqb "HAIL UKK"

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
		[ "${CONF_env}" == "VED" ] && exit 47 #varm. vältt.- est
		common_part ${srcfile} ${d} /
	;;
	0)
		[ "${CONF_env}" == "VED" ] && exit 49 #varm. vältt.- est
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
		#TODO:e23_st() outputin asennus , kehitysymp (tai siis)
		#TODO:puoliksi onnistuneen "$0 0" masentelun jatkaminen (common_part edeltävät tark se ilmeisin este)

		e=${d}
		common_part ${srcfile} ${d} ${e}
		ocs gpg
		part3 ${d}
		other_horrors
	;;
	k)
		#HUOM. TÄMÄ MUISTETTAVA AJAA JOS HALUAA ALLEKIRJOITUKSET TARKISTAA
		#VAIH:tuotaville avaimille jotain tark? jos on jo ennestään jotain av ni niitä vasten testaa uudet, esim.

		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		
		if [ -v gg ] ; then
			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
				dqb "NOP"
				csleep 1

				#olisi varmaan hyväksi importoida jossain järjestyksessä eikä miten sattuu
				for f in $(find ${srcfile} -type f -name "*.sig" ) ; do
					g=$(echo $f | cut -d . -f 1,2)
				#	check=$(smthing)
				#	[ $check ] && 
					${gg} --import ${g}
					rm ${g}	
				done

				#dqb "${gg} --import ${srcfile}/*.gpg soon"
				#csleep 1
				#
				#${gg} --import ${srcfile}/*.gpg
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

#poistelu ajank vain jos tehty lähteelle jotain sitä ennen? vissiin pitäisi jokin tarkistus lisätä (TODO)
if [ $? -eq 0 ] ; then
	if [ -s ${srcfile} ] ; then #riittävä tarq tapauksessa lähde==hakemisto?
		read -p " U  WANT 2 RM SOURCE ?" confirm
		#270526:joskus takaisin toimintaan
		[ "${confirm}" == "Y" ] && echo "SHOULD \$ {NKVD} \${srcfile}"
	fi
fi

cptp2 ${d0}

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

#VAIH:"$0 1 tgtfile -v" - osaako menetellä oikein?

function parse_opts_1() {
	dqb "rot.parse_opts_1() ${1} ((()"

	if [ "${mode}" == "-2" ] ; then
		mode=${1}
	fi
}

#TODO?:exp2/imp2/sqr komentorivien käsittelyyn muutosta? uusi optio? ,mikä?

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
	#function ocs() {???}

	#VAIH:sah6 LOTTOAMINEN UUSIKSI 666!!!

	[ -v CONF_algo ] || exit 666

	case "${CONF_algo}" in
		sha256)
			ocs sha256sum
			sah6=$(${odio} which sha256sum)
		;;
		sha512)
			echo "SHOULD OCS sha512"
		;;
		*)
			exit 667
		;;
	esac

	function check_binaries() {
		echo "rot.check1"

		#mkt=$(${odio} which mktemp) #onkohan import2:sessakaan tarpeellinen?
		scm=$(${odio} which chmod)

		srat=$(${odio} which tar)
		#eXit jos srat ei?

		gg=$(${odio} which gpg) #suattaapi olla että tähän tökkää, taisiis myöhemmin
		[ -z "${gg}" ] && echo "SH0ULD.1NST.GPG"

		NKVD=$(${odio} which shred)
	}

	function check_binaries2() {
		echo "irot.check2"
		srat="${odio} ${srat}"
		NKVD="${odio} ${NKVD} -fu "
	}

	function part3() {
		dqb "rot.part3 :NOT SUPPORTED"
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
[ -z "${distro}" ] && exit 6 #vähempikin tarkistelu riittäisi?

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
			[ $? -eq 0 ] || exit 66
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
	pre
fi

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

function common_part() {
	dqb "rot.common_part ${1} , ${2} , ${3}"

	[ -z "${1}" ] && exit 1 #pitäisi kai keskEyttää suoritus aiemmin tässä tap
	[ -s ${1} ] || exit 2
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}" ] && exit 11 # truhra parm?
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 45

	[ -v CONF_hashfile ] || exit 98
	[ -z "${CONF_hashfile}" ] && exit 99

	dqb "paramz_0k"
	csleep 1

	cd /
	local r
	r=0

	if [ -v gg ] && [ -s ${1}.sha.sig ] ; then
		dqb "A"
		dqb "gg= ${gg}"

		if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
			dqb "B"

			if [ -x ${gg} ] ; then
				dqb "C"

				dqb " ${gg} --verify ${1}.sha.sig "
				${gg} --verify ${1}.sha.sig
				r=$?

				[ -f ${1}.sha.sig.1 ] && ${gg} --verify ${1}.sha.sig.1
			fi
		fi

		[ ${r} -eq 0 ] || ${NKVD} ${1}*
	fi

	csleep 1
	local cfk=1 #TODO:tämän mjan kanssa oli juttuja kuten koko fktionkin kanssa

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
		echo "NO ${CONF_hashfile} CAN BE F0UND FOR ${1}"
	fi

	if [ ${cfk} -gt 0 ] ; then
		read -p " U  SURE ?" confirm

		if [ "${confirm}" == "Y" ] ; then
			dqb "ko"		
		else
			#TODO:ekan param kanssa lisötarkistuksie ttei ihan mitä tahansa dellitä 
			${NKVD} ${1}* 
			${NKVD} ${2}/*.deb ${2}/${CONF_hashfile}* ${2}/*.tar*
			exit 33

		fi
	fi

	csleep 1
	dqb "NECKST: ${srat} ${TARGET_TPX} -C ${3} -xf ${1}"

	csleep 1
	${srat} ${TARGET_TPX} -C ${3} -xf ${1}
	[ $? -eq 0 ] || exit 36	

	csleep 1
	dqb "${srat} DONE"
}

function cptp2() {
	dqb "rot.c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 99
	#[ -z "${2}" ] && exit 98 truhra parm?
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 1

	local t
	t=$(echo ${1} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)

	if [ -f ${t}/common_lib.sh ] ; then
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			${gg} --verify ${t}/common_lib.sh.sig 
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		fi

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t} #${2} toka param turha?
			dqb "running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s 3x3cutabl3 as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
			csleep 10
		fi
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

#TODO:mode 0 vähitellen takaisin
case "${mode}" in
	1)
		[ "${CONF_env}" == "VED" ] && exit 47 #varm. vältt.- est
		common_part ${srcfile} ${d} /
		csleep 1
	;; 
	#... exp2 rp vähän ritetty testailla 05/26
	0)
		[ "${CONF_env}" == "VED" ] && exit 49 #varm. vältt.- est
		e="/"
		[ ${mode} -eq 0 ] || e=${d}
		f=$(tar -tf ${srcfile} | grep '.tar' | head -n 1)
		f=$(dirname ${f})

		echo "bfore sqr.comm_p: $?"
		sleep 6

		common_part ${srcfile} ${d} ${e}

		#VAIH:kiukut6telut voisi poistaa (vai onko vielä moista 250626? vissiin)
		#modaamattomalla kiekolla jos testaisi kanssa		
		echo "sq.FART3: $?"
		[ $? -eq 0 ] && ocs gpg
		
		#sleep 3
		#exit 61

		[ $? -eq 0 ] && part3 ${f}
		[ $? -eq 0 ] && other_horrors
	;;
	3)
		#140526 muutettu paikallinen ocs että stoppaa tarv
		#TODO:e23_st() outputin asennus , kehitysymp
		#TODO:puoliksi onnistuneen "$0 0" masentelun jatkaminen (common_part edeltävät tark se ilmeisin este)

		e=${d}
		common_part ${srcfile} ${d} ${e}
		part3 ${d}
		other_horrors
	;;
	k)
		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		
		if [ -v gg ] ; then
			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
				dqb "NOP"
				csleep 1

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

#poistelu ajank vain jos tehty lähteelle jotain sitä ennen?
if [ -s ${srcfile} ] ; then
	read -p " U  WANT 2 RM SOURCE ?" confirm
	[ "${confirm}" == "Y" ] && ${NKVD} ${srcfile}
fi

cptp2 ${d0}

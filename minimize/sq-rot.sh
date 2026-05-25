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

#e.tar purq (cefgh()) vs tämä sq-rot alku
function pre() {
	#280426:self_extracting_archive-kikkailu saattaa tehdä tämän if-blkin turhaksi jatkossa ( tai sitten ei)

	echo "UNDER THE GRAV3YARD"
	sleep 1
	#gpgtar:kandeeko koskea? taisiis etua "gpg | tar" nähden?

	echo "A"
	p=$(pwd)
	g=$(which sha512sum)

	if [ ! -z "${g}" ] ; then
		q=$(find . -name "dgsts.?" )
		cd ..

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
		q=$(find . -name "*.sig" )

		for r in ${q} ; do
			${g} --verify ${r}
		done

		sleep 1
	fi
	#

	unset q
	unset r
	
	sleep 1
	echo "C"

	#030426:huom. kts commn_lib , E22_M , tarpeellinen
	#import2 syytä purkaa koska case r

	#VAIH:jatkossa purkamaan vain 1 bz3 ? ihan vielä ei onnaa koska gpg ja tables

	#for f in $(find ${d0} -type f -name nekros1.tar.bz3 ) ; do
	for f in $(find ${d0} -type f -name "nekros?".tar.bz3 ) ; do
		tar  -jxvf ${f} #--exclude import2.sh
		sleep 1
		rm ${f}
		sleep 1
	done

	#jos löytyy common_lib.sh.sig ni voisi tässä tarkistaa?
	#... toisaalta vähän tuhra koska cptp23

	if [ ! -z "${g}" ] ; then
		if [ -s ${d0}/common_lib.sh.sig ] ; then
			${g} --verify ${d0}/common_lib.sh.sig
		fi
	fi

	unset g
}

#HUOM.230526:fktio n pre() käskytys oli aiemmin ennen common_lib includointia, takaisiin tähän jos qsee

#resolv.conf vielä ongelma 0305-> ? 
[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
csleep 5
#tuossa yllä tosin turhahko ls

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
	#[ $? -eq 0 ] || exit #tähänkö kosahtanut viime_aikoina?
else
	echo "W33P1NG UND3RR G4L4CTU5"
	sleep 6
	#cptp2 voisi lopuksi palauttaa x-oikeuden kirjastoon?
	
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
		echo "rot13.check1"

		#mkt=$(${odio} which mktemp) #onkohan import2:sessakaan tarpeellinen?
		scm=$(${odio} which chmod)
		sah6=$(${odio} which sha512sum)

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

	#070426:jospa toimisi jnkin verran näinkin
	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
fi

dqb "rot:AFTR common_lib"
csleep 1
[ -v CONF_env ] || exit 66
#if [ -f /.chroot ] ; then #vähän turha tarkistus koska y (tai siis)
#HUOM.20526:ei onnaakaan vielä näin, tai ainakin pitäisi conf ncludoida ennenq common_lib

if [ "${CONF_env}" == "TOOR" ] ; then
	pre
fi

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
#[ $? -eq 0 ] || exit saattaa aiheuttaa ongelmia liialliset tarkistukset

check_binaries2
#[ $? -eq 0 ] || exit

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

#HUOM.lienee hyväksi siivota aiemmat tar:it kummittelemasta, tapahtuu skriptin lopussa kysymyksen takana
#TODO:purkaessa voisi ohittaa rnd, .rnd jos ei siis niin jo tee (eli mitä TPX syönyt?)

function common_part() {
	dqb "rot.common_part ))))) ${1} , ${2} , ${3} ))))))"

	[ -z "${1}" ] && exit 1 #pitäisi kai keskEyttää suoritus aiemmin tässä tap
	[ -s ${1} ] || exit 2
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}"  ] && exit 11 # truhra parm (110426)
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 45

	dqb "paramz_0k"
	csleep 1

	cd /
	local r
	r=0

	if [ -v gg ] ; then #josko näin kuitenkin?
		if  [ -s ${1}.sig ] ; then
			dqb "A"
			dqb "gg= ${gg}"

			#jos pikemminkin tutkisi sen ~/.gnupg-hmiston array:n olemassssaolon sijaan?
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

			#1105326:tässä käytiin, pitäisi odio olla asetettuma että jotain tapahtuisi
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
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	if [ ${cfk} -gt 0 ] ; then
		read -p " U  SURE ?" confirm

		if [ "${confirm}" == "Y" ] ; then
			dqb "ko"		
		else
			${NKVD} ${1}* 
			${NKVD} ${2}/*.deb
			${NKVD} ${2}/sha512sums*
			${NKVD} ${2}/*.tar*

			exit 33
		fi
	fi

	csleep 1
	dqb "NECKST: ${srat} ${TARGET_TPX} -C ${3} -xf ${1}"

	#110523:vöib aiheuttaa nalkutusta jos odio ei asetettu
	csleep 1
	${srat} ${TARGET_TPX} -C ${3} -xf ${1}
	[ $? -eq 0 ] || exit 36	

	csleep 1
	dqb "${srat} DONE"
}

function cptp2() {
	dqb "rot.c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 99
	#[ -z "${2}" ] && exit 98 truhra parm (110426)
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 10

	#tr-kikkailu tässä ei niitä parhaimpia ideoita 
	local t
	t=$(echo ${1} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)

	if [ -f ${t}/common_lib.sh ] ; then
		#onkohan tuossa tarkistuksessa pointtia?
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			#csleep 1
			${gg} --verify ${t}/common_lib.sh.sig 
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		fi

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t}
			dqb "TRO: running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s 3x3cutabl3 as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
		fi
		
		csleep 10
	fi

	csleep 1

	#090326:toimiiko toivotulla tavalla? toivottavasti nytq tr-kikkailut kOrjattu
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
		common_part ${srcfile} ${d} /
	;;
	#240536:jospa olisi tämä ja case 3 jo kunnossa
	#... tai sqrootissa oli menu- ja libw-pakettien asenynuksen kanssa pientä kiukuttelya, toistuuko?
	#... exp2 rp testiin?
	0) #240526:toisen oksan versiossa oli jotain kiukuttelua tässä
		e="/"
		[ ${mode} -eq 0 ] || e=${d}
		f=$(tar -tf ${srcfile} | grep '.tar' | head -n 1)
		f=$(dirname ${f})
		common_part ${srcfile} ${d} ${e}
		[ $? -eq 0 ] && ocs gpg
		
		[ $? -eq 0 ] && part3 ${f}
		[ $? -eq 0 ] && other_horrors
	;;
	3)
		#140526 muutettu paikallinen ocs että stoppaa tarv

		e=${d}
		common_part ${srcfile} ${d} ${e}
		ocs gpg
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

#poistelu ajank vain jos tehty lähteelle jotain sitä ennen? vissiin pitäisi jokin tarkistus lisätä (TODO)
if [ $? -eq 0 ] ; then
	if [ -s ${srcfile} ] ; then #riittävä tarq tapauksessa lähde==hakemisto?
		read -p " U  WANT 2 RM SOURCE ?" confirm
		[ "${confirm}" == "Y" ] && ${NKVD} ${srcfile}
	fi
fi

cptp2 ${d0}

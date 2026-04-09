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
		q=$(find . -name "dgsts.?" )
		cd ..

		#110326:jotain urputusta oli, mksums bugittaa
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

	for f in $(find ${d0} -type f -name "nekros?".tar.bz3 ) ; do
		tar -jxvf ${f}
		sleep 1
		rm ${f}
		sleep 1
	done

	#jos löytyy common_lib.sh.sig ni voiusi tässä tarkistaa?
	#... toisaalta vähän tuhra koska cptp23
	if [ ! -z "${g}" ] ; then
		if [ -s ${d0}/common_lib.sh.sig ] ; then
			${g} --verify ${d0}/common_lib.sh.sig
		fi
	fi

	unset g
fi

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
	[ $? -eq 0 ] || exit
else
	echo "W33P1NG UND3RR G4L4CTU5"
	sleep 13
	#TODO:"$0 1", varm että toimii silloinkin ku n common_lib ei ajokepl
	#(entä "-v" ?)

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

		#mkt=$(${odio} which mktemp) #onkohan import2:sessakaan tarpeellinen?
		scm=$(${odio} which chmod)
		sah6=$(${odio} which sha512sum)

		srat=$(${odio} which tar)
		#eXit jos srat ei?

		gg=$(${odio} which gpg)
	}

	function check_binaries2() {
		echo "irot.check2"
		srat="${odio} ${srat}"
	}

	function part3() {
		dqb "rot.part3 :NOT SUPPORTED"
	}

	function other_horrors() {
		dqb "R0TT1NG W4Y5 T0 M153RY"
	}

	#tarttisiko vielä jotain fktiota tähän? NKVD hos esittelisi ainakin
	#function ocs() {???}
	#function enforce_access() {???}

	#070426:jospa toimisi jnkin verran näinkin
	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
fi

#050426:tämänkin skriptin kanssa se debug-riippuvuus? common_lib saattaisi liittyä
#TODO:jos tekisi asialle jotain (part3)

dqb "rot:AFTR common_lib"
csleep 1
[ -z "${distro}" ] && exit 6 #vähempikin tarkistelu riittäisi?
csleep 1

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
	[ $? -eq 0 ] || exit
else
	echo $?
	echo "N 0 L1.B"
	csleep 1
fi

check_binaries ${d}
[ $? -eq 0 ] || exit 

check_binaries2
[ $? -eq 0 ] || exit
echo "CHEKCS Adn BALACNES"
sleep 1

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

echo "JUST BFR com-ort()";sleep 1
#HUOM.olisi hyväksi siivota aiemmat tar:it kummittelemasta, tapahtuu lopussa kysymyksen takana

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

		#TODO:tähän ehkäö jotain muutosta
		[ ${r} -eq 0 ] || exit ${r}
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

		dqb "#TODO:näille main mallia:import2.sh, common_lib.psqa(), common_pp3() ehkä"
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

function cptp2() {
	dqb "rot.c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 1

	#tr-kikkailu tässä ei niitä parhaimpia ideoita 
	local t
	t=$(echo ${1} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)

	if [ -f ${t}/common_lib.sh ] ; then
		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
			#csleep 1
			${gg} --verify ${t}/common_lib.sh.sig 
			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		fi

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access $(whoami) ${t} #${2} toka param turha?
			dqb "running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s t as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
		fi
	fi

	csleep 1

	#090326:toimiiko toivotulla tavalla? toivottavasti nytq tr-kikkailut kOrjattu
	if [ -d ${t} ] ; then
		dqb "HAIL UKK"

		${scm} 0755 ${t}
		${scm} 0555 ${t}/*.sh #jos sittenkin 0555?
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb

		csleep 1
	fi

	[ ${debug} -eq 1 ] && ls -las ${1}
	csleep 1
	dqb "ALL DONE"
}

case "${mode}" in
	1) #
		common_part ${srcfile} ${d} /
		csleep 1
	;; 
	3)  #0 poistettu 040426 (takaisin josqs vai rai rai?)

		e=${d}
		common_part ${srcfile} ${d} ${e}
		part3 ${d} #TODO:tämän toiminnan testailu uusiksi josqs
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

#poistelu ajank vain jos tehty lähteelle jotain sitä ennen?
if [ -s ${srcfile} ] ; then
	read -p " U  WANT 2 RM SOURCE ?" confirm
	[ "${confirm}" == "Y" ] && ${NKVD} ${srcfile}
fi

cptp2 ${d0}

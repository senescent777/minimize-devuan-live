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
if [ -f /.chroot ] ; then #vähän turha tarkistus koska y (tai siis)
	#280426:self_extracting_archive-kikkailu saattaa tehdä tämän if-blkin turhaksi jatkossa ( tai sitten ei)

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
	#DONE:tuohon alle tar -x:ään tämän import2.sh koskeva --exclude jos mahd?
	#... tosin profiilin importointi

	for f in $(find ${d0} -type f -name "nekros?".tar.bz3 ) ; do
		tar --exclude import2.sh -jxvf ${f}
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
fi

#TODO:se /e/resolv.conf-linkin katkeaminen taas, tee jotain
[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
csleep 5

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
	#[ $? -eq 0 ] || exit #tähänkö kosahtanut viime_aikoina?
else
	echo "W33P1NG UND3RR G4L4CTU5"
	sleep 6

	#cptp2 voisi lopuksi palauttaa x-oikeuden kirjastoon?
	#150426:toimii tämä haara
	#saattaa myös olla että kiukuttelu paikallistui erääseen modattuun desktop_live_kiekkoon 090426

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

	function check_binaries() {
		echo "rot.check1"

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

#echo "JUST BFR com-ort()";sleep 1
#HUOM.olisi hyväksi siivota aiemmat tar:it kummittelemasta, tapahtuu lopussa kysymyksen takana

function common_part() {
	dqb "rot.common_part ${1} , ${2} , ${3}"

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

	#VAIH:.sha.sig -> .sig jatkossa
	if [ -v gg ] && [ -s ${1}.sig ] ; then
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

		#tohtisiko joskus testata oikeasti tuota?
		[ ${r} -eq 0 ] || ${NKVD} ${1}*
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
			#sittenkin näin
			${NKVD} ${1}* 
			${NKVD} ${2}/*.deb
			${NKVD} ${2}/sha512sums*
			${NKVD} ${2}/*.tar*

			exit 33
			#160426:nuo loput dellimisen kohteet eivät niin mielekkäitä koska x .. tai siis
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
	#[ -z "${2}" ] && exit 98 truhra parm (110426)
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 1

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
			dqb "running changedns.sh maY be necessary now to fix some things"
		else
			dqb "n s 3x3cutabl3 as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
			csleep 10
		fi
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

#VAIH:mode 0 vähitellen takaisin , f.tar sijainnin selvittely olisi kiva tehdä seuraavaksi

case "${mode}" in
	1)
		common_part ${srcfile} ${d} /
	;; 
	0)
		e="/"
		[ ${mode} -eq 0 ] || e=${d}
		f=$(tar -tf ${srcfile} | grep '.tar' | head -n 1)
		f=$(dirname ${f})
		common_part ${srcfile} ${d} ${e}
		part3 ${f}
		other_horrors
	;;
	3)
		#TODO:mielellään suorituksen keskeytys aikaisessa vaiheessa mikäli gpg hankaa vastaan, erityisesti ennen lähteen hukkaamista
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
if [ -s ${srcfile} ] ; then #riittävä tarq tapauksessa lähde==hakemisto?
	read -p " U  WANT 2 RM SOURCE ?" confirm
	[ "${confirm}" == "Y" ] && ${NKVD} ${srcfile}
fi

cptp2 ${d0}

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

if [ $# -gt 0 ] ; then
	mode=${1}
	[ -f ${1} ] && exit 99
	[ "${2}" == "-v" ] || srcfile=${2}

	#parse_opts pitäisi
	if [ "${3}" == "-v" ] || [ "${4}" == "-v" ] ; then
		debug=1
	fi
fi

#TODO?:jos järjestelisi tämän kikkareen uudestaan sittenq sqroot-testit seur kerran tehty
#... JOKO JO 300236? eu uhan vielä (2426)
#... joutaisi koko roskan kirjoittamaan uusicksi fråm scratch mutta odotellessa jos latensseja pienemmäksi syystä ilman -v ei toimi mikään

#190326:alkaisikohan kohta asettua parsetus?  (liittyyköhän tables/gpg asiaan?)
#180326:liittyyköhän check_bin():in "ocs ipt" tuohon viimeaikaiseen kiukutteluun?

function parse_opts_1() {
	dqb "parse_opts_1( ${1} )"

#	#sisäkkäiset if-lauseet pystyisi ehkä purkamaan
#	if [ "${mode}" == "-2" ] ; then
#		mode=${1}
#	else
#		if [ "${1}" == "-v" ] ; then
#			debug=1
#		else
#		#	if [ -d ${d0}/${1} ] ; then
#		#		#distro=${1} #090326:kuinkahan oleellinen distron yliajo?
#		#		d=${d0}/${distro}
#		#	else
#				srcfile=${1}
#		#	fi
#		fi
#	fi
}

function parse_opts_2() {
	dqb "imp2.parseopts_2 ${1} ${2}"
}


dqb "SHOULD gg --veridy ${d0}/common_lib.sh HERE, MAYBE"
csleep 1

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	#190326:vissiin tämän haaran kanssa jutut toimivat jnkn verran ja thats it
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

	#debug=1
	dqb "FALLBACK"
	sleep 5

#	if [ -f /.chroot ] ; then
#		odio=""
#	else
#		#chroot-ynmp tulee nalqtusta tästä?
		odio=$(which sudo)
#	fi

	#"tar -cvf OLD.tar"-syystä ei tätä tekstiä huomaa	
	echo "MAYBE U SHOULD chmod a+x ${d0}/common_lib.sh"
	sleep 5

	function check_binaries() {
		dqb "imp2.check1"

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
		echo "imp2.check2"
	
		som="${odio} ${som}"
		uom="${odio} ${uom}"
		srat="${odio} ${srat}"
	}

	function part3() {
		dqb "imp2.part3 :NOT SUPPORTED"
		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount?
	}

	function other_horrors() {
		dqb "AZATH0TH AND OTHER H0RR0RR55.6"
	}

	function ocs() {
		echo "======IPM2.=OCS( ${1} )="
		which ${1}
		echo "==================="
	}

	#barm vuokxi
	function enforce_access() {
		dqb "imp2.3nf :NOT SUPPORTED"
	}

	#TODO:barm vuoksi pitäisi kai käskyttää parse_opts_fktioita siltä varalta että parsetuksen saakin sitä kautta toimimaan
	dqb "SHOULD CALL parse_opts_x() AROUND HERE"
fi

dqb "imp2:AFTR common_lib"
csleep 1
[ -z "${distro}" ] && exit 6
csleep 1

if [ -x ${mkt} ] ; then
	dqb "ipm2.MTK"
else
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

echo "in case of trouble, \"chmod a-x common_lib.sh\" or \"chmod a-x \${distro}/lib.sh\" may help"
csleep 1
#HUOM. tähän ei "process_lib ${d}" , mennään tarkoituksella toisella tavalla (ainakin jnkin aikaa)

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else	
	echo $?
	dqb "N 0 L1.B"
	csleep 1
fi

check_binaries ${d}
[ $? -eq 0 ] || exit 

check_binaries2
[ $? -eq 0 ] || exit

#-x sifd - testi olisi myös idea
[ -v CONF_iface ] && ${sifd} ${CONF_iface}

[ -v mkt ] || exit 7
[ -z "${mkt}" ] && exit 9
echo "mkt= ${mkt} "

[ -v srat ] || exit 8
[ -z "${srat}" ] && exit 10

olddir=$(pwd)
part=/dev/disk/by-uuid/${CONF_part0}
dqb "L0G"

ocs tar
dqb "srat: ${srat}"
csleep 1
dqb "LHP"

#josko tilansäästön nimissä kolmaskin ehto? tai ehkä ei pakko
if [ -s /OLD.tar ] ; then
	dqb "OLD.tar OK"
else
	dqb "SHOULD MAKE A BACKUP OF /etc,/sbin,/home/stubby AND  ~/Desktop ,  AROUND HERE "
	csleep 1
	${srat} -cf /OLD.tar /etc /sbin /home/stubby ~/Desktop
fi

dqb "ip2.m.Lpg"

function common_part() {
	dqb "common_part ${1} , ${2} , ${3}"

	[ -z "${1}" ] && exit 1 #pitäisi kai keskEyttää suoritus aiemmin tässä tap
	[ -s ${1} ] || exit 2
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}"  ] && exit 11
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 44

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

	#$d alta tar-juttuja pois tässä? ehkä ei aina kannata
	#csleep 1
	#251225:mitä jos sen sisemmän sha-tarkistuksen tekisi silloinq common_lib pois pelistä?
	
	csleep 1
	dqb "${srat} DONE"
}

function cptp2() {
	dqb "c tp2 ${1}, ${2}, ${3}"

	[ -z "${1}" ] && echo 99
	[ -z "${2}" ] && echo 98
	[ -d ${1} ] || exit 97

	dqb "cptp2:pars ok"
	csleep 1

	#tr-kikkailu tässä ei niitä parhaimpia ideoita 
	local t
	t=$(echo ${1} | cut -d '/' -f 1-5 | tr -d -c 0-9a-zA-Z/.)
	
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
		${scm} 0555 ${t}/*.sh
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb

		csleep 1
	fi

	[ ${debug} -eq 1 ] && ls -las ${1}
	csleep 1
	dqb "ALL DONE"
}

dqb "HPL"
#TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)
#olisi kai hyväksi selvittää missä kosahtaa kun common_lib pois pelistä (${CONF_default_archive3} siis)

#160326:toimiiko edelleen? "$0 q"-reittiä ainakin
function tpr() {
	dqb "UPIR ) ${1} , ${2} , ${3} ("
	csleep 1

	[ -z "${1}" ] && exit 8
	[ -z "${2}" ] && exit 9
	[ -z "${3}" ] && exit 10
	[ -d ${1} ] || exit 11

	[ -f ${1}/${2} ] || exit 12
	[ -s ${1}/${2} ] || exit 13
	[ -r ${1}/${2} ] || exit 14

	[ -f ${1}/${3} ] || exit 15
	[ -s ${1}/${3} ] || exit 16

	if [ ! -x ${1}/${3} ] ; then
		dqb "CANNOT INCLUDE PROFS.HS 0 R WHÅTEVER"
		dqb "$0 1 \$srcfile | chmod +x ${3} ?"
		exit 17
	fi

	dqb "tpr.pars_ok"
	csleep 1

	#fktioiden {im,ex}portointia jos kokeilisi? man bash...
	. ${1}/${3}
	[ $? -gt 0 ] && exit 19

	dqb "INCLUDE OK"
	#csleep 1

	local q
	local r
	q=$(mktemp -d)
	[ $? -gt 0 ] && exit 20

	dqb "JUST BEFORE TAR ${1}/${2}"
	#jos vielä härdelliä niin keskeytetään mikäli ei $2:sta löydä prefs.js?
	r=$(${srat} -tf ${1}/${2} | grep prefs.js | wc -l) #vielä jos arhc_4 ?
	[ ${r} -gt 0 ] || exit 21
	csleep 1

	${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/${2}
	[ $? -gt 0 ] && exit 22
	csleep 1

	dqb "JUST BEFORE impo_prof"
	csleep 1

	imp_prof esr $(whoami) ${q}
	dqb $?
	csleep 1

	dqb "UP1R D0N3"
	csleep 1
}

#261125:eka case-blokki toimii
#HUOM.110326:voisi olla tämä case nnen common_lib ... paitsi että conf
#... ehkä voisi cpy-pastettaa sen konftdston etsinnän

#sqrot ei tarvitse tätä blokkia (pl. ehkä -h) 
#HUOM.060426:tämä case-esac voisi toimia ilmankin kirjastoa, qhan vain konftdsto löytyy
case "${mode}" in
	-1) 
		# "$0 -1 -v" , miten toimii?
		part=/dev/disk/by-uuid/${CONF_part0}
		[ -b ${part} ] || dqb "no such thing as ${part}"
		c=$(grep -c ${CONF_dir} /proc/mounts)

		if [ ${c} -lt 1 ] ; then
			${som} -o ro ${part} ${CONF_dir}
			csleep 1
			${som} | grep ${CONF_dir}
		fi

		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] unpack AND install | $0 1 <source> just unpacks the archive | $0 3 ..."
		#mode=-3
		#remember:to_umount olisi hyvä muistuttaa kuitenkin
	;;
	2)
		#081225:toimiiko oikein kun "$0 2 -v" ?
		dqb "T=-1 K (Eugen K.)"
		csleep 1

		${uom} ${CONF_dir}
		csleep 1
		${som} | grep ${CONF_dir}

		[ $? -eq 0 ] && echo "NEXT:  \${distro}/doIt6.sh maybe | sleep \$delay;ifup \$iface;changedns if necessary"
		#mode=-3
	;;
	-h)
		usage
		#mode=-3
		exit
	;;
esac

dqb "debug: 1"
echo "mode: ${mode} "
echo "srcfile: ${srcfile} "
[ -z "${srcfile}" ] && exit 44

if [ -s ${srcfile} ] || [ -d ${srcfile} ] ; then #eka tark oli -s , vissiin oltava taas
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	dqb "SD"
else
	#220326:myös sqroot-ymp tähän jouduttu, syy muu kuin ilmeinen?
	#010426:exitin ohitus jos ollaan sqrootissa?
	
	[ -d ${srcfile} ] || dqb "NOT A DIR"
	[ -f ${srcfile} ] || dqb "NOT A FILE"
	dqb "SMTHING WRONG WITH ${srcfile} "
	exit 55
fi

#[ -s ${srcfile} ] || exit 34 #pitäIsikö olla if-blokin sisällä?
[ -r ${srcfile} ] || exit 35

if [ "${mode}" == "-3" ] || [ "${mode}" == "r" ] ; then
	dqb "asia kunnossa"
else
	read -p "U R ABT TO INSTALL ${srcfile} , SURE ABOUT THAT?" confirm
	[ "${confirm}" == "Y" ] || exit 33
fi

#140326:toimiikohan nuo debug-hommat kuten tarkoitus?
dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "srcfile=${srcfile}"
csleep 1

case "${mode}" in
	1) #140326:taitaa toimia
		common_part ${srcfile} ${d} /
		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
		csleep 1
	;; 
#	0|3) #EI POINTTIA TÄSSÄ ENNENQ PARSETUS KORJATTU
#		#090126:case 0 toiminee, säilytetään koska exp2 muutokset
#		#110326:toimii edelleen mod pientä kiukuttelua josqs
#		#160326:sama, kiukuttelulle voisi tosin tehdä jotain
#		#190326:onnistui sqrootin alaisuudessa paketteja asennella
#		
#		#010426:edelleen osasi sqrtot alla
#		#... kiukuttelut sqrot alla liittyvät enemmän wdm-pakettiin kuin itse skriptiin?
#		#sha512sums.txt.bak suattaapi liittyä vua n suattaapi ettei
#	
#		
#		#myös "libc6:amd64 depends on libgcc-s1; however:" joutaisi tehdä jotain?
#		
#		echo "ZER0 S0UND"
#		csleep 1
#		dqb " ${3} ${distro} MN"
#		csleep 1
#		e="/"
#
#		#if [ -f /.chroot ] ; then
#			if [ ${1} -eq 0 ] ; then
#				#mitense alt_root? ensisijaisesti sitä pakettien "uutta" asennustapaa vartebn
#				#... siinä piti vielä prujata se hmistorakanne ainakin
#
#				tar -tf ${srcfile} | grep f.tar | head -n 1
#				echo "... SHOULD BE MOVED UNDER ${d} , AFTER THAT:RUN $0 3 ${d}/f.tar"
#				exit 99
#			fi
#		#fi
#
#		[ ${1} -eq 0 ] || e=${d}
#		csleep 1
#		common_part ${srcfile} ${d} ${e}
#
#		csleep 1
#		dqb "c_p_d0n3, NEXT: pp3"
#		csleep 1
#
#		part3 ${d}
#		other_horrors
#
#		csleep 1
#		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
#	;;
	r) #160326:ehkä tämä jo toimii
	#sqrot ei tarvitse tätä casea, kai
		[ -d ${srcfile} ] || exit 23
		[ -v CONF_default_arhcive ] || exit 24
 		[ -v CONF_default_arhcive2 ] || exit 25
		[ -v CONF_default_arhcive3 ]  || exit 18

		${sr0} -C ~ -jxf ~/${CONF_default_arhcive2}
		echo $?
		csleep 2

		tpr ${srcfile} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
	q)
		#160326:toimi
	#sqrot ei tarvitse tätä casea, kai
		# (turha case oikeastaan koska "$0 1"+"$0 r"
		#btw. ffox 147-jutut enemmän ${CONF_default_archive3}:n heiniä

		[ -v CONF_default_arhcive ] || exit 24
 		[ -v CONF_default_arhcive2 ] || exit 25
		[ -v CONF_default_arhcive3 ]  || exit 18

		#HUOM.110326:olisi parempi , varm. buoksi delliä tai nimetä uudetsaan aiemmatr default_arch ja default_arch2

		c=$(${srat} -tf ${srcfile} | grep ${CONF_default_arhcive} | wc -l)
		[ ${c} -gt 0 ] || exit 27
		common_part ${srcfile} ${d} /

		${sr0} -C ~ -jxf ~/${CONF_default_arhcive2}
		tpr ${d0} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
#	k)
#		#161225:toimii, sq-root-ymp ainakin
#		#HUOM. TÄMÄ MUISTETTAVA AJAA JOS HALUAA ALLEKIRJOITUKSET TARKISTAA
#
#
#		[ -d ${srcfile} ] || exit 22
#		dqb "KLM"
#		#avaInten allekirjoittamiseen oli muuten omakin optio (gpg --edit-key ? letd find out?)
#
#		if [ -v gg ] ; then
#			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
#				dqb "NOP"
#				csleep 1
#
#				#for f in $(fnid $srcfile -type f -name '*.sig') ; do
#				#	g=$(echo $f | cut -d . -f 1,2)
#				#	check=$(smthing)
#				#	[ $check ] && gg --import $g
#				#	rm $g	
#				#done
#
#				dqb "${gg} --import ${srcfile}/*.gpg soon"
#				csleep 1
#
#				${gg} --import ${srcfile}/*.gpg
#				csleep 1
#
#				[ ${debug} -eq 1 ] && ${gg} --list-keys
#				csleep 2
#			fi
#		else
#			dqb "NO-GO-THEOREM"
#		fi
#	;;
	-3)
		dqb "do_Nothing()"
	;;
	*)
		echo "-h"
	;;
esac

cptp2 ${d} ${CONF_iface} #toka param turha?
cd ${olddir}
#ettei umount unohdu 

if [ -v part ] || [ -v CONF_dir ] ; then
	echo "REMEMBER 2 UNM0UNT TH3S3:"
	[ -z ${part} ] || grep ${part} /proc/mounts #greppaus voi jäädä junnaamaan?
	[ -z ${CONF_dir} ] || grep ${CONF_dir} /proc/mounts
fi

${scm} 0555 $0
#HUOM.290925: tämän skriptin pitäisi kuvakkeen kanssa löytyä filesystem.squashfs sisältä (no löytyykö?)

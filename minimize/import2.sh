#!/bin/bash
debug=0
srcfile=""

distro=$(cat /etc/devuan_version)
dir=/mnt
part0=ABCD-1234
mode=-2
d0=$(pwd)
[ z"${distro}" == "z" ] && exit 6
d=${d0}/${distro}

#HUOM.121225:edelleenkin wanha reject_pkgs jyrää uuden, voisiko jtain tehdä?

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "${0} <mode> <srcfile> [distro] [debug] "
	echo "when mode=k , this imports PUBLIC_KEYS , u have to import private keys another way!!!"
	echo "\t also in that case, srcfile=the_dir_that_contains_some_named_keys"
}

if [ $# -gt 0 ] ; then
	mode=${1}
	[ -f ${1} ] && exit 99
	srcfile=${2}
fi

function parse_opts_1() {
	if [ -d ${d0}/${1} ] ; then
		distro=${1}
		d=${d0}/${distro}
	fi

}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

if [ -f /.chroot ] ; then
	echo "UNDER THE GRAV3YARD"
	sleep 1

	#HUOM.141025:them files should be checked before eXtraCting
	for f in $(find ${d0} -type f -name 'nekros?'.tar.bz3) ; do
		tar -jxvf ${f}
		sleep 1
		rm ${f}
		sleep 1
	done
fi

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	sleep 2
	. ${d0}/$(whoami).conf
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
	 	exit 57
	fi	
fi

#VAIH:testaa yhdistelmä live-ymp+common_lib pois pelistä 
#aloiteltu 121225 "$0 k" , toiminee 
#seur "$0 1" (päivityspak?) sen kanssa pientä laittoa vielä (josko jo)
#-1 ja 2 OK
#... siinä ne oleellisimmat tapaukset

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
else
	debug=1
	dqb "FALLBACK"

	#nbämä 2 juuri ennen part3(), mjien alustuksen jälkeen?
	function check_binaries() {
		dqb "imp2.check1"
	}

	function check_binaries2() {
		dqb "imp2.check2"
	}

	if [ -f /.chroot ] ; then
		odio=""
	else
		#chroot-ynmp tulee nalqtusta tästä
		odio=$(which sudo)
	fi

	mkt=$(which mktemp)
	scm="${odio} /bin/chmod" #which chmod jatkossa?
	sah6=$(${odio} which sha512sum)
	srat=$(${odio} which tar)
	gg=$(${odio} which gpg)
	som=$(${odio} which mount)
	uom=$(${odio} which umount)

	#VAIH:jatkossa odion:n ymppääminen mkt-uom tähän , paikallisten check_bin() - fktioiden kautta?
	#... se sqr00t-ymp myls testattava sen jälkeen että miten toimii siellä
	som="${odio} ${som}"
	uom="${odio} ${uom}"
	srat="${odio} ${srat}"

	function part3() {
		dqb "imp2.part3 :NOT SUPPORTED"
		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount
	}

	function other_horrors() {
		dqb "AZATH0TH AND OTHER H0RR0RR55.6"
	}

	function ocs() {
		dqb "=======OCS( ${1} )="
		which ${1}
		dqb "==================="
	}
fi

[ -z ${distro} ] && exit 6
[ -v mkt ] || exit 7
[ -z "${mkt}" ] && exit 9
echo "mkt= ${mkt} "
csleep 2

if [ -f /.chroot ] || [ -x ${mkt} ] ; then
	dqb "MTK"
else
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

echo "in case of trouble, \"chmod a-x common_lib.sh\" or \"chmod a-x \${distro}/lib.sh\" may help"
#121225:ulompi gpg-tarkistus sujuu jo live-ymp, miten sisempi? tehdäänkö sitä? nykyään joo
#111225.2,:live-ymp ja ffox-prof exp/imp, toimiiko? jep

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo $?
	dqb "NO LIB"
	csleep 1

	#TODO:exit jos ongelmia ao. juttujen kanssa
	check_binaries
	check_binaries2
fi

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}
dqb "L0G"

ocs tar
dqb "srat= ${srat}"
csleep 1
dqb "LHP"

if [ -f /.chroot ] || [ -s /OLD.tar ] ; then
	dqb "OLD.tar OK"
else
	dqb "SHOULD MAKE A BACKUP OF /etc,/sbin,/home/stubby AND  ~/Desktop ,  AROUND HERE"
fi

function common_part() {
	dqb "common_part ${1}, ${2}, ${3}"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 2
	[ -r ${1} ] || exit 3
	[ -z "${3}" ] && exit 4

	[ -z "${2}"  ] && exit 11
	[ -d ${2} ] || exit 22
	[ -d ${3} ] || exit 33

	dqb "paramz_0k"
	csleep 1
	cd /

#	local r
#	r=10
#
	#VAIH:näille main urputusta jos ei .sig tarkistus onnistu (jtnkn toisin kuitenkin)
	if [ -v gg ] && [ -s ${1}.sha.sig ] ; then
		dqb "A"

		if [ ! -z ${gg} ] ; then #sen array:n olamessaolon testi tähän?
			dqb "B"

			if [ -x ${gg} ] ; then
				dqb "C"

				dqb " ${gg} --verify ${1}.sha.sig "
				${gg} --verify ${1}.sha.sig
				r=$?
			fi
		fi
	fi

#	[ ${r} -eq 0 ] || exit ${r}
	csleep 3

	#kts. common_lib.psqa()
	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"
		dqb "gg= ${gg}"

		cat ${1}.sha
		${sah6} ${1}
		csleep 2
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	csleep 2
	dqb "NECKST: ${srat} ${TARGET_TPX} -C ${3} -xf ${1}"
	csleep 2

	${srat} ${TARGET_TPX} -C ${3} -xf ${1}
	[ $? -eq 0 ] || exit 36

	csleep 1
	dqb "${srat} DONE"
	local t
	t=$(echo ${2} | cut -d '/' -f 1-5)

	if [ -x ${t}/common_lib.sh ] ; then
		enforce_access ${n} ${t} 
		dqb "running changedns.sh maY be necessary now to fix some things"
	else
		dqb "n s t as ${t}/common_lib.sh "
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

	[ ${debug} -eq 1 ] && ls -las ${2}
	csleep 1
	dqb "ALL DONE"
}

##TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)
##13122:profiiliasiat jko/tsaa kunnossa? muuten kai mutta sen paketin kanssa jotain (VAIH)
function tpr() {
	dqb "UPIR  ${1}"
	csleep 1

	[ -z ${1} ] && exit 11
	[ -d ${1} ] || exit 12
	[ -s ${1}/fediverse.tar ] || exit 13
	[ -r ${1}/fediverse.tar ] || exit 14

	dqb "pars_ok"
	csleep 1

	if [ ! -x ${1}/profs.sh ] ; then
		dqb "CANNOT INCLUDE PROFS.HS"
		dqb "$0 1 \$srcfile | chmod +x profs.sh ?"
		exit 25
	fi

	#fktioiden {im,ex}portointia jos kokeilisi? man bash...
	. ${1}/profs.sh
	[ $? -gt 0 ] && exit 33

	dqb "INCLUDE OK"
	csleep 1
	local q
	q=$(mktemp -d)

	#jos vielä härdelliä niin keskeytetään jos ei fediversestä löydä prefs.js
	${srat} -tf ${1}/fediverse.tar
	csleep 10
	${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/fediverse.tar


	imp_prof esr ${n} ${q}

	dqb "UP1R D0N3"
	csleep 1
}

#261125:eka case-blokki toimii
case "${mode}" in
	-1) 
		# "$0 -1 -v" , miten toimii?
		part=/dev/disk/by-uuid/${part0}
		[ -b ${part} ] || dqb "no such thing as ${part}"
		c=$(grep -c ${dir} /proc/mounts)

		if [ ${c} -lt 1 ] ; then
			${som} -o ro ${part} ${dir}
			csleep 1
			${som} | grep ${dir}
		fi

		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] unpack AND install | $0 1 <source> just unpacks the archive | $0 3 ..."
		#mode=-3
		#remember:to_umount olisi hyvä muistuttaa kuitenkin
	;;
	2)
		#081225:toimiiko oikein kun "$0 2 -v" ?
		dqb "T=-1 K (Eugen K.)"
		csleep 1

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
csleep 1

case "${mode}" in
	r) #141225:testattava taas
		[ -d ${srcfile} ] || exit 22
		${srat} -C ~ -jxf ~/config.tar.bz2
		tpr ${srcfile}
	;;
	1) #121225;testailtru, vissiin toimii
		common_part ${srcfile} ${d} /
		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
		csleep 1
	;; 
	0|3) #121225:case 3 toimii edelleen, luulisin
		#111225 luotu päivitytspak sössi taas slim:in (havaittu 131225)
		#TODO:selvitä, toimiiko case 0? jnpp

		echo "ZER0 S0UND"
		csleep 1
		dqb " ${3} ${distro} MN"
		csleep 1

		if [ ${1} -eq 0 ] ; then
			dqb "DEPRECATED"
			csleep 10
			common_part ${srcfile} ${d} /
		else
			common_part ${srcfile} ${d} ${d}
		fi

		csleep 1
		dqb "c_p_d0n3, NEXT: pp3"
		csleep 1

		part3 ${d}
		other_horrors

		csleep 1
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	q)
		#141225:josko taas toimisi?
		#btw. ffox 147-jutut enemmän profs.sh:n heiniä

		c=$(${srat} -tf ${srcfile} | grep fediverse.tar  | wc -l)
		[ ${c} -gt 0 ] || exit 77
		common_part ${srcfile} ${d} /

		#kai tuo ocnfig voisi suoraan $d0 alla...
		${srat} -C ~ -jxf ~/config.tar.bz2
		tpr ${d0}
	;;
	k)
		#HUOM. TÄMÄ MUISTETTAVA AJAA JOS HALUAA ALLEKIRJOITUKSET TARKISTAA
		dqb "# . \ import2.sh k \ pad -v"

		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		ridk=${srcfile}

		if [ -v gg ] && [ -v TARGET_Dkarray ] ; then
			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then #menisikö näin
				dqb "NOP"

				#TODO:jatkossa jos julkisilla avaimilla olisi jokin pääte
				for k in ${TARGET_Dkarray} ; do
					dqb "dbg: ${gg} --import ${ridk}/${k}"
					${gg} --import ${ridk}/${k}
				done

				[ ${debug} -eq 1 ] && ${gg} --list-keys
				csleep 3
			fi
		else
			dqb "NO-GO-.THEOREM"
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
#HUOM.290925: tämän skriptin pitäisi kuvakkeen kanssa löytyä filesystem.squashfs sisältä (no löytyykö?)

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
	srcfile=${2}
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

	#HUOM.141025:them files should be checked before eztraxting
	for f in $(find ${d0} -type f -name 'nekros?'.tar.bz3) ; do
		tar -jxvf ${f}
		sleep 1
		
		rm ${f}
		sleep 1
	done
fi

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	sleep 5
	. ${d0}/$(whoami).conf
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
	 	exit 57
	fi	
fi

#TODO:testaa yhdistelmä live-ymp+common_lib pois pelistä
if [ -x ${d0}/common_lib.sh ] ; then #VAIH:jatkosäädöt jos niin että ensiksi takaisin pelitttämään sq-chrootin kanssa (tai imp2 k chr EIKU)
	. ${d0}/common_lib.sh
else
	debug=1
	dqb "FALLBACK"

	mkt=$(which mktemp)

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

	scm="${odio} /bin/chmod"
	sah6=$(${odio} which sha512sum)
	srat=$(${odio} which tar) #"/bin/tar"
	gg=$(${odio} which gpg)

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
csleep 6

if [ -f /.chroot ] || [ -x ${mkt} ] ; then
	dqb "MTK"
else
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

#291125:josko toimisi sq-chroot-ympoäristössä, sen ulkpuolella:vissiin
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

	#kts. common_lib.psqa()
	if [ -s ${1}.sha ] ; then
		dqb "KHAZAD-DUM"

		cat ${1}.sha
		${sah6} ${1}
		csleep 3

		#291125:testaus sq-chroot-ymp onnistui ainakin kerran
		if [ -v gg ] && [ -s ${1}.sha.sig ] ; then
			if [ ! -z ${gg} ] ; then
				if [ -x ${gg} ] ; then
					dqb " ${gg} --verify ${1}.sha.sig "
					${gg} --verify ${1}.sha.sig
				fi
			fi
		fi
	else
		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
	fi

	csleep 3
	dqb "NECKST: ${srat} ${TARGET_TPX} -C ${3} -xf ${1}"
	csleep 3

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

	csleep 2
	
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

#TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)
#301125:live-ympäristössä toimi, aiemmin oli chroot:in alla kiukuttelua
function tpr() {
	dqb "UPIR  ${1}"
	csleep 1

	[ -z ${1} ] && exit 11
	[ -d ${1} ] || exit 12

	dqb "pars_ok"
	csleep 1

	#csleep 2

	local t
	for t in ${1}/config.tar.bz2 ~/config.tar.bz2 ; do ${srat} ${TARGET_TPX} -C ~ -xvf ${t} ; done
	[ $? -eq 0 ] || exit

	dqb "PROFS?"
	csleep 1

	if [ -x ${1}/profs.sh ] ; then
		#fktioiden {imp,exp}ortointia jos kokeilisi? man bash...
		. ${1}/profs.sh
		[ $? -gt 0 ] && exit 33
			
		dqb "INCLUDE OK"
		csleep 1
		local q
		q=$(mktemp -d)

		#jatkossa kutsuvaan koodiin tämä if-blokki? mitenkä että?
		if [ -s ~/fediverse.tar ] ; then
			${srat} ${TARGET_TPX} -C ${q} -xvf ~/fediverse.tar
		else
			${srat} ${TARGET_TPX} -C ${q} -xvf ${1}/fediverse.tar
		fi

		imp_prof esr ${n} ${q}
	else
		dqb "CANNOT INCLUDE PROFS.HS"
		dqb "$0 1 \$srcfile ?"
	fi

	dqb "UP1R D0N3"
	csleep 1
}

#261125:eka case-blokki toimii
case "${mode}" in
	-1) 
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
		#remember:to_umount olisi hyvä muistuttaa kyitenkin
	;;
	2)
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
csleep 3

case "${mode}" in
	r) #291125:toimii, ainakin g_doit kautta mentynä
		[ -d ${srcfile} ] || exit 22
		tpr ${srcfile}
	;;
	1) # toimi 261125 (testaapa uudestaan, TODO)
		common_part ${srcfile} ${d} /
		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
		csleep 1
	;; 
	0|3) #291125:case 3 toimii jo sq-chr-ynp kanssa, luulisin että live-ymp myös
		#TODO:selvitä, toimiiko case 0? jnpp
		#011225 oli kiukuttelua sq-chr-ymp, kts toistuuko

		echo "ZER0 S0UND"
		csleep 1
		dqb " ${3} ${distro} MN"
		csleep 1

		#281125:s:n ja t:n kanssa riittää kusta ja paskaa ainakin sq-chroot-ympäristössä
		if [ ${1} -eq 0 ] ; then
			dqb "DEPRECATED"
			csleep 10
			common_part ${srcfile} ${d} /
		else
			common_part ${srcfile} ${d} ${d}
		fi

		csleep 1
		#HUOM.291125:tässä oli blokki (kommentoitu)
		
		csleep 5
		dqb "c_p_d0n3, NEXT: pp3"
		csleep 1	

		part3 ${d}
		other_horrors

		csleep 1
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	q)
		#291125:testattu alustavasti sq-chr-ympäristössä missä kiukutelua
		#291125.2:klytyi tikulta paketti testausta varten, sen kanssa toimi tämä case
		#301125:live-ympäristössä testaus, taitaa toimia		

		#btw. ffox 147-jutut enemmän profs.sh:n heiniä

		c=$(${srat} -tf ${srcfile} | grep fediverse.tar  | wc -l)
		[ ${c} -gt 0 ] || exit 77
		common_part ${srcfile} ${d} /
		tpr ${d0}
	;;
	k)
		#291125:toimii sq-chroot alla (VAIH:testaa live-ymp kanssa, toimii qhan conf)
		dqb "# . / import2.sh k / pad -v"

		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		ridk=${srcfile}

		if [ ! -z ${gg} ] ; then #-v vielä?
			if [ -x ${gg} ] ; then
				dqb "NOP"
				karray="${TARGET_Dkname1} ${TARGET_Dkname2}" #TODO:jatkossa ihan konftdstoon tämä
			
				for k in ${karray} ; do
					dqb "dbg: ${gg} --import ${ridk}/${k}"
					${gg} --import ${ridk}/${k}
				done

				[ ${debug} -eq 1 ] && ${gg} --list-keys
				csleep 5
			fi
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
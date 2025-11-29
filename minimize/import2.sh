#!/bin/bash
debug=0 #1
srcfile=""

distro=$(cat /etc/devuan_version)
dir=/mnt
part0=ABCD-1234
mode=-2
d0=$(pwd)
[ z"${distro}" == "z" ] && exit 6
d=${d0}/${distro}

#HUOM.30925:jospa ei pilkkoisi tätä tdstoa ainakaan ihan vielä

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function usage() {
	echo "${0} <mode> <srcfile> [distro] [debug] "
}

if [ $# -gt 0 ] ; then
	mode=${1}
	srcfile=${2}
fi

#HUOM.041025:debug-riippuvaisen käytöksen syy löytynee tästä fktiosta, ehkä
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

	#HUOM.141025:files should be checked bedore eztraxting
	for f in $(find ${d0} -type f -name 'nekros?'. .bz3) ; do
		#TODO:tähän jotain

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

if [ -x ${d0}/common_lib.sh ] ; then #TODO:jatkosäädöt jos niin että ensiksi takaisin pelitttämään sq-chrootin kanssa
	. ${d0}/common_lib.sh
else
	debug=1
	dqb "FALLBACK"
	#TODO:tähän jotain
fi

[ -z ${distro} ] && exit 6
[ -v mkt ] || exit 7
[ -z "${mkt}" ] && exit 9
echo "mkt= ${mkt} "
sleep 6

#deMorgan
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

	#281125:uskaltaako poistaa vai ei?
	function pr4() {
		dqb "imp2.pr4 \${1}" 
	}

	check_binaries ${d}
	echo $?
	[ $? -eq 0 ] || exit 7
	csleep 1

	check_binaries2
	[ $? -eq 0 ] || exit 8
	csleep 1
fi

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}


dqb "LHP"

#deMOrgan
if [ -f /.chroot ] || [ -s  ] ; then
	dqb "OLD. OK"
else
	#jotain exclude-juttuja voisi olla sikäli mikäli tuota oikeasti johonkin
	#271125:oli jotain urputusta, korjaa jos mahd 
	#281125:qseeko else-haarassa jokin?

	#TODO:jotain tähän
fi

#import2 vs g_doit , mikä ero?

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
	#TODO:tähän jotain
	csleep 3

	#TODO:tähän jotain

	[ $? -eq 0 ] || exit 36

	csleep 1

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
		${scm} 0555 ${t}/*.sh #aiemmin a+x
		${scm} 0444 ${t}/conf*
		${scm} 0444 ${t}/*.deb

		csleep 1
	fi

	[ ${debug} -eq 1 ] && ls -las ${2}
	csleep 1
	dqb "ALL DONE"
}

#TODO:ffox 147 (oikeastaan profs tulisi muuttaa tuohon liittyen)
function tpr() {
	dqb "UPIR  ${1}" #tulisi kai olla vain 1 param tälle fktiolle
	csleep 1

	[ -z ${1} ] && exit 11
	[ -d ${1} ] || exit 12

	dqb "pars_ok"
	csleep 1

	
	csleep 2

	local t
	#TODO:tähän jotain
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

		#jatkossa kutsuvaan koodiin tämä if-blokki?
		#TODO:tähän jotain

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
		#mode=-3 #remember:to_umount olisi hyvä muistuttaa kyitenkin
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
csleep 6

case "${mode}" in
	r) # toimii (261125)
	#kutsutaan muuten g_doit kautta
		[ -d ${srcfile} ] || exit 22
		tpr ${srcfile}
	;;
	1) # toimii (261125)
		common_part ${srcfile} ${d} /
		[ $? -eq 0 ] && echo "NEXT: $0 2 ?"
		csleep 1
	;; 
	#uusi case, vähän niinqu case 0 ja 3 yhdistettynä (tai jos erilliset import3 ja export3?)
	#... vaiko "imp2 0" purkamaan mitä "exp2 0" pakkaa? arpoo arpoo
	0|3) #261125:toimii, case 3 nimittäin
		#TODO:selvitä, toimiiko case 0? jnpp
		echo "ZER0 S0UND"
		csleep 1
		dqb " ${3} ${distro} MN" #mikä pointti?
		csleep 1

		#281125:s:n ja t:n kanssa riittää kusta ja paskaa ainakin sq-chroot-ympäristössä
		if [ ${1} -eq 0 ] ; then
			common_part ${srcfile} ${d} / #voi tietystI mennä mettään tuon $d/common_lib kanssa?
			#281125:tässä ne lisäricir kusivat asioita?
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

		#HUOM.231125:kutsutaan e_a() uudestaan jotta päivityspaketti ei rikkoisi:slim (tosin syy jossain muualla)
	#TODO:TOINEN e_a() POIS?
		t=$(echo ${d} | cut -d '/' -f 1-5)
		${scm} 0555 ${t}/common_lib.sh #251125:uutena tämä		

		if [ -x ${t}/common_lib.sh ] ; then
			enforce_access ${n} ${t}
		else
			echo "N0 SUCH TH1NG AS  ${t}/common_lib.sh "
		fi
		#

		csleep 1
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	q) 
		#testattu viimeksi 271125:toimi silloin
		#btw. ffox 147-jutut enemmän profs.sh:n heiniä

		#TODO:rässä oli jotain
		[ ${c} -gt 0 ] || exit 77
		common_part ${srcfile} ${d} /
		tpr ${d0}
	;;
	k)	#291125:taisi toimia tuo importointi ainakin kerran sq-chroot-ympäristössä 
		[ -d ${srcfile} ] || exit 22
		dqb "KLM"
		ridk=${srcfile}

		if [ -x ${gg} ] && [ -v ] && [ -v  ] ; then #TODO:ehtoihin /.chroot vielä?
			dqb "NOP"
		
			for f in  ; do 	#TODO:tähän jotain		
				dqb "dbg: ${gg} --import ${ridk}/${f}"
				${gg} --import ${ridk}/${f}
			done
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
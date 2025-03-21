#!/bin/bash
d=$(dirname $0)
debug=0
file=""
distro=""
#joitrain oletusarvoja
dir=/mnt
part0=ABCD-1234

case $# in
	2)
		distro=${2}
	;;
	3)
		file=${2}
		distro=${3}
	;;
	*)
		echo "$0 <mode> <other_params>"
	;;
esac

[ z"${distro}" == "z" ] && exit 6

if [ -d ~/Desktop/minimize/${distro} ] && [ -s ~/Desktop/minimize/${distro}/conf ] && [ -x ~/Desktop/minimize/${distro}/lib.sh ] ; then	
	. ~/Desktop/minimize/${distro}/conf
	. ~/Desktop/minimize/common_lib.sh
	. ~/Desktop/minimize/${distro}/lib.sh
else
	srat="sudo /bin/tar"
	som="sudo /bin/mount"
	uom="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	dir=/mnt
	odio=$(which sudo)
	debug=1
	
	function dqb() {
		[ ${debug} -eq 1 ] && echo ${1}
	}

	function csleep() {
		[ ${debug} -eq 1 ] && sleep ${1}
	}

	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

debug=1
mode=${1}

dqb "mode=${mode}"
dqb "distro=${distro}"
dqb "file=${file}"

olddir=$(pwd)
part=/dev/disk/by-uuid/${part0}

if [ ! -s /OLD.tar ] ; then #HUOM.260125: -p wttuun varm. vuoksi   
	${srat} -cf /OLD.tar /etc /sbin /home/stubby /home/devuan/Desktop
fi

dqb "b3f0r3 par51ng tha param5"
csleep 5

function common_part() {
	dqb "common_part()"
	[ y"${1}" == "y" ] && exit 1
	[ -s ${1} ] || exit 2

	#[ y"${2}" == "y" ] && exit 11
	dqb "paramz_0k"

	cd /
	dqb "DEBUG:${srat} -xf ${1} "
	csleep 3
	${srat} -xf ${1} #HUOM.260125: -p wttuun varm. vuoksi  
	csleep 3
	dqb "tar DONE"

	${scm} -R a-wx ~/Desktop/minimize/*
	${scm} 0755 ~/Desktop/minimize/*.sh
	[ ${debug} -eq 1 ] && ls -las ~/Desktop/minimize
	csleep 5

	for f in $(find ~/Desktop/minimize -type d) ; do ${scm} 0755 ${f} ; done 
	#jos nyt olisi hyvä...	
	${scm} 0755 ~/Desktop/minimize
	
	if [ -d ~/Desktop/minimize/${2} ] ; then 
		echo "HAIL CAESAR"
		${scm} 0755 ~/Desktop/minimize/${2}
		${scm} a+x ~/Desktop/minimize/${2}/*.sh
		${scm} 0444 ~/Desktop/minimize/${2}/conf*
	fi

	[ ${debug} -eq 1 ] && ls -las ~/Desktop/minimize/${2}
	csleep 5

	${scm} 0777 /tmp
	${sco} root:root /tmp #oik. o=rwt mutta rwx kai tarpeeksi hyvä useimpiin tarkoituksiin
	dqb "ALL DONE"
}

#TODO:ao- if-blkkiin liittyen jos poistaisi ghubista minimize-hamistosta välistä sen /h/d-osuuden
#VAIH:chmod-juttuja joutaisi miettiä (vissiin jossain se x-oikeus poistui tästä, todnäök commoin_part/lib/common_lib)

case "${1}" in
	-1)
		part=/dev/disk/by-uuid/${part0}		
		[ -b ${part} ] || dqb "no such thing as ${part}"

		${som} -o ro ${part} ${dir}
		csleep 5
		${som} | grep ${dir}

		#VAIH:näyttämään NEXT-jutut vain jos ei tullut virheitä ed. komennoissa
		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> <distro> (unpack AND install) | $0 1 <source> (just unpacks the archive)"
	;;
	2)
		#VAIH:chmod-juttujen läpikäynti (vissiin tämän tdston x-oikeus kyseessä)
		${uom} ${dir}
		csleep 3
		${som} | grep ${dir}

		[ $? -eq 0 ] && echo "NEXT: ${d}/doIt6.sh (maybe)"
	;;
	1)
		[ x"${file}" == "x" ] && exit 44
		[ -s ${file} ] || exit 55

		common_part ${file} ${distro}
		csleep 3
		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	0)
		#JUOM.21035: joskohan uuden päivitysdpkaetin kanssa olisi nalkutukset poistettu

		[ x"${file}" == "x" ] && exit 55
		dqb "KL"
		csleep 2

		[ -s ${file} ] || exit 66
		dqb "${file} IJ"
		csleep 2

		[ z"{distro}" == "z" ] && exit 77
		dqb " ${3} ${distro} MN"
		csleep 2

		common_part ${file} ${distro}		
		#HUOM.290325: näillä main saattaa olla jotain härdelliä daedaluksen tapauksessa
		#... tai pikemminkin väärät parametrit skjriptille
		#P.S. käyttöoikeudetkin tulisi huomioida stna

		pre_part3 ~/Desktop/minimize/${distro}
		pr4 ~/Desktop/minimize/${distro}
		part3 ~/Desktop/minimize/${distro}
		csleep 2

		cd ${olddir}
		[ $? -eq 0 ] && echo "NEXT: $0 2"
	;;
	*)
		echo "-h"
	;;
esac

sudo chmod 0755 $0 #barm vuoksi
#HUOM. tämän olisi kuvakkeen kanssa tarkoitus mennä jatkossa filesystem.squashfs sisälle

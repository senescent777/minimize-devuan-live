#!/bin/bash
#HUOM.151025:kuseeko tämä tdsto vai common_lib vaiko $dustro/lib ?
#debug=0 #1
#srcfile=""
#
#distro=$(cat /etc/devuan_version)
#tämä tarvitaan toistaiseksi leikeltynä vai ei?
#
#dir=/mnt
#part0=ABCD-1234
#mode=-2
#d0=$(pwd)
#[ z"${distro}" == "z" ] && exit 6
#d=${d0}/${distro}
#
#tpx="--exclude tim3stamp --exclude rnd --exclude .chroot --exclude .gnupg " #konftsdtoon vähietllen
##... tai mitä tässä tap ptäisi purkaa ja mitä ei?
#
##HUOM.30925:jospa ei pilkkoisi tätä tdstoa ainakaan ihan vielä
##... optiota -v ei ole pakko käyttää, toisaalta
#
##HUOM.111025:viimeksi muokatuilla .iso-tiedostoilla kokeillessa kävi ilmi että testailu rikkoo äksään kirjautumisen TAAS
##1 ratkaisu olisi dumpata se slim+xfce , minimal_live+startx kehiin niiqu
##toinen taas se että oletetaan aiheuttajaksi se 1 tar+koitetaan korjata
#
#function dqb() {
#	[ ${debug} -eq 1 ] && echo ${1}
#}
#
#function csleep() {
#	[ ${debug} -eq 1 ] && sleep ${1}
#}
#
#function usage() {
#	echo "${0} <mode> <srcfile> [distro] [debug] "
#}
#
#if [ $# -gt 0 ] ; then
#	mode=${1}
#	srcfile=${2}
#else
#	usage
#	exit 1	
#fi
#
##HUOM.041025:debug-riippuvaisen käytöksen syy löytynee tästä fktiosta, ehkä
#function parse_opts_1() {
#	case "${1}" in
#		-v|--v)
#			debug=1
#		;;
#		*)
#			if [ -d ${d0}/${1} ] ; then
#				distro=${1}
#				d=${d0}/${distro}
#			fi
#		;;
#	esac
#}
#
#function parse_opts_2() {
#	dqb "parseopts_2 ${1} ${2}"
#}
#
#if [ -f /.chroot ] ; then #VAIH:tämmöiset jatkossa -> common_lib ?
#	echo "UNDER THE GRAV3YARD"
#	sleep 2
#
#	#HUOM.141025:oikeastaan pitäisi tarkistaa ennen purkua
#	for f in $(find ${d0} -type f -name 'nekros?'.tar.bz3) ; do
#		tar -jxvf ${f}
#		sleep 1
#		rm ${f}
#		sleep 1
#	done
#
#	#HUOM.141025:ei vielä toimi kunnolla chrootin alla jos common_lib poissa pelistä
#	#ainakin $odio tulisi jyrätä tässä blokissa 
#
#	#1. yrityksellä "$0 1 $file" johti bad_signature-valituksiin joten lisää pitäisi iteroida 
#	#myös "gpg: can't open './sha512sums.sig': No such file or directory"
#fi
#
##HUOM.21725:oliko jotain erityistä syyt miksi conf cmmon_lib jälkeen? $distroon liittyvät kai, pitäisi miettiä, nyt näin
#
#if [ -s ${d0}/$(whoami).conf ] ; then
#	echo "ALT.C0NF1G"
#	sleep 5
#	. ${d0}/$(whoami).conf
#else
#	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
#		. ${d}/conf
#	else
#	 	exit 57
#	fi	
#fi
#
#if [ -x ${d0}/common_lib.sh ] ; then #saattaa jo toimia chroot-ymp sisällä
#	#... saattaa olla että sq-chroot:in sisällä ei tarvitsekaan:import2.sh mutta väHän kätevänPI ehgkä
#	. ${d0}/common_lib.sh
#else
#	#HUOM.151025:tässä haarassa jokin qsee?
#	srat="/bin/tar" #which mukaan?
#
#	som="sudo /bin/mount"
#	uom="sudo /bin/umount"
#	scm="sudo /bin/chmod"
#	sco="sudo /bin/chown"
#	odio=$(which sudo)
#
#	#jos näillä lähtisi aiNAKin case q toimimaan
#	n=$(whoami)
#	smr=$(${odio} which rm)
#	NKVD=$(${odio} which shred)
#	NKVD="${NKVD} -fu "
#
#	whack=$(${odio} which pkill)
#	whack="${odio} ${whack} --signal 9 " #P.V.H.H
#	sah6=$(${odio} which sha512sum)
#
#	function check_binaries() {
#		dqb "imp2.ch3ck_b1nar135 \${1} "
#	}
#
#	function check_binaries2() {
#		dqb "imp2.ch3ck_b1nar135_2 \${1} "
#	}
#
#	function fix_sudo() {
#		dqb "imp32.fix.sudo"
#	}
#
#	function enforce_access() {
#		dqb "imp32.enf_acc"
#	}
#
#	#HUOM.26525:tämä versio part3:sesta sikäli turha että common_lib urputtaa koska sha512sums muttei deb?
#	function part3() {
#		dqb "imp2.part3 :NOT SUPPORTED"
#		#HUOM.25725:jos wrapperin kautta ajaessa saisi umount:in tapahtumaan silloin kun varsinainen instailu ei onnaa
#	}
#
#	function ppp3() {
#		dqb "imp32.ppp3"
#	}
#
#	#kutsutaanko tätä? no yhdestä kohdasta ainakin 
#	#tarvitaanko?
#	function other_horrors() {
#		dqb "AZATHOTH AND OTHER HORRORS"
#
#		#HUOM. /e/i tarvitsisi kirjoitusokeude että onnaa
#		#${spc} /etc/default/rules.* /etc/iptables #takaisin jos pykii 
#	
#		${scm} 0400 /etc/iptables/*
#		${scm} 0550 /etc/iptables
#		${sco} -R root:root /etc/iptables
#		${scm} 0400 /etc/default/rules*
#		${scm} 0555 /etc/default
#		${sco} -R root:root /etc/default
#	}
#
#	dqb "FALLBACK"
#	dqb "${scm} may be a good idea now"
#	prevopt=""
#
#	for opt in $@ ; do
#		parse_opts_1 ${opt}
#		parse_opts_2 ${prevopt} ${opt}
#		prevopt=${opt}
#	done
#fi
#
#[ -z ${distro} ] && exit 6
#dqb "mode=${mode}"
#dqb "distro=${distro}"
#dqb "srcfile=${srcfile}"
#mkt=$(${odio} which mktemp)
##exit
#
##deMorgan
#if [ -f /.chroot ] || [ -x ${mkt} ] ; then
#	dqb "MTK"
#else
#	#coreutils vaikuttaisi olevan se paketti mikä sisältää mktemp
#	echo "sudo apt-get update;sudo apt-get install coreutils"
#	exit 8
#fi
#
#echo "in case of trouble, \"chmod a-x common_lib.sh\" or \"chmod a-x \${distro}/lib.sh\" may help"
#
#if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
#	. ${d}/lib.sh
#else
#	echo $?
#	dqb "NO LIB"
#	csleep 1
#
#	function pr4() {
#		dqb "imp2.pr4 \${1}" 
#	}
#
#	check_binaries ${d} #parametrit kunnossq?
#	echo $?
#	[ $? -eq 0 ] || exit 7
#	csleep 1
#
#	check_binaries2
#	[ $? -eq 0 ] || exit 8
#	csleep 1
#fi
#
#olddir=$(pwd)
#part=/dev/disk/by-uuid/${part0}
#ocs tar
#
##deMOrgan
#if [ -f /.chroot ] || [ -s /OLD.tar ] ; then
#	dqb "OLD.TAR OK"
#else
#	#jotain exclude-juttuja voisi olla sikäli mikäli tuota oikeasti tarttee johonkin
#	${srat} -cf /OLD.tar /etc /sbin /home/stubby ~/Desktop
#fi
#
#dqb "b3f0r3 par51ng tha param5"
#csleep 1
#
##b) firefoxin käännösasetukset, missä? jokin .json varmaan...
##glorified "tar -x" this function is - Yoda , tähän jos niitä gpg-juttuja?
##HUOM.061025:"jos ei jatkossa purkaisi kaikkea paketin sisältä kaikissa tilanteissa?" tätä ehkä vähän alettu huomioidfas
##HUOM.061025:allekrijoitus-asioita alettu hiomoioida sekä imp2 että exp2
#
##- import2, common_part , -C - optio common_lib disbled
##	kun purq /p/f.tar.bz2 ni menee juureen , ark sisällä ei hmistorakennetta
##	eli testattava ja toimittava havaintojen mukaan
##	tar -jtf ja putken päähän cut -d / -f 1 , jos pelkkää pistettä ni...
##	paitsi että timestamp voi sotkea grepataan listauksesta se ensin pois
#
##TODO:.deb-pakettien pakkaus/purku vähän uusiksi? voisi olla ./$distro/ alla nuo
##... ja "exp2 0", josko silloin tylysti vain .deb ha sha512sums tar:iin?
#
##TODO:$2 ja $3 käsittely uusiksi?
#
#function common_part() { #HUOM.071025:tuli mutka matkaan imp2 q kanssa
#	dqb "common_part ${1}, ${2}, ${3}"
#
#	[ y"${1}" == "y" ] && exit 1
#	[ -s ${1} ] || exit 2
#	[ -r ${1} ] || exit 3
#	[ y"${3}" == "y" ] && exit 4
#
#	[ y"${2}" == "y" ] && exit 11
#	[ -d ${2} ] || exit 22
#	[ -d ${3} ] || exit 33
#
#	dqb "paramz_0k"
#	csleep 3
#	cd / #-C nykyään...
#	
#	if [ -s ${1}.sha ] ; then
#		dqb "KHAZAD-DUM"
#
#		#TODO:mielellään sah6 -c $1.sha jatkossa
#		cat ${1}.sha
#		${sah6} ${1}
#
#		local gg
#		gg=$(${odio} which gpg)
#
#		if [ -x ${gg} ] ; then #&& [ -v TARGET_Dkname1 ] && [ -v TARGET_Dkname2 ]
#			dqb " ${gg} --verify ${1}.sha.sig "
#			${gg} --verify ${1}.sha.sig ${1}
#		fi
#	else
#		echo "NO SHASUMS CAN BE F0UND FOR ${1}"
#	fi
#
#	#jatkossa voisi -C - option parametrin johtaa $2:sesta?
#	csleep 1
#
#	#HUOM.061025:-tf ilman sudotusta parempi?
#	#... ao. rimpsun perusteella pitäisi sitten tehdä jotain
#	#${srat} -tf ${1} | grep -v tim3 | cut -d / -f 1 | grep -v . | wc -l
#	#csleep 10
#
#	dqb "NECKST:${srat} ${tpx} -C ${3} -xf ${1}"
#	csleep 1
#
#	#efk2 vai ei? ehkä ei koska stand_alone
#	${srat} -C ${3} ${tpx} -xf ${1}
#	[ $? -eq 0 ] || exit 36
#
#	csleep 1
#	dqb "tar DONE"
#
#	local t
#	t=$(echo ${2} | cut -d '/' -f 1-5) #tr mukaan?
#	#HUOM.25725:voi periaatteessa mennä metsään tuo $t josqs, mutta tuleeko käytännössä sellaista tilannetta vastaan?
#
#	#HUOM.031025:omstajuuksia ja käyttöoikeuksia joutuu silti renkkaamaan
#	#... pitäisi varmaan kutsua e_acc aina tai siis...
#
#	if [ -x ${t}/common_lib.sh ] ; then
#		enforce_access ${n} ${t} 
#		#HUOM.111025:oli kokeeksi laitettu jemmaan e_a koska äksän kiukuttelut TAAS
#		dqb "running changedns.sh maY be necessary now to fix some things"
#	else
#		dqb "n s t as ${t}/common_lib.sh "	
#	fi
#
#	csleep 3
#	
#	if [ -d ${t} ] ; then
#		dqb "HAIL UKK"
#
#		#vissiinkin tässä kohtaa common_lib taas käyttöön EIKU
#		#HUOM.020825:tässä ei polkuna voine olla /etc/jotain		
#		${scm} 0755 ${t}
#		${scm} a+x ${t}/*.sh
#		${scm} 0444 ${t}/conf*
#		${scm} 0444 ${t}/*.deb
#
#		csleep 1
#	fi
#
#	[ ${debug} -eq 1 ] && ls -las ${2}
#	csleep 1
#	dqb "ALL DONE"
#}
#
##HUOM.141025:mikä idea $2 kanssa?
##HUOM.071025:nyt tuli mutka matkaan tar:in kanssa , josko taas timisi vähän aikaa
##TODO:se audio mixer k anssa toimimaan  /pavucontrol poistunut /jep/ vai pak kas/purq viallinen myös?
#function tpr() {
#	dqb "UPIR  ${1}, ${2}"
#	csleep 1
#
#	[ -z ${1} ] && exit 11
#	[ -d ${1} ] || exit 12
#
#	dqb "pars_ok"
#	csleep 1
#
#	#ne tar-kikkailut common_lib:iin vähitellen
#	dqb "L ENG TZCHE "
#	csleep 1
#	
#	dqb "stat= ${srat}"
#	csleep 3
#
#	#~ alta kalat pois jottei sotke jatkossa?
#	local t
#	for t in ${1}/config.tar.bz2 ~/config.tar.bz2 ; do ${srat} -C ~ -xvf ${t} ; done #HUOM.091025:ei tarvinne tähän: --exclude ?
#	#echo $?
#	for t in ${1}/pulse.tar ~/pulse.tar ; do ${srat} -C / -xvf ${t} ; done
#	dqb "PROFS?"
#	csleep 1
#
#	if [ -x ${1}/profs.sh ] ; then
#		#fktioiden importointia jos kokeilisi? man bash...
#		. ${1}/profs.sh
#		[ $? -gt 0 ] && exit 33
#			
#		dqb "INCLUDE OK"
#		csleep 1
#		local q
#		q=$(${mkt} -d)
#
#		if [ -s ~/fediverse.tar ] ; then
#			${srat} -C ${q} -xvf ~/fediverse.tar
#		else
#			${srat} -C ${q} -xvf ${1}/fediverse.tar
#		fi
#
#		imp_prof esr ${n} ${q}
#	else
#		dqb "CANNOT INCLUDE PROFS.HS"
#		dqb "$0 1 \$srcfile ?"
#	fi
#
#	dqb "UP1R D0N3"
#	csleep 1
#}
#
#echo "mode = ${mode}"
#echo "src = ${srcfile}"
#sleep 6
#
##TODO:jatkossa 2 eri case:a kuten exp2
#case "${mode}" in
#	-1) #jatkossa jokiN fiksumpi kuin -1?
#		part=/dev/disk/by-uuid/${part0}		
#		[ -b ${part} ] || dqb "no such thing as ${part}"
#		c=$(grep -c ${dir} /proc/mounts)
#
#		if [ ${c} -lt 1 ] ; then
#			${som} -o ro ${part} ${dir}
#			csleep 1
#			${som} | grep ${dir}
#		fi
#
#		[ $? -eq 0 ] && echo "NEXT: $0 0 <source> [distro] unpack AND install | $0 1 <source> just unpacks the archive | $0 3 ..."
#	;;
#	2)
#		${uom} ${dir}
#		csleep 1
#		${som} | grep ${dir}
#
#		[ $? -eq 0 ] && echo "NEXT:  \${distro}/doIt6.sh maybe | sleep \$delay;ifup \$iface;changedns if necessary"
#	;;
#	1)
#		[ x"${srcfile}" == "x" ] && exit 44
#		[ -s ${srcfile} ] || exit 55
#
#		read -p "U R ABT TO EXTRACT ${srcfile} , SURE ABOUT THAT?" confirm
#		[ "${confirm}" == "Y" ]  || exit 77
#		common_part ${srcfile} ${d} /
#
#		csleep 1
#		cd ${olddir}
#		[ $? -eq 0 ] && echo "NEXT: $0 2"
#	;; #HUOM.nollaa edeltävät caset:ei ole sorkittu viime aikoina, pitäisi toimia ok
#	0|3)
#		#HUOM.071025:sen /pad/f.tar.bz2 kanssa imp2 3 parempi
#		dqb "ZER0 S0UND"
#		csleep 1
#
#		[ x"${srcfile}" == "x" ] && exit 55
#		dqb "KL"
#		csleep 1
#
#		[ -s ${srcfile} ] || exit 66
#		dqb "${srcfile} IJ"
#		csleep 1
#
#		[ z"{distro}" == "z" ] && exit 77
#		dqb " ${3} ${distro} MN" #mikä pointti?
#		csleep 1
#
#		read -p "U R ABT TO INSTALL ${srcfile} , SURE ABOUT THAT?" confirm
#		[ "${confirm}" == "Y" ] || exit 33
#		[ -s ${srcfile} ] || exit 34
#		[ -r ${srcfile} ] || exit 35
#
#		#HUOM.061025:pitäisiköhän tässä tutkia lähdetsdton sisältöä ennenq aletaan purkaa?
#		if [ ${1} -eq 0 ] ; then
#			common_part ${srcfile} ${d} / #voi tietystI mennä mettään tuon $d/common_lib kanssa?
#		else
#			common_part ${srcfile} ${d} ${d}
#		fi
#
#		csleep 1
#
#		if [ ${1} -eq 0 ] ; then #HUOM.30925:jospa antaisi efk2-kikkailujen olla toistaiseksi
#			if [ -s ${d}/e.tar ] ; then
#				common_part ${d}/e.tar ${d} /
#			else
#				dqb " ${d}/e.tar CANNOT BE FOUND"
#
#				if [ -s ${d}/f.tar ] ; then
#					common_part ${d}/f.tar ${d} ${d} 				
#				fi
#			fi
#			#for t in ${d}/e.tar ... No Ei
#		fi
#		
#		csleep 5
#		dqb "c_p_d0n3, NEXT: pp3"
#		csleep 1	
#
#		#HUOM.part3->pre_part3->psqa
#		part3 ${d} ${dnsm}
#		other_horrors
#		csleep 1
#		
#		cd ${olddir}
#		[ $? -eq 0 ] && echo "NEXT: $0 2"
#	;;
#	q) #HUOM.071025:josko nyt olisi taas kunnossa sen aikaa kunnes srat
#		[ x"${srcfile}" == "x" ] && exit 55
#		dqb "KL"
#		csleep 1
#
#		[ -s ${srcfile} ] || exit 66
#		dqb "${srcfile} IJ"
#		csleep 1
#	
#		c=$(tar -tf ${srcfile} | grep fediverse.tar  | wc -l)
#		[ ${c} -gt 0 ] || exit 77
#		common_part ${srcfile} ${d} /
#		tpr ${d0}
#	;;
#	r) #HUOM.071025:josko nyt olisi taas kunnossa sen aikaa kunnes srat
#		tpr ${d0}
#	;;
#	k)	
#		[ -z ${srcfile} ] && exit 11
#		[ -d ${srcfile} ] || exit 22
#
#		dqb "KLM"
#		gg=$(${odio} which gpg)
#		ridk=${srcfile}
#
#		if [ -x ${gg} ] && [ -v TARGET_Dkname1 ] && [ -v TARGET_Dkname2 ] ; then #/.chroot vielä?
#			dqb "NOP"
#		
#			for f in ${TARGET_Dkname1} ${TARGET_Dkname2} ; do 			
#				dqb "dbg: ${gg} --import ${ridk}/${f}"
#				${gg} --import ${ridk}/${f}
#			done
#		fi	
#
#		#... ensiksi pitäisi f.tar purqaa m/$distro alle ,imp2 osannee
#		#... sitten tikulta uusimmat skriptit purkaen
#		#... VASTA SEN JÄLKEEN pääsee ajamaan:g_doit
#	;;
#	-h) #HUOM.27725:ilman param kuuluisi kai keskeyttää suor mahd aik
#		usage
#	;;
#	*)
#		echo "-h"
#	;;
#esac
#
##ettei umount unohdu
#echo "REMEMBER 2 UNM0UNT TH3S3:"
#grep ${part} /proc/mounts
#grep ${dir} /proc/mounts
#
#${scm} 0755 $0
##HUOM.290925: tämän skriptin olisi kuvakkeen kanssa tarkoitus löytyä filesystem.squashfs sisältä
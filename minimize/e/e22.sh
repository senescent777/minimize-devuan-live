if [ -v CONF_pkgdir ] ; then #varm vuoksi täMäkin 265226
	${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
	${scm} -Rv 700 ${CONF_pkgdir}/partial/
fi

if [ ! -v CONF_pubk ] ; then
	b="/"
	[ "${CONF_env}" == "VED" ] && b=${CONF_testgris}
	a=$(${odio} find ${b} -type f -name "keys.conf" | head -n 1)

	if [ ! -z "${a}" ] ; then
		if [ -s ${a} ] ; then
			. ${a}
		fi	
	fi

	unset a
	unset b
fi

function e22_hdr() {
	dqb "e22_hdr()"
	[ -z "${1}" ] && exit 61
	[ "${1}" == "-v" ] && exit 62
	
	#onkohan hyvä idea?
	if [ -f ${1} ] ; then
		echo "$1 ALR3ADY EX1STS"
		read -p " U SURE ?" confirm
		[ "${confirm}" == "Y" ] || exit 99
	fi

	fasdfasd ./rnd
	fasdfasd ${1}

	dd if=/dev/random bs=12 count=1 > ./rnd
	${sr0} -cvf ${1} ./rnd
	[ $? -gt 0 ] && exit 60
}

function e22_tyg() {
	dqb " ; e22_tyg( ${1} )(((("	

	[ -z "${1}" ] && exit 45
	[ -s ${1} ] || exit 46
	[ -r ${1} ] || exit 47

	dqb "pars_ok"
	csleep 1

	if [ -x ${gg} ] ; then
		if [ -v CONF_pubk ] ; then
			${gg} -u ${CONF_pubk} -sb ${1}
			[ $? -eq 0 ] || dqb "SIGNING FAILED, SHOUDL IUNSTALLLL PRIVATE KEYS OR SMTHING ELSE"
			csleep 1
			${gg} --verify ${1}.sig
		fi
	fi
}

function e22_ftr() {
	dqb "e22_ftr()"
	[ -z "${1}" ] && exit 62
	[ -s ${1} ] || exit 63
	[ -r ${1} ] || exit 64

	fasdfasd ${1}.sha
	local p=$(pwd)
	local q=$(basename ${1})

	cd $(dirname ${1})
	${sah6} ./${q} > ${q}.sha
	csleep 1

	${sah6} -c ${q}.sha
	csleep 1

	e22_tyg ${q}.sha
	cd ${p}
}

#... joku päivä jos maistuisi selvittää tuo "bash function retuRn value"-juttu että onnnaako vai ei?

#110726:ekana param voisi olla suoraan $1/conf_hashfile?
function aqsp() {
	dqb "aqsp ${1} ; "
	[ -z "${1}" ] && exit 97
	[ -d ${1} ] || exit 96
	local rv=0

	if [ -v gg ] ; then #else-haarat takaisin josqs, ehkä
		if [ -s ${1}/${CONF_hashfile}.sig ] ; then #eka ehto omalle rivilleen ja sit jhotain
			if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
				${gg} --verify ${1}/${CONF_hashfile}.sig
				rv=$?
			fi
		fi
	fi

	if [ -s ${1}/${CONF_hashfile} ] && [ -x ${sah6} ] && [ ${rv} -eq 0 ] ; then
		local p=$(pwd)
		cd ${1}

		${sah6} -c ${CONF_hashfile} --ignore-missing
		rv=$?
		cd ${p}
	else
		rv=93
	fi

	dqb "rv= ${rv}"

	if [ ${rv} -gt 0 ] ; then #toistaiseksi sqap() hoitamaan poistot
		dqb "SMTHNG WENT WR09NG"	
		${NKVD} ./*.deb 
		${NKVD} ./${CONF_hashfile}*
		${NKVD} ./*.tar
	fi

	dqb "aqsp  DONE"
}

function e22_pre1() {
	dqb "e22_pre1( ${1} ; ${2} ; ${3}) "
	csleep 1	

	[ -z "${1}" ] && exit 65
	[ -z "${2}" ] && exit 66
	[ -d ${1} ] || exit 111
	dqb "pars_ok"
	csleep 1

	${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
	${scm} -Rv 700 ${CONF_pkgdir}/partial/
	
	local lefid=$(echo ${1} | tr -d -c 0-9a-zA-Z/) #entä cut?	
	enforce_access $(whoami) ${lefid}

	csleep 1
	${scm} 0755 /etc/apt
	${scm} a+w /etc/apt/sources.list*
	part1 ${2} ${1}
	${scm} a-w /etc/apt/sources.list*
}

#TODO:common_lib fktio jos ei nimeäisi linkkejä uudestaan jatkossa, mikjä fktio olikaan

function e22_pre2() {	
	dqb "e22pre2 )))) ${1} ; ${2} ; ${3} ; ${4} )()))) "
	csleep 1

	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67

	#HUOM.tämän sekoilun piti olla lopetettu
	local par4=$(echo ${2} | tr -d -c 0-9)
	echo $?
	csleep 1

	[ -z "${par4}" ] && exit 89
	csleep 10

	#pedanttiuden nimissä tämmöisiä

	if [ -d /etc/resolv.conf ] ; then
		echo "D"
	else
		if [ -h  /etc/resolv.conf ] ; then
			echo "-L"
		else
			[ -f /etc/resolv.conf ] || ${slinky} /etc/resolv.conf.${par4} /etc/resolv.conf
		fi
	fi

	ls -las /etc/resolv.*
	csleep 10

	${sifu} ${1}
	csleep 1

	${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
	${scm} -Rv 700 ${CONF_pkgdir}/partial/
	${sag_u}

	dqb "pre2.done"
	csleep 1
}

function e22_cleanpkgs() {
	dqb "e22_cleanpkgs() "
	[ -z "${1}" ] && exit 53

	if [ -d ${1} ] ; then
		${smr} ${1}/*.deb
		${smr} ${1}/${CONF_hashfile}*
		ls -las ${1}/*.deb | wc -l
	fi

	dqb "e22_cleanpkgs() DONE"
}

csleep 1

function e22_config1() {
	dqb "e22_config1()"

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22
	[ -z "${2}" ] && exit 11

	dqb "pars.ok"
	csleep 1

	local p=$(pwd)
	cd ${1}

	[ -f ${1}/${2} ] && mv ${1}/${2} ${1}/${2}.ÅLD
	${sr0} -jcf ${2} ./xorg.conf* ./.config
	[ -s ${2} ] || exit 99
	
	cd ${p}
}

#TODO:ffox 147? https://www.phoronix.com/news/Firefox-147-XDG-Base-Directory  
#nuo muutokset oikeastaan tdstoon ${CONF_default_archive3}
#120426:vissiin menee kohteeseen fedi ja profs (mutta meneekö 1. mainittu myös juureen?)

function e22_settings() {
	dqb "e22_settings()"

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22
	[ -z "${2}" ] && exit 44
	[ -z "${3}" ] && exit 89

	if [ ! -x ${1}/${3} ] ; then
		echo "SHOU.LD exp3 p asgfd asgfd"
		exit 24
	fi

	.  ${1}/${3}
	[ -f ${1}/${2} ] && mv ${1}/${2} ${1}/${2}.ÅLD
	exp_prof ${1}/${2} default-esr

	[ -s ${1}/${2} ] || exit 32
	local t

	t=$(tar -tf ${1}/${2} | grep prefs.js | wc -l)
	dqb "FOUND PREFS: ${t}"
	[ ${t} -lt 1 ] && exit 27
}

#TODO:kekekekeksisisisikö jonkin varmistuksen että profiili kanssa menee tariin?
function e22_home_pre() {
	dqb "home_pre()"
	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71
	[ -z "${4}" ] && exit 73
	[ -z "${5}" ] && exit 79

	dqb "paks_ok"
	csleep 1

	if [ ${3} -eq 1 ] && [ -d ${2} ] ; then
		e22_config1 ~ ${4}
		${NKVD} ~/${5}		
		e22_settings ${2}/.. ${5} ${CONF_default_arhcive3}
	fi

	e_final
	${srat} --exclude "changedns*" -rvf ${1} /opt/bin

	for t in $(find ~ -type f -name merd2.sh | head -n 1) ; do
		${srat} -rvf ${1} ${t}
	done	

	#config.tar.bz2?
	for t in $(find ~ -type f -name ${4} ) ; do
		${srat} -rvf ${1} ${t}
	done

	dqb "home.pre.-donr"
	csleep 1
}

function e22_home() {
	dqb "e22_home()"

	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71

	dqb "pars_ok"
	csleep 1
	local f

	${srat} -rvf ${1} ${2}/../${3}
	local t=$(${srat} -tf ${1} | grep ${3} | wc -l)
	[ ${t} -lt 1 ] && exit 72
	csleep 1

	t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 1-5)
	${srat} --exclude "*.deb" --exclude "*.conf" -rvf ${1} /home/stubby ${t} #120726:oliko ${TARGET_TPX} kNSSA VIELÄ JOTAIN?
	csleep 1

	#miksi tässä eikä h_pre() ?
	for f in $(find ~ -type f -name "xorg.conf*" ) ; do 
		${srat} -rvf ${1} ${f}
	done

	dqb "e22_hoem_dnoe()"
	csleep 1
}

function luca() {
	dqb "luca()"
	[ -z "${1}" ] && exit 11
	[ -s ${1} ] || exit 12

	${srat} -rvf ${1} /etc/timezone /etc/localtime

	local f
	for f in $(find /etc -type f -name "local*" -and -not -name "*.202*" ) ; do ${srat} -rvf ${1} ${f} ; done
	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local
}

#(meneekö rules.* kohteeseen useamman kerran? ehkä)

#DONE?:e22_dblock TAKAISIN TAAS 666!!!

function e22_acol() {
	dqb "e22_acol()"
	csleep 1

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 

	[ -z "${2}" ] && exit 2
	[ -z "${3}" ] && exit 3		
	[ -z "${4}" ] && exit 5

	dqb "PARS.OK"
	csleep 1

	${scm} 0555 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	local f
	local ef
	local g

	for f in $(find /etc -type f -name "interfaces*" -and -not -name "*.202*" ) ; do 
		${srat} -rvf ${1} ${f}
	done

	for f in $(${odio} find /etc -type f -name "rules*" -and -not -name "*.202*" ) ; do
		if [ -s ${f} ] && [ -r ${f} ] ; then
			${srat} -rvf ${1} ${f}
		fi
	done

	luca ${1}
	other_horrors

	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		exit 112
	fi

	${srat} -rvf ${1} /etc/default/net*

	case "${2}" in
		wlan0)
			${srat} -rvf ${1} /etc/wpa_supplicant
			${srat} -tf ${1} | grep wpa
		;;
		*)
		;;
	esac

	if [ ${3} -gt 0 ] ; then #-eq 1
		for f in $(find /etc -type f -name "stubby*" -and -not -name "*.202*" ) ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name "dns*" -and -not -name "*.202*" ) ; do ${srat} -rf ${1} ${f} ; done
	fi

	ef=$(echo ${4} | tr -d -c 0-9)

	if  [ ${ef} -eq 1 ] ; then
		dqb "SMTHING"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuqqah /etc/fstab
	fi

	dqb "DONeW EITH THE CALOYTES:MAGNET0"
	csleep 1
}

[ -v CONF_BASEURL ] || exit 6

#VAIH:CONF_iface parametriksi jatkossa?
function e22_pre_e() {
	local p
	local q

	[ -z "${1}" ] && exit 98

	#if [ "${CONF_iface
	if [ "${1}" == "eth0:1" ] ; then
		for p in $@ ; do
			q=$(echo ${p} | grep -v dhcp)
			[ -z "${q}" ] || ${shary} ${q}
		done
	else
		for p in $@ ; do ${shary} ${p} ; done
	fi
}

function e22_ext() {
	dqb "e22_ext()"

	[ -z "${1}" ] && exit 1
	[ -d ${1} ] && exit 59
	[ -f ${1} ] || exit 67
	[ -s ${1} ] || exit 2
	[ -w ${1} ] || exit 6
	[ -z "${2}" ] && exit 3
	[ -z "${3}" ] && exit 4
	[ -z "${4}" ] && exit 47
	[ -d ${4} ] && exit 53
	[ -f ${4} ] || exit 61

	dqb "paramz_ok"
	csleep 1

	local p
	local q	
	local r
	local st

	p=$(pwd)
	q=$(mktemp -d)
	r=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	st=$(echo ${3} | tr -d -c 0-9)

	[ ${debug} -eq 1 ] && pwd
	cd ${q}
	${tig} clone https://${CONF_BASEURL}/more_scripts.git
	[ $? -eq 0 ] || exit 66

	cd more_scripts/misc
	echo $?
	${spc} /etc/dhcp/dhclient.conf ./etc/dhcp/dhclient.conf.${st}

	if [ ! -s ./etc/dhcp/dhclient.conf.1 ] ; then
		${spc} ./etc/dhcp/dhclient.conf.new ./etc/dhcp/dhclient.conf.1	
	fi

	${spc} /etc/resolv.conf ./etc/resolv.conf.${st}

	if [ ! -s ./etc/resolv.conf.1 ] ; then
		${spc} ./etc/resolv.conf.new ./etc/resolv.conf.1
	fi

	#shclitn-d-kojhtaan josqs muutoksia vai ei?
	${spc} /sbin/dhclient-script ./sbin/dhclient-script.${st}
	
	if [ ! -s ./sbin/dhclient-script.1 ] ; then
		${spc} ./sbin/dhclient-script.new ./sbin/dhclient-script.1
		ls -las ./sbin
	fi
	
	local c=0	

	if [ -f /etc/apt/sources.list ] ; then
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:'  | wc -l)

		if [ ${c} -lt 1 ] ; then
			${spc} /etc/apt/sources.list ./etc/apt/sources.list.${2}
		fi
	fi

	${svm} ./etc/apt/sources.list ./etc/apt/sources.list.tmp
	${svm} ./etc/network/interfaces ./etc/network/interfaces.tmp
	${spc} /etc/network/interfaces ./etc/network/interfaces.${r}
	${sco} -R root:root ./etc
	${scm} -R a-w ./etc
	${sco} -R root:root ./sbin 
	${scm} -R a-w ./sbin
	${srat} -rvf ${1} ./etc ./sbin
	echo $?
	local f

	c=$(${srat} -tf ${1} | grep resolv.conf.${st} | wc -l)
	[ ${c} -gt 0 ] || exit 97
	echo $?
	
	for f in $(find ./etc -type f -not -name "interfaces.*" -and -not -name "resolv.*") ; do
		${sah6} ${f} >> ${4}
	done

	cd ${p}
}

function e22_ts() {
	dqb "e22_ts()"
	[ -z "${1}" ] && exit 13
	[ -d ${1} ] || exit 14
	[ -w ${1} ] || exit 15
	[ -z "${2}" ] && exit 16
	[ -d ${2} ] || exit 17

	dqb "${svm} ${2}/*.deb ${1} IN 10 SECS"
	csleep 10
	${svm} ${2}/*.deb ${1}
	[ $? -eq 0 ] || exit 56

	fasdfasd ${1}/tim3stamp
	date > ${1}/tim3stamp
	cg_udp6 ${1}

	ls -las ${1}/*.deb
	csleep 10

	dqb "e22_ts() done"
}

#28526 taas testailut menossa (vissiin muuten toimii mutta shasums.1 kanssa jotain?)
#VAIH:ALAPA TESTAILLA MITEN TOIMII
function e22_arch() {
	dqb "e22_arch( ${1} )  ${2} ) ${3} ) ))) ) ("
	csleep 1

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 44
	[ -z "${3}" ] && exit 53

	dqb "e22_a.pars maybe ok"
	csleep 1
	local p=$(pwd)
	local c=$(find ${2} -type f -name "*.deb" | wc -l)
	[ -v CONF_hashfile ] || exit 94
	[ -z "${CONF_hashfile}" ] && exit 95

	if [ -f ${2}/${CONF_hashfile} ] ; then #turha tarq?
		${NKVD} ${2}/${CONF_hashfile}*
		csleep 1
	fi

	if [ ${c} -lt 1 ] ; then
		echo "N0 .deb - FIL35s UND3R ${2}"
		exit 55
	fi

	${scm} 0444 ${2}/*.deb
	fasdfasd ${2}/${CONF_hashfile}
	fasdfasd ${2}/${CONF_hashfile}.1
	[ ${debug} -eq 1 ] && ls -las ${2}/${CONF_hashfile}*;sleep 3

	cd ${2}
	${sah6} ./*.deb > ./${CONF_hashfile}
	csleep 1
	dqb "${CONF_hashfile}.1"

	for f in $(find . -type f -name "*pkgs*" | grep -v olds) ; do #oliko olds kanssa jotain vei ai?
		[ ${3} -eq 1 ] && ${srat} -rvf ${1} ${f}
		[ -s ./${f} ] && ${sah6} ${f} >> ./${CONF_hashfile}.1
		csleep 1
	done

	csleep 1

	#1209726: -f - tarq tässä tarpeen?
	for f in e.tar g.tar ; do
		dqb "sah6 ./${f}"
		[ -s ./${f} ] && ${sah6} ./${f} >> ./${CONF_hashfile}.1 # | grep -v ${t} 
	done

	[ ${debug} -eq 1 ] && cat ./${CONF_hashfile}.1
	csleep 5
	e22_tyg ./${CONF_hashfile}

	if [ -s ./${CONF_hashfile}.1 ] ; then
		e22_tyg ./${CONF_hashfile}.1
	else
		dqb "./${CONF_hashfile}.1 EMPTY"
		csleep 10
		exit
	fi

	psqa .
	#TODO:psqa():n paluuuarvon kanssa testailua vielä, että oikeasti dellitään jos x tai siis

	if [ $? -gt 0 ] ; then
		${NKVD} ./*.deb
		${NKVD} ./${CONF_hashfile}*
		${NKVD} ./*.tar
	else
		${srat} -rf ${1} ./*.deb ./${CONF_hashfile}* ./tim3stamp
	fi

	cd ${p}
	dqb "E22_A_DONE"
	csleep 1
}

#fktiona vähän turhaq, tarkistuksia enemmän kun varsi.naista koodia, toisaalta voisi prujata fktion sisällön niihin 2 kohtaan export2:sessa
function e22_dblock() {
	dqb "e22_dblock(${1} , ${2} , ${3} , ${4} )))) "

	[ -z "${1}" ] && exit 14
	[ -s ${1} ] || exit 15
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 23
	[ -z "${3}" ] && exit 33
	[ -d ${3} ] || exit 34
	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...
	[ -z "${4}" ] && exit 37

	dqb ".PARS-OK"
	csleep 1
	[ ${debug} -eq 1 ] && pwd
	ls -la ${3}/*.deb | wc -l
	
	for s in ${PART175_LIST} ; do
		${sharpy} ${s}*
		${NKVD} ${3}/${s}*.deb
	done
	
	local t=$(echo ${2} | cut -d "/" -f 1-6)
	e22_ts ${t} ${3}
	dqb "JST B3F0R3 3NF0RC3"
	csleep 5
	
	enforce_access $(whoami) ${t}
	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
	csleep 5

	e22_arch ${1} ${2} ${4}
	e22_cleanpkgs ${2}

	dqb "DBLOK DONE"
	csleep 1
}

#function aval0n() {
#	dqb  \$ {sharpy} libavahi \* #saattaa sotkea ?
#	dqb  \$ {NKVD} $ {CONF_pkgdir} / libavahi \* ?
#}

function e22_rpg() {
	dqb "R-P-G ${1} , ${2} , ${3}"
	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98	
	[ -s "${1}" ] || exit 97
	[ -d ${2} ] || exit 96
	exit 95

#	e22_cleanpkgs ${2}
#		
#	${smr} ${2}/f.tar
#	csleep 1
#		
#	#toimiiko tuo exclude? jos ei ni jotain tarttis tehrä
#	#... koko case pois käytöstä vaikka
#	
#	${srat} --exclude "${CONF_hashfile}*" --exclude "*pkgs*" -C ${d} -xvf ${1}
#	[ $? -eq 0 ] && ${svm} ${1} ${1}.OLD
#	csleep 1
#
#	#... toimii vissiin mutta laitettu pois pelistä 241225 jokatapauksessa
#			
#	e22_arch ${1} ${2} ${4}
#	cd ${2}
#
#	#sotkee sittenkin liikaa?
#	#${srat} -rvf ${1} ./accept_pkgs* ./reject_pkgs* ./pkgs_drop
#		
#	#for t in $(${srat} -tf ${1}) ; do #fråm update2.sh
#	#	${srat} -uvf  ${1} ${t}
#	#done
#		
#	exit
}

#TODO:ao. fktion kanssa sitä self_extracting_archive-juttua kokeillen (JOKO JO 170426?)
function e22_cde() {
	dqb "e22_cde()"
	
	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98
	[ -z "${3}" ] && exit 96
	[ -d "${2}" ] || exit 97
	[ -d "${3}" ] || exit 95

	cd ${2}
	fasdfasd ${1}
	[ ${debug} -eq 1 ] && ls -las ${1}*
	csleep 1

	${srat} --exclude "*merd*" -jcvf ${1} ./*.sh ./pkgs_drop ./${3}/*.sh
}

#VAIH:nimeäminen uusiksi? yleisen linjan mukaan?
function e22_z1() {
	dqb "e22_z1()) ${1} (()"
	[ -z "${1}" ] && exit 66
	dqb "pars ok"
	csleep 2

	${NKVD} ${1}.tmp
	${spc} ${1} ${1}.ÅLD
	${spc} ${1}.sig ${1}.sig.ÅLD
	${spc} ${1}.sha ${1}.sha.ÅLD

	csleep 1
	fasdfasd ${1}.tmp

	dqb "e22_z1() DONE"
	csleep 1
}

function e22_z2() {
	dqb "e22.z2((( ${1} ))(("
	[ -z "${1}" ] && exit 66

	#ekan parametrin kanssa lisää tarkistuksia?
	#.tmp tulisi kai olla olemassa ennenq reqw qtsutaan ... paitsi että mv myöhemmin
	#[ -s ${1} ] || exit 76

	dqb "par\$ 0k"
	csleep 1
	
	reqwreqw ${1}.tmp
	csleep 1

	${NKVD} ${1}.sig
	${NKVD} ${1}.sha
	${NKVD} ${1}
	csleep 1

	fasdfasd ${1}.sig
	fasdfasd ${1}.sha

	${svm} ${1}.tmp ${1}
	[ $? -eq 0 ] || exit
	csleep 1

	${sah6} --ignore-missing -c ${1}
	csleep 3
	e22_tyg ${1}
	${sah6} ${1} > ${1}.sha

	dqb "e22_z2.D0M3"
	csleep 1
}

function e22_z3() {
	dqb "e22_z3()((( ${1}"
	[ -z "${1}" ] && exit 66
	[ -s ${2} ] || exit 67
	[ -z "${3}" ] && exit 68
	csleep 1
	dqb "pars.ko"

	fasdfasd ${3}
	csleep 1

	if [ ! -s ${3} ] ; then
		#120726:mitense exp3? mitå siitä?
		${sr0} -tf ${2} | grep -v .tar | grep -v .deb > ${3}
		csleep 1
	fi

	${srat} -rvf ${2} ${3}
	local t=$(dirname ${1})

	${scm} go-w ${t}/*
	${sco} -R 0:0 ${1}
	${srat} -rvf ${2} ${1}*
	${scm} go-r ${t}/*
	csleep 1

	dqb "3pxe K0"
}

#(josko exp2 voisi korvata "tar -T -cf":llä?)
echo "TODO:JOKO JO ntp-jutut kuntoon ?" #aftr2.bash saattoi liittyä
sleep 6

function e22_sarram() {
	dqb "e22_sarram() "
	#[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9
	[ -z "${2}" ] && exit 11
	[ -z "${3}" ] && exit 13
	[ -s ${3} ] || exit 17

	dqb "pars_ok"
	csleep 1

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	csleep 1
	local f

	for f in $(${odio} find /etc -type f -name "xorg*" -and -not -name "*.202*" ) ; do
		${srat} -rvf ${1} ${f}
	done

	csleep 1
	#display_manager

	for f in $(${odio} find /etc -type f -name "${2}*" -and -not -name "*.202*" ) ; do
		${srat} -rvf ${1} ${f}
	done

	${srat} -rvf ${1} /etc/X11/default-display-manager
	
	#HUOM.tätä ao. 3 riviä varten oli valmiskin palikka?
	${scm} 0555 /etc/iptables
	${scm} 0400 /etc/iptables/rules*
	${scm} 0400 /etc/default/rules*

	#rules vedettiin jo aiemmin
	for f in $(${odio} find /etc -type f -name "rules.v?.?" -and -not -name "*.202*" ) ; do ${sah6} ${f} >> ${3} ; done

	#OLD vai .OLD? ja ja ja

	for f in $(find ~ -type f -name "*pkgs*" | grep -v OLD | grep -v old) ; do 
		${sah6} ${f} >> ${3}
	done

	if [ -x /usr/sbin/ntpd ] ; then
		for f in $(${odio} find /etc -type f -name "ntp*" ) ; do
			${srat} -rvf ${1} ${f}
			${sah6} ${f} >> ${3}
		done

	fi

	other_horrors
	dqb "OCT/NOV"
	csleep 1
}

function e22_stu() { #jatkosäätöä josqs
	echo "# ! / b ..."
	echo "base64 -d << FOE | tar -jxv"
	echo "${srat} -jcf \$opts | base64"
	echo "FOE"
}

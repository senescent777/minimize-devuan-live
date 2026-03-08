dqb "${sco} -Rv _apt:root ${CONF_pkgdir}/partial"
csleep 1

#130126:sellainen aivopieru että {exp2, e22} toiminnalliSuuden saattaisi voida korvata Makefilellä ainakin osoittain
#... jotain jaottelua(yleinen/erITyinen) fktioiden kanssa myös?

${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
${scm} -Rv 700 ${CONF_pkgdir}/partial/
csleep 1

if [ -v CONF_pubk ] ; then #&& ( -v CONF_ksk ) #pubk vai kpub?
	dqb "no keys.conf needed"
else
	#050326:jatkosäätöjä tähän vai ei?
	arsch=$(${odio} find / -type f -name keys.conf | head -n 1)

	if [ -z "${arsch}" ] ; then
		dqb "P1553 UND SCH31553"
	else
		if [ -s ${arsch} ] ; then
			dqb "f0 und schw31nhund"
			. ${arsch}
		else
			dqb "666"
		fi	
	fi

	csleep 1
	unset arsch
fi

csleep 3

function e22_hdr() {
	dqb "e22hdr():BEFORE "
	csleep 1
	[ -z "${1}" ] && exit 61

	fasdfasd ./rnd
	fasdfasd ${1}
	csleep 1

	dd if=/dev/random bs=12 count=1 > ./rnd
	csleep 2

	${srat} -cvf ${1} ./rnd
	[ $? -gt 0 ] && exit 60

	[ ${debug} -eq 1 ] && ls -las ${1}
	csleep 2

	dqb "e22hdr():AFTER th3 WAR"
	csleep 1
}

#tark-. olla priv fktio
function e22_tyg() {
	dqb "e22_tyg( ${1} )"
	csleep 1

	if [ -x ${gg} ] ; then
		if [ -v CONF_pubk ] ; then
			${gg} -u ${CONF_pubk} -sb ${1}
			[ $? -eq 0 ] || dqb "SIGNING FAILED, SHOUDL IUNSTALLLL PRIVATE KEYS OR SMTHING ELSE"
			csleep 1

			${gg} --verify ${1}.sig
			csleep 1
		else
			dqb "NO KEYS?"
		fi
	else
		dqb "SHOULD INSTALL GPG"
	fi
}

function e22_ftr() { #160126:taitaa toimia
	dqb "ess_ftr( ${1} )"
	csleep 1

	[ -z "${1}" ] && exit 62
 	[ -s ${1} ] || exit 63
	[ -r ${1} ] || exit 64

	fasdfasd ${1}.sha
	local p
	local q

	p=$(pwd)
	q=$(basename ${1})
	cd $(dirname ${1})

	${sah6} ./${q} > ${q}.sha
	csleep 1
	${sah6} -c ${q}.sha
	csleep 1
	
	e22_tyg ${q}.sha

	cd ${p}
	echo "cp ${1} \${tgt}; cp ${1}.* \${tgt}" 
	dqb "ASSAN VESSAN KASSA"
	csleep 1
}

function e22_pre1() { #TODO:testaus uusicksi josqs
	#distRo-parametrin vaikutukset voisi testata, sittenq parsetus taas toimii kunnolla(?)
	#HUOM.080326:$distyro mukaan tähän paketinhallinnan takis, ei liity changedns

	dqb "e22_pre1 ${1}  ${2} "
	[ -z "${1}" ] && exit 65
	[ -z "${2}" ] && exit 66

	csleep 2
	dqb "pars.0k"

	csleep 2
	${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
	${scm} -Rv 700 ${CONF_pkgdir}/partial/
	csleep 1

	if [ ! -d ${1} ] ; then
		echo "P.V.HH"
		exit 111
	else
		echo "else"
		dqb "5TNA"

		local lefid
		lefid=$(echo ${1} | tr -d -c 0-9a-zA-Z/) # | cut -d '/' -f 1-5)
		#HUOM.25725:voi periaatteessa mennä metsään nuo $c ja $l, mutta tuleeko käytännössä sellaista tilannetta vastaan?

		enforce_access ${n} ${lefid} ${CONF_iface}
		csleep 1
		dqb "3NF0RC1NG D0N3"

		csleep 1
		${scm} 0755 /etc/apt
		${scm} a+w /etc/apt/sources.list*

		part1 ${2} ${1}
	fi

	dqb "per1 d0n3"
	csleep 1
}

#...note to self: oli varmaankin kommentti yllä cross-distro-syistä, ehkä jossain kohtaa jos sitä juttua teatsisi uudestaan
#TODO:2. param pois josqs
#TODO:testatus myös jällleen

function e22_pre2() {
	dqb "e22_pre2 ${1}, ${2} , ${3} , ${4}  ... WTIN KAARISULKEET STNA" 
	csleep 1

	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67
	[ -z "${3}" ] && exit 68
	[ -z "${4}" ] && exit 69

	dqb "pars.ok"	
	csleep 1

	local ortsac
	local par4

	#leikkelyt tarpeellisia? exc/ceres takia vissiin on
	ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)
	par4=$(echo ${4} | tr -d -c 0-9)

	#HUOM.020825:vähän enemmän sorkintaa tänne?
	#/e/n alihakemistoihin +x ?
	#/e/wpa kokonaan talteen? /e/n kokonaan talteen?

	#TODO:/o/b muutoksien sivuvaikutukset sittenq
	if [ -d ${1} ] && [ -x /opt/bin/changedns.sh ] ; then
		dqb "PRKL"

		#HUOM.080326:jatkossa jos kääåntgyisi e.e. ifup käskyttäisi tarpeellisia skriptejä
		${odio} /opt/bin/changedns.sh ${par4} #${ortsac} tpoistaiseksi pois toka paarm
		echo $?
		csleep 1

		${sifu} ${3}
		[ ${debug} -eq 1 ] && ${sifc}
		csleep 1

		${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
		${scm} -Rv 700 ${CONF_pkgdir}/partial/

		${sag_u}
		csleep 1
	else
		echo "P.V.HH"
		exit 111
	fi

	dqb "e22_pre 2DONE"
	csleep 1
}

function e22_cleanpkgs() { #130126:edelleen toimii
	dqb "e22_cleanpkgs ${1} , ${2} , ${3}  " 
	#(tulisi olla vain 1 param)
	[ -z "${1}" ] && exit 56

	if [ -d ${1} ] ; then
		dqb "cleaning up ${1} "
		csleep 1
		
		#aiemmalla NKVD-tavalla saattaa kestää joten rm
		${smr} ${1}/*.deb
		${smr} ${1}/sha512sums.txt*
		
		#entä ne listat? jospa ei koskettaisi niihin

		ls -las ${1}/*.deb | wc -l
		csleep 2
		dqb "d0nm3"
	else
		dqb "NO SUCH DIR ${1}"
	fi

	dqb "e22_cleanpkgs D0N3"
	csleep 1
}


#e22_acol() yrittää vetää /e alta xorg konftdston mukaan pakettiin
#... ei ole ihan pakko config1():sessä siis
#TODO:testaus

function e22_config1() {
	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22

	dqb "CFG"
	local p
	p=$(pwd)

	cd ${1} 
	#tar:issa olisi myös -C , josko sitä käyttämään jatkossa

	#VAIH:koko .config jatkossa?
	#VAIH:CONBF_def_yhyy kutsuvaan koodiin

	[ -f ${2} ] && mv ${2} ${2}.ÅLD
	tar -jcf ${2} ./xorg.conf*  .config #/xfce4/xfconf/xfce-perchannel-xml

	csleep 1
	[ -s ${2} ] || exit 99
	
	cd ${p}
	dqb "CDONE"
}

#TODO:ffox 147? https://www.phoronix.com/news/Firefox-147-XDG-Base-Directory  
#nuo muutokset oikeastaan tdstoon profs.sh
#pitäisIkö siirtää toiseen tdstoon?
#120126 saattoi toimia testin ajan

#VAIH:tdstonimi parametriksi (myöa konftdstoon voisi lisätä oletuksen)
function e22_settings() {
	dqb "e22_settings ${1},  ${2},. ${3}"
	csleep 1

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22

	[ -z "${2}" ] && exit 44

	dqb "paramz 0k, next:"
	csleep 1
	dqb "PR0.F5"

	#profs.sh kätevämpi laittaa mukaan kutsuvassa koodissa
	if [ ! -x ${1}/profs.sh ] ; then
		dqb "chmod +x ${1}/profs.sh | export2 p \$file ; import2 1 \$file  ?"
		exit 24
	fi

	dqb "DE PROFUNDIS"
	.  ${1}/profs.sh
	[ -f ${1}/${2} ] && mv ${1}/${2} ${1}/${2}.ÅLD
	exp_prof ${1}/${2} default-esr	
		
	csleep 1
	dqb "SOME BASIC TESTS w/  ${1} / ${2} "
	csleep 2

	[ -s ${1}/${2} ] || exit 32
	local t
	t=$(tar -tf ${1}/${2} | grep prefs.js | wc -l)
	[ ${t} -lt 1 ] && exit 27
	csleep 5

	dqb "TSTS DONE"
	csleep 1

	dqb "e22_settings ${1} , ${2} DONE"
	csleep 1
}

#TODO:testaa taas
#VAIH:se 1 tdstonnimi paramEtriksi? jos ei ihan vielä

function e22_home() {
	dqb "  e22_home() ${1} , ${2} , ${3}  "

	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71
	[ -z "${3}" ] && exit 72
	csleep 1

	dqb "params_ok"
	csleep 1
	[ ${debug} -eq 1 ] && pwd
	csleep 1

	#141225:if-lauseen pointti nykyään? tähän liittyen oli jokin idea? (120126)
	if [ ${3} -eq 1 ] && [ -d ${2} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		e22_config1 ~ ${CONF_default_arhcive2}

		${NKVD} ~/${CONF_default_arhcive}
		e22_settings ${2}/.. ${CONF_default_arhcive}
	else
		dqb "PUIG DESTRÖYERR b666"
	fi

	local t
	csleep 1
	${srat} -rvf ${1} /opt/bin #/changedns.sh #VAIH:tähän riviin muutoksdia jatrkossa, parempi vetää koko hmisto?

	#VAIH:CONBF_det_yhyy
	for t in $(find ~ -type f -name merd2.sh -or -name ${CONF_default_arhcive2}) ; do
		${srat} -rvf ${1} ${t}
	done

	${srat} -rvf ${1} ${2}/../${CONF_default_arhcive}
	csleep 5

	t=$(${srat} -tf ${1} | grep ${CONF_default_arhcive} | wc -l)
	[ ${t} -lt 1 ] && exit 72
	csleep 10

	dqb "B"
	csleep 1
	t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 1-5)

	dqb "${srat} ${TARGET_TPX} --exclude=  \* .deb  -rvf ${1}  / home / stubby ${t} "
	
	csleep 1
	${srat} ${TARGET_TPX} --exclude='*.deb' --exclude '*.conf' -rvf ${1} /home/stubby ${t}
	csleep 2

	dqb "AUTOMAGICAL CONFIGURATION IS A DISEASE  x 199 - Bart S."
	
	for f in $(find ~ -type f -name 'xorg.conf*') ; do ${srat} -rvf ${1} ${f} ; done 	
	csleep 5

	dqb "e22_home d0n3"
	csleep 1
}

#030126:vissiin toimii
#pitäisikö siirtää toiseen tdstoon?
#toistaiseksi privaatti fktio (tarvitseeko kutsua suoraan exp2 kautta oikeastaan?)

function luca() {
	dqb "luca ( ${1} )"
	csleep 1

	[ -z "${1}" ] && exit 11
	[ -s ${1} ] || exit 12
	#[ -w ${1} ] || exit 13
	dqb "prs ok"
	csleep 1

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep rule
	csleep 2

	dqb "JUSTs BEFOREs LOCALES"
	csleep 1

	#localtime taisi olla linkki, siksi erikseen
	${srat} -rvf ${1} /etc/timezone /etc/localtime 
	for f in $(find /etc -type f -name 'local*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done

	echo $?
	csleep 1

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local
	csleep 2
	dqb "loca done"
}

#... muuten lienee ok mutta slim/xdm/wdm-spesifinen konfiguraatio ei vielä tule mukaan vai tuleeko?
#020326:vissiin sisältö ok

function e22_acol() { 
	dqb "e22_acol ${1} , ${2} , ${3} , ${4} "
	csleep 1

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9

	[ -z "${2}" ] && exit 2
	[ -z "${3}" ] && exit 3		
	[ -z "${4}" ] && exit 5

	csleep 1
	dqb "params_ok"
	csleep 1

	#missäs nämä palautettiin entiselleen? ja tartttteeko olla 07xx ? let's find out
	${scm} 0555 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	for f in $(find /etc -type f -name 'interfaces*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done
	dqb "JUSTs BEFOREs URLEs S"
	csleep 1

	for f in $(${odio} find /etc -type f -name 'rules*' -and -not -name '*.202*') ; do
		dqb "PROCESSING ${f}"
		csleep 1

		if [ -s ${f} ] && [ -r ${f} ] ; then
			#140226:toimiiko tämä haara? ehkä
			${srat} -rvf ${1} ${f}
		else
			echo "SUURI HIRVIKYRPÄ ${f} "
			echo "5H0ULD exit 666"
			sleep 1
		fi
	done

	echo $?
	csleep 1

	luca ${1}
	csleep 1
	other_horrors 
	dqb "B3F0R3 TÖBX"
	csleep 1

	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	dqb "WLAN-RELAT3D"
	csleep 1
	${srat} -rvf ${1} /etc/default/net*

	case ${2} in
		wlan0)
			dqb "APW"
			csleep 1
			${srat} -rvf ${1} /etc/wpa_supplicant #parempi vetää koko hmisto
			csleep 2
			${srat} -tf ${1} | grep wpa
			csleep 2
		;;
		*)
			dqb "non-wlan"
		;;
	esac

	dqb "DSN"
	csleep 2
	local f
	local g
	
	if [ ${3} -eq 1 ] ; then #-gt 0 ?
		for f in $(find /etc -type f -name 'stubby*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name 'dns*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	else
		dqb "n0 5tub"
	fi

	local ef
	ef=$(echo ${4} | tr -d -c 0-9)

	if  [ ${ef} -eq 1 ] ; then
		dqb "Das Asdd"
	else
		#1.else-haara tOIMII , 1707126
		#2.fstab lisäksi muutakin mukaan vai ei? miten zxcv?
		${srat} -rf ${1} /etc/sudoers.d/meshuqqah /etc/fstab
	fi

	dqb "done w/ acolutes "
	dqb 1
}

#TODO<+:imp2 yms:jos ei ala toimia ilman -v ni tee jotain (?)
#020326:ehkä ok sisältö-siat (xorg ja ntp-jutut voisi testata paremmalla ajalla)

function e22_sarram() {
	dqb "e22_sarram ; $1 ;  $2 ;  $3 ;  $4 ; "

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9

	[ -z "${2}" ] && exit 11
	[ -z "${3}" ] && exit 13
	[ -s ${3} ] || exit 17

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	csleep 3
	
	dqb "find /etc -type f -name xorg \* -and -not -name \* . 202 \* "
	csleep 3

	#josko kopsaisi /e/X11 alle konffin testaustarkoituksissa? nykyään kyllä g_dout kopsailee
	for f in $(${odio} find /etc -type f -name 'xorg*' -and -not -name '*.202*') ; do
		dqb "${srat} -rvf ${1} ${f}"
		${srat} -rvf ${1} ${f}
		csleep 1
	done
	
	csleep 3
	dqb "AFTR X0RG"
	csleep 3

	#020326:tää kohta saattoi toimia oikein, ainakin kerran
	for f in $(${odio} find /etc -type f -name '${2}*' -and -not -name '*.202*') ; do #${g}
		dqb "${srat} -rvf ${1} ${f}"
		${srat} -rvf ${1} ${f}
		csleep 1	
	done

	csleep 2
	dqb "J.S0N V00RH335 WA5 H3R3"
	csleep 1
	${srat} -rvf ${1} /etc/X11/default-display-manager
	csleep 3

	#HUOM.tätä varten oli valmiskin palikka?
	${scm} 0555 /etc/iptables
	${scm} 0400 /etc/iptables/rules*
	${scm} 0400 /etc/default/rules*

	#020326:ehkä ok nämä 2
	for f in $(${odio} find /etc -type f -name 'rules.v?.?' -and -not -name '*.202*') ; do ${sah6} ${f} >> ${3} ; done
	for f in $(find ~ -type f -name '*pkgs*' -not -name '*.OLD') ; do ${sah6} ${f} >> ${3} ; done

	if [ -x /usr/sbin/ntpd ] ; then
		for f in $(${odio} find /etc -type f -name 'ntp*') ; do
			${srat} -rvf ${1} ${f}
			${sah6} ${f} >> ${3}
		done
	fi

	other_horrors
	csleep 1

	dqb "HA55AN-1-5ABBAtH D0n3"
	csleep 1
}

[ -v BASEURL ] || exit 6 

function e22_ext() { #TODO:testatakin voisi taas
#TODO:/o/b liittyvää käsittelyö uusicksi sittenq
	dqb "e22_ext ${1} ,  ${2}, ${3}, ${4}"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 2
	#[ -w ${1} ] || exit 6 
	[ -z "${2}" ] && exit 3
	[ -z "${3}" ] && exit 4
	[ -z "${4}" ] && exit 47
	[ -f ${4} ] || exit 48

	dqb "paramz_0k"
	csleep 1

	local p
	local q	
	local r
	local st

	csleep 1
	p=$(pwd)

	#q=$(${mkt} -d) #ei vaan toimi näin?
	q=$(mktemp -d)
	r=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	st=$(echo ${3} | tr -d -c 0-9)
	[ ${debug} -eq 1 ] && pwd

	cd ${q}
	csleep 1

	${tig} clone https://${BASEURL}/more_scripts.git
	[ $? -eq 0 ] || exit 66

	dqb "e22_ext PT2"
	csleep 1
	cd more_scripts/misc
	echo $?
	csleep 1

	${spc} /etc/dhcp/dhclient.conf ./etc/dhcp/dhclient.conf.${st}

	if [ ! -s ./etc/dhcp/dhclient.conf.1 ] ; then
		${spc} ./etc/dhcp/dhclient.conf.new ./etc/dhcp/dhclient.conf.1	
	fi

	${spc} /etc/resolv.conf ./etc/resolv.conf.${st}

	if [ ! -s ./etc/resolv.conf.1 ] ; then
		 ${spc} ./etc/resolv.conf.new ./etc/resolv.conf.1
	fi

	dqb "N1B.5"
	csleep 1
	${spc} /sbin/dhclient-script ./sbin/dhclient-script.${st}

	if [ ! -s ./sbin/dhclient-script.1 ] ; then
		 ${spc} ./sbin/dhclient-script.new ./sbin/dhclient-script.1
		ls -las ./sbin
		csleep 3
	else
		dqb "./sbin/dhclient-script.1 EXISTS"
	fi

	dqb "SOUCRES"
	csleep 1

	if [ -f /etc/apt/sources.list ] ; then
		local c
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:'  | wc -l)

		if [ ${c} -lt 1 ] ; then
 			${spc} /etc/apt/sources.list ./etc/apt/sources.list.${2}
		fi
	fi

	${svm} ./etc/apt/sources.list ./etc/apt/sources.list.tmp
	${svm} ./etc/network/interfaces ./etc/network/interfaces.tmp

	dqb "1N.T3RF"
	csleep 1
	${spc} /etc/network/interfaces ./etc/network/interfaces.${r}

	${sco} -R root:root ./etc
	${scm} -R a-w ./etc
	${sco} -R root:root ./sbin 
	${scm} -R a-w ./sbin
	${srat} -rvf ${1} ./etc  #./sbin jälkimmäinen hmisto josqs takaisin vai ei?

	echo $?

	local f
	#160126:tuon yhden tdston kanssa jokin ongelma sha-tark kanssa, joten ksrdotssn
	#pois myös resolv.conf.* vaiko ei ?

	for f in $(find ./etc -type f -not -name interfaces.tmp) ; do
		${sah6} ${f} >> ${4}
	done

	dqb "${sah6}  . / sbin / \* >> ${4} (maybe?)"
	csleep 1

	cd ${p}
	[ ${debug} -eq 1 ] && pwd
	dqb "e22_ext done"
	csleep 1
}

#010326:jos vaikka toimisi
function e22_ts() {	
	dqb "e22_ts () ${1} ${2}"
	#van1 param pitäisi olla tällä fktoiplla - Yoda
	csleep 2

	[ -z "${1}" ] && exit 13
	[ -d ${1} ] || exit 14 #hmistossa hyvä olla kirj.oik.
	[ -w ${1} ] || exit 15 

	dqb "NEXT:m v ${CONF_pkgdir} / \* . deb ${1}"
	csleep 3
	${svm} ${CONF_pkgdir}/*.deb ${1}
	dqb $?
	csleep 3

	#lisätäänkö tämä arkistoon jossain? no e22_a()
	fasdfasd ${1}/tim3stamp
	date > ${1}/tim3stamp

	cg_udp6 ${1}
	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb
	csleep 5

	dqb "E22TS DONE"
	csleep 2
}

function e22_arch() { 
	dqb "e22_arch ${1} , ${2} " 
	csleep 1

	[ -z "${1}" ] && exit 1
	#[ -s ${1} ] || exit 2 #antaa nyt olla kommenteissa
	#[ -w ${1} ] || exit 33 #josko man bash...
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 44

	dqb "paramz_ok"
	csleep 1

	p=$(pwd)
	csleep 1
	#HUOM.23725 bashin kanssa oli ne pushd-popd-jutut

	if [ -f ${2}/sha512sums.txt ] ; then
		dqb "rem0v1ng pr3v1oisu shasums"
		csleep 1

		${NKVD} ${2}/sha512sums.txt*
	else
		dqb "JGFIGFIYT"
	fi

	csleep 1
	local c
	c=$(find ${2} -type f -name '*.deb' | wc -l)

	if [ ${c} -lt 1 ] ; then
		echo "TH3R3 1S N0 F15H"
		exit 55
	fi

	dqb "KJHGOUYFIYT"
	csleep 1

	${scm} 0444 ${2}/*.deb
	fasdfasd ${2}/sha512sums.txt
	fasdfasd ${2}/sha512sums.txt.1
	[ ${debug} -eq 1 ] && ls -las ${2}/sha*;sleep 3

	cd ${2}
	echo $?
	${sah6} ./*.deb > ./sha512sums.txt

	dqb "KUKK0 K1EQ 666"

	${sah6} ./reject_pkgs >> ./sha512sums.txt.1
	${sah6} ./accept_pkgs_? >> ./sha512sums.txt.1
	${sah6} ./pkgs_drop >> ./sha512sums.txt.1
	csleep 1

	[ ${debug} -eq 1 ] && ls -las ${2}/sha*;sleep 3
	#alla tuo mja tulisi asettaa vain silloinq vastaava sal av löytyy, tos tate the obvious

	#HUOM gpgv VITTUUN SOTKEMASTA
	#dirmngr kuitenkin tarvitsee jhnkin?
	#"gpg --keyserver hkps://keys.gnupg.net --receive-keys $something" esim.

	if [ -x ${gg} ] && [ -v CONF_pubk ] ; then
		dqb "GGU"
		csleep 1
		${gg} -u ${CONF_pubk} -sb ./sha512sums.txt
		${gg} -u ${CONF_pubk} -sb ./sha512sums.txt.1
		dqb "GHATS"
	else
		dqb "1. ${gg}"
		dqb "2. ${CONF_pubk}"
		csleep 5
	fi

	csleep 1
	psqa .

	${srat} -rf ${1} ./*.deb ./sha512sums.txt* ./tim3stamp
	[ ${debug} -eq 1 ] && ls -las ${1} 

	csleep 5
	cd ${p}
	dqb "e22_arch d0n3"
}

function e22_dblock() { #150126:lisää toivottavaa sisältöä kohde-pakettiin
	dqb "e22_dblock( ${1}, ${2}, ${3} )"

	[ -z "${1}" ] && exit 14
	[ -s ${1} ] || exit 15 #"exp2 e" kautta tultaessa tökkäsi tähän kunnes
	#[ -w ${1} ] || exit 16 #ei näin?

	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 23

	[ -z "${3}" ] && exit 33
	[ -d ${3} ] || exit 34
	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...

	dqb "DBLOCK:PARAMS OK"
	csleep 1

	[ ${debug} -eq 1 ] && pwd
	csleep 1
	#aval0n #tarpeellinen?

	dqb "bFR 175:"
	ls -la ${3}/*.deb | wc -l
	csleep 5
	
	for s in ${PART175_LIST} ; do
		${sharpy} ${s}*
		${NKVD} ${3}/${s}*.deb
	done

	dqb "AFTR 175:"
	ls -la ${3}/*.deb | wc -l
	csleep 5

	local t
	t=$(echo ${2} | cut -d '/' -f 1-5)
	e22_ts ${2}

	enforce_access ${n} ${t} ${CONF_iface} #tarpeellinen nykyään?
	e22_arch ${1} ${2}
	csleep 1

	e22_cleanpkgs ${2}
	dqb "e22dblock DONE"
}

#===========================E23.SH ? =======================================
#091225:toimii

function aswasw() { #privaatti fktio
	dqb " aswasw ${1}"
	[ -z "${1}" ] && exit 56
	csleep 1

	case ${1} in
		wlan0)
			#E22:GN="libnl-3-200 ... "
			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2
			#${shary} libdbus-1-3 toistaiseksi jemmaan 280425, sotkee

			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 #libreadline8 # libssl3 adduser
			${shary} wpasupplicant
		;;
		*)
			dqb "not pulling wpasuplicant"
			csleep 1
		;;
	esac

	dqb " aswasw ${1} DONE"
	csleep 1
}

#function aval0n() { #prIvaattI, toimimaan+käyttöön?
#	dqb " \${sharpy} libavahi \* #saattaa sotkea ?"
#	dqb " \${NKVD} ${CONF_pkgdir} / libavahi \* ?"
#}

#130126:tehdyn paketin sisältö asentuu ainakin live-ymp, vissiin myös sqrootissa
#HUOM.080326:3. param tarpeellisuus?
#TODO:testaus uusicksi josqs

function e22_tblz() {
	#HUOM.28925:vieläkö asentaa avahin?
	dqb "x2.e22_tblz ${1} , ${2}  , ${3}  , ${4} "

	csleep 1
	dqb "\$shary = ${shary}"
	csleep 2

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 15 
	[ -z "${2}" ] && exit 12
	[ -z "${3}" ] && exit 13
	[ -z "${4}" ] && exit 14

	dqb "parx_ok"
	csleep 2

	dqb "EDIBLE AUTOPSY"
	csleep 1
	${fib}
	${asy}
	csleep 1

	#message() tähän?
	tpc7	#jotain excaliburiin liittyvää
	aswasw ${2}
	${shary} ${E22_GT} 

	dqb "x2.e22_tblz.part2"
	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}
	csleep 2

	${asy}
	dqb "BEFORE e22_pre2"
	csleep 2

	#actually necessary
	e22_pre2 ${1} ${3} ${2} ${4} 
	other_horrors
	dqb "x2.e22_tblz.done"
}

#VAIH:ntp-jutut takaisin josqs?
#tables-säännöt vissiin ok
#ja ainakin oletus-konf löytyy
#niin että

#010326:toimii (testaa josqs uusiksi, TODO) 
#btw. mikä muuten syynä libgfortran5-nalkutukseen?
#HUOM.080326:1. param luultavasti tarpeellinen myös jatkossa

function e22_other_pkgs() { 
	dqb "e22_other_pkgs ${1} ,  ${2}  ASDFASDFASDF"
	#toista param? eiole
	csleep 1

	[ -z "${1}" ] && exit 11
	dqb "paramz_ok"
	csleep 1

	dqb "shary= ${shary}"
	csleep 4

	#LOPPUU SE PURPATUS PRKL
	#jatkossa osa E22_GS ?
	${shary} cpp-12 gcc-12-base libstdc++6 
	${shary} libgcc-s1 libc6 libgomp1 
	csleep 2
	
	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?

	${shary} ${E22GI}
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0  git-man git"
	${shary} ${E22_GG}

	#sudo-asia olisi jo kunnossa 120126?	ehkä
	E22_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"
	
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} ${E22_GS}  #moni pak tarttee nämä
	#${shary} #bsd debconf

	#${shary} seatd #130126:paskooko tämä kuitenkin asioita vai ei? ehkä
	message
	jules

	if [ ${1} -eq 1 ] ; then
		${shary} libgmp10 libhogweed6 libidn2-0 libnettle8
		${shary} runit-helper
		${shary} dnsmasq-base dnsmasq dns-root-data #dnsutils
		${lftr} 

		[ $? -eq 0 ] || exit 3

		${shary} libev4
		${shary} libgetdns10 libbsd0 libidn2-0 libssl3 libunbound8 libyaml-0-2 #sotkeekohan libc6 uudelleenas tässä?
		${shary} stubby
	fi

	csleep 1
	${lftr} 
	[ $? -eq 0 ] && dqb "luBE 0F THE R3S0NATED"
	csleep 2
	dqb "MåGOG"
	
#	#TODO:jos lukaisi debian referencen pitkästä aikaa, että löytyisikö jotain jekkua paketinhallinnan kanssa? ettei tarvitse kikkailla initramfs:n ja muutaman paketin kanssa
#	... package pinning?
#	${lftr}
#	csleep 2

#	vähän aikaa ilman kunnes saa aikaiseksi konffata
#	${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
#	${shary} ntpsec
		
	csleep 2
	dqb "e22_other_pkgs donew"
	csleep 1
}

#120126:taitaa toimia tämä
function e22_profs() {
	dqb "e22_profs ${1} ${2}"

	[ -z "${1}" ] && exit 99
	[ -s ${1} ] || exit 98 #pitäisi varmaan tunkea tgtfileeseen jotain että tästä pääsee läpi
	#[ -w ${1} ] || exit 97
	[ -z "${2}" ] && exit 96
	[ -d ${2} ] || exit 95
	[ -w ${2} ] || exit 94

	dqb "params ok"
	csleep 1

	local q
	#q=$(${mkt} -d) #ei näin?
	q=$(mktemp -d)

	cd ${q} #antaa nyt cd:n olla toistaiseksi
	[ $? -eq 0 ] || exit 77

	#jospa antaisi vihjeen ifup:ista jatkossa?
	${tig} clone https://${BASEURL}/more_scripts.git
	[ $? -eq 0 ] || exit 99
	
	[ -s ${2}/profs.sh ] && mv ${2}/profs.sh ${2}/profs.sh.OLD
	mv more_scripts/profs/profs* ${2}

	${scm} 0755 ${2}/profs*
	cd ${2}	
	${srat} -rvf ${1} ./profs.*

	cd ${q}
	dqb "AAMUNK01"
}

#äksän kanssa "+scm +usermod -seatd" se toimiva jekku?

function e22_upgp() {
	dqb "e22_upgp ${1}, ${2}, ${3}, ${4}"
	#ei pitäne tulla neljättä

	[ -z "${1}" ] && exit 1 
	#[ -w ${1} ] || exit 44 #man bash taas?
	#[ -s ${1} ] && mv ${1} ${1}.OLD 261225 laitetttu kommentteihin koska aiheutti ongelmia
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -z "${3}" ] && exit 33 #kuinkahan tarpeellista on tämäkin tuoda fktioon?

	dqb "params_ok"
	csleep 5
	
	${fib}
	csleep 1

	#LOPPUU SE PURPATUS PRKL
	${shary} cpp-12 gcc-12-base libstdc++6 
	${shary} libgcc-s1 libc6 libgomp1 

	#helpompi vain ajaa e22_dm() ennen upgp()
	
	#HUOM.27925: "--yes"- vipu pitäisi olla mukana check_bin2 kautta, onko?
	${sag} --no-install-recommends upgrade -u
	echo $?
	#HUOM.081225:pitäisiköhän keskeyttää tässä jos upgrade qsee?
	csleep 1

	# #d-blkissa jatkossa?
	[ ${debug} -eq 1 ] && ls -las ${2}/*.deb
	csleep 5

	dqb "generic_pt2 may be necessary now"	
	csleep 1

	${sifd} ${3}
	csleep 1
	
	dqb " ${3} SHOULD BE Dbtl 1n turq"
	csleep 1

	#HUOM.part076() ja part2_5() on keksitty (tosin e22_dblock() nykyään...)
	[ ${debug} -eq 1 ] && ls -las ${2}/*.deb
	csleep 1
	
	case ${3} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 1
		;;
		*)
			${NKVD} ${2}/wpa*
			#HUOM.25725:pitäisi kai poistaa wpa-paketit tässä, aptilla myös?
			#... vai lähtisikö vain siitä että g_pt2 ajettu ja täts it
		;;
	esac

	csleep 1
	dqb "SIELUNV1H0LL1N3N"
	csleep 1
}

function e22_rpg() {
	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98
	
	[ -s "${1}" ] || exit 97
	[ -d ${2} ] || exit 96

		exit 69
#
#		e22_cleanpkgs ${2}
#		csleep 1
#		
#		${smr} ${2}/f.tar
#		csleep 1
#		
#		#toimiiko tuo exclude? jos ei ni jotain tarttis tehrä
#		#... koko case pois käytöstä vaikka
#	
#		${srat} --exclude 'sha512sums*' --exclude '*pkgs*' -C ${d} -xvf ${1}
#		[ $? -eq 0 ] && ${svm} ${1} ${1}.OLD
#		csleep 1
#
#		#... toimii vissiin mutta laitettu pois pelistä 241225 jokatapauksessa
#			
#		e22_arch ${1} ${2}
#		cd ${2}
#
#		#sotkee sittenkin liikaa?
#		#${srat} -rvf ${1} ./accept_pkgs* ./reject_pkgs* ./pkgs_drop
#		
#		#for t in $(${srat} -tf ${1}) ; do #fråm update2.sh
#		#	${srat} -uvf  ${1} ${t}
#		#done
#		
#		exit
}

function e22_fgh() {
	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98	
	[ -s "${1}" ] || exit 97

	e22_hdr ${1}
	e22_arch ${1} ${2}
	e22_ftr ${1}
	exit
}

#VAIH:tdstonnimi parametriksi
#VAIH:param tark
#TODO:testaa

function e22_qrs() {
	[ -z "${1}" ] && exit 77
	[ -s ${1} ] || exit 66
	[ -r ${1} ] || exit 55
	[ -z "${4}" ] && exit 44
	
	e22_config1 ~ ${CONF_default_arhcive2}
	${srat} -rvf $1} ~/${CONF_default_arhcive2} #VAIH:CONBF_def_yhyy

	dqb $?
	csleep 4

	${NKVD} ~/${CONF_default_arhcive}
	csleep 1

	e22_settings ${2} ${CONF_default_arhcive}
	#btw. mikä olikaan syy että q on tässä ekassa switch-case:ssa? pl siis että turha apt-renkkaus

	for f in $(find ${2} -maxdepth 1 -name '${CONF_default_arhcive}' -or -name 'profs.sh' | grep -v pulse) ; do
		${srat} -rvf ${1} ${f}
	done

	e22_ftr ${1}
	dqb "CASE Q D0N3"
	csleep 3
	exit
}

function e22_cde() {
	#130126:laati paketin, sisältö:lienee ok
	# tekee paketin (mod ehkä /tmp-hmiston  kiukuttelut)
	#-T - vipu tar:in kanssa käyttöön vai ei? pärjännee ilmankin
	
	#TODO:tmän kanssa sitä self_extracting_archive-juttua kokeillen?
	
	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98
	[ -d "${2}" ] || exit 97

	cd ${2}
	fasdfasd ${1}
	[ ${debug} -eq 1 ] && ls -las ${1}*
	csleep 2
		
	${srat} --exclude '*merd*' -jcvf ${1} ./*.sh ./pkgs_drop ./${3}/*.sh ./${3}/*_pkgs* ./${3}/pkgs_drop ./1c0ns/*.desktop
	e22_ftr ${1}
	exit
}

function e22_ghi() {
	dqb "TODO:testaa"
	dqb "${sag_u} | ${fib} , when necessary " 
	exit 44

	echo "${shary} ${E22GI}"
	echo "${svm} ${CONF_pkgdir}/*.deb ${2}/${3}"
	
	echo "$0 f ${1} ${3}"
	#exit 1
}

function e22_pqr() {
	[ -z "${1}" ] && exit 99
	[ -z "${2}" ] && exit 98
	#mihin muuten kosahtaa jos omegan jälkeen tätä ajaa? srat vai fasdfasd vai mikä?

	e22_hdr ${1}
	e22_profs ${1} ${2}
	exit
}
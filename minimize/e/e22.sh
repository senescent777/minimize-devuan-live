dqb "${sco} -Rv _apt:root ${CONF_pkgdir}/partial"
csleep 1

#130126:sellainen aivopieru että {exp2, e22} toiminnalliSuuden saattaisi voida korvata Makefilellä ainakin osoittain
#... jotain jaottelua(yleinen/ertiyinen) fktioiden kanssa myös?

${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
${scm} -Rv 700 ${CONF_pkgdir}/partial/
csleep 1

if [ -v CONF_pubk ] ; then #&& ( -v CONF_ksk ) #pubk vai kpub?
	dqb "no keys.conf needed"
else
	#if [ -v CONF_testgris ] ; then #ei sittenkään näin?
	#	dqb "${odio} find ${CONF_testgris} -type f -name keys.conf | head -n 1"
	#	csleep 5
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
	#fi
fi

csleep 5

function e22_hdr() {
	#140126:lienee toimiva fktio koska x
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

function e22_pre1() { #130126:edelleen toimiva?
	#distRo-parametrin vaikutukset voisi testata, sittenq parsetus taas toimii kunnolla(?)

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

		enforce_access ${n} ${lefid} ${CONF_iface} #jos taas toimisi
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

function e22_pre2() { #120126:toiminee edelleen
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

	if [ -d ${1} ] && [ -x /opt/bin/changedns.sh ] ; then
		dqb "PRKL"

		${odio} /opt/bin/changedns.sh ${par4} ${ortsac}
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

#120126:taisi toimia taas
#HUOM.1§50126:loka() yrittää vetää /e alta xorg konftdston mukaan pakettiin
#... ei ole ihan pakko config1:sessä siis

function e22_config1() {
	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22

	dqb "CFG"
	local p
	p=$(pwd)

	cd ${1} 
	#tar:issa olisi myös -C , josko sitä käyttämään jatkossa

	[ -f config.tar.bz2 ] && mv config.tar.bz2 config.tar.bz2.ÅLD
	tar -jcf config.tar.bz2 .config/xfce4/xfconf/xfce-perchannel-xml ./xorg.conf*

	csleep 1
	[ -s config.tar.bz2 ] || exit 99
	
	cd ${p}
	dqb "CDONE"
}

#TODO:ffox 147? https://www.phoronix.com/news/Firefox-147-XDG-Base-Directory  
#nuo muutokset oikeastaan tdstoon profs.sh
#pitäisIkö siirtää toiseen tdstoon?
#120126 saattoi toimia testin ajan

function e22_settings() {
	dqb "e22_settings ${1},  ${2}"
	csleep 1

	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22

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
	[ -f ${1}/fediverse.tar ] && mv ${1}/fediverse.tar ${1}/fediverse.tar.ÅLD
	exp_prof ${1}/fediverse.tar default-esr	
		
	csleep 1
	dqb "SOME BASIC TESTS w/  ${1} / fediverse.tar "
	csleep 2

	[ -s ${1}/fediverse.tar ] || exit 32
	local t
	t=$(tar -tf ${1}/fediverse.tar | grep prefs.js | wc -l)
	[ ${t} -lt 1 ] && exit 27
	csleep 5

	dqb "TSTS DONE"
	csleep 1

	dqb "e22_settings ${1} , ${2} DONE"
	csleep 1
}

function e22_home() { #160126:suattaapi vaikka toimia
	dqb "  e22_home() ${1} , ${2} , ${3}  "

	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71
	csleep 1

	dqb "params_ok"
	csleep 1
	[ ${debug} -eq 1 ] && pwd
	csleep 1

	#141225:if-lauseen pointti nykyään? tähän liittyen oli jokin idea (120126)
	if [ ${3} -eq 1 ] && [ -d ${2} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		e22_config1 ~
		${NKVD} ~/fediverse.tar
		e22_settings ${2}/..
	else
		dqb "PUIG DESTRÖYERR b666"
	fi

	local t
	csleep 1
	${srat} -rvf ${1} /opt/bin/changedns.sh

	for t in $(find ~ -type f -name merd2.sh -or -name config.tar.bz2) ; do
		${srat} -rvf ${1} ${t}
	done

	${srat} -rvf ${1} ${2}/../fediverse.tar	
	csleep 5

	t=$(${srat} -tf ${1} | grep fediverse.tar | wc -l)
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

	dqb "JUST BEFOREs LOCALES"
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

#pitäisiköhäbn myös paremtrein määrälle tehdä jotain? fcktion pilkkominen esim?
#
#... muuten lienee ok mutta slim/xdm/wdm-spesifinen konfiguraatio ei vielä tule mukaan

function loka() { 
	dqb "loka ${1} , ${2} , ${3} , ${4} , ${5} , ${6}"
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

	for f in $(find /etc -type f -name 'rules*' -and -not -name '*.202*') ; do
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

	#mikä järki juuri tässä keskeyttää suoritus?
	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	dqb "WLAN-RELAT3D"
	csleep 1

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

	#jos tämä blokki aikaisemmaksi jatkossa, loka
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
	#

	local ef
	ef=$(echo ${4} | tr -d -c 0-9)

	if  [ ${ef} -eq 1 ] ; then
		dqb "Das Asdd"
	else
		#1.else-haara tOIMII , 1707126
		#2.fstab lisäksi muutakin mukaan vai ei?
		${srat} -rf ${1} /etc/sudoers.d/meshuqqah /etc/fstab
	fi

}

function marras() {
	dqb "marras $1 $2 $3 $4"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 

	#[ -w ${1} ] || exit 9
	#TODO:param tark. pitäisi lotota uusiksi

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	csleep 3
	
	dqb "find /etc -type f -name xorg \* -and -not -name \* . 202 \* "
	csleep 3

	for f in $(find /etc -type f -name 'xorg*' -and -not -name '*.202*') ; do
		dqb "${srat} -rvf ${1} ${f}"
		${srat} -rvf ${1} ${f}
		csleep 1
	done
	
	csleep 3
	#130126:josko alkaisi vähitellen tulla wdm-jutut mukaan? ei vielä koska jokin juttu?
	dqb "find / etc -type f -name ${2} \* -and -not -name  \* .202 \* "
	csleep 3

	g=$(${odio} find /etc -type f -name '${2}*' -and -not -name '*.202*')

	for f in ${g} ; do
		dqb "${srat} -rvf ${1} ${f}"
		${srat} -rvf ${1} ${f}
		csleep 1	
	done

	csleep 3
	${srat} -rvf ${1} /etc/X11/default-display-manager
	csleep 3

	${scm} 0555 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	#HUOM.150226:alkanut näyttää huonolta idealta ottaa listaan mukaan täsmälleen rules.v4 ja rules.v6
	#... persistentit otettu pois paketeista sivuvaikutuksena, barm vuoksi ( kts check_bin)

	for f in $(${odio} find /etc -type f -name 'rules.v*' -and -not -name '*.202*') ; do ${sah6} ${f} >> ${3}	; done
	for f in $(find ~ -type f -name '*pkgs*' -not -name '*.OLD') ; do ${sah6} ${f} >> ${3}	; done

	other_horrors
	dqb "loka done"
	csleep 1
}

[ -v BASEURL ] || exit 6 

function e22_ext() { #160126:toiminee
	dqb "e22_ext ${1} ,  ${2}, ${3}, ${4}"
	#160126:kuinka monta param nykyään tarvitsee tämä?

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

function e22_ts() {
	#130126:jos vaikka toimisi?
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

	udp6 ${1}
	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb
	csleep 5

	dqb "E22TS DONE"
	csleep 2
}

#HUOM.olisi hyväksi, ensisijaisesti .deb-pak sisältävien .tar kanssa, joko poistaa kirj- oik luonnin jälkeen ja/tai gpg:llä sign ja vast tark jottei vahingossa muuttele

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
	#090126:ao,. fktioon liittyen changedns jos tarkistaisi rules.* - tdstot
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

	enforce_access ${n} ${t}  ${CONF_iface} #tarpeellinen nykyään?
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

#VAIH:ntp-jutut takaisin josqs? tables-säännt ja mahd konffayus varmaan seuraavaksi (JOKO JO?)

#140126:joskohan paketin sisältö toimisi? ehkä just ennen ntpsec
#btw. mikä muuten syynä libgfortran5-nalkutukseen?
function e22_other_pkgs() { 
	dqb "e22_other_pkgs ${1} ,  ${2}  ASDFASDFASDF"
	#toista param? eiole
	csleep 1

	[ -z "${1}" ] && exit 11
	dqb "paramz_ok"
	csleep 1

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
		#josqs ntp-jututkin mukaan?
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

	#uutena 170126, pois jos qsee
	# Depends:
	#adduser, ,,, (= 1.2.2+dfsg1-1+deb12u1),, (>= 0.0), libc6 (>= 2.34), (>= 1:2.10), (>= 3.0.0)
	#TODO:NTP-KIKKAREEN KONFFAAMINEN	

	${shary} lsb-base netbase python3 python3-ntp tzdata libbsd0 libcap2 libssl3
	${shary} ntpsec
		
	csleep 2
	dqb "e22_other_pkgs donew"
	csleep 1
}

#DONE:uusi wdm-paketti modatun ison rakennusta varten, asentuu sekä live että sqroot, tosin jotain kiukuttelua äksän kanssa EDELLEEN
#wdm kanssa kun xorg kiukuttelee ni jospa a) xdm tai b) DISPLAY MANAGEr WTTUUN KOKONAAN 666 
function e22_dm() {
	dqb "e22dm ( ${1} ) "
	csleep 1

	[ -z "${1}" ] && exit 11
	csleep 4

	${fib}
	csleep 2
	
	#LOPPUU SE PURPATUS PRKL
	${shary} cpp-12 gcc-12-base libstdc++6 
	${shary} libgcc-s1 libc6 libgomp1 
	csleep 1

	${shary} libice6 libsm6 libx11-6 libxext6 libxmu6 libxt6
	${shary} menu twm
	csleep 1
	
	#libselinux oikeastaan muualla jo
	${shary} libcrypt1 libpam0g libselinux1 #jemmaan?
	${shary} libxau6 libxaw7 libxdmcp6 libxft2 libxinerama1 
	csleep 1
	
	${shary} libxpm4 libxrender1 debconf x11-utils cpp lsb-base x11-xserver-utils procps
	csleep 1

	${shary} libgtk-3-0 libgtk-3-common
	csleep 1

	${shary} libxxf86vm1 libxrandr2 libxml2 libxi6 libglib2.0-0 libglib2.0-data libatk1.0-0 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-common
	csleep 1

	${shary} fontconfig libfribidi0 libharfbuzz0b libthai0
	${shary} libfreetype6 libxcb-shape0 libxcb-damage0 libxcb-present0 libxcb-xfixes0 libxcb1
	${shary} libxcb-render0 libxcb-shm0
	#, , 

	case ${1} in
		xdm) #010126:pitäisiköhän tämäkin case testata?
			${shary} xdm
		;;
		wdm)
			# zlib1g perl:any xserver-xorg | xserver:tarteeko juuri tässä vetää?
			${shary} libnuma1

			${shary} libwebp7 libaom3 libdav1d6 libde265-0 libx265-199
			#csleep 1

			${shary} libwebpdemux2 libheif1 libaudit-common libcap-ng0 libaudit1
			csleep 1

			${shary} libdb5.3 libpam-modules-bin libpam-modules libpam-runtime
			#csleep 1

			${shary} sysvinit-utils libtinfo6 libpng16-16 libx11-xcb1  
			csleep 1

			${shary} libxfixes3 libxcursor1
			#csleep 1

			${shary} libxkbfile1 libxmuu1 
			#bsdextrautils | bsdmainutils 
			${shary} bsdextrautils groff-base libgdbm6 libpipeline1 libseccomp2 man-db
			csleep 1

			${shary} libexpat1 fontconfig-config libfontconfig1
			${shary} libfontenc1 libglvnd0 libglx0 libgl1  
			#csleep 1

			${shary} x11-common libxtst6 libxv1 libxxf86dga1 
			csleep 1

			#Depends:  (>= 2.33),  (>= 1.6.2-1), , ,  (>= 2:1.7.5),  (>= 2:1.0.14), , , , , (>> 1.1.2), ,  (>> 2.1.1), (>= 2:1.2.99.4),  (>= 1:1.1.0),  (>= 2:1.1.3), (>= 2:1.1.3), ,  (>= 1:1.1.0), 

			${shary} psmisc x11-apps
			#csleep 1

			${shary} libpcre2-8-0 libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
			csleep 1

			${shary} libgif7 libwraster6 libjpeg62-turbo
			${shary} imagemagick-6-common libmagickwand-6.q16-6 libtiff6
			#csleep 1

			${shary} libbz2-1.0 libfftw3-double3  libjbig0 liblcms2-2 liblqr-1-0 libltdl7 liblzma5 libopenjp2-7 libwebpmux3
			csleep 1

			${shary} libmagickcore-6.q16-6 
			#csleep 1

			${shary} libwutil5 wmaker-common libwings3
			csleep 1

			${shary} libx11-data libmd0 libbsd0
			#csleep 1 	
		
			${shary} wdm
		;;
#		lxdm)
#			
#			${shary} libpixman-1-0
#			csleep 1
#			
#			#jos aikoo dbusista eroon ni libcups2 asennus ei hyvä idea
#			
#			# (>= 1.28.3),  (>= 1.28.3),(>= 1.28.3),(>= 2:1.4.99.1),  (>= 1:0.4.5), libxcursor1 (>> 1.1.2), libxdamage1 (>= 1:1.1), , libxfixes3,  (>= 2:1.1.4),  (>= 2:1.5.0),  adwaita-icon-theme | gnome-icon-theme, hicolor-icon-theme, shared-mime-info
#			${shary} libpangocairo-1.0-0   
#			csleep 1
#
#			${shary} libdeflate0 debliblerc4 
#			csleep 1
#
#			#acceptiin ainakin 2-0-common enne 2-0 ja sitten muuta tauhkaa hakien tässä kunnes alkaa riittää
#			${shary} libcairo2 libgtk2.0-common libgtk2.0-0
#			csleep 1
#	
#			#gdk ennen gtk?
#			${shary}   
#			csleep 1
#		
#			${shary} gtk2-engines-pixbuf gtk2-engines 
#			csleep 1
#
#			${shary} lxdm 
#			csleep 1
#			
#			#261225:lxde-juttujrn ja lxpolkit:in riippuvuukisien selvutys saattaa osoittautua tarpeelliskeis?
#			
#			#polkit-1-auth-agent:
#			
#			#${shary} lxsession-data libpolkit-agent-1-0 libpolkit-gobject-1-0 policykit-1 laptop-detect lsb-release
#			#csleep 1
#			 
#			#	 lxlock | xdg-utils, 
#
#			# lxpolkit | polkit-1-auth-agent,  lxsession-logout
#			
#			${shary} lxpolkit lxsession-logout lxsession
#			csleep 1
#		;;
		*)
			dqb "sl1m?"
		;;
	esac
	
	E22_GX="libwww-perl xscreensaver-data init-system-helpers libegl1 xscreensaver"
	${shary} ${E22_GX}  #libsystemd0
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
	csleep 2
	
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

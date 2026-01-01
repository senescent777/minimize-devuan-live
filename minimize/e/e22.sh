dqb "${sco} -Rv _apt:root ${CONF_pkgdir}/partial"
csleep 1

${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
${scm} -Rv 700 ${CONF_pkgdir}/partial/
csleep 1

if [ -v CONF_pubk ] ; then #&& ( -v CONF_ksk ) 
	dqb "no keys.conf needed"
else
	#voisi tarkemminkin speksata mistä haetaan?
	arsch=$(find / -type f -name 'keys.conf' | head -n 1)

	if [ ! -z "${arsch}" ] ; then
		if [ -s ${arsch} ] ; then
			. ${arsch}
		fi
	fi

	csleep 1
	unset arsch
fi

csleep 1

function e22_hdr() {
	#091225:toiminee sillä ehdolla että EI tätä ennen sano "chmod o+t /tmp"

	dqb "e22hdr():BEFORE "
	csleep 1
	[ -z ${1} ] && exit 61

	fasdfasd ./rnd
	fasdfasd ${1} #kanssa myös?
	csleep 1

	dd if=/dev/random bs=12 count=1 > ./rnd
	#dqb "srat= ${srat}"
	csleep 2

	${srat} -cvf ${1} ./rnd
	[ $? -gt 0 ] && exit 60

	[ ${debug} -eq 1 ] && ls -las ${1}
	csleep 2

	dqb "e22hdr():AFTER th3 WAR"
	csleep 1
}

function e22_ftr() { #231225:pitäisiköhän jo testata uuedstaan?
	dqb "ess_ftr( ${1} )"
	csleep 1

	[ -z ${1} ] && exit 62
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
	
	#riittävät tarkistukset?
	if [ -x ${gg} ] ; then
		if [ -v CONF_pubk ] ; then
			${gg} -u ${CONF_pubk} -sb ${q}.sha
			[ $? -eq 0 ] || dqb "SIGNING FAILED, SHOUDL IUNSTALLLL PRIVATE KEYS OR SMTHING ELSE"
			csleep 1

			${gg} --verify ${q}.sha.sig
			csleep 1
		else
			dqb "NO KEYS?"
		fi
	else
		dqb "SHOULD INSTALL GPG"
	fi

	cd ${p}
	echo "cp ${1} \${tgt}; cp ${1}.* \${tgt}" 
	dqb "ASSAN VESSAN KASSA"
	csleep 1
}

function e22_pre1() { #091225:vissiin toimii koska "exp2 3"
	#disto-parametrin vaikutukset voisi testata, sittenq parsetus taas toimii kunnolla(?)

	dqb "e22_pre1 ${1}  ${2} "
	[ -z ${1} ] && exit 65 #-d- testi olikin jo alempana
	[ -z ${2} ] && exit 66

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

		enforce_access ${n} ${lefid} #jos jo toimisi
		csleep 1
		dqb "3NF0RC1NG D0N3"

		csleep 1
		${scm} 0755 /etc/apt
		${scm} a+w /etc/apt/sources.list*

		part1 ${1}
	fi

	dqb "per1 d0n3"
	csleep 1
}

#...note to self: oli varmaankin kommentti yllä cross-distro-syistä, ehkä jossain kohtaa jos sitä juttua teatsisi uudestaan

function e22_pre2() { #091225:vissiin toimii koska "exp2 3"
	dqb "e22_pre2 ${1}, ${2} , ${3} , ${4}  ...#WTIN KAARISULKEET STNA" 
	csleep 1

	[ -z ${1} ] && exit 66 #HUOM. -d oli jo
	[ -z ${2} ] && exit 67
	[ -z ${3} ] && exit 68
	[ -z ${4} ] && exit 69

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

function e22_cleanpkgs() { #HUOM.301125:toimii
	dqb "e22_cleanpkgs ${1} , ${2} , ${3}  " #(tulisi olla vain 1 param)
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

#pitäöiskö siirtää toiseen tdstoon?
#VAIH:jos sitten tämän kautta mukaan se äksän konf (kys tdston sisällön lottoaminen taas jossain muualla) (olisikohan jo 25122555555 thty?)
function e22_config1() {
	[ -z ${1} ] && exit 11
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
#pitäöiskö siirtää toiseen tdstoon?
function e22_settings() {
	dqb "e22_settings ${1},  ${2}"
	csleep 1

	[ -z ${1} ] && exit 11
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
	dqb "SOME BASIC TESTS w/  ${1}/fediverse.tar "
	csleep 2

	[ -s ${1}/fediverse.tar ] || exit 32
	local t
	t=$(tar -tf ${1}/fediverse.tar | grep prefs.js | wc -l)
	[ ${t} -lt 1 ] && exit 27
	csleep 10

	dqb "TSTS DONE"
	csleep 1

	dqb "e22_settings ${1} , ${2} DONE"
	csleep 1
}

#pitäöiskö siirtää toiseen tdstoon?
function e22_home() { #151225:josko prof.asiat taas tilap. kunn.
	dqb "e22_home ${1} , ${2} , ${3}  "

	[ -z ${1} ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z ${2} ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z ${3} ] && exit 71
	csleep 1

	dqb "params_ok"
	csleep 1
	[ ${debug} -eq 1 ] && pwd
	csleep 1

	#141225:if-lauseen pointti nykyään?
	if [ ${3} -eq 1 ] && [ -d ${2} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		e22_config1 ~
		${smr} ~/fediverse.tar
		e22_settings ${2}/..
	else
		dqb "PUIG DESTRÖYERR b666"
	fi

	local t
	csleep 1
	${srat} -rvf ${1} /opt/bin/changedns.sh

	#maxdepth mukaan vai ei?
	#HUOM.171225:onko hyvä kun osassa (arkistoon menevistä) tdstoista on tuo ~ mukana polussa ja osassa taas ei?
	#pitäisi kai väjhän miettiä niitä polkuja siis

	for t in $(find ~ -type f -name 'merd2.sh' -or -name config.tar.bz2) ; do
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

	dqb "${srat} ${TARGET_TPX} --exclude='*.deb' -rvf ${1} /home/stubby ${t} "
	csleep 1

	${srat} ${TARGET_TPX} --exclude='*.deb' --exclude '*.conf' -rvf ${1} /home/stubby ${t}
	csleep 2

	dqb "AUTOMAGICAL CONFIGURATION IS A DISEASE  x 199 - Bart S."
	dqb "Xorg -config ~/xorg.conf TODO?"
	dqb "find /' ,,, ?"
	
	for f in $(find ~  -type f -name 'xorg.conf*') ; do ${srat} -rvf ${1} ${f} ; done 	
	csleep 10

	dqb "e22_home d0n3"
	csleep 1
}

#pitäöiskö siirtää toiseen tdstoon?
#toistaiseksi privaatti fktio (tarvitseeko kutsua suoraan exp2 kautta oikeastaan?)
function luca() { #301125:taitaa toimia
	dqb "luca ( ${1})"
	csleep 1

	[ -z ${1} ] && exit 11
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

#pitäöiskö siirtää toiseen tdstoon?
function e22_elocal() { #VAIH:slim/lxdm/whåteva konfig lisäys (201225) olisiko jo kohta?
	#... vaikka sen "exp2 4"-testailun yht kta että on sopivaa konftdstoa mukana
	dqb "e22_elocal ${1} ${2} ${3} ${4}"
	csleep 1

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9

	[ -z ${2} ] && exit 2
	[ -z ${3} ] && exit 3	
	[ -z ${4} ] && exit 5
	
	[ -z ${5} ] && exit 11
	csleep 1

	dqb "params_ok"
	csleep 1

	${scm} 0755 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	for f in $(find /etc -type f -name 'interfaces*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done
	dqb "JUST BEFORE URLE	S"
	csleep 1

	for f in $(find /etc -type f -name 'rules*' -and -not -name '*.202*') ; do
		if [ -s ${f} ] && [ -r ${f} ] ; then
			${srat} -rvf ${1} ${f}
		else
			echo "SUURI HIRVIKYRPÄ ${f} "
			echo "5H0ULD exit 666"
			sleep 1
		fi
	done

	echo $?
	luca ${1}
	csleep 1
	other_horrors

	dqb "B3F0R3 TÖBX"
	csleep 2

	#mikä järki juuri tässä keskeyttää suoritus?
	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	dqb "WLAN-RELAT3D"
	csleep 2

	case ${2} in
		wlan0)
			dqb "APW"
			csleep 1
			${srat} -rvf ${1} /etc/wpa_supplicant #parempi vetää koko hmisto
			csleep 2
			${srat} -tf ${1} | grep wpa
			csleep 3
		;;
		*)
			dqb "non-wlan"
		;;
	esac

	local ef
	ef=$(echo ${4} | tr -d -c 0-9)

	if  [ ${ef} -eq 1 ] ; then
		dqb "Das Asdd"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuggah
	fi

	dqb "DSN"
	csleep 2
	local f
	
	if [ ${3} -eq 1 ] ; then #-gt 0 ?
		for f in $(find /etc -type f -name 'stubby*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name 'dns*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	else
		dqb "n0 5tub"
	fi

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	csleep 5
	
	for f in $(find /etc -type f -name 'xorg*' -and -not -name '*.202*') ; do
		${srat} -rvf ${1} ${f}
	done
	
	csleep 5
	
	for f in $(find /etc -type f -name '${5}*' -and -not -name '*.202*') ; do
		${srat} -rvf ${1} ${f}
	done

	csleep 5
	dqb "e22_elocal done"
	csleep 1
}

[ -v BASEURL ] || exit 6 

#pitäöiskö siirtää toiseen tdstoon?
function e22_ext() { #091225:taitaa toimia
	dqb "e22_ext ${1} ,  ${2}, ${3}, ${4}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2
	#[ -w ${1} ] || exit 6 
	[ -z ${2} ] && exit 3
	[ -z ${3} ] && exit 4

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

	#voisi jollain ehdolla estää kloonauksen?
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

	cd ${p}
	[ ${debug} -eq 1 ] && pwd
	dqb "e22_ext done"
	csleep 1
}

function e22_ts() { #091225:jos vaikka toimisi
	dqb "e22_ts () ${1} ${2}" #van1 param pitäisi olla tällä - Yoda
	csleep 2

	[ -z ${1} ] && exit 13
	[ -d ${1} ] || exit 14 #hmistossa hyvä olla kirj.oik.
	[ -w ${1} ] || exit 15 

	dqb "NEXT:mv ${CONF_pkgdir}/*.deb ${1}"
	csleep 5
	${svm} ${CONF_pkgdir}/*.deb ${1}
	dqb $?
	csleep 5

	fasdfasd ${1}/tim3stamp
	date > ${1}/tim3stamp

	udp6 ${1}
	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb
	csleep 10

	dqb "E22TS DONE"
	csleep 2
}

#HUOM.olisi hyväksi, ensisijaisesti .deb-pak sisältävien .tar kanssa, joko poistaa kirj- oik luonnin jälkeen ja/tai gpg:llä sign ja vast tark jottei vahingossa muuttele

function e22_arch() { 
	dqb "e22_arch ${1}, ${2} " 
	csleep 1

	[ -z ${1} ] && exit 1
	#[ -s ${1} ] || exit 2 #antaa nyt olla kommenteissa
	#[ -w ${1} ] || exit 33 #josko man bash...

	[ -z ${2} ] && exit 11
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
		csleep 9
	fi

	csleep 1
	psqa .

	${srat} -rf ${1} ./*.deb ./sha512sums.txt*
	[ ${debug} -eq 1 ] && ls -las ${1} 

	csleep 10
	cd ${p}
	dqb "e22_arch d0n3"
}

function e22_dblock() { #010126:ok
	dqb "e22_dblock( ${1}, ${2}, ${3})"

	[ -z ${1} ] && exit 14
	[ -s ${1} ] || exit 15 #"exp2 e" kautta tultaessa tökkäsi tähän kunnes
	#[ -w ${1} ] || exit 16 #ei näin?

	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 23

	dqb "DBLOCK:PARAMS OK"
	csleep 1

	[ ${debug} -eq 1 ] && pwd
	csleep 1
	#aval0n #tarpeellinen?

	dqb "bFR 175:"
	ls -la ${CONF_pkgdir}/*.deb | wc -l
	csleep 10
	
	for s in ${PART175_LIST} ; do
		${sharpy} ${s}*
		${NKVD} ${CONF_pkgdir}/${s}*.deb
	done

	dqb "AFTR 175:"
	ls -la ${CONF_pkgdir}/*.deb | wc -l
	csleep 10

	local t
	t=$(echo ${2} | cut -d '/' -f 1-5)

	e22_ts ${2}
	enforce_access ${n} ${t} #tarpeellinen nykyään?
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
#	dqb "${sharpy} libavahi* #saattaa sotkea ?"
#	dqb "${NKVD} ${CONF_pkgdir}/libavahi* ?"
#}


#VAIH:testaus, tekee paketin:jep sisältö: (251225)
function e22_tblz() {
	#HUOM.28925:vieläkö asentaa avahin?
	dqb "x2.e22_tblz ${1} , ${2}  , ${3}  , ${4} "

	csleep 1
	dqb "\$shary= ${shary}"
	csleep 2

	[ -z ${1} ] && exit 11
	[ -d ${1} ] || exit 15 

	[ -z ${2} ] && exit 12
	[ -z ${3} ] && exit 13
	[ -z ${4} ] && exit 14

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

	#vastannee t_2312_0, asentunee
	#kts check_binaries()
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

#TODO:ntp-jutut takaisin josqs?

function e22_other_pkgs() { 
	dqb "e22_other_pkgs ${1} ,  ${2}  ASDFASDFASDF"
	csleep 1

	[ -z "${1}" ] && exit 11
	dqb "paramz_ok"
	csleep 1
	#josko jollain optiolla saisi apt:in lataamaan paketit vain leikisti? --simulate? tai --no-download?

	dqb "shary= ${shary}"
	csleep 5
	${shary} ${E22GI}

	#E22_GG="coreutils libcurl3-gnutls ... git"
	${shary} coreutils
	${shary} libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0
	${shary} git-man git

	#E22_GS="libc6 ... sudo"
	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} libc6 zlib1g libreadline8 #moni pak tarttee nämä
	${shary} groff-base libgdbm6 libpipeline1 libseccomp2 #bsd debconf
	csleep 5

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=sudo=1.9.13p3-1+deb12u1
	${shary} libaudit1 libselinux1
	${shary} man-db sudo
	csleep 2

	message
	jules

	if [ ${1} -eq 1 ] ; then
		#E22_GT="libgmp10 ... stubby"
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
#	${lftr}
#	csleep 2

	csleep 2
	dqb "e22_other_pkgs donew"
	csleep 1
}

function e22_dm() {
	[ -z "${1}" ] && exit 11
	csleep 5

	${fib}
	csleep 5

	#libc6 (>= 2.33), libgcc-s1 (>= 3.0), libstdc++6
	#menu (>= 2.1.26), libc6 (>= 2.14), (>= 1:1.0.0), l, , , , 

	${shary} libice6 libsm6 libx11-6 libxext6 libxmu6 libxt6
	${shary} menu twm
	csleep 2

	#VAIH:miten jos SITTENKIN xdm tai wdm?
	#pelkkä lxdm kun ei riitä ja lxsession-jutut vaativat policykit-matskua ja niiden bugeja tulee mukaan
	
	case ${1} in
		xdm)
			#TODO:osa jutuista ennen casea
			${shary} libcrypt1 libpam0g libselinux1 libxau6 libxaw7 libxdmcp6  libxft2 libxinerama1 
			csleep 2
			${shary} libxpm4 libxrender1 debconf x11-utils cpp lsb-base x11-xserver-utils procps
			csleep 2
			${shary} xdm


# | debconf-2.0,  | xbase-clients | xmessage,  (>= 3.2-14), 

		;;
		wdm)

#libc6 libgcc-s1 (>= 3.0), libstdc++6 zlib1g perl:any xserver-xorg | xserver:tarteeko juuri tässä vetää?

			${shary} libwebp7 libaom3 libdav1d6 libde265-0 libx265-199
			csleep 2

			${shary} libcrypt1 libwebpdemux2 libheif1 libaudit1 debconf
			csleep 2

			${shary} libdb5.3 libpam0g libselinux1 libpam-modules-bin libpam-modules libpam-runtime
			csleep 2

			${shary} sysvinit-utils libtinfo6 libpng16-16  libx11-xcb1 libxaw7 
			csleep 2

			${shary} libxcb-damage0 libxcb-present0 libxcb-xfixes0 libxcb1 libxcursor1  libxft2
			csleep 2

			${shary} libxi6 libxkbfile1 libxmuu1 libxrender1 libxinerama1  man-db
			csleep 2

			${shary} lsb-base libfontconfig1 libfontenc1 libgl1 libxcb-shape0 libxrandr2 
			csleep 2

			${shary} libxtst6 libxv1 libxxf86dga1 libxxf86vm1 cpp 
			csleep 2

			${shary} psmisc x11-apps x11-common x11-utils x11-xserver-utils
			csleep 2

			${shary} libpcre2-8-0 libpango-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
			#TODO:wraster6 muut riuipp?
			#TODO:	libmagickwand-6 riip?	
			${shary} libgif7 libwraster6 libwutil5 wmaker-common libwings3
			csleep 2

			${shary} libjpeg62-turbo libmagickwand-6 libtiff6 libxpm4 libx11-data
			csleep 2

			${shary} libxau6 libbsd0
			csleep 2 	
		
			${shary} libxdmcp6 x11-xserver-utils wdm
		;;
#		lxdm)
#			#"exp2 rp" on nykyään keksitty
#			#E22_GL="libxcb-render0 ... lxdm"
#
#			${shary} libxcb-render0 libxcb-shm0 libxcb1
#			csleep 2
#			
#			${shary} libatk1.0-0 libfreetype6 libpixman-1-0
#			csleep 2
#			
#			#jos aikoo dbusista eroon ni libcups2 asennus ei hyvä idea
#			
#			# (>= 1.28.3),  (>= 1.28.3),(>= 1.28.3),(>= 2:1.4.99.1),  (>= 1:0.4.5), libxcursor1 (>> 1.1.2), libxdamage1 (>= 1:1.1), , libxfixes3,  (>= 2:1.1.4),  (>= 2:1.5.0),  adwaita-icon-theme | gnome-icon-theme, hicolor-icon-theme, shared-mime-info
#			${shary} libpangocairo-1.0-0   
#			csleep 2
#
#			${shary} libdeflate0 debliblerc4 
#			csleep 2
#
#			#HUOM.201225:libgdk, libgtk- pakettien riippuvuuksiA joutunee selvittämään ja kasaamaan tänne
#			${shary} libgdk-pixbuf2.0-common libgdk-pixbuf-2.0-0
#			csleep 2
#			
#			#acceptiin ainakin 2-0-common enne 2-0 ja sitten muuta tauhkaa hakien tässä kunnes alkaa riittää
#			${shary} debconf libcairo2 libgtk2.0-common libgtk2.0-0
#			csleep 2
#	
#			#gdk ennen gtk?
#			${shary} libfribidi0 libharfbuzz0b libthai0
#			csleep 2
#			
#			${shary} libglib2.0-data libglib2.0-0
#			csleep 2
#		
#			${shary} fontconfig  gtk2-engines-pixbuf gtk2-engines 
#			csleep 2
#
#			${shary}  lxdm 
#			csleep 2
#			
#			#261225:lxde-juttujrn ja lxpolkit:in riippuvuukisien selvutys saattaa osoittautua tarpeelliskeis?
#			
#			#polkit-1-auth-agent:
#			
#			#${shary} lxsession-data libpolkit-agent-1-0 libpolkit-gobject-1-0 policykit-1 laptop-detect lsb-release
#			#csleep 2
#			 
#			#Depends: libc6 (>= 2.4), libglib2.0-0 (>= 2.37.3), libgtk2.0-0 (>= 2.12.0),
#			#	 (>= 0.94),  (>= 0.94),  
#			#lxpolkit kanssa taisi olla joitainj vaihtoehtoja
#			
#			#Depends: libc6 (>= 2.4), libcairo2 (>= 1.2.4), libgdk-pixbuf-2.0-0 (>= 2.22.0), libglib2.0-0 (>= 2.26.0), libgtk2.0-0 (>= 2.24.0), , 
#			#	 lxlock | xdg-utils, 
#
#			#Depends: libc6 (>= 2.14), libglib2.0-0 (>= 2.43.92), libgtk2.0-0 (>= 2.24.0), , lsb-release, ,
#			# lxpolkit | polkit-1-auth-agent,  lxsession-logout
#			
#			${shary} libgtk2.0-0 lxpolkit lxsession-logout lxsession
#			csleep 5
#		;;
		*)
			dqb "sl1m?"
		;;
	esac
	
	#E22_GX="libwww-perl ... xscreensaver"
	#xscreensaver-data:
	# Depends:
	#libwww-perl, libc6 (>= 2.34), libgdk-pixbuf-2.0-0 (>= 2.22.0), libglib2.0-0 (>= 2.16.0), , ,  (>> 2.1.1), 

	#VAIH:xscreensaver+xlock ennen dm-spesifistä cvasea? tai toiseen fktioon kutenkin moinen
	# Depends:
	#xscreensaver-data, 
	#init-system-helpers (>= 1.52), libatk1.0-0 (>= 1.12.4), libc6 (>= 2.34), #onjo?
	#1 (>= 1:4.1.0), libegl1, 
	#libglib2.0-0 (>= 2.49.3), libgtk-3-0 (>= 3.16.2), g (>= 0.99.7.1), #onjo?
	# libsystemd0 (>= 243), 
	# (>= 2:1.2.99.901), ,  (>> 2.1.1), #onjo?
	# libxi6 (>= 2:1.2.99.4), libxinerama1 (>= 2:1.1.4), 
	#libxml2 #onjo?
	# (>= 2.7.4), libxrandr2 (>= 2:1.2.99.2), , libxxf86vm1

	${shary} xscreensaver-data xscreensaver
}

#251225:teki paketin missä sisältöä, sis. tmivuus testaten myöhemmin
function e22_profs() {
	dqb "e22_profs ${1} ${2}"

	[ -z ${1} ] && exit 99
	[ -s ${1} ] || exit 98 #pitäisi varmaan tunkea tgtfileeseen jotain että tästä pääsee läpi
	#[ -w ${1} ] || exit 97

	[ -z ${2} ] && exit 96
	[ -d ${2} ] || exit 95
	[ -w ${2} ] || exit 94

	dqb "params ok"
	csleep 1

	local q
	#q=$(${mkt} -d) #ei näin?
	q=$(mktemp -d)

	cd ${q} #antaa nyt cd:n olla toistaiseksi
	[ $? -eq 0 ] || exit 77

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

#010126 teki ei-tyuhjän paketin, sisäLtökin näköjään asentuu
function e22_upgp() {
	dqb "e22_upgp ${1}, ${2}, ${3}, ${4}"

	[ -z ${1} ] && exit 1 
	#[ -w ${1} ] || exit 44 #TODO: man bash taas?
	#[ -s ${1} ] && mv ${1} ${1}.OLD 261225 laitetttu kommentteihin koska aiheutti ongelmia
	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22

	[ -z ${3} ] && exit 33

	dqb "params_ok"
	csleep 10
	
	${fib}
	csleep 1
	
	#HUOM.27925: "--yes"- vipu pitäisi olla mukana check_bin2 kautta, onko?
	${sag} --no-install-recommends upgrade -u
	echo $?
	#HUOM.081225:pitäisiköhän keskeyttää tässä jos upgrade qsee?
	csleep 1

	[ -v CONF_pkgdir ] || exit 99 #d-blkissa jatkossa?
	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}/*.deb
	csleep 10

	dqb "generic_pt2 may be necessary now"	
	csleep 1

	${sifd} ${3}
	csleep 1
	
	dqb " ${3} SHOULD BE Dbtl 1n turq"
	csleep 1

	#HUOM.part076() ja part2_5() on keksitty
	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}/*.deb
	csleep 1
	
	case ${3} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 1
		;;
		*)
			${NKVD} ${CONF_pkgdir}/wpa*
			#HUOM.25725:pitäisi kai poistaa wpa-paketit tässä, aptilla myös?
			#... vai lähtisikö vain siitä että g_pt2 ajettu ja täts it
		;;
	esac

	csleep 1
	dqb "SIELUNV1H0LL1N3N"
	csleep 1
}

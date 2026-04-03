${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
${scm} -Rv 700 ${CONF_pkgdir}/partial/
dqb "MDB"
csleep 1

if [ -v CONF_pubk ] ; then
	dqb "Å"
else
	#050326:jatkosäätöjä tähän vai ei?
	arsch=$(${odio} find / -type f -name "keys.conf" | head -n 1)

	if [ -z "${arsch}" ] ; then
		dqb "B"
	else
		if [ -s ${arsch} ] ; then
			. ${arsch}
		else
			dqb "C"
		fi	
	fi

	csleep 1
	unset arsch
fi

dqb "MILTONS L0ST PARAD153"
csleep 1

#170326:lienee ok
function e22_hdr() {
	echo "e22_hdr() ${1}"
	sleep 1

	[ -z "${1}" ] && exit 61
	[ "${1}" == "-v" ] && exit 62
	[ -f ${1} ] && echo "${1} ALREADY EXISTS"

	fasdfasd ./rnd
	fasdfasd ${1}
	csleep 1

	dd if=/dev/random bs=12 count=1 > ./rnd
	csleep 1

	#tarkoituksella sr0 eikä srat
	echo "${sr0} -cvf ${1} ./rnd IN 1 SECS"
	csleep 1
	${sr0} -cvf ${1} ./rnd
	[ $? -gt 0 ] && exit 60

	[ ${debug} -eq 1 ] && ls -las ${1}
	dqb "hdr done"
	csleep 1
}

#tark-. olla priv fktio
#170326:taitaa olla toimiva fktio nykyään (ellei toisin todisteta)
#290326:toimii edelleen?
function e22_tyg() {
	dqb " e22_tyg()"

	[ -z "${1}" ] && exit 45
	[ -s ${1} ] || exit 46
	[ -r ${1} ] || exit 47

	csleep 1
	dqb "e22_tyg().pars.ok"

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

	dqb "e22_tyg() done"
	csleep 1
}

#170326:lienee ok
function e22_ftr() {
	dqb "e22_ftr()"
	[ -z "${1}" ] && exit 62
	[ -s ${1} ] || exit 63
	[ -r ${1} ] || exit 64

	dqb "pars.ok"
	csleep 1

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

	dqb "e22_ftr() done"
	csleep 1
}

#20426:lienee delleen ok?
function e22_pre1() {
	dqb "e22_pre1()"
	[ -z "${1}" ] && exit 65
	[ -z "${2}" ] && exit 66
	csleep 1
	dqb "pars.0k"
	csleep 1

	${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
	${scm} -Rv 700 ${CONF_pkgdir}/partial/
	csleep 1

	if [ ! -d ${1} ] ; then
		exit 111
	else
		local lefid
		lefid=$(echo ${1} | tr -d -c 0-9a-zA-Z/)	
		enforce_access $(whoami) ${lefid}

		csleep 1
		${scm} 0755 /etc/apt
		${scm} a+w /etc/apt/sources.list*
		part1 ${2} ${1}
		${scm} a-w /etc/apt/sources.list*
	fi

	dqb "P3R1.D0N3"
	csleep 1
}

#...note to self: oli varmaankin kommentti yllä cross-distro-syistä, ehkä jossain kohtaa jos sitä juttua teatsisi uudestaan
#HUOM:KOITA PUUSILMÄ JAKSAA KATSOA TARKEMMIN MIKÄ ON HOMMAN NIMI 2. PARAMETRIN KANSSA

#170326:kai toimii, tietyt muutoksetkin tehty
function e22_pre2() {
	echo "per2..."
	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67
	[ -z "${3}" ] && exit 68
	[ -z "${4}" ] && exit 69

	dqb " (pars.ok)"
	csleep 1
	#local ortsac
	local par4

	#leikkelyt tarpeellisia? exc/ceres takia vissiin on
	#ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z) #kts import2 tai mikä olikaan
	par4=$(echo ${4} | tr -d -c 0-9)

	#HUOM.020825:vähän enemmän sorkintaa tänne?
	#/e/n alihakemistoihin +x ?
	#/e/n kokonaan talteen?

	if [ -d ${1} ] ; then
		echo $?
		csleep 2

		#HUOM.200326:TLA() tähän väliaikaisesti vai ei? nykyään kyllä ifup...

		#280326:tilapäinen viritys kunnes x? mikä?
		[ -f /etc/resolv.conf ] || ${slinky} /etc/resolv.conf.${par4} /etc/resolv.conf
		ls -las /etc/resolv.*
		csleep 2	

		${sifu} ${3}
		csleep 1

		${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
		${scm} -Rv 700 ${CONF_pkgdir}/partial/
		${sag_u}
	else
		exit 111
	fi

	csleep 1
	dqb "... done"
}

#230326:vissiin toimii edelleen
function e22_cleanpkgs() {
	dqb "cleanpkgs()"
	[ -z "${1}" ] && exit 56

	if [ -d ${1} ] ; then
		#aiemmalla NKVD-tavalla saattaa kestää joten rm
		${smr} ${1}/*.deb
		${smr} ${1}/sha512sums.txt*
		#entä ne listat? jospa ei koskettaisi niihin
		ls -las ${1}/*.deb | wc -l
	else
		dqb "NO SUCH DIR: ${1}"
	fi

	dqb "done"
}

#290326:tämän kanssa jotain hatkosäätöä vai ei?
function e22_config1() {
	dqb "e22_config1()"
	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22
	[ -z "${2}" ] && exit 11

	local p
	p=$(pwd)
	
	cd ${1} 
	#antaa nyt olla toistaiseksi näin, cd:n kanssa
	[ -f ${1}/${2} ] && mv ${1}/${2} ${1}/${2}.ÅLD
	${sr0} -jcf ${2} ./xorg.conf* ./.config

	[ -s ${2} ] || exit 99
	cd ${p}

	dqb "e22_config1() done"
	csleep 1
}

#TODO:ffox 147? https://www.phoronix.com/news/Firefox-147-XDG-Base-Directory  
#nuo muutokset oikeastaan tdstoon ${CONF_default_archive3}

#290326:tämän kanssa jotain hatkosäätöä vai ei?
function e22_settings() {
	dqb "e22_settings(${1}, ${2}, ${3}, ${4})"
	[ -z "${1}" ] && exit 11
	[ -d ${1} ] || exit 22
	[ -z "${2}" ] && exit 44
	[ -z "${3}" ] && exit 89
	dqb "pars.ok"
	csleep 1

	if [ ! -x ${1}/${3} ] ; then
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

#290326:toimii edelleen, mutta fediverse.tar juuressa, e22_settings() pitäisi vissiin muuttaa? (vielä 020426?)
#TODO:testgirs-ehto mukaan suoritukseen vai ei?
#20426:edelleen toimii?

function e22_home_pre() {
	dqb "e22_home_pre()"

	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71
	[ -z "${4}" ] && exit 73
	[ -z "${5}" ] && exit 79

	if [ ${3} -eq 1 ] && [ -d ${2} ] ; then
		e22_config1 ~ ${4}
		${NKVD} ~/${5}		
		e22_settings ${2}/.. ${5} ${CONF_default_arhcive3}
	fi

	csleep 1

	${srat} -rvf ${1} /opt/bin 

	dqb "JUST BEFORE FIND"
	csleep 1

	for t in $(find ~ -type f -name merd2.sh -or -name ${4} ) ; do #qseeko tässä?
		${srat} -rvf ${1} ${t}
	done

	dqb "HOMEPRE D0NE"
	csleep 1
}

#290326:toimii, mutta $3 kanssa ehkä jotain
#TODO:testgirs-ehto mukaan suoritukseen vai ei?
#29426:edelleen toimii?

function e22_home() {
	dqb "e22_home()"
	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71

	#[ -z "${4}" ] && exit 73
	csleep 1

	local t
	local f

	${srat} -rvf ${1} ${2}/../${3}
	t=$(${srat} -tf ${1} | grep ${3} | wc -l)
	[ ${t} -lt 1 ] && exit 72
	csleep 2

	t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 1-5)
	${srat} ${TARGET_TPX} --exclude='*.deb' --exclude '*.conf' -rvf ${1} /home/stubby ${t}
	csleep 2

	#find qsee jossain?	
	for f in $(find ~ -type f -name "xorg.conf*" ) ; do ${srat} -rvf ${1} ${f} ; done
	dqb "e22_home().done()"	
}

#pitäisikö siirtää toiseen tdstoon?
#toistaiseksi privaatti fktio (tarvitseeko kutsua suoraan exp2 kautta oikeastaan?)

function luca() {
	[ -z "${1}" ] && exit 11
	[ -s ${1} ] || exit 12
	#[ -w ${1} ] || exit 13

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep rule
	csleep 1

	#localtime taisi olla linkki, siksi erikseen
	#josko kokeiliSi "g_Doit 1" jäljiltä että päivittyvätkö nuo 2 (TODO)
	${srat} -rvf ${1} /etc/timezone /etc/localtime 

	local f
	for f in $(find /etc -type f -name "local*" -and -not -name "*.202*" ) ; do ${srat} -rvf ${1} ${f} ; done
	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local
}


#204226:toimii edelleen?
# slim/xdm/wdm-spesifinen konfiguraatio saattaa tulla jo mukaan myös
#020426:ei vedä verkosta mitään ni ei tartte lisätestejä?

function e22_acol() {
	dqb "e22_acol()"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9
	[ -z "${2}" ] && exit 2
	[ -z "${3}" ] && exit 3		
	[ -z "${4}" ] && exit 5

	dqb "prs ok"
	csleep 1

	#missäs nämä palautettiin entiselleen? ja tartttteeko olla 07xx ? let's find out
	${scm} 0555 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	local f
	local ef
	local g

	for f in $(find /etc -type f -name "interfaces*" -and -not -name "*.202*" ) ; do ${srat} -rvf ${1} ${f} ; done
	
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

	dqb "e22_acol() dinbe()"
}

#imp2 yms:jos ei ala toimia ilman -v ni tee jotain (ajankohtainen viuelä 080326?)
#020326:ehkä ok sisältö-siat (xorg ja ntp-jutut voisi testata paremmalla ajalla)

#20426:edelleen toimii?

#020426:vissiin ai tarvitse lisätestejä koska ei vedä verkosta mitään

function e22_sarram() {
	dqb "e22_sarram(${1} ; ${2} ; ${3} )))))))()))))"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9
	[ -z "${2}" ] && exit 11
	[ -z "${3}" ] && exit 13
	[ -s ${3} ] || exit 17

	dqb "e22_sarram().pars.ok"

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	csleep 1
	
	local f
	#csleep 1

	#VAIH:hipsut wttuun
	for f in $(${odio} find /etc -type f -name "xorg*" -and -not -name "*.202*" ) ; do
		${srat} -rvf ${1} ${f}
	done	

	dqb "X0RG.D0N3"
	csleep 1

	dqb "\${odio} find /etc -type f -name \"${2}*\" S00N"
	csleep 1

	for f in $(${odio} find /etc -type f -name "${2}*" -and -not -name "*.202*" ) ; do
		${srat} -rvf ${1} ${f}
	done

	dqb "NEXT:ddm"
	csleep 1
	${srat} -rvf ${1} /etc/X11/default-display-manager

	#HUOM.tätä ao. 3 riviä varten oli valmiskin palikka?
	${scm} 0555 /etc/iptables
	${scm} 0400 /etc/iptables/rules*
	${scm} 0400 /etc/default/rules*

	#150326:nalkutusta ruleksien käyttöopikeukissta, tee jotain? (vielä 230326?)
	for f in $(${odio} find /etc -type f -name "rules.v?.?" -and -not -name "*.202*" ) ; do ${sah6} ${f} >> ${3} ; done

	#VAIH:hispujen liskäsi karsittava hmiston minimize.OLD alaiset
	for f in $(find ~ -type f -name "*pkgs*" | grep -v .OLD ) ; do ${sah6} ${f} >> ${3} ; done

	#230326:ntp-jtut näyttäisi vetävän mukaan
	if [ -x /usr/sbin/ntpd ] ; then
		for f in $(${odio} find /etc -type f -name "ntp*" ) ; do
			${srat} -rvf ${1} ${f}
			${sah6} ${f} >> ${3}
		done
	fi

	other_horrors
	dqb "e22_sarram() dne()"
}

[ -v CONF_BASEURL ] || exit 6

#20426:toimii edelleen/taas?
#tai sen zxcv;b sha-tarkistuksen kanssa jotain kiukuttelua että "tar -t $arch" josqs(TODO)
#TODO:verkkoyhteyttä vaativat jutut vain jos testgris ei asetrettu? vaiko kutsuvan koodin puolella tarkistus?

function e22_ext() {
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

	local p
	local q	
	local r
	local st

	csleep 1 #VAIH:deBugin latensseja jos taas karsisisisi (vielä 030426?)
	p=$(pwd)

	#q=$(${mkt} -d) #ei vaan toimi näin?
	q=$(mktemp -d)
	r=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	st=$(echo ${3} | tr -d -c 0-9)
	[ ${debug} -eq 1 ] && pwd

	cd ${q}
	#csleep 1

	dqb "iface should be up by bow, next:git"
	csleep 1

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

	${spc} /sbin/dhclient-script ./sbin/dhclient-script.${st}

	if [ ! -s ./sbin/dhclient-script.1 ] ; then
		${spc} ./sbin/dhclient-script.new ./sbin/dhclient-script.1
		ls -las ./sbin
	fi

	if [ -f /etc/apt/sources.list ] ; then
		local c
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
	${srat} -rvf ${1} ./etc  #./sbin jälkimmäinen hmisto josqs takaisin vai ei?

	echo $?

	local f
	#160126:tuon yhden tdston kanssa jokin ongelma sha-tark kanssa, joten ksrdotssn
	#pois myös resolv.conf.* vaiko ei ?

	#interfaces-alkuisten kanssa kiukuttelua cnangedns kanssa
	for f in $(find ./etc -type f -not -name "interfaces.*" ) ; do
		${sah6} ${f} >> ${4}
	done

	cd ${p}
	[ ${debug} -eq 1 ] && pwd
}

#239326:lienee edelleen toimiva
function e22_ts() {
	dqb "E222.TS ()()() $1 , $2, $3"
	[ -z "${1}" ] && exit 13
	[ -d ${1} ] || exit 14
	[ -w ${1} ] || exit 15  #hmistossa hyvä olla kirj.oik.
	[ -z "${2}" ] && exit 16
	[ -d ${2} ] || exit 17

	dqb "par5 0k"
	csleep 1

	${svm} ${2}/*.deb ${1}
	[ $? -eq 0 ] || exit 56

	#lisätäänkö tämä arkistoon jossain? no e22_a()
	fasdfasd ${1}/tim3stamp
	date > ${1}/tim3stamp
	cg_udp6 ${1}

	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb
}

#220326:toimii, tai ainakin osasi tehdä paketin
function e22_arch() {
	dqb "e22_arch() $1 , $2 , $3 , $4"

	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 2 #josko uskaltaisi poistaa kommeneitsta

	#[ -w ${1} ] || exit 33 #josko man bash...
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 44
	[ -z "${3}" ] && exit 53

	dqb "pars ok"
	csleep 1
	local p=$(pwd)
	#csleep 1

	#HUOM.23725 bashin kanssa oli ne pushd-popd-jutut
	if [ -f ${2}/sha512sums.txt ] ; then
		${NKVD} ${2}/sha512sums.txt*
	fi

	local c
	c=$(find ${2} -type f -name "*.deb" | wc -l)

	if [ ${c} -lt 1 ] ; then
		dqb "N0.F1SH"
		exit 55
	fi

	${scm} 0444 ${2}/*.deb
	fasdfasd ${2}/sha512sums.txt
	fasdfasd ${2}/sha512sums.txt.1
	[ ${debug} -eq 1 ] && ls -las ${2}/sha*;sleep 3

	cd ${2}
	echo $?
	${sah6} ./*.deb > ./sha512sums.txt

	if [ ${3} -eq 1 ] ; then
		${srat} -rf ${1} ./*pkgs*
	fi

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
		${gg} -u ${CONF_pubk} -sb ./sha512sums.txt
		${gg} -u ${CONF_pubk} -sb ./sha512sums.txt.1
	fi

	psqa .
	${srat} -rf ${1} ./*.deb ./sha512sums.txt* ./tim3stamp
	[ ${debug} -eq 1 ] && ls -las ${1}
	cd ${p}

	dqb "ARCH ENEMA DöNE"
}

#function aval0n() { #prIvaattI, toimimaan+käyttöön?
#	dqb  \$ {sharpy} libavahi \* #saattaa sotkea ?
#	dqb  \$ {NKVD} $ {CONF_pkgdir} / libavahi \* ?
#}

#290326:paketin rakennus onnaa edelleen
function e22_dblock() {
	dqb "e22_dblock(${1} , ${2} , ${3} , ${4})"

	[ -z "${1}" ] && exit 14
	[ -s ${1} ] || exit 15 #"exp2 e" kautta tultaessa tökkäsi tähän kunnes (vielä 080326?)
	#[ -w ${1} ] || exit 16 #ei näin?
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
	#csleep 1
	#aval0n #tarpeellinen?
	ls -la ${3}/*.deb | wc -l
	
	#HUOM.160326:ao. for-blokki omaksi fktioksi?
	for s in ${PART175_LIST} ; do
		${sharpy} ${s}*
		${NKVD} ${3}/${s}*.deb
	done
	
	local t
	t=$(echo ${2} | cut -d '/' -f 1-6) #joitain tr-jekkuja vielä?
	e22_ts ${t} ${3}
	dqb "JST B3F0R3 3NF0RC3"
	csleep 2
	
	enforce_access $(whoami) ${t}
	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
	csleep 2

	e22_arch ${1} ${2} ${4}
	e22_cleanpkgs ${2}
}

#080326:testattu senverranq pystyy, jotain kiukuttelua aiheutui (debbug-ulostuksen typot kenties)
#function e22_rpg() {
#	dqb "R-P-G ${1} , ${2} , ${3}"
#	[ -z "${1}" ] && exit 99
#	[ -z "${2}" ] && exit 98	
#	[ -s "${1}" ] || exit 97
#	[ -d ${2} ] || exit 96
#	exit 95
#
##	e22_cleanpkgs ${2}
##	csleep 1
##		
##	${smr} ${2}/f.tar
##	csleep 1
##		
##	#toimiiko tuo exclude? jos ei ni jotain tarttis tehrä
##	#... koko case pois käytöstä vaikka
##	
##	${srat} --exclude 'sha512sums*' --exclude '*pkgs*' -C ${d} -xvf ${1}
##	[ $? -eq 0 ] && ${svm} ${1} ${1}.OLD
##	csleep 1
##
##	#... toimii vissiin mutta laitettu pois pelistä 241225 jokatapauksessa
##			
##	e22_arch ${1} ${2} ${4}
##	cd ${2}
##
##	#sotkee sittenkin liikaa?
##	#${srat} -rvf ${1} ./accept_pkgs* ./reject_pkgs* ./pkgs_drop
##		
##	#for t in $(${srat} -tf ${1}) ; do #fråm update2.sh
##	#	${srat} -uvf  ${1} ${t}
##	#done
##		
##	exit
#}

#TODO:ao. fktion kanssa sitä self_extracting_archive-juttua kokeillen?
#030426:taitaa edelleen toimia paketin sisältö sqrootissa

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

	${srat} --exclude '*merd*' -jcvf ${1} ./*.sh ./pkgs_drop ./${3}/*.sh ./${3}/*_pkgs* ./${3}/pkgs_drop ./1c0ns/*.desktop

	dqb "e22_cde DONE()"
}

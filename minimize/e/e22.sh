#https://superuser.com/questions/1020155/pre-up-in-the-network-interfaces-file
#https://www.cyberciti.biz/faq/setting-up-an-network-interfaces-file/
#https://unix.stackexchange.com/questions/128439/good-detailed-explanation-of-etc-network-interfaces-syntax
#https://askubuntu.com/questions/1030048/how-to-create-post-up-and-pre-down-routes-in-interfaces-file
#csleep 6
#
#${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
#${scm} -Rv 700 ${CONF_pkgdir}/partial/
#csleep 1
#
#if [ -v CONF_pubk ] ; then
#	dqb "Å"
#else
#	#050326:jatkosäätöjä tähän vai ei?
#	arsch=$(${odio} find / -type f -name 'keys.conf' | head -n 1)
#
#	if [ -z "${arsch}" ] ; then
#		dqb "B"
#	else
#		if [ -s ${arsch} ] ; then
#			. ${arsch}
#		else
#			dqb "C"
#		fi	
#	fi
#
#	csleep 1
#	unset arsch
#fi
#
#csleep 3
#
##140326:toimi ainakin kerran hdr()
#
#
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
csleep 2
echo "${sr0} -cvf ${1} ./rnd IN 1 SECS"
csleep 1
${sr0} -cvf ${1} ./rnd
[ $? -gt 0 ] && exit 60
[ ${debug} -eq 1 ] && ls -las ${1}
dqb "hdr done"
csleep 2
}
#
##tark-. olla priv fktio
##080326:toimi jnkn verran (miten nykyään?)
#
#function e22_tyg() {
#
#	[ -z "${1}" ] && exit 45
#	[ -s ${1} ] || exit 46
#	[ -r ${1} ] || exit 47
#	csleep 1
#
#
#	if [ -x ${gg} ] ; then
#		if [ -v CONF_pubk ] ; then
#			${gg} -u ${CONF_pubk} -sb ${1}
#			[ $? -eq 0 ] || dqb "SIGNING FAILED, SHOUDL IUNSTALLLL PRIVATE KEYS OR SMTHING ELSE"
#			csleep 1
#
#			${gg} --verify ${1}.sig
#			csleep 1
#		else
#			dqb "NO KEYS?"
#		fi
#	else
#		dqb "SHOULD INSTALL GPG"
#	fi
#}
#
##140326:toimi?
#TODO:pois koemmnetista josqs
#function e22_ftr() {
#	[ -z "${1}" ] && exit 62
#	[ -s ${1} ] || exit 63
#	[ -r ${1} ] || exit 64
#
#	fasdfasd ${1}.sha
##	local p
##	local q
#
#	p=$(pwd)
#	q=$(basename ${1})
#	cd $(dirname ${1})
#
#	${sah6} ./${q} > ${q}.sha
#	csleep 1
#	${sah6} -c ${q}.sha
#	csleep 1
#	
#	e22_tyg ${q}.sha
#	cd ${p}
#}
#TODO:selvitä qseeko vai ei?
function e22_pre1() {
[ -z "${1}" ] && exit 65
[ -z "${2}" ] && exit 66
csleep 3
dqb "pars.0k"
csleep 2
${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
${scm} -Rv 700 ${CONF_pkgdir}/partial/
csleep 1
if [ ! -d ${1} ] ; then
exit 111
else
lefid=$(echo ${1} | tr -d -c 0-9a-zA-Z/)
enforce_access ${n} ${lefid}
csleep 1
${scm} 0755 /etc/apt
${scm} a+w /etc/apt/sources.list*
part1 ${2} ${1}
fi
dqb "P3R1.D0N3"
csleep 1
}
#
##...note to self: oli varmaankin kommentti yllä cross-distro-syistä, ehkä jossain kohtaa jos sitä juttua teatsisi uudestaan
##HUOM:KOITA PUUSILMÄ JAKSAA KATSOA TARKEMMIN MIKÄ ON HOMMAN NIMI 2. PARAMETRIN KANSSA
#
##150326:debug-syistä rivejä kommentteihin
#TODO:SELVITÄ KLUSEEKO TÄMÄ VAI EI?
function e22_pre2() {
	echo "per2..."
#	[ -z "${1}" ] && exit 66
#	[ -z "${2}" ] && exit 67
#	[ -z "${3}" ] && exit 68
#	[ -z "${4}" ] && exit 69
##
##	local ortsac
##	local par4
##
##	#leikkelyt tarpeellisia? exc/ceres takia vissiin on
##	ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z) #kts import2 tai mikä olikaan
##	par4=$(echo ${4} | tr -d -c 0-9)
##
##	#HUOM.020825:vähän enemmän sorkintaa tänne?
##	#/e/n alihakemistoihin +x ?
##	#/e/wpa kokonaan talteen? /e/n kokonaan talteen?
##
###	if [ -d ${1} ] && [ -x /opt/bin/changedns.bash ] ; then
##		#HUOM.080326:jatkossa jos kääåntgyisi e.e. ifup käskyttäisi tarpeellisia skriptejä
###		echo $?
##		csleep 1
###		${sifu} ${3}
#####		${sco} -Rv _apt:root ${CONF_pkgdir}/partial/
##		${scm} -Rv 700 ${CONF_pkgdir}/partial/
##
##		${sag_u}
csleep 1
##	else
##		exit 111
##	fi
dqb "... done"
}

function e22_cleanpkgs() {
	[ -z "${1}" ] && exit 56
	if [ -d ${1} ] ; then
		#aiemmalla NKVD-tavalla saattaa kestää joten rm
		${smr} ${1}/*.deb
		${smr} ${1}/sha512sums.txt*
		#entä ne listat? jospa ei koskettaisi niihin
		ls -las ${1}/*.deb | wc -l
	else
		dqb "NO SUCH DIR ${1}"
	fi
}

#e22_acol() yrittää vetää /e alta xorg konftdston mukaan pakettiin
##... ei ole ihan pakko config1():sessä siis
#
##140326:toimii edelleen
#function e22_config1() {
#	[ -z "${1}" ] && exit 11
#	[ -d ${1} ] || exit 22
#	[ -z "${2}" ] && exit 11
#	
#	#local p
#	p=$(pwd)
#	cd ${1} 
#	#antaa nyt olla toistaiseksi näin, cd:n kanssa
#
#	[ -f ${1}/${2} ] && mv ${1}/${2} ${1}/${2}.ÅLD
#	${sr0} -jcf ${2} ./xorg.conf* ./.config
#	[ -s ${2} ] || exit 99
#	
#	cd ${p}
#}
#
##TODO:ffox 147? https://www.phoronix.com/news/Firefox-147-XDG-Base-Directory  
##nuo muutokset oikeastaan tdstoon ${CONF_default_archive3}
##pitäisIkö siirtää toiseen tdstoon? ei just nyt
#
##140326:toimii edelleen
#function e22_settings() {
#
#	[ -z "${1}" ] && exit 11
#	[ -d ${1} ] || exit 22
#	[ -z "${2}" ] && exit 44
#	[ -z "${3}" ] && exit 89
#
#	if [ ! -x ${1}/${3} ] ; then
#		exit 24
#	fi
#
#	.  ${1}/${3}
#	[ -f ${1}/${2} ] && mv ${1}/${2} ${1}/${2}.ÅLD
#	exp_prof ${1}/${2} default-esr	
#		
#	[ -s ${1}/${2} ] || exit 32
#	#local t
#
#	t=$(tar -tf ${1}/${2} | grep prefs.js | wc -l)
#	dqb "FOUND PREFS: ${t}"
#	[ ${t} -lt 1 ] && exit 27
#}
#
##VAIH:testaa taas (jokojo 14326?)
##HUOM.140326:testit vaiheessa, kommentteihin jos qsee
#
function e22_home_pre() {
if [ ${3} -eq 1 ] && [ -d ${2} ] ; then
e22_config1 ~ ${4}
${NKVD} ~/${CONF_default_arhcive}
e22_settings ${2}/.. ${CONF_default_arhcive} ${CONF_default_arhcive3}
fi
csleep 1
#150326:JOSKOHANLIITTYISI VIIMEAIKAISEEN KUSEMISEEN TUO AO. RIVI
${srat} -rvf ${1} /opt/bin 
#exit 99 #find qsee jossain
#for t in $(find ~ -type f -name merd2.sh -or -name ${4} ) ; do #qseeko tässä?
#	${srat} -rvf ${1} ${t}
#done
dqb "HOMEPRE D0NE"
csleep 1
}

#HUOM.140326:testit vaiheessa, kommentteihin jos qsee
function e22_home() {

	[ -z "${1}" ] && exit 67
	[ -s ${1} ] || exit 68
	[ -z "${2}" ] && exit 69
	[ -d ${2} ] || exit 70
	[ -z "${3}" ] && exit 71
	[ -z "${3}" ] && exit 72
	[ -z "${4}" ] && exit 73
	csleep 1


	#141225:if-lauseen pointti nykyään? tähän liittyen oli jokin idea? (120126)

	${srat} -rvf ${1} ${2}/../${3}

	t=$(${srat} -tf ${1} | grep ${3} | wc -l)
	[ ${t} -lt 1 ] && exit 72
	csleep 10

	t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 1-5)

	${srat} ${TARGET_TPX} --exclude='*.deb' --exclude '*.conf' -rvf ${1} /home/stubby ${t}
	csleep 2

	exit 99
	#find qsee jossain	
	#for f in $(find ~ -type f -name 'xorg.conf*' ) ; do ${srat} -rvf ${1} ${f} ; done	
}


#pitäisikö siirtää toiseen tdstoon?
#toistaiseksi privaatti fktio (tarvitseeko kutsua suoraan exp2 kautta oikeastaan?)
#HUOM.140326:testit vaiheessa, kommentteihin jos qsee
#VAIH:toiminnan testaus

function luca() {

	[ -z "${1}" ] && exit 11
	[ -s ${1} ] || exit 12
	#[ -w ${1} ] || exit 13

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep rule
	csleep 2


	#localtime taisi olla linkki, siksi erikseen
	${srat} -rvf ${1} /etc/timezone /etc/localtime 
	exit 99
	#for f in $(find /etc -type f -name 'local*' -and -not -name '*.202*' ) ; do ${srat} -rvf ${1} ${f} ; done

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local
}

#... muuten lienee ok mutta slim/xdm/wdm-spesifinen konfiguraatio ei vielä tule mukaan vai tuleeko?
#HUOM.140326:testit vaiheessa, kommentteihin jos qsee
#VAIH:toiminnan testaus

function e22_acol() {
	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9

	[ -z "${2}" ] && exit 2
	[ -z "${3}" ] && exit 3		
	[ -z "${4}" ] && exit 5

	#missäs nämä palautettiin entiselleen? ja tartttteeko olla 07xx ? let's find out
	${scm} 0555 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	exit 99
	#for f in $(find /etc -type f -name 'interfaces*' -and -not -name '*.202*' ) ; do ${srat} -rvf ${1} ${f} ; done

	#for f in $(${odio} find /etc -type f -name 'rules*' -and -not -name '*.202*') ; do
	#	if [ -s ${f} ] && [ -r ${f} ] ; then
	#		${srat} -rvf ${1} ${f}
	#	#else
	#	fi
	#done

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

	#local f
	#local g
	
	exit 99
	#if [ ${3} -eq 1 ] ; then #-gt 0 ?
	#	for f in $(find /etc -type f -name 'stubby*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	#	for f in $(find /etc -type f -name 'dns*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	##else
	#fi
#
	#local ef
	ef=$(echo ${4} | tr -d -c 0-9)

	if  [ ${ef} -eq 1 ] ; then
		dqb "SMTHING"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuqqah /etc/fstab
	fi
}

#imp2 yms:jos ei ala toimia ilman -v ni tee jotain (ajankohtainen viuelä 080326?)
#020326:ehkä ok sisältö-siat (xorg ja ntp-jutut voisi testata paremmalla ajalla)

#HUOM.140326:testit vaiheessa, kommentteihin jos qsee
#VAIH:toiminnan testaus

function e22_sarram() {
	[ -z "${1}" ] && exit 1
	[ -s ${1} ] || exit 4 
	#[ -w ${1} ] || exit 9

	[ -z "${2}" ] && exit 11
	[ -z "${3}" ] && exit 13
	[ -s ${3} ] || exit 17

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	csleep 3
	exit 99
#
#	#josko kopsaisi /e/X11 alle konffin testaustarkoituksissa? nykyään kyllä g_dout kopsailee
#	for f in $(${odio} find /etc -type f -name 'xorg*' -and -not -name '*.202*') ; do
#		${srat} -rvf ${1} ${f}
#	done
#exit 99
#	#020326:tää kohta saattoi toimia oikein, ainakin kerran
#	for f in $(${odio} find /etc -type f -name '${2}*' -and -not -name '*.202*') ; do
#		${srat} -rvf ${1} ${f}
#	done

	${srat} -rvf ${1} /etc/X11/default-display-manager

	#HUOM.tätä varten oli valmiskin palikka?
	${scm} 0555 /etc/iptables
	${scm} 0400 /etc/iptables/rules*
	${scm} 0400 /etc/default/rules*
	exit 99

#	#020326:ehkä ok nämä 2
#	for f in $(${odio} find /etc -type f -name 'rules.v?.?' -and -not -name '*.202*') ; do ${sah6} ${f} >> ${3} ; done
#	for f in $(find ~ -type f -name '*pkgs*' -not -name '*.OLD') ; do ${sah6} ${f} >> ${3} ; done
	exit 99

#	if [ -x /usr/sbin/ntpd ] ; then
#		for f in $(${odio} find /etc -type f -name 'ntp*') ; do
#			${srat} -rvf ${1} ${f}
#			${sah6} ${f} >> ${3}
#		done
#	fi

	other_horrors
}

[ -v CONF_BASEURL ] || exit 6

function e22_ext() {
	#VAIH:testatakin voisi taas, takaisin kommentteihin koko fcktio jos qsee
	#TODO:/o/b liittyvää käsittelyä uusicksi sittenq
#
#	[ -z "${1}" ] && exit 1
#	[ -s ${1} ] || exit 2
#	#[ -w ${1} ] || exit 6
#	#-f, ! -d pitäisikö olla 1 tai 4 kanssa?
#	[ -z "${2}" ] && exit 3
#	[ -z "${3}" ] && exit 4
#	[ -z "${4}" ] && exit 47
#	[ -f ${4} ] || exit 48
#
	#local p
	#local q	
	#local r
	#local st

	csleep 1
	p=$(pwd)

	#q=$(${mkt} -d) #ei vaan toimi näin?
	q=$(mktemp -d)
	r=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	st=$(echo ${3} | tr -d -c 0-9)
	[ ${debug} -eq 1 ] && pwd

	cd ${q}
	csleep 1

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
#	else
	fi

	if [ -f /etc/apt/sources.list ] ; then
		#local c
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

	#local f
	#160126:tuon yhden tdston kanssa jokin ongelma sha-tark kanssa, joten ksrdotssn
	#pois myös resolv.conf.* vaiko ei ?
	#exit 99

	for f in $(find ./etc -type f -not -name 'interfaces.tmp') ; do
		${sah6} ${f} >> ${4}
	done

	cd ${p}
	[ ${debug} -eq 1 ] && pwd
}

function e22_ts() {
	dqb "E222.TS $1 , $2"
	[ -z "${1}" ] && exit 13
	[ -d ${1} ] || exit 14 #hmistossa hyvä olla kirj.oik.
	[ -w ${1} ] || exit 15 
	dqb "par5 0k"	
	csleep 1
	${svm} ${CONF_pkgdir}/*.deb ${1} #glob muutt vähän huonjo juttu oikeastaan

	#lisätäänkö tämä arkistoon jossain? no e22_a()
	fasdfasd ${1}/tim3stamp
	date > ${1}/tim3stamp

	cg_udp6 ${1}
	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb
}

#joskohan jo toimisi 110326 mennessä ?
function e22_arch() { 
	[ -z "${1}" ] && exit 1
	#[ -s ${1} ] || exit 2 #antaa nyt olla kommenteissa
	#[ -w ${1} ] || exit 33 #josko man bash...
	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 44

	dqb "pars ok"
	csleep 1

	#local p=$(pwd)
	csleep 1
	#HUOM.23725 bashin kanssa oli ne pushd-popd-jutut

	if [ -f ${2}/sha512sums.txt ] ; then
		${NKVD} ${2}/sha512sums.txt*
	#else
	fi
	exit 99

#	local c
#	c=$(find ${2} -type f -name '*.deb' | wc -l)
#
#	if [ ${c} -lt 1 ] ; then
#		exit 55
#	fi

	${scm} 0444 ${2}/*.deb
	fasdfasd ${2}/sha512sums.txt
	fasdfasd ${2}/sha512sums.txt.1
	[ ${debug} -eq 1 ] && ls -las ${2}/sha*;sleep 3

	cd ${2}
	echo $?
	${sah6} ./*.deb > ./sha512sums.txt

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
	#else
	fi

	psqa .

	${srat} -rf ${1} ./*.deb ./sha512sums.txt* ./tim3stamp
	[ ${debug} -eq 1 ] && ls -las ${1} 
	cd ${p}

	dqb "ARCH DONE"
}

#function aval0n() { #prIvaattI, toimimaan+käyttöön?
#	dqb  \$ {sharpy} libavahi \* #saattaa sotkea ?
#	dqb  \$ {NKVD} $ {CONF_pkgdir} / libavahi \* ?
#}

function e22_dblock() {
	[ -z "${1}" ] && exit 14
	[ -s ${1} ] || exit 15 #"exp2 e" kautta tultaessa tökkäsi tähän kunnes (vielä 080326?)
	#[ -w ${1} ] || exit 16 #ei näin?

	[ -z "${2}" ] && exit 11
	[ -d ${2} ] || exit 22
	[ -w ${2} ] || exit 23

	[ -z "${3}" ] && exit 33
	[ -d ${3} ] || exit 34
	#[ -w ${3} ] || exit 35 #tämän kanssa taas jotain, man bash...

	[ ${debug} -eq 1 ] && pwd
	csleep 1
	#aval0n #tarpeellinen?
	ls -la ${3}/*.deb | wc -l
	
	for s in ${PART175_LIST} ; do
		${sharpy} ${s}*
		${NKVD} ${3}/${s}*.deb
	done

	#local t
	t=$(echo ${2} | cut -d '/' -f 1-6) #joitain tr-jekkuja vielä?
	e22_ts ${t}
	dqb "JST B3F0R3 3NF0RC3"
	csleep 5

	enforce_access ${n} ${t} #${CONF_iface}
	dqb "ENFORC1NG D0N3, arch() 15 N3XT"
	csleep 5

	e22_arch ${1} ${2}
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
##	e22_arch ${1} ${2}
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
#
#140326:taitaa toimia
#TODO:pois kommenteista josqs
#function e22_fgh() {
#	dqb "e22_fgh( ${1} ; ${2} ; ${3} )"
#	[ -z "${1}" ] && exit 99
#	[ -z "${2}" ] && exit 98	
#	#[ -s "${1}" ] || exit 97 #mikä tässä oli pointti?
#
#	dqb "PA.RS"
#
#
#	e22_arch ${1} ${2}
#
#	exit
#}
#
##110326:toimi
##TODO:tmän kanssa sitä self_extracting_archive-juttua kokeillen?
##TODO:uusicksi testaus koska viimeaikaiset muutokset
#
#function e22_cde() {
#	[ -z "${1}" ] && exit 99
#	[ -z "${2}" ] && exit 98
#	[ -d "${2}" ] || exit 97
#
#	cd ${2}
#	fasdfasd ${1}
#	[ ${debug} -eq 1 ] && ls -las ${1}*
#	csleep 2
#		
#	${srat} --exclude '*merd*' -jcvf ${1} ./*.sh ./pkgs_drop ./${3}/*.sh ./${3}/*_pkgs* ./${3}/pkgs_drop ./1c0ns/*.desktop
#	#e22_ftr ${1}
#	#exit
#}
#
function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#HUOM.021025:näille main saattaa tulla muutox
if [ -f /.chroot ] ; then
	odio=""
	debug=1

	function itni() {
		dqb "alt-itn1"
		sco=$(which chown)
		scm=$(which chmod)
	}
else
	function itni() {
		odio=$(which sudo)
		[ y"${odio}" == "y" ] && exit 99 
		[ -x ${odio} ] || exit 100
		
		sco=$(sudo which chown)
		[ y"${sco}" == "y" ] && exit 98
		[ -x ${sco} ] || exit 97
		
		scm=$(sudo which chmod)
		[ y"${scm}" == "y" ] && exit 96
		[ -x ${scm} ] || exit 95
	}

	#https://stackoverflow.com/questions/49602024/testing-if-the-directory-of-a-file-is-writable-in-bash-script ei egkä ihan
	#https://unix.stackexchange.com/questions/220912/checking-that-user-dotfiles-are-not-group-or-world-writeable josko tämä
fi

itni

function fix_sudo() {
	dqb "fix_sud0.pt0"

	${sco} -R 0:0 /etc/sudoers.d
	${scm} 0440 /etc/sudoers.d/*
	${sco} -R 0:0 /etc/sudo*
	${scm} -R a-w /etc/sudo*

	dqb "POT. DANGEROUS PT 1"

	if [ -d /usr/lib/sudo ] ; then #onko moista daedaluksessa?
		${sco} 0:0 /usr/lib/sudo/*
		${scm} -R a-w /usr/lib/sudo/*
		${scm} 0444 /usr/lib/sudo/sudoers.so
	fi

	dqb "fix_sud0.pt1"
	${scm} 0750 /etc/sudoers.d
	${scm} 0440 /etc/sudoers.d/*
	
	[ ${debug} -eq 1 ] && ls -las /usr/bin/sudo*
	csleep 1
	dqb "fix_sud0.d0n3"

	#HUOM.29925:pidetään nyt varm. vuoksi "ch m00d abcd \u5 R \ bin \ 5 ud0 *" poissa tstä
}

function other_horrors() {	
	dqb "other_horrors()"

	${scm} 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	${sco} -R root:root /etc/iptables
	${scm} 0400 /etc/default/rules*
	${scm} 0555 /etc/default
	${sco} -R root:root /etc/default

	dqb " DONE"
	csleep 1
}

sco="${odio} ${sco} "
scm="${odio} ${scm} "	
#HUOM. ei tarvitse cb_listiin mutta muuten tarvitsee asettaa mahd aikaisin
sah6=$(${odio} which sha512sum)
	
slinky=$(${odio} which ln)
slinky="${odio} ${slinky} -s "
spc=$(${odio} which cp)
svm=$(${odio} which mv)
svm="${odio} ${svm} "
spc="${odio} ${spc} "
whack=$(${odio} which pkill)
whack="${odio} ${whack} --signal 9 "
snt=$(${odio} which netstat)
snt="${odio} ${snt} -tulpan "
smr=$(${odio} which rm)	
smr="${odio} ${smr} "

NKVD=$(${odio} which shred)
NKVD="${NKVD} -fu "
NKVD="${odio} ${NKVD} "
	
#PART175_LIST="avahi bluetooth cups exim4 nfs network ntp mdadm sane rpcbind lm-sensors dnsmasq stubby"
PART175_LIST="avahi blue cups exim4 nfs network mdadm sane rpcbind lm-sensors dnsmasq stubby" # ntp" ntp jemmaan 28525

#HUOM.YRITÄ SINÄKIN SAATANAN SIMPANSSI JA VITUN PUOLIAPINA KÄSITTÄÄ ETTÄ EI NÄIN 666!!!
#sdi=$(${odio} which dpkg)
#spd="${odio} ${sdi} -l " #jäänyt turhaksi muuten mutta g_pt2
#sdi="${odio} ${sdi} -i "
sleep 6

#VAIH:näille main muutoksia, yo. mjien uudelleennimeäinen, ocs() ennen tähä blokkia+kutsu
#laajempaan käyttöön?
#HUOM.0301025:oli jotain urputusta riviltä 161
function ocs() {
	dqb "ocs(${1} ) "
	local tmp2
	tmp2=$(${odio} which ${1})

	if [ y"${tmp2}" == "y" ] ; then
		dqb "KAKKA-HÄTÄ ${1} "
		exit 82
	fi

	if [ ! -x ${tmp2} ] ; then
		exit 77
	fi
}

#mitvit
ocs dpkg
sd0=$(${odio} which dpkg)
[ -v sd0 ] || exit 78
[ -z ${sd0} ] && exit 79

unset sdi #tekeeko tämä jotain? kyl , kts check_bin() ,, "second half"
echo "SFDSFDSFDSFDSFDSFDSFDSFDS"
sleep 3

sifu=$(${odio} which ifup)
sifd=$(${odio} which ifdown)
sip=$(${odio} which ip)
sip="${odio} ${sip} "

if [ -v distro ] ; then 
	dqb "DUSTRO OK"
else
	distro=$(cat /etc/devuan_version)
fi

if [ -v n ] ; then
	dqb "n OK"
else
	n=$(whoami)
fi

fix_sudo
other_horrors

function jules() {
	dqb "LE BIG MAC"
	#dqb "V8" #josko kommentoituna takaisin se cp
	#${spc} /etc/default/rules.* /etc/iptables
	csleep 1

	other_horrors
	[ ${debug} -eq 1 ] && ${odio} ls -las /etc/iptables
	csleep 1
}

function message() {
	echo "INSTALLING NEW PACKAGES IN x SECS"
	sleep 1
	echo "DO NOT ANSWER \"Yes\" TO QUESTIONS ABOUT IPTABLES"
	sleep 1
	echo "... FOR POSITIVE ANSWER MAY BREAK THINGS"
	sleep 1
}

#laajempaan käyttöön? miksi?
function psqa() {
	dqb "QUASB (THE BURNING) ${1}"

	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		local p
		p=$(pwd)
		cd ${1}

		if [ -v SOME_CONFIG_OPT ] ; then	
			dpkg -V #HUOM.11525:toistaiseksi jemmaan
			sleep 1
		fi

		#HUOM.15525:pitäisiköhän reagoida tilanteeseen että asennettavia pak ei ole?
		${sah6} -c sha512sums.txt --ignore-missing
		[ $? -eq 0 ] || exit 94

		local gv
		gv=$(${odio} which gpgv)

		if [ -x ${gv} ] && [ -v TARGET_Dkname1 ] && [ -v TARGET_Dkname2 ] ; then
			dqb "${gv} --keyring \${TARGET_Dpubkf} ./sha512sums.sig ./sha512sums in 3 secs"
			csleep 3
			${gv} --keyring \${TARGET_Dpubkf} ./sha512sums.sig ./sha512sums
			csleep 3
		fi

		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
	fi

	csleep 1
}

#jatkossa gg-tarkistus mukaan jotenkin tähän? vaiko fktioon psqa?
function pre_part3_clib() {
	dqb "pre_part3_clib ${1}"
	csleep 1
	pwd

	dqb "find ${1} -type f -name ' \* .deb ' " #auttaako \* tässä?
	csleep 3

	local q
	local r 

	#HUOM.25725:näistä polun leikkelyistä voi tulla ongelma
	q=$(find ${1} -type f -name '*.deb' | wc -l)
	r=$(echo ${1} | cut -d '/' -f 1-5)

	if [ ${q} -lt 1 ] ; then
		#HUOM.23525:kuuluisi varmaankin ohjeistaa kutsuvassa koodissa
		echo "SHOULD REMOVE ${1} /sha512sums.txt"
		echo "\"${scm} a-x ${1} /../common_lib.sh;import2 1 \$something\" MAY ALSO HELP"
		
		#pitäis ikai huomioida että scm voi aiheuttaa sivuvaikutuksia myöhemmin
		${scm} a-x ${r}/common_lib.sh 
		
		dqb "NO EXIT 55 HERE, CHIMAERA..."
		#exit 55
		#... tosin alkutilanteessa tables pitäisi chimaerasta löytyä
		#HUOM.25725:laitettu yaas exit jemmaan koska chimaeran tapauksessa ei välttis paketteja kotihak alla koska tables löytyy valimiiksi	
	else
		psqa ${1} #tai miten menikään
		#yo. fktio voisi jatkossa sisältää allek.tark?
	fi
}

#HUOM.28925:toimiikohan toivotulla tavalla? vissiin pitäisi kirjoittaa uusiksi (VAIH)
function efk1() {
	dqb "efk1( $@)"
	${sdi} $@

	if [ $? -eq 0 ] ; then
		${NKVD} $@
		dqb "ÖK"
	else
		dqb $?
	fi

	csleep 3
	#for x in $@ #jatkossa jtnkn näin
	#for y in $(find -type f -name $x)
	#$sdi $y
	#done
	#done
}

function efk2() {
	dqb "efk2( $@)"

	#koita katsoa ettei käy: sudo sudo tar
	if [ -s ${1} ] && [ -r ${1} ] ; then
		${odio} ${srat} -C ${2} -xf ${1}
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi	

	csleep 1
}

#VAIH:ao. nalqtuksen korjaus
#dpkg: dependency problems prevent configuration of libnl-route-3-200:amd64:
# libnl-route-3-200:amd64 depends on libnl-3-200 (= 3.7.0-0.2+b1); however:
#  Package libnl-3-200:amd64 is not installed.
#
#dpkg: error processing package libnl-route-3-200:amd64 (--install):
# dependency problems - leaving unconfigured

#HUOM.031025:riippuvuusasia ehgjkä korjattu mutta dpkg saatava toimimaan taas
#HUOM.041025:chroot.ympäristössä tietenkin se ympäristömja sudotuksern yht ongelma, keksisikö jotain
function fromtend() {
	local sdi2
	sdi2=$(${odio} which dpkg)
	dqb "FRöMTEND"

	[ -v sd0 ] || exit 99
	[ -z ${sd0} ] && exit 98
	[ -x ${sd0} ] || exit 97
#josko sd0 kohta...
#	if [ ! -f /.chroot ] ; then
		dqb "${odio} DEBIAN_FRONTEND=noninteractive ${sdi2} --force-confold -i $@"
		${odio} DEBIAN_FRONTEND=noninteractive ${sdi2} --force-confold -i $@
		csleep 3
#	fi
	
	dqb "DNÖE"
}

#HUOM.25725:chimaeran kanssa kosahti tablesin asennus, libnetfilter ja libnfnetlink liittyivät asiaan
function common_tbls() {
	dqb "COMMON TABLESD ($1, $2)"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	[ -z ${2} ] && exit

	local d2
	d2=$(echo ${2} | tr -d -c 0-9)

	dqb "PARAMS_OK"
	csleep 1
	psqa ${1}

	#chimaera-spesifisiä seur 2, pois jos pykii
	efk1 ${1}/libnfnet*.deb  #TARKKANA PRKL PAKETTIEN KANSSA
	csleep 1

	efk1 ${1}/libnetfilter*.deb
	csleep 1
	#/chim

	fromtend ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/libip*.deb

	efk1 ${1}/libxtables*.deb
	csleep 1

	efk1 ${1}/libnftnl*.deb 
	csleep 1

	#uutena 031925 tämä linbl
	efk1 ${1}/libnl-*.deb 
	csleep 1

	fromtend ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/iptables_*.deb
	
	csleep 1
	${scm} 0755 /etc/iptables

	${odio} update-alternatives --set iptables /usr/sbin/iptables-legacy
	${odio} update-alternatives --set iptables-restore /usr/sbin/iptables-legacy-restore	
	
	local s
	local t

	s=$(${odio} which iptables-restore)
	t=$(${odio} which ip6tables-restore)

	if [ ! -z ${d2} ] ; then
		${odio} ${s} /etc/iptables/rules.v4.${d2}
		${odio} ${t} /etc/iptables/rules.v6.${d2}
		csleep 1
	fi

	#VAIH:fromtend-jekkua varten fktio koska urp
	fromtend ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/netfilter-persistent*.deb

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=iptables-persistent=1.0.20
	fromtend ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/iptables-*.deb

	csleep 1
	${scm} 0550 /etc/iptables	

	echo "common_tblz d0n3"
	csleep 10
}

function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135(${1} )"
	csleep 1

	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)

#	#HUOM.28725:kenties helpompi olisi lisätä sha512sum allekirjoitus+sen tarkistus kuin kokonaan vivuta tar:in hommia esim. gpgtar:ille
#	if [ -x ${1}/../tar-wrapper.sh ] ; then 
#		dqb "TODO?: tar-wrapper.sh" #josko vähitellen?
#	else
		srat=$(${odio} which tar)
		
		if [ ${debug} -eq 1 ] ; then
			srat="${srat} -v "
		fi
#	fi
	
	local y
	debug=1

	y="ifup ifdown apt-get apt ip netstat ${sd0} tar mount umount sha512sum dhclient" # kilinwittu.sh	
	for x in ${y} ; do ocs ${x} ; done
	dqb "JUST BEFORE"
	csleep 6

	spd="${sd0} -l " #jäänyt turhaksi muuten mutta g_pt2
	sdi="${odio} ${sd0} -i "

	#HUOM.041025:chrot.ympäristössä fromtendin kanssa ongelma joten skipataan tblz asennus silloin
	if [ y"${ipt}" == "y" ] && [ ! -f /.chroot ] ; then # #kokeeksi vaihdettu näin 041025
		[ z"${1}" == "z" ] && exit 99
		dqb "-d ${1} existsts?"
		[ -d ${1} ] || exit 101

		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		jules
		sleep 6

		#HUOM.olisikohan sittenkin suhteelliset polut tar:in sisällä helpompia?
		#... tai jopspa jatkossa roiskisi /tmp alle

		efk2 ${1}/e.tar
		efk2 ${1}/f.tar ${1}

		pre_part3_clib ${1} #HUOM.25725:tarvitaan
		common_tbls ${1} ${dnsm}
		other_horrors

		ipt=$(${odio} which iptables)
		ip6t=$(${odio} which ip6tables)
		iptr=$(${odio} which iptables-restore)
		ip6tr=$(${odio} which ip6tables-restore)
	fi

	#xcalibur-testien älk muutox (halt ja reboot silleen niinqu turhia jos eivät toimi)
	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1

	#HUOM.14525:listan 6 ekaa voi poistaa jos tulee ongelmia
	#HUOM.25525:dhclient siirretty tilapäisesti ulos listasta excalibur-testien vuoksi, ehkä josqs takaisin

	#[ -v sdi ] || exit 666
	[ -v sd0 ] || exit 666
 	[ -v sdi ] || exit 667

	if [ ! -f /.chroot ] ; then #toiv tämä kikkailu pois 
		for x in iptables ip6tables iptables-restore ip6tables-restore  ; do ocs ${x} ; done
		csleep 6
	fi

	sag=$(${odio} which apt-get)
	sa=$(${odio} which apt)
	som=$(${odio} which mount)
	uom=$(${odio} which umount)
	sifc=$(${odio} which ifconfig)

	dqb "b1nar135 0k"
	csleep 1
}

function check_binaries2() {
	dqb "c0mm0n_lib.ch3ck_b1nar135.2()"
	csleep 1
	[ -v sd0 ] || exit 666 #sdi 

	ipt="${odio} ${ipt} "
	ip6t="${odio} ${ip6t} "
	iptr="${odio} ${iptr} "
	ip6tr="${odio} ${ip6tr} "

	sharpy="${odio} ${sag} remove --purge --yes "

	#HUOM. ${sag} VIIMEISENÄ
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "
	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "
	
	lftr="${smr} -rf /run/live/medium/live/initrd.img* " #distro-kohtainen jatkossa
	
	#srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	
	dqb "b1nar135.2 0k.2" 
	csleep 1
}

function mangle_s() {
	dqb "mangle_s ( ${1} , ${2}, ${3} ) " #kaarisulkeet edelleen perseestä
	csleep 1

	[ y"${1}" == "y" ] && exit 44
	[ -x ${1} ] || exit 55

	#HUOM.26525:pitäisiköhän olla jotain lisätarkistuksia $2 ja $3 kanssa?
	[ y"${2}" == "y" ] && exit 43
	[ -f ${2} ] || exit 54

	${scm} 0555 ${1}
	${sco} root:root ${1}
#
#	local s
#	local n2
#
#	if [ y"${3}" == "y" ] ; then
#		n2=$(whoami)
#	else
#		n2=${3}
#	fi
#
#	s=$(sha256sum ${1})
#	echo "${n2} localhost=NOPASSWD: sha256: ${s} " >> ${2}
#Tässä tavoitteena tehdä mahd vaikeasti helppo asia tai sitten excaliburiin liittyvät sorkkimiset aiheuttaneet sivuvaikutuksia. Monivalintakysymys.

	echo -n "$(whoami)" | tr -dc a-zA-Z >> ${2}
	echo -n " " >> ${2}
	echo -n "localhost=NOPASSWD:" >> ${2}
	echo -n " " >> ${2}
	echo -n "sha256:" >> ${2}
	echo -n " " >> ${2}

#https://github.com/senescent777/some_scripts/blob/main/skripts/export/common_funcs.sh.export , slaughter0 olisi myös 1 idea

	local p
	p=$(sha256sum ${1} | cut -d ' ' -f 1 | tr -dc a-f0-9)

	echo -n ${p} >> ${2}
	echo -n " " >> ${2}
	echo -n ${1} | tr -dc a-zA-Z0-9/. >> ${2} #
	
	echo -e "\n" >> ${2} #menisikö näin?
}

function dinf() {
	##HUOM.280325.2:lienee niin että samalle tdstonnimelle voi asEttaa useamman tiivisteen eli /sbin/dhclient-script:in saisi sudoersiin mukaan
	##, tosin tarvitseeko? ehkä sitten jos estää ifup:ia käynnistelemästä prosesseja
	#echo -n "$(whoami) localhost=NOPASSWD: " >> ${1}

	#local frist
	local g
	#frist=1

	for g in $(sha256sum /sbin/dhclient-script* | cut -d ' ' -f 1 | uniq) ; do
		#if [ ${frist} -eq 1 ] ; then 
		#frist=0
		#else
		#echo -n "," >> ${1}
		#fi
		#
		#echo -n "sha256:${f}" >> ${1}

		dqb ${g}
	done

	#echo " /sbin/dhclient-script " >> ${1}
	#cat ${1}
	#exit
}

#HUOM:initramfs-tools ja live-boot, nämä paketit aiheuttavat ulinaa 031025

function pre_enforce() {
	dqb "common_lib.pre_enforce( ${1} )"
	local q
	local f

	q=$(mktemp -d)
	dqb "sudo touch ${q}/meshuggah in 3 secs"
	csleep 1

	touch ${q}/meshuggah
	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 1

	[ -f ${q}/meshuggah ] || exit 33
	dqb "1N F3NR0 0F SACR3D D35TRUCT10N"
	[ -d /opt/bin ] || ${odio} mkdir /opt/bin
	
	[ -f ${1}/changedns.sh ] && ${svm} ${1}/changedns.sh /opt/bin
	mangle_s /opt/bin/changedns.sh ${q}/meshuggah
	csleep 1

	dqb "LETf HOUTRE JOINED IN DARKN355"
	for f in ${CB_LIST1} ; do mangle_s ${f} ${q}/meshuggah ; done
	csleep 1

	dqb "TRAN S1LVAN1AN HUGN3R"
	dinf ${q}/meshuggah
	csleep 1

	if [ -s ${q}/meshuggah ] ; then
		dqb "sudo mv ${q}/meshuggah /etc/sudoers.d in 2 secs"
		csleep 1

		${scm} 0440 ${q}/meshuggah
		${sco} root:root ${q}/meshuggah
		${svm} ${q}/meshuggah /etc/sudoers.d

		CB_LIST1=""
		unset CB_LIST1
		#saavuttaakohan tuolla nollauksella mitään? kuitenkin alustetaan
	fi

	local c4
	c4=0
	
	if [ -v dir ] ; then
		c4=$(grep ${dir} /etc/fstab | wc -l) #aiemmin grepattiin $part0:lla, wc -l varmempi EHKä
	else
		echo "NO SUCH THING AS \$dir"
		exit 99
	fi

	if [ ${c4} -lt 1 ] ; then
		#HUOM. pitäisi kai karsia edellinen rivi millä $dir?
		${scm} a+w /etc/fstab
		${odio} echo "/dev/disk/by-uuid/${part0} ${dir} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		${scm} a-w /etc/fstab
	fi

	csleep 1
	dqb "common_lib.pre_enforce d0n3"
}

function mangle2() {
	if [ -f ${1} ] ; then
		dqb "MANGLED ${1}"
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}

function e_e() {
	dqb "e_e()"	
	csleep 1
	fix_sudo
	for f in $(find /etc/sudoers.d/ -type f) ; do mangle2 ${f} ; done

	for f in $(find /etc -name 'sudo*' -type f | grep -v log) ; do
		mangle2 ${f}
	done

	other_horrors
	${scm} 0755 /etc
	${sco} -R root:root /etc #-R liikaa?

	#-R liikaa tässä alla 2 rivillä? nyt 240325 poistettu
	#pitäisiköhän muuttaa ao. rivejä?

	${scm} 0555 /etc/network
	${scm} 0444 /etc/network/*
	${sco} root:root /etc/network #turha koska ylempänä

	dqb "e_e d0n3"
	csleep 1
}

function e_v() {
	dqb "e_v()"

	${sco} -R root:root /sbin
	${scm} -R 0755 /sbin

	${sco} root:root /var
	${scm} 0755 /var
	${sco} root:staff /var/local
	${sco} root:mail /var/mail
	${sco} -R man:man /var/cache/man
	${scm} -R 0755 /var/cache/man

	dqb "V1C.V0N.D00m"
	csleep 1
}

function e_h() {
	dqb "e_h( ${1} , ${2} )"
	csleep 2

	${sco} root:root /home
	${scm} 0755 /home

	if [ y"${1}" != "y" ] ; then
		dqb "${sco} -R ${1}:${1} ~"
		${sco} -R ${1}:${1} ~
		csleep 1
	fi

	#HUOM.28525:p.o $1/$2 jatkossa tai ainakin tarkistaa että $2 sis $1
	[ -d ${2} ] || exit 99
	local f

	dqb " e h PT 2"
	csleep 1
	${scm} 0755 ${2}

	for f in $(find ${2} -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${2} -type f -name '*.sh') ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -name '*.deb' -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${2} -type f -name 'conf*') ; do ${scm} 0444 ${f} ; done

	dqb "F1ND D0N3"
	csleep 1

	for f in ${2} /opt/bin ; do
		${scm} 0555 ${f}/changedns.sh
		${sco} root:root ${f}/changedns.sh
	done

	dqb "e_h()"
	csleep 1
}

#/e/n/i ja excalibur, pitäisikö tehdä jotain?
function e_final() {
	dqb "e_final()"
	csleep 1
	local f
	f=$(date +%F)

	[ -f /etc/resolv.conf.${f} ] || ${spc} /etc/resolv.conf /etc/resolv.conf.${f}
	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}

	if [ -h /etc/resolv.conf ] ; then
		if [ -s /etc/resolv.conf.0 ] && [ -s /etc/resolv.conf.1 ] ; then
			${smr} /etc/resolv.conf
		fi
	fi

	[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
	csleep 5 

	#TODO:pitäisiköhän muuttaa ao. rivejä? miten?
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	dqb "e_final() D0N3"
	csleep 1
}

function enforce_access() {
	dqb " enforce_access( ${1} , ${2})"
	csleep 5
	dqb "changing /sbin , /etc and /var 4 real"

	e_e
	e_v

	${scm} 0755 /
	${sco} root:root /

	${scm} 0777 /tmp
	#${scm} o+t /tmp
	${sco} root:root /tmp

	#ch-jutut siltä varalta että tar tjsp sössii oikeudet tai omistajat
	e_h ${1} ${2}
	e_final

	jules
	[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables;sleep 2
}

#tavoitetila dokumentoituna: https://www.devuan.org/os/packages
#myös https://github.com/topics/sources-list

#debian.ethz.ch voisi jotenkin huomioida?
function part1_5() {
	dqb "part1_5( ${1} )"
	csleep 1
	local t

	#HUOM.28525:pitäisiköhän tilap. sallia /e/a sorkinta tässä?
	t=$(echo ${1} | cut -d '/' -f 1) #-dc a-z ?

	if [ ! -s /etc/apt/sources.list.${t} ] ; then
		if [ ! -s /etc/apt/sources.list.tmp ] ; then	
			local h
			dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"
			csleep 1

			h=$(mktemp -d)
			touch ${h}/sources.list.tmp

			for x in DISTRO DISTRO-updates DISTRO-security ; do
				echo "deb https://REPOSITORY/merged ${x} main" >> ${h}/sources.list.tmp
			done

			${svm} ${h}/sources.list.tmp /etc/apt
		fi

		dqb "p1.5.2()"
		csleep 1

		#HUOM.22525:vaikuttaisi jopa toimivan, seur forWardointi sh:lle
		local tdmc
	
		tdmc="sed -i 's/DISTRO/${t}/g'"
		echo "${odio} ${tdmc} /etc/apt/sources.list.tmp" | bash -s
		csleep 1

		if [ ! -z ${pkgsrc} ] ; then
			tdmc="sed -i 's/REPOSITORY/${pkgsrc}/g'"
			echo "${odio} ${tdmc} /etc/apt/sources.list.tmp" | bash -s
			csleep 1
		fi
	
		echo "${odio} mv /etc/apt/sources.list.tmp /etc/apt/sources.list.${t}" | bash -s
		csleep 1

		dqb "finally"
		csleep 1
	fi

	${sco} -R root:root /etc/apt
	#tarkempaa sertiä tulisi findin kanssa
	${scm} -R a-w /etc/apt/

	[ ${debug} -eq 1 ] && ls -las /etc/apt
	csleep 1

	dqb "p1.5 done"
	csleep 1
}

#oli aiemmin osa part1:stä
function dis() {
	dqb "CHAMBERS OF 5HA0 L1N( ${1} ) "
	[ -z ${1} ] && exit 44
	csleep 1
	
	${scm} 0755 /etc/network
	${sco} -R root:root /etc/network
	${scm} a+r /etc/network/*

	#linkkien nimiin ei tarvitse päiväystä
	if [ -f /etc/network/interfaces ] ; then
		if [ ! -h /etc/network/interfaces ] ; then
			${svm} /etc/network/interfaces /etc/network/interfaces.$(date +%F)
		else
			#${smr} /etc/network/interfaces
			dqb " /e/n/i n0t a l1nk"
		fi
	else
		dqb "/e/n/i n0t f0und"
	fi

	local t
	t=$(echo ${1} | cut -d '/' -f 1 | tr -d -c a-zA-Z)

	if [ -f /etc/network/interfaces.${t} ] ; then
		dqb "LINKS-1-2-3"
		${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
		echo $?		
		csleep 1
	else
		dqb "N0 \$UCH TH1NG A5 /etc/network/interfaces.${t}"
	fi

	${scm} 0555 /etc/network
	[  ${debug} -eq 1 ] && ls -las /etc/network
	csleep 1

	#TEHTY:selvitä mikä kolmesta puolestaan rikkoo dbusin (eka ei, toinen kyllä, kolmas ei, sysctl ei)

	${odio} ${sifd} ${iface}
	csleep 1

#	${odio} ${sifd} -a
#	csleep 1
#
	[ ${debug} -eq 1 ] && ${sifc};sleep 1

	dqb "${sip} link set ${iface} down"
	${sip} link set ${iface} down
	[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	csleep 1
	
	${odio} sysctl -p #mitä tuo tekikään?
	csleep 1
	dqb "DONE"
}

#HUOM.29525:ntp sammutetaan nyt lib.pre_part2-reittiä koska excalibur
function part076() {
	dqb "FART076( ${1})"
	csleep 1

	dis ${1}
	local s

	for s in ${PART175_LIST} ; do
		dqb ${s}

		for t in $(find /etc/init.d -name ${s}* ) ; do
			${odio} ${t} stop
			csleep 1
		done

		#HUOM.28525:ao. rivi ei vissiin sössi asioita, syyllinen saattaa löytyä ylempää
		${whack} ${s}*
	done

	dqb "alm0st d0n3"
	csleep 1

	${whack} nm-applet
	${snt}

	dqb "P.176 DONE"
	csleep 1
}

function part1() {
	dqb "PART1( ${1} )"
	csleep 1

	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
	csleep 1

	if [ y"${ipt}" == "y" ] ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		for t in INPUT OUTPUT FORWARD ; do
			${ipt} -P ${t} DROP
			dqb "V6"; csleep 1

			${ip6t} -P ${t} DROP
			${ip6t} -F ${t}
		done

		for t in INPUT OUTPUT FORWARD b c e f ; do ${ipt} -F ${t} ; done
	
		if [ ${debug} -eq 1 ] ; then
			${ipt} -L #
			dqb "V6.b"; csleep 1
			${ip6t} -L # -x mukaan?
			csleep 1
		fi
	fi

	local c
	local g
	local t

	g=$(date +%F)
	t=$(echo ${1} | cut -d '/' -f 1 | tr -dc a-z) 

	if [ -f /etc/apt/sources.list ] ; then
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:' | wc -l)

		if [ ${c} -gt 0 ] ; then 
			${svm} /etc/apt/sources.list /etc/apt/sources.list.${g}
			csleep 1
		fi
	fi

	part1_5 ${t}

	if [ ! -f /etc/apt/sources.list ] ; then
		if [ -s /etc/apt/sources.list.${t} ] && [ -r /etc/apt/sources.list.${t} ] ; then
			${slinky} /etc/apt/sources.list.${t} /etc/apt/sources.list
		fi	
	fi

	[ ${debug} -eq 1 ] && cat /etc/apt/sources.list
	csleep 1

	${sco} -R root:root /etc/apt
	${scm} -R a-w /etc/apt/
	dqb "FOUR-LEGGED WHORE (i have Tourettes)"
}

function part2_5() {
	dqb "PART2.5.1 ${1} , ${2}"
	csleep 1

	if [ ${1} -eq 1 ] ; then
		dqb "pHGHGUYFLIHLYGLUYROI mglwafh"
		${lftr}
		${fib} #uutena 27525, xcalibur...
		csleep 1
		
		for s in ${PART175_LIST} ; do
			dqb "processing ${s}"
			#csleep 1

			${sharpy} ${s}*
			csleep 1
		done

		${lftr} #pitäisikö laittaa distro==chimaera taakse näiden takominen?
		${sharpy} libblu* libcupsfilters* libgphoto* #tartteeko vielä?
		${lftr}

		${sharpy} pkexec po*
		${lftr}
		${sharpy} python3-cups
		${lftr}
		csleep 1

		case ${iface} in
			wlan0)
				dqb "NOT REMOVING WPASUPPLICANT"
				csleep 1
			;;
			*)
				${sharpy} modem* wireless* wpa*
				${sharpy} iw lm-sensors
			;;
		esac
	fi

	dqb "PART2.5.2 ${1} , ${2}"
	csleep 1

	${lftr}
	csleep 1

	if [ y"${ipt}" != "y" ] ; then
		jules

		#HUOM. saattaa toimia ilman .$2 koska tables-kikkailuja laitettu uusiksi 26525

		local t
		t=$(echo ${2} | tr -d -c 0-9)

		if [ -s /etc/iptables/rules.v6.${t} ] ; then
			${ip6tr} /etc/iptables/rules.v6.${t}
		fi

		if [ -s /etc/iptables/rules.v4.${t} ] ; then
			${iptr} /etc/iptables/rules.v4.${t}
		fi
	fi

	if [ ${debug} -eq 1 ] ; then
		${snt}
		sleep 1
	fi

	csleep 1
	dqb "PART2.5 d0ne"
	csleep 1
}

#HUOM.26525:alunperin tablesin asentamista varten, nykyään tehdään check_binaries() kautta sen asennus
#pendency problems prevent configuration of bind9-dnsutils:
# bind9-dnsutils depends on bind9-libs (= 1:9.18.33-1~deb12u2); however:
#  Version of bind9-libs:amd64 on system is 1:9.18.16-1~deb12u1.

function part3() {
	dqb "part3 ${1} ${2}"
	csleep 1

	jules
	pre_part3_clib ${1}
	csleep 1

	reficul ${1}
	pr4 ${1}

	dqb "4RP DONE"
	csleep 6

#	efk1 ${1}/lib*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 66"
#	csleep 1
#

#
#	efk1 ${1}/*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 67"	
#	csleep 1

	for f in $(find ${1} -name 'lib*.deb') ; do ${sdi} ${f} ; done #tilapäisesti jemmassa 031025

	if [ $? -eq  0 ] ; then
               dqb "part3.1 ok"
               csleep 1
               ${NKVD} ${1}/lib*.deb
	else
               exit 66
	fi
	
	dqb "LIBS DONE"
	csleep 6
	for f in $(find ${1} -name '*.deb') ; do ${sdi} ${f} ; done #tilap jemm 031025
	
	if [ $? -eq  0 ] ; then
		dqb "part3.2 ok"
		csleep 1
		${NKVD} ${1}/*.deb
	else
        	exit 67
       	fi

	[ -f ${1}/sha512sums.txt ] && ${NKVD} ${1}/sha512sums.txt
	csleep 1
	other_horrors
}

function slaughter0() {
	local fn2
	local ts2

	fn2=$(echo $1 | awk '{print $1}') 
	ts2=$(sha512sum ${fn2})

	echo ${ts2} | awk '{print $1,$2}' >> ${2}
}

#HUOM.voisi -v käsitellä jo tässä
#-h myös
function gpo() {
	dqb "GPO"
	#getopt olisi myös keksitty

	local prevopt
	local opt
	prevopt=""

	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
}

#https://stackoverflow.com/questions/16988427/calling-one-bash-script-from-another-script-passing-it-arguments-with-quotes-and
gpo "$@"
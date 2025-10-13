function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#===========================================================
#HUOM.021025:näille main saattaa tulla muutox?
if [ -f /.chroot ] ; then
	odio=""
	debug=1

	#TODO:nekros- ja root.conf - jekut jo tässä?

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
#==================================================================================
#TODO:sco-sah6 tässä vai ei?

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

fix_sudo
other_horrors
#=================================================================
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
dqb "SFDSFDSFDSFDSFDSFDSFDSFDS"
csleep 3

#TODO:tar alust tähän?
#===================================================================
#missä kohtaa nämä pitää alustaa?
[ -v distro ] || distro=$(cat /etc/devuan_version)
[ -v n ] || n=$(whoami)
#d,n jölkeen conf includointi? (kts itni)
#==================================================================
#seur. 2 fktiota nämä?

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
#===================================================================
#seur 2 fktiota
#sah6 oltava esitelty && conf includoitu ennenq näitä kutsutaan
#muuten ei kai preferenssiä järjestyksen suhteen

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
			${gv} --keyring ${TARGET_Dpubkf} ./sha512sums.sig ./sha512sums
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
#===========================================================================
#NKVD, srat ja sdi esiteltävä ennen näitä
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
		#HUOM.0421025:jatkossa se sd0-kikkailu tar:in kanssa myös?
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi	

	csleep 1
}
#===========================================================================
#seur. pari, sdi, efk, psqa() ennen näitä
function fromtend() {
	dqb "FRöMTEND"

	[ -v sd0 ] || exit 99
	[ -z ${sd0} ] && exit 98
	[ -x ${sd0} ] || exit 97

	if [ ! -f /.chroot ] ; then
		dqb "${odio} DEBIAN_FRONTEND=noninteractive ${sd0} --force-confold -i $@"
		${odio} DEBIAN_FRONTEND=noninteractive ${sd0} --force-confold -i $@
	else #-haara tähän jos ei nalqtus lopu?
		${odio} ${sd0} --force-confold -i $@
	fi

	csleep 3
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

#====================================================================
#common_tbls ja pp3_clib jölkeen oltava nämä
function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135(${1} )"
	csleep 1

	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)

		srat=$(${odio} which tar)
		
		if [ ${debug} -eq 1 ] ; then
			srat="${srat} -v "
		fi
	
	local y
	debug=1

	y="ifup ifdown apt-get apt ip netstat ${sd0} tar mount umount sha512sum dhclient" # kilinwittu.sh	
	for x in ${y} ; do ocs ${x} ; done
	dqb "JUST BEFORE"
	csleep 6
	sdi="${odio} ${sd0} -i "

	#HUOM.041025:chrot.ympäristössä fromtendin kanssa ongelma joten skipataan tblz asennus silloin
	if [ y"${ipt}" == "y" ] ; then
		[ z"${1}" == "z" ] && exit 99
		dqb "-d ${1} existsts?"
		[ -d ${1} ] || exit 101

		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		jules
		sleep 6

		efk2 ${1}/e.tar
		efk2 ${1}/f.tar ${1}

		pre_part3_clib ${1} #HUOM.25725:tarvitaan
		[ -f /.chroot ] && message
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

	[ -v sd0 ] || exit 666
 	[ -v sdi ] || exit 667
	#TODO:-z vielä?

		for x in iptables ip6tables iptables-restore ip6tables-restore  ; do ocs ${x} ; done
		csleep 6
	
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

#====================================================================
#ei kovin suurta preferenssiä missä esitellään

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
#======================================================================
#m_:s ja dinf() jlk oltava

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

#======================================================================
#melkein mihin vaan tämä
function mangle2() {
	if [ -f ${1} ] ; then
		dqb "MANGLED ${1}"
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}
#===================================================================
#o_h ja f_s jälkeen

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

	#TODO:pitäisiköhän muuttaa ao. rivejä? miten? if-blokki ympärille?
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	dqb "e_final() D0N3"
	csleep 1
}
#====================================================================================
#e_x jälk

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
#===================================================================
#p1_5() , dis() ?
#======================================================================
#whack, snt määrittelyn jölkeen
#part-jutut ei ihan tdston alussa muttei aivan lopussakaan?
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
#==================================================================
#part1() tulisi p1_5() ja check_bin() jälkeen
#part2_5() tulisi cgeck:_bin() + lftr-fib-sharpy jälkeen
#==================================================================
#part3() olisi NKVD , pre_part3 jlk , myös lib oltava includoitu ennen kutsumista
#==================================================================
#slkaughter0 samantekevää missä sij
#==================================================================
#lopuksi gpo()
#sitten oli niitä juttuja, mitä conf-tdstoa käyttää
#... muut paitsi imp2 ja exp2 riittäisi että . ./$(cst (e/distro)/conf 
#gpo() knanssa ne -v,  -h - käsittelyt
#libeudev ennne eudev
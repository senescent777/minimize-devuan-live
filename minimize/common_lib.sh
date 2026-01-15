function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#tämän tiedoston siirto toiseen taisiiskolmanteen repositoryyn? koska syyt? (siis siihen samaan missä profs.sh?)

if [ -f /.chroot ] ; then
	odio=""
	#debug=1

	function itni() {
		dqb "alt-itn1"
	}
else
	function itni() {
		dqb "ITN1-2"

		odio=$(which sudo)
		[ y"${odio}" == "y" ] && exit 99 
		[ -x ${odio} ] || exit 100
	
		#dqb "ITN1-2-2"	
	}

	#https://stackoverflow.com/questions/49602024/testing-if-the-directory-of-a-file-is-writable-in-bash-script ei egkä ihan
	#https://unix.stackexchange.com/questions/220912/checking-that-user-dotfiles-are-not-group-or-world-writeable josko tämä
fi

itni

function fix_sudo() {
	dqb "common_lib.fix_sud0.pt0"
	
	sco=$(${odio} which chown)
	[ y"${sco}" == "y" ] && exit 98
	[ -x ${sco} ] || exit 97
		
	scm=$(${odio} which chmod)
	[ y"${scm}" == "y" ] && exit 96
	[ -x ${scm} ] || exit 95

	dqb "f_s_PART2"
	sco="${odio} ${sco} "
	scm="${odio} ${scm} "	

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

	dqb "fix_sud0.pt"
	${scm} 0750 /etc/sudoers.d
	${scm} 0440 /etc/sudoers.d/*
	
	[ ${debug} -eq 1 ] && ls -las /usr/bin/sudo*
	csleep 1
	dqb "fix_sud0.d0n3"

	#HUOM.29925:pidetään nyt varm. vuoksi "ch m00d abcd \u5 R \ bin \ 5 ud0 *" poissa tstä
}

function other_horrors() {	
	dqb "other_horrors"

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

#HUOM.111225:toimiiko oikein sq-chroot-ympäristössä?
function ocs() {
	dqb "ocs ${1}  "
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

#... miten LC_juttujen aikainen asettaminen muuten vaikuttaa el_loco():on ?
function check_bin_0() {
	dqb "check_bin_0"
	csleep 1

	dqb "cb1"
	ocs sha512sum
	ocs dpkg
	ocs tar
	ocs shred
	csleep 1

	dqb "cb2"
	unset sdi #tekeeko tämä jotain? kyl , kts check_bin ,, "second half"
	unset sr0
	unset srat
	unset sah6
	unset NKVD
	csleep 1

	dqb "cb3"
	#HUOM. ei tarvitse cb_listiin mutta muuten tarvitsee asettaa mahd aikaisin
	sah6=$(${odio} which sha512sum)

	#sdi-jutut myös tänne?
	sd0=$(${odio} which dpkg)
	[ -v sd0 ] || exit 78
	[ -z ${sd0} ] && exit 79
	#-x vielä?

	sr0=$(${odio} which tar)
	[ -v sr0 ] || exit 80
	[ -z ${sr0} ] && exit 81
	#-x vielä?

	srat=${sr0}
	
	#tämä kuitenkin myöhempänä?	
	if [ ${debug} -eq 1 ] ; then
		srat="${srat} -v "
	fi

	csleep 1
	dqb "cb4"

	slinky=$(${odio} which ln)
	slinky="${odio} ${slinky} -s "
	spc=$(${odio} which cp)
	svm=$(${odio} which mv)
	svm="${odio} ${svm} "
	spc="${odio} ${spc} " #tämmöisten kanssa tarkkana sitten koska check_bin_2
	whack=$(${odio} which pkill)
	whack="${odio} ${whack} --signal 9 "
	snt=$(${odio} which netstat)
	snt="${odio} ${snt} -tulpan "
	smr=$(${odio} which rm)	
	smr="${odio} ${smr} "

	NKVD=$(${odio} which shred)
	[ -z ${NKVD} ] && exit 37
	NKVD="${odio} ${NKVD} -fu "
	
	PART175_LIST="avahi blu cups exim4 nfs network mdadm sane rpc lm-sensors dnsmasq stubby" 

	# ntp" ntp jemmaan 28525 #slim kokeeksi mukaan listaan 271125, hiiri lakkasi toimimasta
	#HUOM.excalibur ei sisällä:dnsmasq,stubby

	#HUOM.YRITÄ SINÄKIN SAATANAN SIMPANSSI JA VITUN PUOLIAPINA KÄSITTÄÄ ETTÄ EI NÄIN 666!!!
	#sdi=$(${odio} which dpkg)
	#spd="${odio} ${sdi} -l " #jäänyt turhaksi muuten mutta g_pt2
	#sdi="${odio} ${sdi} -i "
	csleep 2

	sifu=$(${odio} which ifup)
	sifd=$(${odio} which ifdown)
	sip=$(${odio} which ip)
	sip="${odio} ${sip} "

	smd=$(${odio} which mkdir)
	sca=$(${odio} which chattr)
	sca="${odio} ${sca}"
	mkt=$(${odio} which mktemp)
	tig=$(${odio} which git)
	gg=$(${odio} which gpg)
	gv=$(${odio} which gpgv)

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

	#-v taakse nämä?
	export LC_TIME
	export LANGUAGE
	export LC_ALL
	export LANG

	csleep 1
	dqb "cb0 done"
}

check_bin_0

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

function psqa() {
	dqb "Q ${1}"
	csleep 1

	[ -z ${1} ] && exit 97
	[ -d ${1} ] || exit 96
	[ ${debug} -gt 0 ] && ls -las ${1}/sha512sums*
	csleep 1

	#HUOM.171225:isommat blokkien sisällöt jos ulkoistaisi omiin fktioihinsa?
	#dpkg -V oli tässä josqs

	if [ -v gg ] && [ -s ${1}/sha512sums.txt.sig ] ; then
		dqb "S( ${1} )"
		csleep 1

		#pitäisikö testata dgdts-hmiston sisltöä tai .gnupg? pubring.kbx yli 32 tavua?
		if [ ! -z ${gg} ] && [ -x ${gg} ] ; then
			dqb "${gg} --verify ${1}/sha512sums.txt.sig "
			csleep 1
			${gg} --verify ${1}/sha512sums.txt.sig 
					
			if [ $? -eq 0 ] ; then #tässäkö se bugi oli?
				dqb "KÖ"
			else
				dqb "SHOULD imp2 k \$dir !!!"
				exit 95
			fi
			
			csleep 1
				
			[ -f ${1}/sha512sums.txt.1.sig ] && ${gg} --verify ${1}/sha512sums.txt.1.sig
			csleep 1
		else
			dqb "COULD NOT VERIFY SIGNATURES"
		fi
	else
		dqb "Лаврентий Берия MADE .txt.sig DISAPPEAR"
	fi

	csleep 2

	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		dqb "R ${1} "
		csleep 1
		local p
		p=$(pwd)
		cd ${1}

		#HUOM.15525:pitäisiköhän reagoida tilanteeseen että asennettavia pak ei ole?		
		${sah6} -c sha512sums.txt --ignore-missing
	
		if [ $? -eq 0 ] ; then
			dqb "Q.KO"
		else
			dqb "export2 f ?"
			exit 94
		fi

		[ -f ${1}/sha512sums.txt.1 ] && ${sah6} --ignore-missing -c sha512sums.txt.1
		csleep 1
		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
		exit 93
	fi

	csleep 2
}

#not-that-necessary-wrapper-for-psqa()
function common_pp3() {
	dqb "common_pp3 ${1}"
	csleep 1

	#kutsutaan useammasta paikkaa joten varm vuoksi
	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 101

	[ ${debug} -eq 1 ] && pwd
	csleep 1

	dqb "find ${1} -type f -name \* .deb"
	csleep 3

	local q
	local r 

	q=$(find ${1} -type f -name '*.deb' | wc -l)
	r=$(echo ${1} | cut -d '/' -f 1-5)

	if [ ${q} -lt 1 ] ; then
		echo "SHOULD REMOVE ${1} / sha512sums . t x t"
		echo "ibcovation \"${scm} a-x ${1} /../common_lib.sh;import2 1 \$something\" MAY ALSO HELP"

		#tämä lienee se syy miksi myöhemmin pitää renkata...
		${scm} a-x ${r}/common_lib.sh
		dqb "NO EXIT 55 HERE, CHIMAERA..."
	else
		psqa ${1}
	fi
}

#TODO:"man 5 sources.list", josko pääsisi dpkg-kikkailuista
function efk1() {
	dqb "efk1 $@"
	${sdi} $@

	if [ $? -eq 0 ] ; then
		${NKVD} $@
		dqb "ÖK"
	else
		dqb $?
	fi

	csleep 1
}

function efk2() { #jotain kautta tätäkin kai kutsuttiin (cefgh nykyään)
	dqb "efk2 ${1}"

	if [ -s ${1} ] && [ -r ${1} ] ; then
		${odio} ${sr0} -C ${2} -xf ${1}
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi	

	csleep 1
}

#VAIH:lisäksi clibpre():n toiminnallisuuden ymppääminen
function common_lib_tool() {
	dqb "common_lib_tool( ${1}  , ${2}) "
	[ -d ${1} ] || exit 66
	[ -z "${2}" ] && exit 67
	[ -s ${1}/${2} ] || dqb "SHOULD COMPLAIN ABT MISSING FILE"
	
	dqb "WILL START REJECTING P1GS NOW"
	csleep 1
	
	local q
	local r
	local s
	
	for q in $(grep -v '#' ${1}/${2}) ; do
		dqb "outer; ${q}"
		#jatk r pois?
		r=$(find ${1} -type f -name "${q}*.deb" )

		for s in ${r} ; do
			dqb "inner: ${NKVD} ${s}"
			csleep 1
			${NKVD} ${s}
			csleep 1
		done
		
		if [ ${debug} -eq 1 ] ; then
			ls -las ${1}/${q}* | wc -l
		fi
	done

	dqb "REJECTNG DONE"
}

function clibpre() {
	dqb "common_lib_tool.re( ${1}  , ${2}) "
	[ -d ${1} ] || exit 96
	[ -z "${2}" ] && exit 67
	[ -s ${1}/${2} ] || dqb "SHOULD COMPLAIN ABT MISSING FILE" 

	dqb "PARANMS OK"
	csleep 1

	dqb "LOREMIPSUM-.LOREM1PSUM.LOREMIPSUM.LIPSUU"
	csleep 3

	local p
	local q

	p=$(pwd)
	cd ${1}

	dqb "4 REALZ"
	csleep 1

	for q in $(grep -v '#' ${2}) ; do efk1 ${q} ; done
	
	csleep 3
	cd ${p}
	dqb "BlAnR3eY C0kCCC!!!"
}

#HUOM.041025:chroot-ympäristössä tietenkin se ympäristömja sudotuksen yht ongelma, keksisikö jotain (VAIH)
#... export xxx tai sitten man sudo taas
#https://superuser.com/questions/1470562/debian-10-over-ssh-ignoring-debian-frontend-noninteractive saattaisi liittyä

function fromtend() {
	dqb "FRöMTEND"

	[ -v sd0 ] || exit 99
	[ -z ${sd0} ] && exit 98
	[ -x ${sd0} ] || exit 97

	if [ ! -f /.chroot ] ; then
		dqb "${odio} DEBIAN_FRONTEND=noninteractive ${sd0} --force-confold -i $@"
		${odio} DEBIAN_FRONTEND=noninteractive ${sd0} --force-confold -i $@
	else
		${odio} ${sd0} --force-confold -i $@
	fi

	csleep 2
	dqb "DNÖE"
}

#P.S. this function created to avoid a chicken-and-egg-situation, maybe
#TODO:chimaera/xcalibur-testi että selviää, voiko ao. fktion heittää roskikseen jo?
#function common_tbls() {
#	dqb "COMMON TABLESD $1, $2"
#	csleep 1
#
#	[ y"${1}" == "y" ] && exit 33	
#	[ -d ${1} ] || exit 45
#	[ -z ${2} ] && exit 67
#
#	local d2
#	d2=$(echo ${2} | tr -d -c 0-9)
#
#	dqb "PARAMS_OK"
#	csleep 1
#	psqa ${1}
#
#	#uutena 251025 syystä excaLIBUR/ceres, pois jos qsee
#	efk1 ${1}/isc-dhcp*.deb
#	csleep 1
#
#	efk1 ${1}/libnfnet*.deb
#	csleep 1
#
#	efk1 ${1}/libnetfilter*.deb
#	csleep 1
#
#	fromtend ${1}/libip*.deb
#	[ $? -eq 0 ] && ${NKVD} ${1}/libip*.deb
#
#	efk1 ${1}/libxtables*.deb
#	csleep 1
#
#	efk1 ${1}/libnftnl*.deb 
#	csleep 1
#
#	efk1 ${1}/libnl-3-200*.deb
#	csleep 1
#
#	efk1 ${1}/libnl-route*.deb 
#	csleep 1
#
#	efk1 ${1}/libnl-*.deb 
#	csleep 1
#
#	fromtend ${1}/iptables_*.deb
#	[ $? -eq 0 ] && ${NKVD} ${1}/iptables_*.deb
#	
#	csleep 1
#	${scm} 0755 /etc/iptables 
#
#	${odio} update-alternatives --set iptables /usr/sbin/iptables-legacy
#	${odio} update-alternatives --set iptables-restore /usr/sbin/iptables-legacy-restore	
#	
#	local s
#	local t
#
#	s=$(${odio} which iptables-restore)
#	t=$(${odio} which ip6tables-restore)
#
#	if [ ! -z ${d2} ] ; then
#		${odio} ${s} /etc/iptables/rules.v4.${d2}
#		${odio} ${t} /etc/iptables/rules.v6.${d2}
#		csleep 1
#	fi
#
#	fromtend ${1}/netfilter-persistent*.deb
#	[ $? -eq 0 ] && ${NKVD} ${1}/netfilter-persistent*.deb
#
#	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=iptables-persistent=1.0.20
#	fromtend ${1}/iptables-*.deb
#	[ $? -eq 0 ] && ${NKVD} ${1}/iptables-*.deb
#
#	csleep 1
#	${scm} 0550 /etc/iptables	
#
#	echo "common_tblz d0n3"
#	csleep 1
#}

function cefgh() {
	dqb " cefgh( ${1} )"

	[ -z "${1}" ] && exit 66
	[ -d ${1} ] || exit 67

	dqb "pars ok"
	csleep 1
	
	efk2 ${1}/e.tar
	[ $? -eq 0 ] && ${NKVD} ${1}/e.tar
	
	efk2 ${1}/f.tar ${1}
	[ $? -eq 0 ] && ${NKVD} ${1}/f.tar	
}

function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135 ( ${1} ) "
	csleep 1

	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)
	
	local y
	y="ifup ifdown apt-get apt ip netstat ${sd0} ${sr0} mount umount sha512sum mkdir mktemp" # kilinwittu.sh	
	for x in ${y} ; do ocs ${x} ; done

	#HUOM.nämä e22_jutut tarkoituksella asetettu juuri tässä fktiossa
	sdi="${odio} ${sd0} -i "	
	E22GI="libassuan0 libbz2-1.0 libc6 libgcrypt20 libgpg-error0 libreadline8 libsqlite3-0 gpgconf zlib1g gpg"
	
	E22_GT="isc-dhcp-client isc-dhcp-common libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11 libnftables1 libedit2"
	E22_GT="${E22_GT} iptables"
	E22_GT="${E22_GT} iptables-persistent init-system-helpers netfilter-persistent"

	E22_GU="isc-dhcp libnfnet libnetfilter libxtables libnftnllibnl-3-200 libnl-route libnl"
	E22_GV="libip iptables_  netfilter-persistent iptables-"
	
	#HUOM.ao. mjan asettaminen konfiguraatiossa voi aiheuttaa härdelliä tässä alla?
	if [ ! -v CONF_testgris ] ; then #mitenköhän ehdon pitäisi mennä?
		if [ -z "${ipt}" ] || [ -z "${gg}" ] ; then
			[ -z "${1}" ] && exit 99
			[ -d ${1} ] || exit 101

			cefgh ${1}
			common_pp3 ${1}

			#HUOM.181225:muna-kana-tilanteen mahdollisuuden vuoksi tämä pitäisi ajaa ennen c_pp3() ?
			if [ -z "${gg}" ] ; then
				for p in ${E22GI} ; do efk1 ${1}/${p}*.deb ; done
				csleep 1

				gg=$(${odio} which gpg)
				gv=$(${odio} which gpgv)
				csleep 1

				common_pp3 ${1}
			fi

			if [ -z "${ipt}" ] ; then
				jules
	
				[ -f /.chroot ] && message

				#common_tbls ${1} ${CONF_dnsm}
				
				for p in ${E22_GU} ; do efk1 ${1}/${p}*.deb ; done

				for p in ${E22_GV} ; do 
					fromtend ${1}/${p}*.deb
					[ $? -eq 0 ] && ${NKVD} ${1}/${p}*.deb	
				done
				
				other_horrors

				ipt=$(${odio} which iptables)
				ip6t=$(${odio} which ip6tables)
				iptr=$(${odio} which iptables-restore)
				ip6tr=$(${odio} which ip6tables-restore)
				
				#sqroot-juttuja
				[ -z "${ipt}" ] && ${scm} a-wx $(pwd)/common_lib.sh
			fi
		
			ls ${1}/*.deb | wc -l
			csleep 3
			
			#261225:pitäisiköhän gpg- ja tables- instausten jämät deletoida varM, vuoksi?
			#${NKVD} ${1}/*.deb saattaa jäädä tällä tavalla git tai mktemp puuttumaan	
		fi
	
		#181225:lisätty tämmöinen kikkailu kehitysymp varten ettei jumitu heti alkuunsa	
		for x in iptables ip6tables iptables-restore ip6tables-restore ; do ocs ${x} ; done
	fi
	
	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1

	#kts g_pt2 liittyen
	[ -f /.chroot ] || ocs dhclient
	csleep 1
	
	sag=$(${odio} which apt-get)
	sa=$(${odio} which apt)

	#151225:pitäisikö sittenkin alustaa check_bin_0():ssa ainakin 2 seuraavaa?
	som=$(${odio} which mount)
	uom=$(${odio} which umount)
	sifc=$(${odio} which ifconfig)

	dqb "b1nar135 0k"
	csleep 1
}

function check_binaries2() {
	dqb "c0mm0n_lib.ch3ck_b1nar135.2"
	csleep 1
	[ -v sd0 ] || exit 666

	ipt="${odio} ${ipt} "
	ip6t="${odio} ${ip6t} "
	iptr="${odio} ${iptr} "
	ip6tr="${odio} ${ip6tr} "

	sharpy="${odio} ${sag} remove --purge --yes "

	#HUOM. ${sag} oltava VIIMEISENÄ tai siis ao. kolmikosta
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "

	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "

	#lftr="echo # \${smr} -rf  / run / live / medium / live / initrd.img\* " 
	
	#VAIH:lftr asettaminen sqroot- tai distro- riippuvaiseksi? live-ymp ei tekisi mitään?
	
	#aiemmin moinen lftr oli tarpeen koska ram uhkasi loppua kesken initrd:n päivittelyn johdosta
	#cp: error writing '/run/live/medium/live/initrd.img.new': No space left on device

	#... chimaerassa esim pitäisi tuo lgftr asettaa jhnkin ei-huuhaa-sisältöön

	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	smd="${odio} ${smd}"

	dqb "b1nar135.2 0k.2" 
	csleep 1
}
#==================================================================
function slaughter0() { #090126:mangle_s toiminee tämän kanssa
	local fn2
	local ts2

	fn2=$(echo $1 | awk '{print $1}') 
	ts2=$(${sah6} ${fn2})
	echo ${ts2} | awk '{print $1,$2}'  >> ${2}
}

#060126:josko jo alkaisi toimia toivotulla tavalla?
function mangle_s() {
	dqb "mangle_s  ${1} , ${2}, ${3}  "
	csleep 1

	[ -z "${1}" ] && exit 44
	[ -x ${1} ] || exit 55

	[ -z "${2}" ] && exit 45
	[ -f ${2} ] || exit 54

	#local p
	#local q
	local r
	#s=$(echo ${1} | grep '..' | wc -l)

	#ei vissiin näin
	#r=$(echo $1 | grep -v '..')
	#[ -z "${r}" ] && echo 67
	#[ -s gt 0 ] && exit 67

	r=$(echo ${1} | tr -dc a-zA-Z0-9/.)
	${scm} 0555 ${r}
	${sco} root:root ${r}

	echo -n "$(whoami)" | tr -dc a-zA-Z >> ${2}
#	p=$(sha256sum ${r} | cut -d ' ' -f 1 | tr -dc a-f0-9)
#	q=$r #(echo ${1} | tr -dc a-zA-Z0-9/.)
#
#	echo -n " localhost=NOPASSWD:sha256:${p} ${q}" >> ${2}
#	echo -e "\n" >> ${2}

	#100126:ALL vai localhost? rahat vs kolmipyörä?
	#echo -n " localhost=NOPASSWD:sha512:" >> ${2}
	#KVG <sudo-juttuja>	? (kts omega)

	echo -n " ALL=NOPASSWD:sha512:" >> ${2}
	slaughter0 ${r} ${2}
}

#VAIH:jinnebtiudut jutut taas käyttöön asfd asdf fads
#tässä va i kutsvassa koodissa bugi?
function dinf() {
	local g
	local frist
	frist=1

	#vissiin tähän alkuun tarttisi jotain?
	#for ... in find /sbin -type f -name 'dhclient-script* ; do ...

	for g in $(sha256sum /sbin/dhclient-script* | cut -d ' ' -f 1 | uniq) ; do
		dqb ${g}

		if [ ${frist} -eq 1 ] ; then 
			frist=0
#		else
#			echo -n "," >> ${1}
		fi
		
#		echo -n " sha256:${f}" >> ${1}
	done

#	echo -n " $(whoami) localhost=NOPASSWD: " >> ${1}
#	echo " /sbin/dhclient-script " >> ${1}

	#cat ${1}
	#exit
}
#=================================================================
function fasdfasd() {
	#HUOM.ei-olemassaoleva tdstonnimi sallittava parametriksi
	[ -z ${1} ] && exit 99

	dqb "SUN LIIRUM SUN LAARUM ${1}"
	dqb "sco= ${sco}"
	dqb $(whoami)
	csleep 1

	${odio} touch ${1}
	${sco} $(whoami):$(whoami) ${1}
	${scm} 0644 ${1}
}

#olisiko jokin palikka jo aiemmin? e_jutut ?
function reqwreqw() {
	dqb "rewqreqw(${1} )"
	[ -z ${1} ] && exit 99
	#[ -f ${1} ] && exit 100 #takaisn josqs? miksi?
	
	csleep 1
	${sco} 0:0 ${1}
	${scm} a-w ${1}

	dqb "rewqreqw(${1} ) DONE"
}

#HUOM. voisi jaksaa ajatella sitäkin että /e/s.d alaisen tdston nimen_muutos vaikuttaa myös g_doit toimintaan
function pre_enforce() {
	dqb "common_lib.pre_enforce ${1} "

	local q
	local f

	[ -v mkt ] || exit 99
	#q=$(mktemp) #ei kai tämä?
	q=$(${mkt} -d)
	q=${q}/meshuqqah
	dqb "touch ${q} in 3 secs"

	csleep 1
	fasdfasd ${q}

	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 1
	[ -f ${q} ] || exit 33

	dqb "LETf HOUTRE JOINED IN L0CH N355"
	for f in ${CB_LIST1} ; do mangle_s ${f} ${q} ; done
	csleep 1

	#HUOM.ao. mjan asettaminen konfiguraatiossa voi aiheuttaa härdelliä tässä alla?
	if [ ! -v CONF_testgris ] ; then #tämän kanssa semmoinen juttu jatkossa (jos mahd)
		dqb "1N F3NR0 0F SACR3D D35TRUCT10N"

		if [ ! -d /opt/bin ] ; then
			dqb "FSDFSDFSD"
			${smd} /opt/bin
			[ $? -eq 0 ] || ${odio} ${smd} /opt/bin
		fi

		if [ -f ${1}/changedns.sh ] ; then
			dqb "SÖSSÖN SÖSSÖN"
			${svm} ${1}/changedns.sh /opt/bin
		fi

		mangle_s /opt/bin/changedns.sh ${q}
		csleep 1
	fi

	dqb "TRAN S1LVAN1AN HUGN3R GAM35"
	dinf ${q}
	csleep 1

	if [ -s ${q} ] ; then
		dqb "sudo mv ${q} /etc/sudoers.d in 2 secs"
		csleep 1

		reqwreqw ${q}
		${scm} 0440 ${q}
		${svm} ${q} /etc/sudoers.d

		CB_LIST1=""
		unset CB_LIST1
	fi

	local c4
	c4=0
	csleep 1

	if [ -v CONF_dir ] ; then
		c4=$(grep ${CONF_dir} /etc/fstab | wc -l)
	else
		echo "NO SUCH THING AS \$CONF_dir"
		exit 99
	fi

	csleep 1

	#HUOM.261125:typot hyvä pitää minimissä konf-fileissä
	if [ ${c4} -lt 1 ] ; then
		dqb "MUTILAT31NG /E/F-STAB"
		csleep 1

		${scm} a+w /etc/fstab
		csleep 1
		${odio} echo "/dev/disk/by-uuid/${CONF_part0} ${CONF_dir} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		csleep 1
		${scm} a-w /etc/fstab

		csleep 1
		[ ${debug} -eq 1 ] && cat /etc/fstab
		csleep 1
	fi

	csleep 1
	dqb "common_lib.pre_enforce d0n3"
}

function mangle2() {
	[ -z  ${1} ] && exit 99

	if [ -f ${1} ] ; then
		dqb "MANGLED ${1} BEYOND RECQG"
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}

function e_e() {
	dqb "e_e"	
	csleep 1
	fix_sudo
	for f in $(find /etc/sudoers.d/ -type f) ; do mangle2 ${f} ; done

	for f in $(find /etc -name 'sudo*' -type f | grep -v log) ; do
		mangle2 ${f}
	done

	other_horrors

	${scm} 0755 /etc
	${sco} -R root:root /etc
	${scm} 0555 /etc/network
	${scm} 0444 /etc/network/*
	${sco} root:root /etc/network

	for f in $(find /etc/network -type d ) ; do ${scm} 0555 ${f} ; done
	dqb "e_e d0n3"
	csleep 1
}

function e_v() {
	dqb "e_v"

	${sco} -R root:root /sbin
	${scm} -R 0755 /sbin
	${sco} root:root /var
	${scm} 0755 /var
	${sco} root:staff /var/local
	${sco} root:mail /var/mail
	${sco} -R man:man /var/cache/man
	${scm} -R 0755 /var/cache/man

	dqb "V1C.THE.V33P"
	csleep 1
}

function e_h() {
	dqb "e_h ${1} , ${2} "
	csleep 1
	${sco} root:root /home
	${scm} 0755 /home

	if [ y"${1}" != "y" ] ; then
		dqb "${sco} -R ${1}:${1} ~"
		${sco} -R ${1}:${1} ~
		csleep 1
	fi

	[ -d ${2} ] || exit 99
	local f
	dqb " e h PT 2"
	csleep 1
	${scm} 0755 ${2}

	for f in $(find ${2} -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -type f) ; do ${scm} 0444 ${f} ; done

	#291125:josko kuitenkin 0555? paitsi että sittenq tarttee muokata (to state the obvious)
	#... jatkossa debug-riippuvaista että 755 vai 555 ?	
	local m

	if [ ${debug} -gt 0 ] ; then
		m=0755
	else
		m=0555
	fi

	for f in $(find ${2} -type f -name '*.sh') ; do ${scm} ${m} ${f} ; done
	dqb "F1ND D0N3"
	csleep 1

	for f in ${2} /opt/bin ; do
		${scm} 0555 ${f}/changedns.sh
		${sco} root:root ${f}/changedns.sh
	done

	dqb "e_h"
	csleep 1
}

function e_final() {
	dqb "e_final ${1} "
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
	csleep 1
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant
	dqb "e_final D0N3"
	csleep 1
}

function enforce_access() {
	dqb " enforce_access ${1} , ${2}"
	csleep 1
	dqb "changing /sbin , /etc and /var 4 real"

	e_e
	e_v

	${scm} 0755 /
	${sco} root:root /

	${scm} 0777 /tmp
	${scm} o+w /tmp #081225:+t pois koska "exp2 u"
	${sco} root:root /tmp

	#ch-jutut siltä varalta että tar tjsp sössii oikeudet tai omistajat
	e_h ${1} ${2}
	e_final ${CONF_iface}

	jules
	[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables;sleep 2
}

#tavoitetila dokumentoituna: https://www.devuan.org/os/packages
#myös https://github.com/topics/sources-list

function part1_5() {
	dqb "part1_5 ${1} "
	csleep 1
	local t
	t=$(echo ${1} | cut -d '/' -f 1) #nose tr?

	if [ ! -s /etc/apt/sources.list.${t} ] ; then
		dqb "S3RV1CE F0R A VCANT C0FF1N"
		[ -v mkt ] || exit 99
		[ -z "${mkt}" ] && exit 98

		local h
		h=$(mktemp -d) 
		[ $? -eq 0 ] || exit 97

		dqb "MTKK"
		csleep 1

		if [ ! -s /etc/apt/sources.list.tmp ] ; then	
			dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"
			csleep 1
			touch ${h}/sources.list.tmp

			for x in DISTRO DISTRO-updates DISTRO-security ; do
				echo "deb https://REPOSITORY/merged ${x} main" >> ${h}/sources.list.tmp
			done
		else
			${svm} /etc/apt/sources.list.tmp ${h}			
			fasdfasd  ${h}/sources.list.tmp
		fi

		dqb "p1.5.2"
		csleep 1
		local tdmc
	
		tdmc="sed -i 's/DISTRO/${t}/g'"
		echo "${tdmc} ${h}/sources.list.tmp" | bash -s
		csleep 1

		if [ ! -z ${CONF_pkgsrv} ] ; then
			tdmc="sed -i 's/REPOSITORY/${CONF_pkgsrv}/g'"
			echo "${tdmc} ${h}/sources.list.tmp" | bash -s
			csleep 1
		fi
	
		${svm} ${h}/sources.list.tmp /etc/apt/sources.list.${t}
		csleep 1

		dqb "finally"
		csleep 1
	fi

	${sco} -R root:root /etc/apt
	${scm} -R a-w /etc/apt/

	[ ${debug} -eq 1 ] && ls -las /etc/apt
	csleep 1

	dqb "p1.5 done"
	csleep 1
}

function dis() {
	dqb "CHAMBERS OF 5HA0 L1N ${1}"
	[ -z "${1}" ] && exit 44
	csleep 1

	${scm} 0755 /etc/network
	${sco} -R root:root /etc/network
	${scm} a+r /etc/network/*

	if [ -f /etc/network/interfaces ] ; then
		if [ ! -h /etc/network/interfaces ] ; then
			${svm} /etc/network/interfaces /etc/network/interfaces.$(date +%F)
		else
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

	#TEHTY:selvitä mikä kolmesta puolestaan rikkoo dbusin , eka ei, toinen kyllä, kolmas ei, sysctl ei
	if [ -v CONF_iface ] ; then
		if [ ! -z "${CONF_iface}" ] ; then
			${odio} ${sifd} ${CONF_iface}
			csleep 1
	
		#	${odio} ${sifd} -a
			csleep 1

			[ ${debug} -eq 1 ] && ${sifc};sleep 1
			dqb "${sip} link set ${CONF_iface} down"
	
			${sip} link set ${CONF_iface} down
			[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
		fi
	fi
	
	csleep 1
	${odio} sysctl -p
	csleep 1

	dqb "5HAD0W 0F TH3 BA35T D0N3"
}

function part076() {
	dqb "FART076 ${1}"
	[ -z ${1} ] && exit 76

	csleep 1
	dis ${1}
	local s

	for s in ${PART175_LIST} ; do
		dqb ${s}
		#HUOM.271125:saisiko tällä tyylillä myös slimin sammutettua? saa, mutta...

		for t in $(find /etc/init.d -name ${s}* ) ; do
			${odio} ${t} stop
			csleep 1
		done

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
	dqb "PART1 ${1} "
	csleep 1
	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
	csleep 1
	[ -v ipt ] || exit 666

	if [ -z "${ipt}" ] ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		if [ -x ${ipt} ] ; then # \$ odio vs \$ ipt vielä?
			for t in INPUT OUTPUT FORWARD ; do
				${ipt} -P ${t} DROP
				dqb "V6"; csleep 1

				${ip6t} -P ${t} DROP
				${ip6t} -F ${t}
			done

			for t in INPUT OUTPUT FORWARD b c e f ; do ${ipt} -F ${t} ; done
	
			if [ ${debug} -eq 1 ] ; then
				${ipt} -L
				dqb "V6.b"; csleep 1
				${ip6t} -L
				csleep 1
			fi
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
	dqb "FOUR-LEGGED WHORE"
}

function part2_5() { #mikä olikaan tämän nimeämisen logiikka?
	dqb "PART2.5.1 ${1} , ${2} , ${3}"
	csleep 20

	[ -z "${1}" ] && exit 55
	[ -z "${2}" ] && exit 56

	dqb "PARS_OK"
	csleep 1

	if [ ${1} -eq 1 ] ; then
		dqb "pHGHGUYFLIHLYGLUYROI mglwafh..."
		${lftr}
		${fib}
		csleep 1
		
		for s in ${PART175_LIST} ; do 
			csleep 4
		
			dqb "processing ${s}"
			${sharpy} ${s}*
			csleep 1
		done

		${lftr}
		
		${sharpy} libblu* libcupsfilters* libgphoto*
		${lftr}

		#josko vielä pkexec:istä ajo-oik poisto? vai riittäisikö sharpy?
		${sharpy} pkexec po*
		${lftr}

		${sharpy} python3-cups
		${lftr}
		csleep 1

		case ${3} in
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

function part3() {
	dqb "part3 ${1} , ${2}"
	csleep 1

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 101

	dqb "PARAMS_OK"
	csleep 1
	local c15
	c15=$(find ${1} -type f -name '*.deb' | wc -l)

	if [ ${c15} -lt 1 ] ; then
		cefgh ${1}
	fi

	csleep 1
	jules
	common_pp3 ${1}
	csleep 1

	#HUOM.071225 ehto kommentteihin koska y
	#if [ ! -f /.chroot ] ; then
	#poisteluun jotain muutoksia jatkossa?
		common_lib_tool ${1} reject_pkgs
	#fi

	#TODO:libc6*.deb gcc-12*.deb cpp*.deb erikseen jotta common_lib_tool käyttöönotto
	clibpre ${1} accept_pkgs_1
	clibpre ${1} accept_pkgs_2

	dqb "g4RP D0NE"
	csleep 1

#	efk1 ${1}/lib*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 66"
#	csleep 1
#
#	efk1 ${1}/*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 67"	
#	csleep 1

	for f in $(find ${1} -name 'lib*.deb') ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
               dqb "part3.1 ok"
               csleep 1
               ${NKVD} ${1}/lib*.deb
	else
               exit 66
	fi

	dqb "LIBS DONE"
	csleep 1
	for f in $(find ${1} -name '*.deb') ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
		dqb "part3.2 ok"
		csleep 1
		${NKVD} ${1}/*.deb
	else
	       	exit 67
 	fi

	[ -f ${1}/sha512sums.txt ] && ${NKVD} ${1}/sha512sums.txt*
	csleep 1
	other_horrors
}

function gpo() {
	dqb "GPO"
	local prevopt
	local opt
	prevopt=""

	#121225:miten g_jutut nykyään tämän kanssa?
	if [ $# -lt 1 ] ; then
		echo "$0 -h"
		#exit
	fi

	for opt in $@ ; do
		case ${opt} in	
			-v|--v)
				debug=1
			;;
			-h|--h)
				usage
				exit #181225:sen toisen repon juttuja. Kandeeko laittaa tätä?
			;;
		esac

		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
}

#https://stackoverflow.com/questions/16988427/calling-one-bash-script-from-another-script-passing-it-arguments-with-quotes-and
gpo "$@"

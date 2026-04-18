#fktioksi tmä ni ei tartte globaalien mjien kanssa sählätä?
if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
	sleep 5
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
	 	exit 57
	fi	
fi

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#tämän tiedoston siirto toiseen taisiiskolmanteen repositoryyn? koska syyt? (siis siihen samaan missä profs.sh?)

#ei tarvinne conf_alt_root ainakaan vielä
if [ -f /.chroot ] ; then
	odio=""

	function itni() {
		dqb "alt-itn1"
	}
else
	function itni() {
		dqb "ITN1-2"

		odio=$(which sudo)
		[ y"${odio}" == "y" ] && exit 99 
		[ -x ${odio} ] || exit 100
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

	if [ -d /usr/lib/sudo ] ; then
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

	for f in $(${odio} find /etc -type f -name "rules.*" ) ; do
		${sco} -R root:root ${f}
		${scm} 0400 ${f}
	done

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

function ocs() {
	dqb "ocs () () ((( ${1} "
	local tmp2
	tmp2=$(${odio} which ${1})

	if [ -z "${tmp2}" ] ; then
		dqb "KAKKA-HÄTÄ ${1} "
		exit 82
	fi

	if [ ! -x ${tmp2} ] ; then
		exit 77
	fi
}

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
	sah6=$(${odio} which sha512sum)

	sd0=$(${odio} which dpkg)
	[ -v sd0 ] || exit 78
	[ -z "${sd0}" ] && exit 79
	[ -x ${sd0} ] || exit 77

	sr0=$(${odio} which tar)
	[ -v sr0 ] || exit 80
	[ -z "${sr0}" ] && exit 81
	[ -x ${sr0} ] || exit 76

	srat=${sr0}

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
	[ -z "${NKVD}" ] && exit 37
	NKVD="${odio} ${NKVD} -fu "

	#ehkä tämmöinen lista kuuluisi konftdstoon?
	#4426:brl ja openssh uutena minimal_live liittyen, pois jos qsee (6426 ssh viskoi pihalle äksästä ennenaikaisesti, toistuuko?)
	PART175_LIST="avahi blu cups exim4 nfs network mdadm sane rpc lm-sensors dnsmasq stubby brltty openssh" # ssh 

	# ntp" ntp jemmaan 28525 #slim kokeeksi mukaan listaan 271125, hiiri lakkasi toimimasta
	#HUOM.excalibur ei sisällä:dnsmasq,stubby

	#HUOM.YRITÄ SINÄKIN SAATANAN SIMPANSSI JA VITUN PUOLIAPINA KÄSITTÄÄ ETTÄ EI NÄIN 666!!!
	#sdi=$(${odio} which dpkg)

	#sdi="${odio} ${sdi} -i "
	csleep 2

	sifu=$(${odio} which ifup)
	sifd=$(${odio} which ifdown)
	sip=$(${odio} which ip)
	sip="${odio} ${sip} "

	smd=$(${odio} which mkdir)
	sca=$(${odio} which chattr) #käytössä?
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

	#[-v jotain ]  taakse nämä?
	export LC_TIME
	export LANGUAGE
	export LC_ALL
	export LANG

	#280326:/o/b/zxcv - jutut jo kunnossa? vai vielä jotain säätöä?
	[ -s /opt/bin/zxcv ] || echo "should exit 98"
	[ -s /opt/bin/zxcv.sig ] || echo "ahouls exit 99"
	[ -s /opt/bin/zxcv.sha ] || echo "shoul.d ex1t 97"

	#pitäisiköhä olla lukuoikeus noilla ao. tdstoilla?

	${odio} ${sah6} -c /opt/bin/zxcv.sha
	#jatkossa .sig vai .sha.sig?
	[ $? -gt 0 ] && echo "gh0uls 0f n1n1w3h"

	[ -z "${gg}" ] || ${gg} --verify /opt/bin/zxcv.sig
	[ $? -gt 0 ] && echo "dhoulf exit 126"

	local p=$(pwd)
	cd /
	${odio} ${sah6} -c /opt/bin/zxcv
	[ $? -gt 0 ] && echo "dhoulf exit 1234!!!"
	cd ${p}

	csleep 1
	dqb "cb0 done"
}

check_bin_0

function jules() {
	dqb "LE BIG MAC"
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

#TODO:jatkosäätöä josqs lähiaikoina?
function psqa() {
	dqb "c.Q () () () () ${1} ;;;"
	csleep 1

	[ -z "${1}" ] && exit 97
	[ -d ${1} ] || exit 96
	[ ${debug} -gt 0 ] && ls -las ${1}/sha512sums*
	csleep 1

	#return 92 #ei näin?
	#dpkg -V oli tässä josqs , [ -v ] takana

	if [ -v gg ] && [ -s ${1}/sha512sums.txt.sig ] ; then
		dqb "))S))))( ${1} )"
		csleep 1

		#pitäisikö testata dgdts-hmiston sisltöä tai .gnupg? pubring.kbx yli 32 tavua?
		if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
			dqb "${gg} --verify ${1}/sha512sums.txt.sig "
			csleep 1
			${gg} --verify ${1}/sha512sums.txt.sig 

			if [ $? -eq 0 ] ; then
				dqb "KÖ"
			else
				dqb "SHOULD imp2 k \$dir !!!"
				${NKVD} ${1}/sha512sums.*
				return 95 #jatk exit pois
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
			dqb "SHOULD \${NKVD} ${1}/*.deb"
			return 94
		fi

		[ -f ${1}/sha512sums.txt.1 ] && ${sah6} --ignore-missing -c sha512sums.txt.1
		csleep 1
		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
		dqb "SHOULD \${NKVD} ${1}/*.deb"		
		return 93
	fi

	dqb " DONE WITH THE Q-FEVER () ;;;; (((((("
	csleep 2
}

#HUOM.060426:ne kalat mitkä eivät listassa tulisi kai hukata
#... tai helpompi että sha512sums mukaiset tilap hmistoon misytä sitten asennellaan, jölkjelle jääneet pois
#efk2 2. param ja cefgh voisi liittyä asiaan

#TODO:tapaus e.tar, pitäisi tarkistaa pikemminkin $file.sha
#TODO:"palautusarvo-tarkistus" uusiksi josqs
#TODO:jatkossa tämä tai kutsuva koodi viskomaan validit paketit tmp-hmistoon jatkoa vrten
function common_pp3() {
	dqb "() common_pp3 )))))) ${1} )))))))))))))"
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

	q=$(find ${1} -type f -name "*.deb" | wc -l)
	r=$(echo ${1} | cut -d "/" -f 1-5)

	if [ ${q} -lt 1 ] ; then
		echo "SHOULD REMOVE ${1} / sha512sums . t x t"
		echo "ibcovation \"${scm} a-x ${1} /../common_lib.sh;import2 1 \$something\" MAY ALSO HELP"

		#tämä lienee se syy miksi myöhemmin pitää renkata...
		${scm} a-x ${r}/common_lib.sh
		dqb "NO EXIT 55 HERE, CHIMAERA..."
	else
		psqa ${1}
		#TODO:koitahan päättää mitä tässä tekee.
		[ $? -gt 0 ] && ${NKVD} ./*.deb ./sha512sums ./*.tar* #näin ok?
	fi

	dqb "() common_pp3 DONE"
	csleep 1
}

#... tai siis vaatinee jnkn verran selvittelyä dpkg korvaaminen aptilla niin että

function efk1() {
	dqb "efk1 $@"
	${sdi} $@

	if [ $? -eq 0 ] ; then
		${NKVD} $@
		dqb "ÖK"
	else
		dqb $?
	fi

	csleep 1 #riittäisikö?
}

function efk2() {
	dqb "efk2 )))))))) ${1} ))) ${2} )))))"

	if [ -s ${1} ] && [ -r ${1} ] ; then
		${odio} ${sr0} -C ${2} -xf ${1}
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi

	csleep 1
}

function wopr() { #050426:toimii jo?
	dqb "wpor ) ${1} ; ${2} ; ${3} ; )"
	local r=$(find ${1} -type f -name "${2}*.deb" )

	for s in ${r} ; do
		case "${3}" in
			reject_pkgs)
				${NKVD} ${s}
			;;
			accept_pkgs_1|accept_pkgs_2)
				efk1 ${s}
			;;
			*)
				exit 99
			;;
		esac
	done

	csleep 1
}

function common_lib_tool() {
	dqb "common_lib_tool( ${1}  ; ${2} )))) "
	[ -d ${1} ] || exit 66
	[ -z "${2}" ] && exit 67
	[ -s ${1}/${2} ] || dqb "SHOULD COMPLAIN ABT MISSing f ILE"

	dqb "WILL START PR0C3551NG TGTs NOW"
	csleep 1
	local q

	for q in $(grep -v "#" ${1}/${2}) ; do
		dqb "outer; ${q}"
		wopr ${1} ${q} ${2}

		if [ ${debug} -eq 1 ] ; then
			ls -las ${1}/${q}* | wc -l
		fi
	done

	dqb "t00l DONE"
}

#HUOM.140326:jospa olisi jo ympäristömjat kunnossa fromtendissä
#https://superuser.com/questions/1470562/debian-10-over-ssh-ignoring-debian-frontend-noninteractive saattaisi liittyä

function fromtend() {
	dqb "FRöMTEND"

	[ -v sd0 ] || exit 99
	[ -z "${sd0}" ] && exit 98
	[ -x ${sd0} ] || exit 97

	export DEBIAN_FRONTEND=noninteractive

	if [ ! -f /.chroot ] ; then #ei conf_alt_root ainakaan vielä
		dqb "${odio} -E ${sd0} --force-confold -i $@"
		${odio} -E ${sd0} --force-confold -i $@
	else
		${odio} ${sd0} --force-confold -i $@
	fi

	csleep 2
	dqb "DNÖE"
}

#VAIH:jatkossa uusikcsi tämä?
function cefgh() {
	dqb " cefgh( ${1} )))"

	[ -z "${1}" ] && exit 66
	[ -d ${1} ] || exit 67

	dqb "pars ok"
	csleep 1

	if [ -z "${gg}" ] ; then	
		efk2 ${1}/e.tar ${1}
		#[ $? -eq 0 ] && 
		${NKVD} ${1}/e.tar
	fi

	efk2 ${1}/f.tar ${1}

	if [ $? -eq 0 ] ; then
		[ -x ${gg} ] && ${NKVD} ${1}/f.tar
	fi

	#mitäjos part3() kaNssa tulee sitä gpg-nalkutusta? g.tar-jutut takaisin tähämn?	
	#"exp2 g $d/g.tar" ? + "exp2 f jälkeen"
	#... tai tuo e.tar-jutska jos olisi kätevämpi sittenkin?
}

#160426:tarteeko uusia vai ei?
function CB01() {
	dqb "common.lib.CB01( ${1} )"
	csleep 1
	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 100

	#180426:josko sittenkin kikkailisi ao. blokin -> cefgh ?
	if [ -s ${1}/g.tar ] ; then
		#JOSPA TARKISTETTAISIIn g.tar ennen purq eikä sisällön purun jälkeen
		#... tai ilman gpg:tä voi tehdä vain sha-tarq ja sekin oikeastaan tapahtuu jo kutsuvassa koodissa
		#... g.tar:in saisi kyllä listaan mukaan

		efk2 ${1}/g.tar /
		common_pp3 ${1}
		${NKVD} ${1}/g.tar
		exit 103
	fi

	#160426:libaassuanin kanssa härdelliä vai ei?
	common_pp3 ${1}
	for p in ${E22_GI} ; do efk1 ${1}/${p}*.deb ; done
	csleep 1

	gg=$(${odio} which gpg)
	gv=$(${odio} which gpgv)
	csleep 1

	[ -s ${1}/sha512sums.txt.bak ] && ${svm} ${1}/sha512sums.txt.bak ${1}/sha512sums.txt
	common_pp3 ${1}

	dqb "common.lib.CB01() DONE"
	csleep 1
}

#160426:bissiin ei tarvtse muutella Just Nyt
function CB02() {
	dqb "CB02()"
	csleep 1
	jules

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 100

	[ -f /.chroot ] && message
	local p
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
	dqb "CB02() D0.N3"
	csleep 1
}

function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135 ( ${1} ) "
	csleep 1

	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)

	#(joko jo kunnossa 050426? melkein) (jos sittenkin vipuaisi GS takaisin accept-tdstoihin?)
	E22_GS="gcc-12-base libgcc-s1 libc6" #meneeköhän jännäksi 2. ja 3. kohdalla? jep, sicksi dpkg:n kanssa kuten menee
	E22_GS="${E22_GS} libgmp10 libisl23 libmpfr6 libmpc3 libzstd1 zlib1g"
	E22_GS="${E22_GS} libstdc++6 libgomp1 cpp-12" #060426:tartteeko varsinaisen cpp:n kanssa?

	E22_GM="libc6 libselinux1"

	E22_GM="${E22_GM} debianutils debconf liblocale-gettext-perl libtext-charwidth-perl libtext-iconv-perl libtext-wrapi18n-perl" # nfs-common	
	E22_GM="${E22_GM} debconf-i18n libelf1 libbpf1 " #zlib1,libc6
	E22_GM="${E22_GM} libmnl0 libxtables12 " # oikeastaanm jo toisissakin jutussa mukana

	#HUOM.060426:gss-  ja krb5 - kirjastoista tarvitaan oikeat versiot!!! (olisikojo 7426?)
	E22_GM="${E22_GM} libcom-err2 libk5crypto3 libkeyutils1 libkrb5support0 libssl3 libkrb5-3 libkrb5support0"
	E22_GM="${E22_GM} libmnl0 libatm1 libpcre2-8-0 libmd0 libgssapi-krb5-2 "
	E22_GM="${E22_GM} libbsd0 libcap2 libcap2-bin libdb5.3 libtirpc-common libtirpc3 iproute2"

	#Depends: , debianutils (>= 2.8.2), iproute2
	#	E22_GM="${E22_GM} resolvconf" #josq toimisi ilmankin tätä 
	E22_GM="${E22_GM} isc-dhcp-client isc-dhcp-common" #dhcp-jutut erilleen jotenkin?
	E22_GM="${E22_GM} libpam0g libcrypt1 libaudit1 libpam-modules-bin libpam-modules "

	#Depends: passwd
	#Depends:  (>= 2.34), adduser, iproute2

	E22_GM="${E22_GM} libbz2-1.0 libsemanage-common libsemanage2 libsepol2 passwd adduser ifupdown"
	E22_GM="${E22_GM} libblkid1 libmount1 libsmartcols1 mount net-tools"
	E22_GM="${E22_GM} libacl1 libattr1 libgmp10 coreutils" #iproute2-doc iproute

	#... nuo jutut miel accept1/2 mukaan jatq tjsp?

	local y
	y="ifup ifdown apt-get apt ip netstat ${sd0} ${sr0} mount umount sha512sum mkdir mktemp" # kilinwittu.sh
	for x in ${y} ; do ocs ${x} ; done

	#HUOM.nämä e22_jutut tarkoituksella asetettu juuri tässä fktiossa
	sdi="${odio} ${sd0} -i "

	#050426:tämä jo okK?
	E22_GI="libassuan0 libbz2-1.0 libc6 libgcrypt20 libgpg-error0 libreadline8 libsqlite3-0 gpgconf zlib1g gpg"

	#080426:twm-jutut josqs myöhemmin, ehkä (enemmän liittyy e23.sh)

	#050426:dhcp-jutut erilleen jatkossa? 
	E22_GT="isc-dhcp-client isc-dhcp-common "
	E22_GT="${E22_GT} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11 libnftables1 libedit2"
	E22_GT="${E22_GT} iptables"
	E22_GT="${E22_GT} init-system-helpers" # iptables-persistent netfilter-persistent

	E22_GU="isc-dhcp libnfnet libnetfilter libxtables libmnl libnftnl libnftables libnl-3-200 libnl-route libnl nftables"
	E22_GV="libip iptables_ iptables-" # netfilter-persistent

	#HUOM. gpg:n opistumis-ongelmalle voisi vähitellen keksiä ratkaisun prkl
	if [ -z "${ipt}" ] || [ -z "${gg}" ] ; then
		[ -z "${1}" ] && exit 99
		[ -d ${1} ] || exit 101

		#HUOM.040326:ce saattaa vähän haitata jos aikoo "import2 3"-tavalla mennä g_doit
		cefgh ${1}
		common_pp3 ${1}
		#070426:gpg-tarq pystyy tekemöään vastaq gpg asennettu, jos voisi jtnkinhuiomioida

		dqb "BF0R3 CVB0"
		csleep 5
	fi

	#HUOM.181225:muna-kana-tilanteen mahdollisuuden vuoksi tämä pitäisi ajaa ennen c_pp3() ?
	#... pitäisiköhän gg:n suhteen jotain tehdä, imp2 kiukuttelut nimittäin

	if [ -z "${gg}" ] ; then
		CB01 ${1}
	fi

	if [ -z "${ipt}" ] ; then
		CB02 ${1}
	fi

	dqb "#jäölk ÄYÖYÄ SDDFSDSDGH t. Paska-Ankka"
	#echo "CBIN.BF0RE.OCS"
	ls ${1}/*.deb | wc -l
	csleep 3
	for x in iptables ip6tables iptables-restore ip6tables-restore ; do ocs ${x} ; done

	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1

	#kts g_pt2 liittyen
	#ei vielä conf_lt_root
	[ -f /.chroot ] || ocs dhclient
	csleep 1

	sag=$(${odio} which apt-get)
	sa=$(${odio} which apt) #tar4vitaanko jossain? jep

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

	#HUOM.joutaisi varmaan nimeämistä miettiä, vöin tull skaannuksia
	sharpy="${odio} ${sag} remove --purge --yes "
	#HUOM. ${sag} oltava VIIMEISENÄ tai siis ao. kolmikosta
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "

	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "

	#konftdstoon tuo INITRd vai ei?
	INITRD=No
	export INITRD

	lftr="${smr} -rf /run/live/medium/live/initrd.img* " 
	${scm} a-wx /usr/sbin/update-initramfs #kokeeksi tämäkin, vissiin jotyain saa aikaan 050426

	#aiemmin moinen lftr oli tarpeen koska ram uhkasi loppua kesken initrd:n päivittelyn johdosta
	#cp: error writing /run/live/medium/live/initrd.img.new: No space left on device
	#
	#... chimaerassa esim pitäisi tuo lftr asettaa jhnkin ei-huuhaa-sisältöön

	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	smd="${odio} ${smd}"

	dqb "b1nar135.2 0k.2" 
	csleep 1
}

function TLA() {
	dqb "TLA.ipt :  ${ipt} "
	dqb "TLA.testgris : ${CONF_testgris}"
	csleep 1

	#3. ehto pois jatkossa vai ei?
	#200326:toimiikohan tarkistus toivotulla tavalla?
	#210326:tla() ja sqroot? jos on pedantti niin tuollakin yhdostelmällä piytäisi tables-säännöt muuttaa...

	if [ -z "${ipt}" ] || [ "${ipt}" == "${odio}" ] || [ -f /.chroot ] ; then #010426:antaa toistaiseksi o.lla viimiei n eht0
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		if [ ! -v CONF_testgris ] ; then
			#160426:mitenkähän tämän kohdan kanssa jatkossa?	
		
			dqb "JST B3F0R:tlb-b a s h"
			[ -s /opt/bin/tlb.bash ] || exit 99
			${scm} 0511 /opt/bin/tlb.bash

			#tarkoituksella ilman param
			${odio} /opt/bin/tlb.bash 
		fi
	fi
}

#060426:process_lib() oli tässä TLA() ja slaughter0() välissä aiemmin
#kokeeksi siirretty juuri ennen gpo() , toimii sielläkin

#==================================================================
function slaughter0() {
	local fn2
	local ts2

	fn2=$(echo $1 | awk '{print $1}') #TARKKUUTTA PRKL NÄIDEN KANSSA!!!
	ts2=$(${sah6} ${fn2})

	#tähän alle jotain tr-kikkAIlua?
	echo ${ts2} | awk '{print $1,$2}' >> ${2} #TARKK PRKL
}

function mangle_s() {
	dqb " mangle_s( ${1} )"
	csleep 1

	[ -z "${1}" ] && exit 44
	[ -x ${1} ] || exit 55
	[ -z "${2}" ] && exit 45
	[ -f ${2} ] || exit 54

	dqb "pars ok"
	csleep 1

	local r
	r=$(echo ${1} | tr -dc a-zA-Z0-9/.)
	#$r kanssa jotain t arkistuksia?
	${scm} 0555 ${r}
	${sco} root:root ${r}
	#vs /e/paswd ?

	echo -n "$(whoami)" | tr -dc a-zA-Z >> ${2}
	#100126:ALL vai localhost? rahat vs kolmipyörä?
	#echo -n " localhost=NOPASSWD:sha512:" >> ${2}
	#(kts omega)
	echo -n " ALL=NOPASSWD:sha512:" >> ${2}
	slaughter0 ${r} ${2}

	dqb " mangle_s() done"
}

function dinf() {
	local g
	local t
	local frist
	frist=1

	echo -n "#" >> ${1} #toimiiko näin?
	echo -n " $(whoami)" | tr -dc a-zA-Z >> ${1}
	echo -n " localhost=NOPASSWD:" >> ${1}

	for g in $(${odio} find /sbin -type f -name "dhclient-script*" ) ; do
		if [ ${frist} -eq 1 ] ; then 
			frist=0
		else
			echo -n "," >> ${1}
		fi

		echo -n "sha512:" >> ${1}
		t=$(${sah6} ${g} | awk '{print $1}' | tr -dc a-fA-F0-9) #TARRKK PRKL
		echo -n ${t} >> ${1}
	done

	echo " /sbin/dhclient-script" >> ${1}
	cat ${1}
	csleep 5
}

#=================================================================
function fasdfasd() {
	#HUOM.ei-olemassaoleva tdstonnimi sallittava parametriksi
	[ -z "${1}" ] && exit 99

	csleep 1
	${odio} touch ${1}
	${sco} $(whoami):$(whoami) ${1}
	${scm} 0644 ${1}
}

#olisiko jokin palikka jo aiemmin? e_jutut ? mangle2() ? ei ihan täsmä lleen kumpikaan
function reqwreqw() {
	[ -z "${1}" ] && exit 99
	[ -f ${1} ] || exit 100
	csleep 1
	${sco} 0:0 ${1}
	${scm} a-w ${1}
}

#HUOM. voisi jaksaa ajatella sitäkin että /e/s.d alaisen tdston nimen_muutos vaikuttaa myös g_doit toimintaan?
function pre_enforce() {
	dqb "pre_enforce() "
	[ -z "${1}" ] && exit 98	
	[ -d ${1} ] || exit 97
	[ -v mkt ] || exit 99
	dqb "pars_ok"
	csleep 1

	local q
	local f
	q=$(${mkt} -d)
	q=${q}/meshuqqah
	csleep 1
	fasdfasd ${q}
	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 1
	[ -f ${q} ] || exit 33
	for f in ${CB_LIST1} ; do mangle_s ${f} ${q} ; done

	dqb "BFOR3 testgris"
	csleep 1

	if [ ! -v CONF_testgris ] ; then #tämän kanssa semmoinen juttu jatkossa (jos mahd)
		if [ ! -d /opt/bin ] ; then
			${smd} /opt/bin
			[ $? -eq 0 ] || ${odio} ${smd} /opt/bin
		fi

		#140326:jospa olisi tämä blokki jnkin aikaa ok näin
		if [ -d ${1}/opt/bin ] ; then
			#tämä mv ok?
			${svm} ${1}/opt/bin/*.bash /opt/bin
			#090326.2:miten /o/b/zxcv ?
		fi

		#vainko .bash mankeloidaan jatkossa?
		for f in $(${odio} find /opt/bin -type f -name "*.bash" ) ; do
			mangle_s ${f} ${q}
		done

		#uutena 150326
		${scm} a-w /opt/bin/*
		${scm} a-wx /opt/bin/*.sh
		csleep 1
	fi

	csleep 1

	if [ -s ${q} ] ; then
		csleep 1
		reqwreqw ${q}
		${scm} 0440 ${q}
		#tämä mv ok?
		${svm} ${q} /etc/sudoers.d
		CB_LIST1=""
		unset CB_LIST1
	fi

	q=$(${mkt})
	fasdfasd ${q}
	dinf ${q}
	reqwreqw ${q}
	${scm} 0440 ${q}
	${svm} ${q} /etc/sudoers.d
	csleep 1

	local c4
	c4=0
	csleep 1

	if [ -v CONF_dir ] ; then
		c4=$(grep ${CONF_dir} /etc/fstab | wc -l)
	else
		exit 99
	fi

	csleep 1
	#HUOM.261125:typot hyvä pitää minimissä konf-fileissä

	if [ ${c4} -lt 1 ] ; then
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

	dqb "pre_enforce() done"	
	csleep 1
}

function mangle2() {
	[ -z  "${1}" ] && exit 99

	if [ -f ${1} ] ; then
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}

#010426:pitäisiköhän vähän miettiä mistä tätä ao. fkftiota tarpeellista kutsua ja mistä ei?
#170426:resolv.conf delliminen voi aiheuttaa härdelliä myöhemmin
function e_e() {
	csleep 1
	fix_sudo
	for f in $(find /etc/sudoers.d/ -type f) ; do mangle2 ${f} ; done

	for f in $(find /etc -name "sudo*" -type f | grep -v log) ; do
		mangle2 ${f}
	done

	other_horrors
	${scm} 0755 /etc
	${sco} -R root:root /etc
	${scm} 0555 /etc/network
	${scm} 0444 /etc/network/*

	for f in $(find /etc/network -type d ) ; do ${scm} 0555 ${f} ; done
	csleep 1

	local f
	local c

	#280326:missä djclient-sctipy hukataan? siihen tarvitsisi kosea vain jos CONF_dnsm
	#... /o/b/m voisiolla se hukkaaja

	f=$(date +%F)
	[ -f /etc/resolv.conf.${f} ] || ${svm} /etc/resolv.conf /etc/resolv.conf.${f}
	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}

	#030426:ok näin vai ei?
	if [ -h /etc/resolv.conf ] ; then
		#tarkistus hyvä näin vai ei? toimiiko size?
		c=$(find /etc -type f -name "resolv.conf.*" -size +10c | wc -l )

		if [ ${c} -gt 0 ] ; then 
			${smr} /etc/resolv.conf
		fi
	fi

	[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
	csleep 5

	#CONF_iface-tarkistuksen taakse?
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	for f in $(${odio} find /etc -type f -name "rules.*" ) ; do
		${sco} -R root:root ${f}
		${scm} 0400 ${f}
	done

	csleep 1
}

function e_v() {
	#180326:/sbin - rivien kanssa jotain ongelmaa? chown valittaa /sbin alaisista tdstoista...
	#kiekolla bittejä poikittain?

	${sco} -R root:root /sbin
	${scm} -R 0755 /sbin
	dqb "e_V_2 IN 1 SECS"
	csleep 1

	${sco} root:root /var
	${scm} 0755 /var
	${sco} root:staff /var/local
	${sco} root:mail /var/mail
	${sco} -R man:man /var/cache/man
	${scm} -R 0755 /var/cache/man
	csleep 1
}

#150326:vissiin toimii kuten tarkoitus
function e_h() {
	[ -z "${1}" ] && exit 98
	[ -d ${2} ] || exit 99

	csleep 1
	${sco} root:root /home
	${scm} 0755 /home
	local c
	c=$(grep $1 /etc/passwd | wc -l)

	if [ ${c} -gt 0 ] ; then
		${sco} -R ${1}:${1} ~
		csleep 1
	fi

	local f
	csleep 1
	${scm} 0755 ${2}
	for f in $(find ${2} -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -type f) ; do ${scm} 0444 ${f} ; done
	local m=0555

	#tämäkö siihen "-v vs ei -v"-temppuiluun liittyy?
	for f in $(find ${2} -type f -name "*.sh" ) ; do ${scm} ${m} ${f} ; done
	csleep 1

	if [ -d ${2}/opt/bin ] ; then
		${sco} -R root:root ${2}/opt/bin
		${scm} go-wr ${2}/opt/bin/*
		${scm} 0400 ${2}/opt/bin/*.sh
		${scm} 0511 ${2}/opt/bin/*.bash
	fi

	csleep 1
}

#150326:ehkä tämäkin toimii
function e_final() {
	csleep 1

	${scm} go-rw /opt/bin/*
	${scm} 0400 /opt/bin/*.sh
	${scm} 0511 /opt/bin/*.bash
	${sco} -R root:root /opt
	${scm} 0755 /
	${sco} root:root /

	${scm} 0777 /tmp
	#${scm} o+w /tmp
	#081225:+t pois koska exp2 u
	${sco} root:root /tmp

	csleep 1
}

function enforce_access() {
	dqb "enforce_access(${1} , ${2} )"
	[ -z "${1}" ] && exit 67
	[ -z "${2}" ] && exit 68
	csleep 1

	e_e
	e_v
	e_h ${1} ${2}
	e_final
	jules

	[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables;sleep 2
}

#tavoitetila dokumentoituna: https://www.devuan.org/os/packages
#kts myös https://github.com/topics/sources-list

function part1_5() {
	dqb "part1_5()"

	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67
	[ -d ${2} ] || exit 68

	dqb "part1_5().pasr.ko"
	csleep 1
	local t
	t=$(echo ${1} | cut -d "/" -f 1) #tr kanssa?

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
			local b

			if [ -f /.chroot ] && [ -v CONF_alt_root ] ; then
				b="deb file://${2}"
			else
				b="deb https://REPOSITORY/merged"
			fi

			for x in DISTRO DISTRO-updates DISTRO-security ; do
				echo "${b} ${x} main" >> ${h}/sources.list.tmp
			done
		else
			${svm} /etc/apt/sources.list.tmp ${h}
			fasdfasd  ${h}/sources.list.tmp
		fi

		dqb "p1.5.2"
		csleep 1
		local tdmc

		tdmc="sed -i 's/DISTRO/${t}/g'" #TARRKK PRKL
		echo "${tdmc} ${h}/sources.list.tmp" | bash -s
		csleep 1

		if [ ! -z "${CONF_pkgsrv}" ] ; then
			tdmc="sed -i 's/REPOSITORY/${CONF_pkgsrv}/g'" #TARRKK PRKL
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

#HUOM.170326:JOS VAI N MITENKÄÄN MAHDOLLISTA NIIN EI TABLESIN KANSSA SAISI JÄÄDÄ ACCEPT-TILANTEESEEN
function part1() {
	dqb "()()() PART1 ${1} , ${2} ()()()()() "
	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67
	[ -d ${2} ] || exit 68

	csleep 1
	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
	csleep 1

	[ -v ipt ] || dqb "SHOULD exit 69"
	local c
	local g
	local t

	g=$(date +%F)
	t=$(echo ${1} | cut -d '/' -f 1 | tr -dc a-z)  #TARRKK PRKL

	if [ -f /etc/apt/sources.list ] ; then
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:' | wc -l) #TARRKK PRKL

		if [ ${c} -gt 0 ] ; then 
			${svm} /etc/apt/sources.list /etc/apt/sources.list.${g}
			csleep 1
		fi
	fi

	#kuinkahan tarpeellinen kikkailu?
	if [ -f /.chroot ] && [ -v CONF_alt_root ] ; then
		part1_5 ${t} ${CONF_alt_root}/${t}
	else
		part1_5 ${t} ${2}
	fi

	if [ ! -f /etc/apt/sources.list ] ; then
		if [ -s /etc/apt/sources.list.${t} ] && [ -r /etc/apt/sources.list.${t} ] ; then
			${slinky} /etc/apt/sources.list.${t} /etc/apt/sources.list
		fi	
	fi

	[ ${debug} -eq 1 ] && cat /etc/apt/sources.list
	csleep 1

	${sco} -R root:root /etc/apt
	${scm} -R a-w /etc/apt/
	dqb "FOUR-LEGGED WH0R3"
}

function part2() {
	dqb "PART2.5.1 ( $1 , $2 , $3 ((("
	csleep 6

	[ -z "${1}" ] && exit 55
	[ -z "${2}" ] && exit 56

	dqb "PARS_OK"
	csleep 1

	if [ ${1} -eq 1 ] ; then
		dqb "pHGHGUYFLIHLYGLUYROI mglwafh..."
		#HUOM.080326:if  $INITRD = No  then , olisiko apua initramfs-urputuksen kanssa?
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

		case "${3}" in
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

	dqb "PART2.5.2 )))))( $1 , $2"
	csleep 1
	${lftr}
	csleep 1

	#150326:pitäisikohän tehdf vielä toinenkin veuiartlu barm buoksi?
	if [ ! -z "${ipt}"  ] ; then
		jules
		local t

		#210326:nyt sitten miettimään että pitäisikö reslvo.conf:ille tehdä jotain. taas
		t=$(echo ${2} | tr -d -c 0-9)
		${odio} /opt/bin/tlb.bash ${t}
	fi

	if [ ${debug} -eq 1 ] ; then
		${snt}
		sleep 1
	fi

	csleep 1
	dqb "PART2.5 d0ne"
	csleep 1
}

#010136:jospa toimisi
function cg_udp6() {
	dqb " GENERIC REPLACEMENT FOR daud.lib.UPDP-6 ${1}"
	csleep 1

	[ -z "${1}" ] && exit 65
	#jokin syy miksi ei -z ? eikai

	[ -d ${1} ] || exit 66
	dqb "paramz 0k"
	csleep 1

	dqb "${1} :"
	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb | wc -l
	csleep 3

	dqb "${pkgdir} :"
	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}/*.deb | wc -l
	csleep 3

	common_lib_tool ${1} reject_pkgs
	dqb "D0NE"
	csleep 1
}

function cg_pp2() {
	dqb " GENERIC REPLACEMENT FOR daud.lib.pre_part2 ${1}"
	csleep 1

	${odio} /etc/init.d/ntpd stop
	#$sharpy ntp* jo aiempana

	for f in $(find /etc/init.d -type f -name "ntp*" ) ; do 
		${odio} ${f} stop
		csleep 1
	done

	csleep 2
	dqb "d0n3"
}

dqb "HUOM. KANNATTAA KEHITYSYMP PURKAA PAKETTI RIITTÄVIN VALTUUKSIN ETTÄ PYSYVÄT SKRIPTIT AJAN TASALLA"
csleep 6

#160126:g.tar liittyvää kikkailua jatkossa? sittenkin check_bin() alta g-jutut -> cefgh()?
#140326:libfortran-urputuksille j os tekisijojo tain?
#libatomic1 : Depends: gcc-12-base (= 12.2.0-14) but 12.2.0-14+deb12u1 is installed
# libgfortran5 : Depends: gcc-12-base (= 12.2.0-14) but 12.2.0-14+deb12u1 is installed
# libquadmath0 : Depends: gcc-12-base (= 12.2.0-14) but 12.2.0-14+deb12u1 is installed
#... jospa nyt aluksi selvittäisi mikä näitä tarvitsee?

#TODO:toiminnan selvittelyä vai ei?
function part3() {
	dqb "))() part3 ${1} , ${2} (((((((("
	csleep 1

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 101

	dqb "PARAMS_OK"
	csleep 1
	
	local n15
	n15=$(find ${1} -type f -name "*.deb" | wc -l)

	if [ ${n15} -lt 1 ] ; then
		cefgh ${1}
	fi

	csleep 1
	jules
	common_pp3 ${1}
	dqb "AL-fPGA"
	csleep 1

	common_lib_tool ${1} reject_pkgs
	#HUOM.160126:pitäisiköhän ajaa lftr ennen masenteluja? chimaera...
	dqb "B3T4"
	csleep 6

	#060426:AO. RIVI TUOLLAINEN TARKOITUKSELLA, ÄLÄ SORKI!!!
	efk1 ${1}/gcc-12-base*.deb ${1}/libgcc-s1*.deb ${1}/libc6*.deb
	dqb "LAcKK.a"
	csleep 6

	for p in ${E22_GS} ; do wopr ${1} ${p} accept_pkgs_1 ; done
	dqb "önEGA-VGA RA"
	csleep 6

	common_lib_tool ${1} accept_pkgs_1
	common_lib_tool ${1} accept_pkgs_2

	dqb "g4RP D0NE"
	csleep 1

#	efk1 ${1}/lib*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 66"
#	csleep 1
#
#	efk1 ${1}/*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 67"	
#	csleep 1

	for f in $(find ${1} -name "lib*.deb" ) ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
               dqb "part3.1 ok"
               csleep 1
               ${NKVD} ${1}/lib*.deb
	else
               exit 66
	fi

	dqb "LIBS DONE"
	csleep 1
	for f in $(find ${1} -name "*.deb" ) ; do ${sdi} ${f} ; done

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

function process_lib() {
	dqb "process_lib( ${1} )(((((((("
	[ -z "${1}" ] && exit 66
	csleep 1

	if [ -x "${gg}" ] && [ -s ${1}/lib.sh.sig ] ; then
		dqb "SHOULD ${gg} --verify ${1}/lib.sh.sig ? "
		${gg} --verify ${1}/lib.sh.sig
		[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		csleep 1
	fi

	csleep 1

	if [ -d ${1} ] && [ -x ${1}/lib.sh ] ; then
		.  ${1}/lib.sh		
	else
		fallback	
	fi

	#jospa jatkossa c_b if-blokin jälkeen jokatap? silloin syytä tark että common_lib sisältää x.-oik
	check_binaries ${1}
	[ $? -eq 0 ] || dqb "SHOULD exit 67"

	check_binaries2
	[ $? -eq 0 ] || dqb "SHOULD exit 68 också"

	TLA
	dqb "process_lib.done()"
}	

function gpo() {
	dqb "GPO"
	local prevopt
	local opt
	prevopt=""

	if [ $# -lt 1 ] ; then
		echo "$0 -h"
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

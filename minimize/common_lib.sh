#fktioksi tnä ni ei tartte globaalien mjien kanssa sählätä?
#debug=1 #pois sittenq

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
	#020236:josko toimisi uudella tavalla paremmin?
	#${scm} 0400 /etc/iptables/*

	for f in $(${odio} find /etc -type f -name 'rules.*') ; do
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
	dqb "ocs ${1} "
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
	[ -z ${sd0} ] && exit 79
	#-x vielä?

	sr0=$(${odio} which tar)
	[ -v sr0 ] || exit 80
	[ -z ${sr0} ] && exit 81
	#-x vielä?

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
	[ -z ${NKVD} ] && exit 37
	NKVD="${odio} ${NKVD} -fu "

	#ehkä tämmöinen lista kuuluisi konftdstoon?
	PART175_LIST="avahi blu cups exim4 nfs network mdadm sane rpc lm-sensors dnsmasq stubby" 

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

	#[-v jotain ]  taakse nämä?
	export LC_TIME
	export LANGUAGE
	export LC_ALL
	export LANG

	#VAIH:/o/b/zxcv - jutut
	[ -s /opt/bin/zxcv ] || echo "should exit 98"
	[ -s /opt/bin/zxcv.sig ] || echo "ahouls exit 99"
	[ -s /opt/bin/zxcv.sha ] || echo "should exit 97"
	${sah6} -c /opt/bin/zxcv.sha
	[ $? -gt 0 ] || echo "should exit 96"
	${gg} --verify ${g_d0}/zxcv.sig
	[ $? -gt 0 ] && echo "dhoulf exit 126"

	csleep 1
	dqb "cb0 done"
}

check_bin_0

function jules() {
	dqb "LE BIG MAC"

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

	[ -z "${1}" ] && exit 97
	[ -d ${1} ] || exit 96
	[ ${debug} -gt 0 ] && ls -las ${1}/sha512sums*
	csleep 1

	#dpkg -V oli tässä josqs

	if [ -v gg ] && [ -s ${1}/sha512sums.txt.sig ] ; then
		dqb "S( ${1} )"
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

	csleep 1
}

function efk2() {
	dqb "efk2 ${1}"

	if [ -s ${1} ] && [ -r ${1} ] ; then
		${odio} ${sr0} -C ${2} -xf ${1}
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi	

	csleep 1
}

function common_lib_tool() {
	dqb "common_lib_tool( ${1}  , ${2} ) "
	[ -d ${1} ] || exit 66
	[ -z "${2}" ] && exit 67
	[ -s ${1}/${2} ] || dqb "SHOULD COMPLAIN ABT MISSing f ILE"

	dqb "WILL START PR0C3551NG TGTs NOW"
	csleep 1

	local q
	local r
	local s

	for q in $(grep -v '#' ${1}/${2}) ; do
		dqb "outer; ${q}"
		#jatk r pois?
		r=$(find ${1} -type f -name "${q}*.deb" )

		for s in ${r} ; do
			dqb "inner: \${cmd} ${s}"

			#130226:tähän case-seac + pkgs_drop käsdittely vaiko ei?
			if [ "$2" == "reject_pkgs" ] ; then
				${NKVD} ${s}
			else
				efk1 ${s}
			fi

			csleep 1
		done

		if [ ${debug} -eq 1 ] ; then
			ls -las ${1}/${q}* | wc -l
		fi
	done

	dqb "t00l DONE"
}

#HUOM.140326:jospa olisi jo ympäristömjat kunnossa fromtendissä
#https://superuser.com/questions/1470562/debian-10-over-ssh-ignoring-debian-frontend-noninteractive saattaisi liittyä
#alahan jo tehdä jotain tuolle
#toimii edelleen noinkin? (050326) (110326 puolella sqroot alaisuudessa näyttäisi toimivan myös)

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

	#mitäjos part3() kaNssa tulee sitä gpg-nalkutusta? g.tar-jutut takaisin tähämn?	
}

function CB01() {
	dqb "CB01()"
	csleep 1
	
	#160326:mv-komennon kanssa oli jotain urputusta? vissiin tämän?
	[ -s ${1}/sha512sums.txt ] && ${svm} ${1}/sha512sums.txt.bak
	efk2 ${1}/g.tar ${1}
	common_pp3 ${1}
	[ -s ${1}/g.tar ] && ${spc} ${1}/g.tar ${1}/g.tar.bak
	[ $? -eq 0 ] && ${NKVD} ${1}/g.tar
	
	#160326:mv-komennon kanssa oli jotain urputusta?
	[ -s ${1}/g.tar.bak ] && ${svm} ${1}/g.tar.bak ${1}/g.tar
	common_pp3 ${1} #JOSPA TARKISTETTAISIIn g.tar ennen purq eikä sisältö purun jälkeen
	
	for p in ${E22GI} ; do efk1 ${1}/${p}*.deb ; done
	csleep 1
	
	gg=$(${odio} which gpg)
	gv=$(${odio} which gpgv)
	csleep 1
	
	#160326:mv-komennon kanssa oli jotain urputusta?
	[ -s ${1}/sha512sums.txt.bak ] && ${svm} ${1}/sha512sums.txt
	common_pp3 ${1}
	}

function CB02() {
	dqb "CB02()"
	csleep 1
	jules

	[ -f /.chroot ] && message
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
	E22_GT="${E22_GT} init-system-helpers" # iptables-persistent netfilter-persistent

	E22_GU="isc-dhcp libnfnet libnetfilter libxtables libnftnl libnl-3-200 libnl-route libnl"
	E22_GV="libip iptables_ iptables-" # netfilter-persistent

	#HUOM.ao. mjan asettaminen konfiguraatiossa voi aiheuttaa härdelliä tässä alla?
	#voisiko testgris-ehdon hukata jatkossa? lets find out
	#if [ ! -v CONF_testgris ] ; then
		if [ -z "${ipt}" ] || [ -z "${gg}" ] ; then
			[ -z "${1}" ] && exit 99
			[ -d ${1} ] || exit 101
			
			#HUOM.040326:ce saattaa vähän haitata jos aikoo "import2 3"-tavalla mennä g_doit
			cefgh ${1}
			common_pp3 ${1}
		fi
		
		#HUOM.181225:muna-kana-tilanteen mahdollisuuden vuoksi tämä pitäisi ajaa ennen c_pp3() ?
		if [ -z "${gg}" ] ; then
			CB01 ${1}
		fi
	
		if [ -z "${ipt}" ] ; then
			CB02 ${1}
		fi

		ls ${1}/*.deb | wc -l
		csleep 3
	
		for x in iptables ip6tables iptables-restore ip6tables-restore ; do ocs ${x} ; done
	#fi #tstgris
	
	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1

	#kts g_pt2 liittyen
	#ei vielä conf_lt_root
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
	#	
	#aiemmin moinen lftr oli tarpeen koska ram uhkasi loppua kesken initrd:n päivittelyn johdosta
	#cp: error writing '/run/live/medium/live/initrd.img.new': No space left on device
	#
	#... chimaerassa esim pitäisi tuo lgftr asettaa jhnkin ei-huuhaa-sisältöön

	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	smd="${odio} ${smd}"
	
	#tähän/seuraavaan TLA() vai mitenkä?
	dqb "b1nar135.2 0k.2" 
	csleep 1
}

#jatkossa erillinen fktio vaiko kutsuen /o/b/tlb.bash ? vissiin jälkimmäinen (VAIH)
function TLA() {
	dqb "TLA.ipt :  ${ipt} "
	dqb "TLA.testgris : ${CONF_testgris}"
	csleep 1

	#3. ehto pois jatkossa vai ei?
	#200326:toimiikohan tarkistus toivotulla tavalla?
	if [ -z "${ipt}" ] || [ "${ipt}" == "${odio}" ] ||  [ -f /.chroot ]  ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		dqb "JST B3F0R:tlb-b a s h"
		[ -x /opt/bin/tlb.bash ] || exit 99
		${odio} /opt/bin/tlb.bash #tarkoiytukseölla ilman param

#		#HUOM.140326:olisikohan CONBF_tesgtgirs riittävästi huomioitu? 
#		#aluksi ohitetaan koko for-takenne uknnes ehkä keksii paremman tavan
#		
#	
#		#... -F ja -P vain tarvittaessa, HCF-jutut lopuksi
#
#		#to state the obvious:export2 kautta kutsuttaessa part1() ei tarvinne tables-sääntöjä nollata
#		if [ -x ${ipt} ] ; then #VAIH:nalqtrus jos ei -x
#			local c
#			local c2
#
#			c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
#			c2=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
#
#			if [ ${c} -gt 0 ] || [ ${c2} -gt 0 ] ; then
#				#if [ ! -v CONF_testgris ] ; then # ehto pois 18326, tarvtseeko takaisin?
#				#/o/b/tlb.bash
#			
#				for t in INPUT OUTPUT FORWARD ; do
#					${ipt} -P ${t} DROP
#					[ $? -eq 0 ] || ${odio} /sbin/halt
#					dqb "V6"; csleep 1
#
#					${ip6t} -P ${t} DROP
#					[ $? -eq 0 ] || ${odio} /sbin/halt
#					${ip6t} -F ${t}
#				done
#
#				for t in INPUT OUTPUT FORWARD b c e f u v ; do 
#					${ipt} -F ${t}
#					[ $? -eq 0 ] || ${odio} /sbin/halt
#				done
#	
#				if [ ${debug} -eq 1 ] ; then
#					#pitäisikö olla ipt-legacy? 
#					${ipt} -L
#
#					dqb "V6.b"; csleep 1
#					${ip6t} -L
#				fi
#				
#				csleep 1
#			fi		
#
#			c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
#			[ ${c} -gt 1 ] && echo "SHOULD HALt AND CATCH FIRE IMMEDIATELY"
#			csleep 1
#
#			c=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
#			[ ${c} -gt 1 ] && echo "SHOULD ALSO:HALt AND CATCH FIRE IMMEDIATELY"
#			csleep 1
#		else
#			dqb "ipt NOT RUNNABLE?"
#			#exit 99 #ei ihan vielä uskalla näin tehdä? linkkiys sotkee asioita?
#		fi	
	fi
}

function process_lib() {
	dqb "process_lib( ${1} )"
	[ -z "${1}" ] && exit 66
	csleep 1

	[ -x "${gg}" ] && dqb "SHOULD ${gg} --verify ${1}/lib.sh.sig ? "
	csleep 1

	if [ -d ${1} ] && [ -x ${1}/lib.sh ] ; then
		.  ${1}/lib.sh		
	else
		fallback	
	fi

	#jospa jatkossa c_b if-blokin jälkeen jokatap? silloin syytä tark että common_lib sisältää x.-oik
	check_binaries ${1}
	[ $? -eq 0 ] || dqb "SHOULD exit 67" #tilap jemmaan 020326 , jokin qsee

	check_binaries2
	[ $? -eq 0 ] || dqb "SHOULD exit 68 också"

	TLA
	dqb "process_lib.done()"
}	

#==================================================================
function slaughter0() {
	local fn2
	local ts2

	fn2=$(echo $1 | awk '{print $1}') 
	ts2=$(${sah6} ${fn2})

	#tähän alle jotain tr-kikkialua?
	echo ${ts2} | awk '{print $1,$2}' >> ${2}
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

	for g in $(${odio} find /sbin -type f -name 'dhclient-script*') ; do
		if [ ${frist} -eq 1 ] ; then 
			frist=0
		else
			echo -n "," >> ${1}
		fi

		echo -n "sha512:" >> ${1}
		t=$(${sah6} ${g} | awk '{print $1}' | tr -dc a-fA-F0-9)
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

#olisiko jokin palikka jo aiemmin? e_jutut ? mangle2() ?
function reqwreqw() {
	[ -z "${1}" ] && exit 99
	[ -f ${1} ] || exit 100 #takaisn josqs? miksi?

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
	
		for f in $(${odio} find /opt/bin -type f -name '*.bash') ; do
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

#VAIH:/e alaisten tdstojen linkitttämiseen liittyen jokin juttu? jhnkin toiseen skriptiin vissiin

function e_e() {
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

	#vihje:ei tarvinne erikseen -R koska ylempänä
	${scm} 0444 /etc/network/*
	#${sco} root:root /etc/network
	for f in $(find /etc/network -type d ) ; do ${scm} 0555 ${f} ; done
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

	for f in $(${odio} find /etc -type f -name 'rules.*') ; do
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

	if [ ${debug} -gt 0 ] ; then
		m=0755
	fi

	#tämäkö siihen "-v vs ei -v"-temppuiluun liittyy?
	for f in $(find ${2} -type f -name '*.sh' ) ; do ${scm} ${m} ${f} ; done
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
	#${scm} a-w /opt/bin/*
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
#myös https://github.com/topics/sources-list

function part1_5() {
	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67
	[ -d ${2} ] || exit 68
	
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
	
		tdmc="sed -i 's/DISTRO/${t}/g'"
		echo "${tdmc} ${h}/sources.list.tmp" | bash -s
		csleep 1

		if [ ! -z "${CONF_pkgsrv}" ] ; then
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
#

#HUOM.170326:JOS VAI N MITENKÄÄN MAHDOLLISTA NIIN EI TABLESIN KANSSA SAISI JÄÄDÄ ACCEPT-TILANTEESEEN
function part1() {
	dqb "PART1 ${1} , ${2} "
	[ -z "${1}" ] && exit 66
	[ -z "${2}" ] && exit 67
	[ -d ${2} ] || exit 68
	
	csleep 1
	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
	csleep 1
	
	[ -v ipt ] || dqb "SHOULD exit 69" #010326 qseeko tämä kohta?
	#TLA #vähitellen pois tsätä fktiosta va i ei sittenkään?

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
		#HUOM.080326:if [ "$INITRD" = 'No' ]; then , olisiko apua initramfs-urputuksen kanssa?
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

	dqb "PART2.5.2 )))))( $1 , $2"
	csleep 1
	${lftr}
	csleep 1

	#150326:pitäisikohän tehdf vielä toinenkin veuiartlu barm buoksi?
	if [ ! -z "${ipt}"  ] ; then
		jules
		local t

		dqb "VAIH:repklce PART2.5.2 w/ o/b/tlb ?"
		csleep 6

		t=$(echo ${2} | tr -d -c 0-9)
		${odio} /opt/bin/tlb.bash ${t}

#		#HUOM.160226:tdstot ilman ".$t"-päätettä, pitäisikö tehdä jotain? 
#
#		if [ -s /etc/iptables/rules.v6.${t} ] ; then
#			${ip6tr} /etc/iptables/rules.v6.${t}
#		fi
#
#		if [ -s /etc/iptables/rules.v4.${t} ] ; then
#			${iptr} /etc/iptables/rules.v4.${t}
#		fi
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
	#jokin syy miksi ei -z ? let's find out

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

#160126:g.tar liittyvää kikkailua jatkossa? sittenkin check_bin() alta g-jutut -> cefgh()?
#140326:libfortran-urputuksille j os tekisijojo tain

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

	common_lib_tool ${1} reject_pkgs
	#HUOM.160126:pitäisiköhän ajaa lftr ennen masenteluja? chimaera...

	#140326:näiden 3 kanssa saattaa olla jokin juttu
	efk1 ${1}/libc6*.deb ${1}/gcc-12*.deb ${1}/cpp*.deb

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

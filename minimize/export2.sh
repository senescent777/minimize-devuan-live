#!/bin/bash
debug=0 #1
distro=$(cat /etc/devuan_version | cut -d '/' -f 1) #HUOM.28525:cut pois jatkossa?
d0=$(pwd)
echo "d0= ${d0}"

mode=-2
tgtfile=""

#HUOM.8725.1:joskohan wpa_supplicant.conf kanssa asiat kunnossa

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function parse_opts_1() {
	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			if [ ${mode} -eq -2 ] ; then
				mode=${1}
			else
				if [ -d ${d}/${1} ] ; then 
					distro=${1}
				else
					tgtfile=${1}
				fi
			fi
		;;
	esac
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

#parsetuksen knssa menee jännäksi jos conf pitää lkadata ennen common_lib (no paerse_opts:iin tiettty)
d=${d0}/${distro}

if [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa?
	echo "CONF MISSING"
	exit 55
fi

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
##	#HUOM.23525:oleellisempaa että import2 toimii tarvittaessa ilman common_lib
##	#"lelukirjasto" saattaa toimia sen vErrAn että "$0 4 ..." onnistuu	
##	
##	srat="sudo /bin/tar"
##	som="sudo /bin/mount"
##	uom="sudo /bin/umount"
##	scm="sudo /bin/chmod"
##	sco="sudo /bin/chown"
##	odio=$(which sudo)
##
##	#jos näillä lähtisi aiNAKin case q toimimaan
##	n=$(whoami)
##	sah6=$(${odio} which sha512sum)
##	smr="${odio} which rm"
##	smr="${odio} ${smr}"
##
##	function check_binaries() {
##		dqb "exp2.ch3ck_b1nar135( ${1} )"
##	}
##
##	function check_binaries2() {
##		dqb "exp2.ch3ck_b1nar135_2( ${1} )"
###	}
##
##	function fix_sudo() {
##		dqb "exp32.fix.sudo"
##	}
##
##	function enforce_access() {
##		dqb "exp32.enf_acc()"
##	}
##
##	function part3() {
##		dqb "exp32.part3()"
##	}
##
##	function part1_5() {
##		dqb "exp32.p15()"
##	}
##
##	function message() {
##		dqb "exp32.message()"
##	}
##
##	function jules() {
##		dqb "exp32.jules()"
##	}
##
##	#HUOM.23525:josko tässä kohtaa pakotus riittäisi
##	function other_horrors() {
##		dqb "AZATHOTH AND OTHER HORRORS"
##		#${spc} /etc/default/rules.* /etc/iptables #tartteeko tuota enää 27525?
##
##		${scm} 0400 /etc/iptables/*
##		${scm} 0550 /etc/iptables
##		${sco} -R root:root /etc/iptables
##		${scm} 0400 /etc/default/rules*
##		${scm} 0555 /etc/default
##		${sco} -R root:root /etc/default
##	}
##
##	function ppp3() {
##		dqb "exp32.ppp3()"
##	}
##
##	prevopt=""
##
##	for opt in $@ ; do
##		parse_opts_1 ${opt}
##		parse_opts_2 ${prevopt} ${opt}
##		prevopt=${opt}
##	done

	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 2

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
#else
#	echo "NOT (L1B AVA1LABL3 AND 3X3CUT4BL3)"
#
#	function pr4() {
#		dqb "exp2.pr4 ${1} " 
#	}
#
#	function udp6() {
#		dqb "exp32.UPD6()"
#	}
#
#	#onko tässä sktiptissä oleellista välittää $d part3:lle asti c_b välityksellä?
#	check_binaries ${d}
#	check_binaries2
fi

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \$ {d0} /\${distro}" 
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 t ... option for ipTables"			
	echo "$0 -h: shows this message about usage"	
}

dqb "tar = ${srat} "

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

tig=$(${odio} which git)
mkt=$(${odio} which mktemp)

if [ x"${tig}" == "x" ] ; then
	#HUOM. kts alempaa mitä git tarvitsee
	echo "sudo apt-get update;sudo apt-get install git"
	exit 7
fi

if [ x"${mkt}" == "x" ] ; then
	#coreutils vaikuttaisi olevan se paketti mikä sisältää mktemp
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

${sco} -Rv _apt:root ${pkgdir}/partial/
${scm} -Rv 700 ${pkgdir}/partial/
csleep 1

#HUOM. ei kovin oleellista ajella tätä skriptiä squashfs-cgrootin siäsllä
#mutta olisi hyvä voida testailla sq-chrootin ulkopuolella

function pre1() { #VAIH
	debug=1
	dqb "pre1( ${1}  ${2} )"
	[ -z ${1} ] && exit 666 #vika löytyi niinqu
	csleep 5

	${sco} -Rv _apt:root ${pkgdir}/partial/
	${scm} -Rv 700 ${pkgdir}/partial/
	csleep 1

	if [ -d ${1} ] ; then
		dqb "5TNA"
		n=$(whoami)
			
		local ortsac
		#local lefid

		#VAIH:näille main muutoksia
		#ortsac=$(echo ${1} | cut -d '/' -f 6 | tr -d -c a-z)
		#lefid=$(echo ${1} | cut -d '/' -f 1-5 | tr -d -c a-zA-Z/)
		#enforce_access ${n} ${lefid} tilapäisesti jemmaan 240725

		ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)
		csleep 1

		dqb "3NF0RC1NG D0N3"
		csleep 1
	
		${scm} 0755 /etc/apt
		${scm} a+w /etc/apt/sources.list*

		if [ -s /etc/apt/sources.list.${ortsac} ] ; then
			${smr} /etc/apt/sources.list #vähän jyrkkää mutta
		else
			#HUOM.20525:joutunee laittamaan uusiksi tässä
			part1_5 ${ortsac}
		fi

		if [ -f /etc/apt/sources.list.${ortsac} ] && [ -s /etc/apt/sources.list.${ortsac} ] && [ -r /etc/apt/sources.list.${ortsac} ] ; then 
			[ -h /etc/apt/sources.list ] && ${smr} /etc/apt/sources.list
			csleep 1
			${slinky} /etc/apt/sources.list.${ortsac} /etc/apt/sources.list
		fi

		${scm} -R a-w /etc/apt
		${scm} 0555 /etc/apt
		${sco} root:root /etc/apt

		[ ${debug} -eq 1 ] && ls -las /etc/apt/sources.list*		
		csleep 2
	else
		echo "P.V.HH"
		exit 111
	fi
}

function pre2() { #VAIH
	debug=1
	dqb "pre2 ${1}, ${2} #WTIN KAARISULKEET STNA" 
	[ -z ${1} ] && exit 66
	[ -z ${2} ] && exit 67
	local ortsac
	ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)

	if [ -d ${1} ] ; then
		dqb "PRKL"
		${odio} /opt/bin/changedns.sh ${dnsm} ${ortsac}
		csleep 1

		${sifu} ${iface}
		[ ${debug} -eq 1 ] && ${sifc}
		csleep 1

		${sco} -Rv _apt:root ${pkgdir}/partial/
		${scm} -Rv 700 ${pkgdir}/partial/

		${sag_u}
		csleep 1
	else
		echo "P.V.HH"
		exit 111
	fi

	echo "PRE 2DONE"
	sleep 2
}

function tpq() { #HUOM.24725:tämän casen output vaikuttaa järkevältä, lisää testejä myöhemmin
		
	debug=1
	dqb "tpq ${1} ${2}"
	[ -d ${1} ] || exit 22
	[ -d ${1} ] || exit 23	
	dqb "paramz 0k"
	csleep 1

	cd ${1}
	${srat} -jcf ./config.tar.bz2 ./.config/xfce4/xfconf/xfce-perchannel-xml ./.config/pulse /etc/pulse

	if [ -x ${2}/profs.sh ] ; then
		dqb "DE PROFUNDIS"
		.  ${2}/profs.sh
	
		exp_prof ./fediverse.tar default-esr
	else
		dqb "1nT0 TH3 M0RB1D R31CH"	
	fi

	cd ${2}
}

#VAIH:tässä jos sanoisi 3. parametrina minne siirrytään cd:llä ennenq ajaa tar
function tp1() { 
	debug=1

	dqb "tp1 ${1} , ${2} , ${3}  "
	[ -z ${1} ] && exit
	dqb "params_ok"
	csleep 1

	pwd
	csleep 1

	if [ -d ${2} ] ; then #toimiiko tmä kohta?
		dqb "cleaning up ${2} "
		csleep 1

		${NKVD} ${2}/*.deb
		${NKVD} ${2}/*.tar
		${NKVD} ${2}/sha512sums.txt

		dqb "d0nm3"
	else
		dqb "NO SUCH DIR ${2}"
	fi

	csleep 1

	if [ ${enforce} -eq 1 ] && [ -d ${2} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		tpq ~ ${d0} #TODO:gloib muutt mäkeen
	else
		dqb "PUIG DESTROYER"
	fi

	csleep 1
	#lototaan vaikka tässä uuden sijannin skriptin lisäys
	${srat} -rvf ${1} /opt/bin/changedns.sh
	
#	#TODO:keksittävä fiksumpi ratkaisu? ${d0}:n polusta 4 vikaa osaa?
#
#	if [ -d ${3} ] ; then
#		cd ${3}
#		dqb "DO SOMTHING"
#		dqb "rm ${2}/e.tar"
#		dqb "${srat} --exclude='*.deb' -rvf ${1} ./home/stubby ./home/devuan/Desktop/minimize
#	else
#		${srat} --exclude='*.deb' -rvf ${1} /home/stubby ${d0} #globaalit wttuun tästäkin
#	fi
#
	dqb "tp1 d0n3"
	csleep 1
}

#TODO:sen testaaminen miten import/part3() syö tämän fktion outputtia
function rmt() { #HUOM.16725:toiminee muuten mutta param tark vähn pykii
	debug=1
	dqb "rmt ${1}, ${2} " #WTUN TYPOT STNA111223456

	#[ -z ${1} ] && exit 1 #nämäkö kusevat edelleen?
	#[ -s ${1} ] || exit 2

	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22

	dqb "paramz_ok"
	csleep 1

	p=$(pwd)
	csleep 1
	#HUOM.23725 bashin kanssa oli ne pushd-popd-jutut

	if [ -f ${2}/sha512sums.txt ] ; then
		dqb "rem0v1ng pr3v1oisu shasums"
		csleep 1

		${NKVD} ${2}/sha512sums.txt
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
	touch ${2}/sha512sums.txt

	chown $(whoami):$(whoami) ${2}/sha512sums.txt
	chmod 0644 ${2}/sha512sums.txt
	[ ${debug} -eq 1 ] && ls -las ${2}/sha*;sleep 3

	cd ${2}
	echo $?

	${sah6} ./*.deb > ./sha512sums.txt
	csleep 1
	psqa .

	${srat} -rf ${1} ./*.deb ./sha512sums.txt
	csleep 1
	cd ${p}
	dqb "rmt d0n3"
}

#HUOM.25525:tapaus excalibur/ceres teettäisi lisähommia, tuskin menee qten alla
tcdd=$(cat /etc/devuan_version)
t2=$(echo ${d} | cut -d '/' -f 6 | tr -d -c a-zA-Z/) #tai suoraan $distro?
	
if [ ${tcdd} != ${t2} ] ; then
	dqb "XXX"
	csleep 1
	shary="${sag} install --download-only "
fi

function aswasw() {
	dqb " aswasw( ${1})"
	csleep 1

	case ${1} in #VAIH
		wlan0)
			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2
			#${shary} libdbus-1-3 toistaiseksi jemmaan 280425, sotkee

			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 libreadline8 # libssl3 adduser
			${shary} wpasupplicant
		;;
		*)
			dqb "not pulling wpasuplicant"
			csleep 1
		;;
	esac

	${shary} isc-dhcp-client isc-dhcp-common
	dqb " aswasw( ${1}) DONE"
	csleep 1

}

function tlb() { #VAIH
	#debug=1
	dqb "x2.tlb( ${1} ; ${2} )"
	csleep 1
	dqb "\$shary= ${shary}"
	csleep 2

	if [ z"${pkgdir}" != "z" ] ; then
		dqb "SHREDDED HUMANS"
		csleep 1
		${NKVD} ${pkgdir}/*.deb
	fi

	dqb "EDIBLE AUTOPSY"
	csleep 1
	${fib}
	${asy}
	csleep 1

	tpc7	
	aswasw ${2} #iface}
	${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11

	#18725:toimiikohan se debian_interactive-jekku tässä? dpkg!=apt
	${shary} iptables
	${shary} iptables-persistent init-system-helpers netfilter-persistent

	dqb "x2.tlb.part2"
	[ ${debug} -eq 1 ] && ls -las ${pkgdir}
	csleep 2

	#uutena 31525
	udp6 ${pkgdir}

	#actually necessary
	pre2 ${1} ${distro}
	other_horrors

	dqb "x2.tlb.done"
}

#https://askubuntu.com/questions/1206167/download-packages-without-installing liittynee
#HUOM.25725:joskohan jakaisi tämän skriptin 2 osaan, fktio-kirjasto se uusi osa

function tp4() { #HUOM.24725:fktion output vaikuttaa sopicvlta, jatkotestaus josqs
	debug=1
	dqb "tp4 ${1} , ${2} "

	#[ -z ${1} ] && exit 1 #mikä juttu näissä on?
	#[ -s ${1} ] || exit 2 #jotainn pykimistä 16725
	
	dqb "DEMI-SEC"
	csleep 1

	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22

	dqb "paramz_ok"
	csleep 1
	
	#jos sen debian.ethz.ch huomioisi jtnkin (muutenkin kuin uudella hmistolla?)
	tlb ${2} ${iface}

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} groff-base libgdbm6 libpipeline1 libseccomp2 #bsd debconf libc6 zlib1g		
	#HUOM.28525:nalkutus alkoi jo tässä (siis ennenq libip4tc2-blokki siirretty)

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=sudo=1.9.13p3-1+deb12u1
	${shary} libaudit1 libselinux1
	${shary} man-db sudo
	message
	jules

	if [ ${dnsm} -eq 1 ] ; then #josko komentorivioptioksi?
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

	dqb "${shary} git coreutils in secs"
	csleep 1
	${lftr} 

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=git=1:2.39.2-1~bpo11+1
	${shary} coreutils
	${shary} libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 zlib1g 
	${shary} git-man git

	[ $? -eq 0 ] && dqb "TOMB OF THE MUTILATED"
	csleep 1
	${lftr}

	#aswasw

	#HUOM. jos aikoo gpg'n tuoda takaisin ni jotenkin fiksummin kuin aiempi häsläys kesällä
	if [ -d ${2} ] ; then
		pwd
		csleep 1

		${NKVD} ${2}/*.deb
		csleep 1		
		${svm} ${pkgdir}/*.deb ${2}
		rmt ${1} ${2}
	fi

	dqb "tp4 donew"
	csleep 1
}

#koita päättää mitkä tdstot kopsataan missä fktiossa, interfaces ja sources.list nyt 2 paikassa
#HUOM.20525:joskohan locale- ja rules- juttuja varten uusi fktio? vääntöä tuntuu riittävän nimittäin
function tp2() { #HUOM.8725:olisikohan kunnossa tämä?
	#debug=1
	dqb "tp2 ${1} ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2

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
	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep rule | less
	sleep 2

	dqb "JUST BEFORE LOCALES"
	sleep 1

	${srat} -rvf ${1} /etc/timezone /etc/localtime 
	#HUOM.22525:tuossa alla locale->local niin saisi localtime:n mukaan mutta -type f
	for f in $(find /etc -type f -name 'local*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done

	echo $?
	sleep 1

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local | less
	csleep 1
	other_horrors

	#HUOM.23525:tähän tökkäsi kun mode=4 && a-x common
	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	case ${iface} in #oface parametriksi?
		wlan0)
			[ ${debug} -eq 1 ] && echo "APW";sleep 3
			${srat} -rvf ${1} /etc/wpa_supplicant/*.conf
			${srat} -tf ${1} | grep wpa
			csleep 3
		;;
		*)
			dqb "non-wlan"
		;;
	esac

	if [ ${enforce} -eq 1 ] ; then
		dqb "das asdd"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuggah
	fi

	if [ ${dnsm} -eq 1 ] ; then
		local f;for f in $(find /etc -type f -name 'stubby*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name 'dns*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	fi

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*

	dqb "tp2 done"
	csleep 1
}

#HUOM.23525: b) firefoxin käännösasetukset, pikemminkin profs.sh juttuja
#dnsm 2. parametriksi... eiku ei, $2 onkin jo käytössä ja tarttisi sen cut-jekun
function tp3() { #VAIH
	debug=1 #antaa olla vielä
	dqb "tp3 ${1} ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2

	dqb "paramz_0k"
	csleep 1

	local p
	local q	
	tig=$(${odio} which git) #voisi alustaa jossain aiempana

	p=$(pwd)
	q=$(${mkt} -d)
	cd ${q}
	
	[ ${debug} -eq 1 ] && pwd  
	csleep 1

	${tig} clone https://github.com/senescent777/more_scripts.git

	[ $? -eq 0 ] || exit 66
	
	dqb "TP3 PT2"
	csleep 1
	cd more_scripts/misc
	echo $?
	csleep 1

	#HUOM.14525:ghubista löytyy conf.new mikä vastaisi dnsm=1 (ao. rivi tp2() jatkossa?)
	${spc} /etc/dhcp/dhclient.conf ./etc/dhcp/dhclient.conf.${dnsm}

	if [ ! -s ./etc/dhcp/dhclient.conf.1 ] ; then
		${spc} ./etc/dhcp/dhclient.conf.new ./etc/dhcp/dhclient.conf.1	
	fi

	#HUOM.14525.2:ghubista ei löydy resolv.conf, voisi lennosta tehdä sen .1 ja linkittää myös nimelle .new tmjsp
	# (ao. rivi tp2() jatkossa?)	
	${spc} /etc/resolv.conf ./etc/resolv.conf.${dnsm}

	if [ ! -s ./etc/resolv.conf.1 ] ; then
		 ${spc} ./etc/resolv.conf.new ./etc/resolv.conf.1
	fi

	#HUOM.14525.3:ghubista löytyvä(.new) vastaa tilannetta dnsm=1
	# (ao. rivi tp2() jatkossa?)
	${spc} /sbin/dhclient-script ./sbin/dhclient-script.${dnsm}

	if [ ! -s ./sbin/dhclient-script.1 ] ; then
		  ${spc} ./sbin/dhclient-script.new ./sbin/dhclient-script.1
	fi
	
	#HUOM.14525.4:tp3 ajetaan ennenq lisätään tar:iin ~/D/minim tai paikallisen koneen /e
	#HUOM.sources.list kanssa voisi mennä samantap idealla kuin yllä? 
	# (ao. rivi tp2() jatkossa?)

	#HUOM.25525.2:$distro ei ehkä käy sellaisenaan, esim. tapaus excalibur/ceres

	if [ -f /etc/apt/sources.list ] ; then
		local c
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:'  | wc -l)

		#HUOM.20525:onkohan tuo ehto hyvä noin? pikemminkin https läsnäolo?
		if [ ${c} -lt 1 ] ; then
 			${spc} /etc/apt/sources.list ./etc/apt/sources.list.${2}
		fi
	fi

	${svm} ./etc/apt/sources.list ./etc/apt/sources.list.tmp
	${svm} ./etc/network/interfaces ./etc/network/interfaces.tmp
	# (ao. rivi tp2() jatkossa?)

	local r
	r=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	pwd

	dqb "r=${r}"
	csleep 2
	${spc} /etc/network/interfaces ./etc/network/interfaces.${r}

	${sco} -R root:root ./etc
	${scm} -R a-w ./etc
	${sco} -R root:root ./sbin 
	${scm} -R a-w ./sbin
	${srat} -rvf ${1} ./etc ./sbin 

	echo $?
	#HUOM.19725:qseeko tässä jokin? ei kai enää
	cd ${p}
	pwd
	dqb "tp3 done"
	csleep 1
}

function tpu() { #HUOM.21725:tässä saattaa olla jotain ongelmaa paketin rakentamisen suhteen
	#-.. tai sitten viimeaikaiset kikkailut paskoneet part3/pr4/ppp3/whåtever
	dqb "tpu ${1}, ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] && mv ${1} ${1}.OLD
	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22
	dqb "params_ok"

	#pitäisiköhän kohdehmistostakin poistaa paketit?
	${NKVD} ${pkgdir}/*.deb
	dqb "TUP PART 2"

	${fib} #uutena 205.25
	${sag} upgrade -u
	echo $?
	csleep 1

	local s

	for s in ${PART175_LIST} ; do #HUOM.turha koska ylempänä... EIKU
		dqb "processing ${s} ..."
		csleep 1

		${NKVD} ${pkgdir}/${s}*
	done

	case ${iface} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 1
		;;
		*)
			${NKVD} ${pkgdir}/wpa*
		;;
	esac

	udp6 ${pkgdir}
	dqb "UTP PT 3"

	${svm} ${pkgdir}/*.deb ${2}
	${odio} touch ${2}/tim3stamp
	${scm} 0644 ${2}/tim3stamp
	${sco} $(whoami):$(whoami) ${2}/tim3stamp

	date > ${2}/tim3stamp
	${srat} -cf ${1} ${2}/tim3stamp
	rmt ${1} ${2}

	${sifd} ${iface}
	dqb "SIELUNV1H0LL1N3N"
}

#TODO:-v tekemään jotain hyödyllistä (miten tilanne 8725 ja sen jälk?)

function tp5() { #8725 toiminee
	debug=1

	dqb "tp5 ${1} ${2}"
	[ -z ${1} ] && exit 99
	[ -s ${1} ] || exit 98
	[ -d ${2} ] || exit 97
 
	dqb "params ok"
	csleep 1

	local q
	q=$(${mkt} -d)
	cd ${q}
	[ $? -eq 0 ] || exit 77

	${tig} clone https://github.com/senescent777/more_scripts.git
	[ $? -eq 0 ] || exit 99
	
	#HUOM:{old,new} -> {0,1} ei liity
	[ -s ${2}/profs.sh ] && mv ${2}/profs.sh ${2}/profs.sh.OLD
	mv more_scripts/profs/profs* ${2}

	${scm} 0755 ${2}/profs*
	${srat} -rvf ${1} ${2}/profs*

	dqb "AAMUNK01"
}

dqb "mode= ${mode}"
dqb "tar= ${srat}"
csleep 1
pre1 ${d} ${distro}

#18725:skriptin case:t 0/4/e kai toimibat, muiden testaus myös
#HUOM.20525:pitäisi kai mode:n kanssa suosia numeerisia arvoja koska urputukset
case ${mode} in
	0|4) #erikseen vielä case missä tp3 skipataan?
		[ z"${tgtfile}" == "z" ] && exit 99 
		pre1 ${d} ${distro}
		pre2 ${d} ${distro}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd

		dd if=/dev/random bs=12 count=1 > ./rnd
		${srat} -cvf ${tgtfile} ./rnd
		tp3 ${tgtfile} ${distro} 

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		${srat} -cvf ${d}/e.tar ./rnd #tarvitseeko random-kuraa 2 kertaan?
		[ ${mode} -eq 0 ] && tp4 ${d}/e.tar ${d}
		${sifd} ${iface}

		#HUOM.22525: pitäisi kai reagoida siihen että e.tar enimmäkseen tyhjä?
		tp1 ${tgtfile} ${d} #/
		pre1 ${d} ${distro}
		tp2 ${tgtfile}
	;;
	1|u|upgrade)
		pre2 ${d} ${distro}
		tpu ${tgtfile} ${d}
	;;
	p)
		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${d} ${distro}
		tp5 ${tgtfile} ${d0} 
	;;
	e)  #HUOM.24725:fktion output vaikuttaa sopicvlta, jatkotestaus josqs
		pre2 ${d} ${distro}
		tp4 ${tgtfile} ${d}
	;;
	f)  #HUOM.24725:output vaikuttaa järkevältä, vielä testaa miten import2 suhtautuu
		rmt ${tgtfile} ${d} #HUOM. ei kai oleellista päästä ajelemaan tätä skriptiä chroootin sisällä, generic ja import2 olennaisempia
	;;
	q) #HUOM.24725:tämän casen output vaikuttaa järkevältä, lisää testejä myöhemmin
		[ z"${tgtfile}" == "z" ] && exit 99
		${sifd} ${iface}
	
		tpq ~ ${d0}
		cd ${d0}
	
		q=$(mktemp)
		${srat} -cf ${tgtfile} ${q}

		dqb "	OIJHPIOJGHO(YRI/&RE("
		pwd
		csleep 1

		for f in $(find . -type f -name config.tar.bz2 -or -name fediverse.tar) ; do
			${srat} -rvf ${tgtfile} ${f}
		done
		
		dqb "CASE Q D0N3"
		csleep 3
	;;
	t) #HUOM.24725:output vaikuttaa järkevältä, vielä testaa miten import2 suhtautuu
		pre2 ${d} ${distro}
		${NKVD} ${d}/*.deb
		tlb ${d} ${iface}
		${svm} ${pkgdir}/*.deb ${d}
		rmt ${tgtfile} ${d}
	;;
	-h) #HUOM.24725:tämä ja seur case lienevät ok, ei tartte just nyt testata
		usage
	;;
	*)
		echo "-h"
		exit
	;;
esac

if [ -s ${tgtfile} ] ; then
	${odio} touch ${tgtfile}.sha
	${sco} $(whoami):$(whoami) ${tgtfile}.sha
	${scm} 0644 ${tgtfile}.sha

	${sah6} ${tgtfile} > ${tgtfile}.sha
	${sah6} -c ${tgtfile}.sha

	echo "cp ${tgtfile} \${tgt}; cp ${tgtfile}.sha \${tgt}" 
fi
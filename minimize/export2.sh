#!/bin/bash
debug=0 #1
tgtfile=""
distro=$(cat /etc/devuan_version | cut -d '/' -f 1) #HUOM.28525:cut pois jatkossa
PREFIX=~/Desktop/minimize #käyttöön+konftdstoon jos mahd #tai dirname?
mode=-2

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
				if [ -d ${PREFIX}/${1} ] ; then
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

if [ -x ${PREFIX}/common_lib.sh ] ; then
	. ${PREFIX}/common_lib.sh
else
	#HUOM.23525:oleellisempaa että import2 toimii tarvittaessa ilman common_lib
	#"lelukirjasto" saattaa toimia sen varren että "$0 4 ..." onnistuu	
	
	srat="sudo /bin/tar"
	som="sudo /bin/mount"
	uom="sudo /bin/umount"
	scm="sudo /bin/chmod"
	sco="sudo /bin/chown"
	odio=$(which sudo)

	#jos näillä lähtisi aiNAKin case q toimimaan
	n=$(whoami)
	sah6=$(${odio} which sha512sum)
	smr="${odio} which rm"
	smr="${odio} ${smr}"

	function check_binaries() {
		dqb "exp2.ch3ck_b1nar135( ${1} )"
	}

	function check_binaries2() {
		dqb "exp2.ch3ck_b1nar135_2( ${1} )"
	}

	function fix_sudo() {
		dqb "exp32.fix.sudo"
	}

	function enforce_access() {
		dqb "exp32.enf_acc()"
	}

	function part3() {
		dqb "exp32.part3()"
	}

	function part1_5() {
		dqb "exp32.p15()"
	}

	function message() {
		dqb "exp32.message()"
	}

	function jules() {
		dqb "exp32.jules()"
	}

	#HUOM.23525:josko tässä kohtaa pakotus riittäisi
	function other_horrors() {
		dqb "AZATHOTH AND OTHER HORRORS"
		#${spc} /etc/default/rules.* /etc/iptables #tartteeko tuota enää 27525?

		${scm} 0400 /etc/iptables/*
		${scm} 0550 /etc/iptables
		${sco} -R root:root /etc/iptables
		${scm} 0400 /etc/default/rules*
		${scm} 0555 /etc/default
		${sco} -R root:root /etc/default
	}

	function ppp3() {
		dqb "exp32.ppp3()"
	}

	prevopt=""

	for opt in $@ ; do
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done

	dqb "FALLBACK"
	dqb "chmod may be a good idea now"
fi

[ -z ${distro} ] && exit 6
d=${PREFIX}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 3

if [ -s ${d}/conf ] ; then
	. ${d}/conf
else #joutuukohan else-haaran muuttamaan jatkossa?
	echo "CONF MISSING"
	exit 55
fi

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else
	echo "NOT (L1B AVA1LABL3 AND 3X3CUT4BL3)"

	function pr4() {
		dqb "exp2.pr4 ${1} " 
	}

	function udp6() {
		dqb "exp32.UPD6()"
	}

	#onko tässä sktiptissä oleellista välittää $d part3:lle asti c_b välityksellä?
	check_binaries ${d}
	check_binaries2
fi

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \${PREFIX}/\${distro}"
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"				
	echo "$0 -h: shows this message about usage"	
}

dqb "tar = ${srat} "
${scm} 0555 ${PREFIX}/changedns.sh
${sco} root:root ${PREFIX}/changedns.sh
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
csleep 2

function pre1() { #HUOM.31525:lienee kunnossa
	debug=1
	dqb "pre1( ${1} )"
	[ -z ${1} ] && exit 666 #vika löytyi niinqu
	csleep 10

	${sco} -Rv _apt:root ${pkgdir}/partial/
	${scm} -Rv 700 ${pkgdir}/partial/
	csleep 2

	if [ -d ${1} ] ; then
		dqb "5TNA"
		n=$(whoami)
			
		local ortsac
		local lefid

		ortsac=$(echo ${1} | cut -d '/' -f 6 | tr -d -c a-z) #tr uutena 1625
		lefid=$(echo ${1} | cut -d '/' -f 1-5 | tr -d -c a-zA-Z/)

		enforce_access ${n} ${lefid} 
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
		csleep 4
	else
		echo "P.V.HH"
		exit 111
	fi
}

function pre2() { #HUOM.31525:toiminee
	debug=1
	dqb "pre2 ${1}, ${2} #WTIN KAARISULKEET STNA" 
	[ -z ${1} ] && exit 666

	local ortsac
	local ledif

	ortsac=$(echo ${1} | cut -d '/' -f 6)
	ledif=$(echo ${1} | cut -d '/' -f 1-5 | tr -d -c a-zA-Z/)

	if [ -d ${1} ] ; then
		dqb "PRKL"
		${odio} ${ledif}/changedns.sh ${dnsm} ${ortsac}
		csleep 2

		${sifu} ${iface}
		[ ${debug} -eq 1 ] && ${sifc}
		csleep 2

		${sco} -Rv _apt:root ${pkgdir}/partial/
		${scm} -Rv 700 ${pkgdir}/partial/

		${sag_u}
		csleep 2
	else
		echo "P.V.HH"
		exit 111
	fi

	echo "PRE 2DONE"
	sleep 2
}

function tpq() { #HUOM.viimeksi 31525 testattu että tekee tarin
	dqb "tpq ${1} ${2}"
	[ -d ${1} ] || exit 22
	dqb "paramz 0k"
	csleep 1

	local t
	t=$(echo ${1} | cut -d '/' -f 1,2,3 | tr -d -c a-zA-Z/)

	#HUOM.23525:pakkaus mukaan kuten näkyy, config.tar vie .deb jälkeen melkeinpä eniten tilaa 
	${srat} -jcf ${1}/config.tar.bz2 ${t}/.config/xfce4/xfconf/xfce-perchannel-xml ${t}/.config/pulse /etc/pulse
	csleep 1

	if [ -x ${1}/profs.sh ] ; then
		dqb "DE PROFUNDIS"
			
		. ${1}/profs.sh
		exp_prof ${1}/fediverse.tar default-esr
	else
		dqb "1nT0 TH3 M0RB1D R31CH"	
	fi

	csleep 2
}

function tp1() { #VAIH:test 31525
	#debug=1
	dqb "tp1 ${1} , ${2} "
	[ -z ${1} ] && exit
	dqb "params_ok"
	csleep 1

	if [ -d ${2} ] ; then
		dqb "cleaning up ${2} "
		csleep 1
		${NKVD} ${2}/*.deb
		dqb "d0nm3"
	fi

	local ledif
	ledif=$(echo ${2} | cut -d '/' -f 1-5 | tr -d -c a-zA-Z/) 
	#p.itäisiköhän olla jokin tarkistus tässä alla? -d lisäksi?

	if [ ${enforce} -eq 1 ] && [ -d ${ledif} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		tpq ${ledif}
	fi

	if [ ${debug} -eq 1 ] ; then
		ls -las ${ledif}
		sleep 2
	fi

	${srat} -rvf ${1} ${ledif} /home/stubby 	
	dqb "tp1 d0n3"
	csleep 1
}

#HUOM.23525:josko nyt vähän fiksummin toimisi
function rmt() { #HUOM.31525:toiminee mutta varmista(VAIH)
	debug=1
	dqb "rmt ${1}, ${2} " #WTUN TYPOT STNA111223456

	[ -z ${1} ] && exit 1 #nämäkö kusevat edelleen?
	[ -s ${1} ] || exit 2

	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22

	dqb "paramz_ok"
	csleep 1

	p=$(pwd)
	csleep 1

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

	cd ${p}
	${srat} -rf ${1} ${2}/*.deb ${2}/sha512sums.txt
	csleep 1
	
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

#HUOM.jos ei lähde debian testingin kanssa lataUtumaan niin sitten olisi vielä unstable
#... myös excalibur uudemman kerran mutta tiedä siitäkin
#HUOM.31525:josqo sen sdfsdf1 testaisi kuiteskin nytq $shary vaihdettu oletusarvosta
# (pitäisiköhän ethz knssa vielä?)

function asw() {
	#VAIH:erilliseksi fktioksi tämä?
	case ${iface} in
		wlan0)
			#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=wpasupplicant=2:2.10-12+deb12u2
			#${shary} libdbus-1-3 toistaiseksi jemmaan 280425, sotkee

			${shary} libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libpcsclite1 libreadline8 # libssl3 adduser
			${shary} wpasupplicant
		;;
		*)
			dqb "not pulling wpasuplicant"
			csleep 2
		;;
	esac

	${shary} isc-dhcp-client isc-dhcp-common
}

function tlb() {
	debug=1
	dqb "x2.tlb( ${1} ; ${2} )"
	csleep 2
	dqb "\$shary= ${shary}"
	csleep 4

	if [ z"${pkgdir}" != "z" ] ; then
		dqb "SHREDDED HUMANS"
		csleep 1
		${NKVD} ${pkgdir}/*.deb
	fi

	dqb "EDIBLE AUTOPSY"
	csleep 1
	${fib}
	${asy}
	csleep 3

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=netfilter-persistent=1.0.20
	local cc
	local cc2

	cc=$(echo ${distro} | grep excalibur | wc -l)
	cc2=$(echo ${distro} | grep ethz | wc -l)

	#https://pkgs.org/download/linux-image-6.12.27-amd64 ... joskohan ethz kautta
	#... tarkistus tosin uusiksi, josko sinne tcdd-blokkiin ylemmäs?
	
	#distro-spesifinen osuus -> lib jatkossa (esim. tpc7)
	if [ ${cc} -gt 0 ] || [ ${cc2} -gt 0 ] ; then
		dqb "6.12....27"
#		csleep 5
#	
#		#${shary} linux-modules-6.12.27-amd64 #31525 uutena
#
#		#nopeasti lähimpiä vastineita:
#		#https://packages.debian.org/trixie/linux-image-6.12.27-amd64 miten tämä?
#		#https://debian.ethz.ch/debian/pool/main/l/linux-signed-amd64/linux-image-cloud-amd64_6.12.27-1_amd64.deb
#		#wget/curl jos ei muuten
#
#		local fname
#		fname=linux-image-6.12.27-amd64
#
#		${odio} touch ${pkgdir}/${fname} #seur rivit toistuvat usein, fktioksi?
#		${scm} 0644 ${pkgdir}/${fname}
#		${sco} $(whoami):$(whoami) ${pkgdir}/${fname}
#		
#		curl -o ${pkgdir}/${fname} https://packages.debian.org/trixie/${fname}
#
		#${shary} nftables #excalibur-spesifisiä?
		asw #jatkossa "if cc"-blokin uplkop tämä
	fi

	${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11
	${shary} iptables #mitä ymp. mja - jekkuja tähän oli ajateltu?
	${shary} iptables-persistent init-system-helpers netfilter-persistent

	dqb "x2.tlb.part2"
	[ ${debug} -eq 1 ] && ls -las ${pkgdir}
	csleep 6

	#uutena 31525
	udp6 ${pkgdir}

	#actually necessary
	pre2 ${1}
	other_horrors

	dqb "x2.tlb.done"
}

#https://askubuntu.com/questions/1206167/download-packages-without-installing liittynee

#HUOM.26525:apg-get sisältää vivun "-t" , mitä se tekee Devuanin tapauksessa? pitääkö sources.list sorkkia liittyen?
#... ei oikein lähtenyt -t:llä ethz kanssa ekalla yrItyksellä 29525
#sen sijaan kun sources-list:iin vaihtoi stable-> testing ni jotain alkoi tapahtua

#HUOM.31525:pienin vaiva saada tables excaliburiin toimimaan saattaa olla hakea tables-paketit excailburilla
#...sikäli mikäli dhclient ja wpasupplicant sun muut löytyvät

function tp4() { #TODO:tämäkin pitäisi testata, erityisesti koska tlb()
	debug=1
	dqb "tp4 ${1} , ${2} "

	[ -z ${1} ] && exit 1 #mikä juttu näissä on?
	[ -s ${1} ] || exit 2
	
	dqb "DEMI-SEC"
	csleep 1

	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22

	dqb "paramz_ok"
	csleep 1
	
	#jos sen debian.ethz.ch huomioisi jtnkin (muutenkin kuin uudella hmistolla?)
	tlb ${2}

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=man-db=2.11.2-2
	${shary} groff-base libgdbm6 libpipeline1 libseccomp2 #bsd debconf libc6 zlib1g		
	#HUOM.28525:nalkutus alkoi jo tässä (siis ennenq libip4tc2-blokki siirretty)

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=sudo=1.9.13p3-1+deb12u1
	${shary} libaudit1 libselinux1 #libpam0g #libpam-modules zlib1g #libpam kanssa oli nalkutusta 080525

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

	asw

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
function tp2() { #HUOM.31525:olisikohan kunnossa tämä?
	debug=1
	dqb "tp2 ${1} ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2

	dqb "params_ok"
	csleep 2

	${scm} 0755 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	for f in $(find /etc -type f -name 'interfaces*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done
	dqb "JUST BEFORE URLE	S"
	csleep 2

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
	sleep 2

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local | less
	csleep 2
	other_horrors

	#HUOM.23525:tähän tökkäsi kun mode=4 && a-x common
	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	case ${iface} in
		wlan0)
			#tartteekokokoko ko hakemostoa?
			${srat} -rf ${1} /etc/wpa/wpa_supplicant.conf
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
	csleep 2
}

#HUOM.23525: b) firefoxin käännösasetukset, pikemminkin profs.sh juttuja
#dnsm 2. parametriksi... eiku ei, $2 onkin jo käytössä ja tarttisi sen cut-jekun
function tp3() { #31525:vaikuttaisi tulevan jutut mukana
	#debug=1 #antaa olla vielä
	dqb "tp3 ${1} ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2

	dqb "paramz_0k"
	csleep 2

	local p
	local q	
	tig=$(${odio} which git) #voisi alustaa jossain aiempana

	p=$(pwd)
	q=$(${mkt} -d)
	cd ${q}
	
	[ ${debug} -eq 1 ] && pwd  
	csleep 2
	${tig} clone https://github.com/senescent777/more_scripts.git

	[ $? -eq 0 ] || exit 66
	
	dqb "TP3 PT2"
	csleep 2
	cd more_scripts/misc

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

	local p
	p=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	${spc} /etc/network/interfaces ./etc/network/interfaces.${p}

	${sco} -R root:root ./etc
	${scm} -R a-w ./etc
	${sco} -R root:root ./sbin 
	${scm} -R a-w ./sbin
	${srat} -rvf ${1} ./etc ./sbin 

	echo $?
	cd ${p}
	dqb "tp3 done"
	csleep 2
}

function tpu() { #VAIH:testaa (30525 vaikutti toimivan)
	debug=1	
	#HUOM:0/1/old/new ei liity
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
	csleep 2

	local s

	for s in ${PART175_LIST} ; do #HUOM.turha koska ylempänä... EIKU
		dqb "processing ${s} ..."
		csleep 1

		${NKVD} ${pkgdir}/${s}*
	done

	case ${iface} in
		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 6
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

#TODO:-v tekemään jotain hyödyllistä

function tp5() { #HUOM.viimeksi testattu 31525, tekee tarin tai siis
	#debug=1

	dqb "tp5 ${1} ${2}"
	[ -z ${1} ] && exit 99
	[ -s ${1} ] || exit 98
	[ -d ${2} ] || exit 97
 
	dqb "params ok"
	csleep 2

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
csleep 2
pre1 ${d}

#HUOM.20525:pitäisi kai mode:n kanssa suosia numeerisia arvoja koska urputukset
case ${mode} in
	0|4) #erikseen vielä case missä tp3 skipataan?
		pre1 ${d}
		pre2 ${d}

		${odio} touch ./rnd
		${sco} ${n}:${n} ./rnd
		${scm} 0644 ./rnd
		dd if=/dev/random bs=6 count=1 > ./rnd

		${srat} -cvf ${tgtfile} ./rnd
		tp3 ${tgtfile} ${distro} #voisiko käyttää $d?

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		${srat} -cvf ${d}/e.tar ./rnd #tarvitseeko random-kuraa 2 kertaan?
		[ ${mode} -eq 0 ] && tp4 ${d}/e.tar ${d}
		${sifd} ${iface}

		#HUOM.22525: pitäisi kai reagoida siihen että e.tar enimmäkseen tyhjä?
		tp1 ${tgtfile} ${d}
		pre1 ${d}
		tp2 ${tgtfile}
	;;
	1|u|upgrade)
		pre2 ${d}
		tpu ${tgtfile} ${d}
	;;
	p)
		#HUOM.240325:tämä+seur case toimivat, niissä on vain semmoinen juttu(kts. S.Lopakka:Marras)
		pre2 ${d}
		tp5 ${tgtfile} ${PREFIX} #PREFIX vähemmäLLe jatkossa?
	;;
	e)
		pre2 ${d}
		tp4 ${tgtfile} ${d}
	;;
	f)
		rmt ${tgtfile} ${d}
	;;
	q)
		[ z"${tgtfile}" == "z" ] && exit 99
		${sifd} ${iface}

		tpq ${PREFIX}
		${srat} -cf ${tgtfile} ${PREFIX}/config.tar.bz2 ${PREFIX}/fediverse.tar
	;;
	t)
		pre2 ${d}
		${NKVD} ${d}/*.deb
		tlb ${d}
		${svm} ${pkgdir}/*.deb ${d}
		rmt ${tgtfile} ${d}
	;;
	-h)
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
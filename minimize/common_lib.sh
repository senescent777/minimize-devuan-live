
if [ -s ${d0}/$(whoami).conf ] ; then
	#pitäisikö olla eri conf toisen repon skriptien kautta mentäessä?
	echo "ALT.C0NF1G (. ${d0}/$(whoami).con )"
	#HUOM.sudo voi vähän sotkea tämän if-haaran tyoimintaa
	. ${d0}/$(whoami).conf
	sleep 5
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		echo ". ${d}/conf"
		. ${d}/conf
	else
		#TODO:tämä kohta uusiksi koska common_funcs/mksums ?
	 	exit 57
	fi	
fi

unset sco
unset scm
unset odio

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}


[ -v CONF_env ] || exit 99
echo "CONF_env = ${CONF_env}"
sleep 5

case "${CONF_env}" in
	TOOR)
		odio=""

		function itni() {
			dqb "alt-itn1"
		}
	;;
	VED)
		odio=""
		[ -v CONF_testgris ] || exit 96
			
		function itni() {
			dqb "itn1-3"
			}
	;;
	*)
		function itni() {
			dqb "ITN1-2"

			odio=$(which sudo)
			[ y"${odio}" == "y" ] && exit 99 
			[ -x ${odio} ] || exit 100
		}
	;;
esac

itni
echo "aftr 1nt1"
sleep 6

function fix_sudo() {
	
	sco=$(${odio} which chown)
	[ y"${sco}" == "y" ] && exit 98
	[ -x ${sco} ] || exit 97
	
	scm=$(${odio} which chmod)
	[ y"${scm}" == "y" ] && exit 96
	[ -x ${scm} ] || exit 95

	sco="${odio} ${sco} "
	scm="${odio} ${scm} "	

	if [ "${CONF_env}" == "DEFAULT" ] ; then
		dqb "1NNERMöST"

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

		dqb "fix_sud0.pt whåtever"
		${scm} 0750 /etc/sudoers.d
		${scm} 0440 /etc/sudoers.d/*
	fi
	
	[ ${debug} -eq 1 ] && ls -las /usr/bin/sudo*
	csleep 1
	dqb "fix_sud0.d0n3"
}

function other_horrors() {
	dqb "other_horrors"
	
	if [ "${CONF_env}" == "DEFAULT" ] ; then
		dqb "hERBAL 5UFFER1NG"

		for f in $(${odio} find /etc -type f -name "rules.*" ) ; do
			${sco} -R root:root ${f}
			${scm} 0400 ${f}
		done

		${scm} 0550 /etc/iptables
		${sco} -R root:root /etc/iptables
		${scm} 0400 /etc/default/rules*
		${scm} 0555 /etc/default
		${sco} -R root:root /etc/default
	fi

	dqb " DONE"
	csleep 1
}

fix_sudo
other_horrors
echo "LOOl PIP WFT"
#common_funcs tarttee

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

#common_funcs tarttee
function check_bin_0() {
	echo "check_bin_0"
	sleep 1
	dqb "cb1"

	ocs dpkg
	ocs tar
	ocs shred
	csleep 1

	unset sdi
	unset sr0
	unset srat
	unset sah6
	unset NKVD
	csleep 1
	
	csleep 6
	[ -v CONF_algo ] || exit 77

	case "${CONF_algo}" in
		sha256)
			sah6=$(${odio} which sha256sum)
			ocs sha256sum
		;;
		sha512)
			sah6=$(${odio} which sha512sum)
			ocs sha512sum
		;;
		*)
			exit 99
		;;
	esac

	sd0=$(${odio} which dpkg)

	#if [ "${CONF_env}" != "VED" ] ; then
	[ -v sd0 ] || exit 78
	[ -z "${sd0}" ] && exit 79
	[ -x ${sd0} ] || exit 77
	#fi

	sr0=$(${odio} which tar)
	[ -v sr0 ] || exit 80
	[ -z "${sr0}" ] && exit 81
	[ -x ${sr0} ] || exit 76
	srat=${sr0}
	
	if [ ${debug} -eq 1 ] ; then
		srat="${srat} -v "
	fi

	csleep 1

	slinky=$(${odio} which ln)
	slinky="${odio} ${slinky} -s "
	spc=$(${odio} which cp)
	svm=$(${odio} which mv)
	svm="${odio} ${svm} "

	spc="${odio} ${spc} "
	#tämmöisten kanssa tarkkana sitten koska check_bin_2

	whack=$(${odio} which pkill)
	whack="${odio} ${whack} --signal 9 "
	snt=$(${odio} which netstat)
	snt="${odio} ${snt} -tulpan "
	smr=$(${odio} which rm)	
	smr="${odio} ${smr} "

	NKVD=$(${odio} which shred)
	[ -z "${NKVD}" ] && exit 37
	NKVD="${odio} ${NKVD} -fu "

	PART175_LIST="avahi blu cups exim4 nfs network mdadm sane rpc lm-sensors dnsmasq stubby brltty openssh" #  ssh too soon

	#HUOM.YRITÄ SINÄKIN SAATANAN SIMPANSSI JA VITUN PUOLIAPINA KÄSITTÄÄ ETTÄ EI NÄIN 666!!!
	#sdi=$(${odio} which dpkg)
	#sdi="${odio} ${sdi} -i "
	csleep 2

	#näille main jotain muutoksia?
	sifu=$(${odio} which ifup)
	sifd=$(${odio} which ifdown)
	
	sip=$(${odio} which ip)
	sip="${odio} ${sip} "
	smd=$(${odio} which mkdir)

	sca=$(${odio} which chattr)
	#käytössä?
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

	export LC_TIME
	export LANGUAGE
	export LC_ALL
	export LANG

	if [ "${CONF_env}" == "DEFAULT" ] ; then
		[ -v CONF_hashfile3 ] || exit 66
		[ -v CONF_DIR2 ] || exit 99 #tähänkö tökkäsdi 14726? bssiin

		if [ -d ${CONF_DIR2} ] ; then
			[ -s ${CONF_hashfile3} ] || echo "should exit 98" 
			[ -s ${CONF_hashfile3}.sig ] || echo "ahouls exit 99"
			[ -s ${CONF_hashfile3}.sha ] || echo "shoul.d ext1 8 97"
	
			${odio} ${sah6} -c ${CONF_hashfile3}.sha
			[ $? -gt 0 ] && echo "gh0uls 0f n1n1w3h"

			[ -z "${gg}" ] || ${gg} --verify ${CONF_hashfile3}.sig
			[ $? -gt 0 ] && echo "dhoulf exit 126"

			local p=$(pwd)
			cd /

			${odio} ${sah6} -c ${CONF_hashfile3}
			[ $? -gt 0 ] && echo "dhoulf exit 1234!!!"
			cd ${p}
		fi
	fi

	csleep 1
	dqb "cb0 done"
}

check_bin_0

function jules() {
	other_horrors
	[ ${debug} -eq 1 ] && ${odio} ls -las /etc/iptables
}

function destroy() {
	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 98

	${NKVD} ${1}/*.deb
	${NKVD} ${1}/${CONF_hashfile}*
	${NKVD} ${1}/*.tar*

	csleep 1
	dqb "CONTENTS OF ${1} DESTROYED"
}

function psqa() {
	dqb "c.Q () () () () ${1} ;;;"
	csleep 1

	[ -z "${1}" ] && exit 97
	[ -d ${1} ] || exit 96
	[ ${debug} -gt 0 ] && ls -las ${1}/${CONF_hashfile}*
	csleep 1

	#return 92 #ei näin?
	#dpkg -V oli tässä josqs , [ -v ] takana

	[ -v CONF_hashfile ] || exit 98
	[ -z "${CONF_hashfile}" ] && exit 99

	#TODO:parametrien kanssa voisi tehdä jotain
	if [ -v gg ] && [ -s ${1}/${CONF_hashfile}.sig ] ; then
		dqb "))S))))( ${1} )"
		csleep 1

		#pitäisikö testata dgdts-hmiston sisltöä tai .gnupg? pubring.kbx yli 32 tavua?
		if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
			dqb "${gg} --verify ${1}/${CONF_hashfile}.sig "
			csleep 1
			${gg} --verify ${1}/${CONF_hashfile}.sig 

			if [ $? -eq 0 ] ; then
				dqb "KÖ"
			else
				dqb "SHOULD imp2 k \$dir !!!"

				#${NKVD} ${1}/${CONF_hashfile}*
				destroy ${1}				

				return 95 #jatk exit pois
			fi

			csleep 1
			[ -f ${1}/${CONF_hashfile}.1.sig ] && ${gg} --verify ${1}/${CONF_hashfile}.1.sig
			csleep 1
		else
			dqb "COULD NOT VERIFY SIGNATURES"
		fi
	else
		dqb "Лаврентий Берия MADE .txt.sig DISAPPEAR"
	fi

	csleep 2

	if [ -s ${1}/${CONF_hashfile} ] && [ -x ${sah6} ] ; then
		dqb "R ${1} "
		csleep 1

		local p=$(pwd)
		cd ${1}
		${sah6} -c ${CONF_hashfile} --ignore-missing

		if [ $? -eq 0 ] ; then
			dqb "Q.KO"
		else
			dqb "SHOULD \${NKVD} ${1}/ \* .deb"
			destroy ${1}
			return 94
		fi

		if [ -f ${1}/${CONF_hashfile}.1 ] ; then
			${sah6} --ignore-missing -c ${CONF_hashfile}.1
		else
			echo "EILINRN PULLA 90 c"
			#HUOM.12726:hashfile.1 ei välttämättä saataville ennen f.tar purkua joten suurta mölinää ei syytä laittaa käyntiin ennenq cefgh() ajettu (tai miteb lienee)
		fi

		csleep 1
		cd ${p}
	else
		dqb "NO SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
		dqb "SHOULD \${NKVD} ${1}/ \*.deb"

		#destoy rähän kanssa?		
		destroy ${1}

		return 93
	fi

	echo " DONE WITH THE Q-FEVER () ;;;; (((((("
	sleep 1
}

#pikemminkin siellä $2-hmistossa käsin se sha-tarkstus?  ehkä ei kuitenkaan?
function common_pp3() {	
	echo "() common_pp3 )))))) ${1} ) ${2} ))))))))))))) "
	sleep 1

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 101
	[ -z "${2}" ] && exit 98
	[ -d ${2} ] || exit 102

	[ ${debug} -eq 1 ] && pwd
	#csleep 1

	dqb "find ${1} -type f -name \* .deb"
	#csleep 3

	local q=$(find ${1} -type f -name "*.deb" | wc -l)
	local r=$(echo ${1} | cut -d "/" -f 1-5)

	if [ ${q} -lt 1 ] ; then
		${scm} a-wx ${r}/common_lib.sh
	else
		psqa ${1}

		if [ $? -gt 0 ] ; then #TODO:tulisi kai testata
			#${NKVD} ${1}/*.deb
			#${NKVD} ${1}/${CONF_hashfile}*
			#${NKVD} ${1}/*.tar*

			destroy ${1}
		fi

		#HUOM.12726:svm, spc - jutut vosi ohittaa jos $2==$1
		 if [ "${1}" != "${2}" ] ; then
			local s

			for s in $(grep -v '#' ${1}/${CONF_hashfile} | awk '{print $2}') ; do
				${svm} ${1}/${s} ${2}
			done

			for s in $(grep -v '#' ${1}/${CONF_hashfile}.1 | grep -v drop | awk '{print $2}') ; do
				${spc} ${1}/${s} ${2}
			done

			${spc} ${1}/${CONF_hashfile}* ${2}
			ls -las ${2}/${CONF_hashfile}*
			#csleep 5
		fi
	fi

	echo "COMMON_PP3-DONE()"
}

function efk1() {
	dqb "efk1 $@"
	${sdi} $@

	if [ $? -eq 0 ] ; then
		${NKVD} $@
	fi
}

function efk2() {
	dqb "efk2 )))))))) ${1} ))) ${2} )))))"
	[ -z "${2}" ] && exit 98

	if [ -s ${1} ] && [ -r ${1} ] ; then
		${odio} ${sr0} -C ${2} -xf ${1}
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi

	csleep 1
} #TARKKUUTTA PRKL

function fromtend() {
	dqb "FRöMTEND"
	[ -v sd0 ] || exit 99
	[ -z "${sd0}" ] && exit 98
	[ -x ${sd0} ] || exit 97

	export DEBIAN_FRONTEND=noninteractive

	if [ "${CONF_env}" != "TOOR" ] ; then
		dqb "${odio} -E ${sd0} --force-confold -i $@"
		${odio} -E ${sd0} --force-confold -i $@
	else
		${odio} ${sd0} --force-confold -i $@
	fi
}

function cefgh() {
	[ -z "${1}" ] && exit 66
	[ -d ${1} ] || exit 67

	if [ -z "${gg}" ] ; then
		dqb "SHOULD {sah6} -c ${1}/e.tar HERE"

		if [ -s ${1}/e.tar.sha ] ; then
			${sah6} -c ${1}/e.tar.sha
			[ $? -eq 0 ] || ${NKVD} ${1}/e.tar*
		fi

		csleep 5

		efk2 ${1}/e.tar ${1}
		${NKVD} ${1}/e.tar
	fi

	efk2 ${1}/f.tar ${1}
	
	if [ $? -eq 0 ] ; then
		[ -x ${gg} ] && ${NKVD} ${1}/f.tar
	fi
}

#VAIH:sqroot-ympäristön pAKettivalikoiman päivitys, mm. gpg_poistuu-syistä
#mitä nyt viimeksdi exp2:lla duunattu -> toimii pienellä urputuksella? (ne accpet-tdstot olisi hyvä saada sqroot asti kanssa)

function CB01() {
	dqb "common.lib.CB01( ${1} (( ${2} )"
	csleep 1

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 100
	[ -z "${2}" ] && exit 98
	[ -d ${2} ] || exit 102

#	if [ -s ${1}/g.tar ] ; then
#		#JOSPA TARKISTETTAISIIn g.tar ennen purq eikä sisällön purun jälkeen
#		#... tai ilman gpg:tä voi tehdä vain sha-tarq ja sekin oikeastaan tapahtuu jo kutsuvassa koodissa
#		#... g.tar:in saisi kyllä listaan mukaan
#
#		efk2 ${1}/g.tar /
#		common_pp3 ${1} ${t}
#		${NKVD} ${1}/g.tar
#		exit 103
#	fi

	#common_pp3 ${1} ${2} #kuinkahan monta kertaa pitää tuo tarkistus ajaa, ennen CB0x-kutsuja jo...
	for p in ${E22_GI} ; do efk1 ${2}/${p}*.deb ; done
	csleep 1
	dqb "iZOMVIE"
	
	gg=$(${odio} which gpg)
	gv=$(${odio} which gpgv)
	[ -z "${gg}" ] && ${scm} a-wx ${1}/../common_lib.sh #$0 josko näin kuitenkin?
	csleep 1
	
	common_pp3 ${1} ${2}
	dqb "common.lib.CB01() DONE"
	csleep 1
}

function message() {
	echo "INSTALLING NEW PACKAGES IN x SECS"
	sleep 1
	echo "DO NOT xxx yyy"
	sleep 1
	echo "... FOR POSITIVE ANSWER MAY BREAK THINGS"
	sleep 1
}

function CB02() {
	dqb "CB02()"
	csleep 1
	jules

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 100
	
	[ "${CONF_env}" == "TOOR" ] && message
	local p
	for p in ${E22_GU} ; do efk1 ${1}/${p}*.deb ; done
	
	for p in ${E22_GV} ; do 
		fromtend ${1}/${p}*.deb
		[ $? -eq 0 ] && ${NKVD} ${1}/${p}*.deb
	done
	
	dqb "GYUV DONE, NXT:P2T"
	other_horrors
	
	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)
	
	[ -z "${ipt}" ] && ${scm} a-wx $(pwd)/common_lib.sh #tai $0 ?
	dqb "CB02() D0.N3"
	csleep 1
}

function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135 ( ${1} ; ${2} ) "	
	csleep 1
	
	ipt=$(${odio} which iptables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)

	E22_GS="gcc-12-base libgcc-s1 libc6" 	
	E22_GS="${E22_GS} libgmp10 libisl23 libmpfr6 libmpc3 libzstd1 zlib1g"
	E22_GS="${E22_GS} libstdc++6 libgomp1 cpp-12"

	#moni pak tarttee nämä
	E23_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"
	E22_GG="coreutils libcurl3-gnutls libexpat1 liberror-perl libpcre2-8-0 git-man git"
	
	E22_GM="libc6 libselinux1"
	E22_GM="${E22_GM} debianutils debconf liblocale-gettext-perl libtext-charwidth-perl libtext-iconv-perl libtext-wrapi18n-perl" # nfs-common
	E22_GM="${E22_GM} debconf-i18n libelf1 libbpf1 " #zlib1,libc6
	E22_GM="${E22_GM} libmnl0 libxtables12 " # oikeastaanm jo toisissakin jutussa mukana

	E22_GM="${E22_GM} libcom-err2 libk5crypto3 libkeyutils1 libkrb5support0 libssl3 libkrb5-3 libkrb5support0"
	E22_GM="${E22_GM} libmnl0 libatm1 libpcre2-8-0 libmd0 libgssapi-krb5-2 "
	E22_GM="${E22_GM} libbsd0 libcap2 libcap2-bin libdb5.3 libtirpc-common libtirpc3 iproute2"

	[ "${CONF_iface}" == "eth0:1" ] || E22_GM="${E22_GM} isc-dhcp-client isc-dhcp-common" #dhcp-jutut erilleen jotenkin?
	E22_GM="${E22_GM} libpam0g libcrypt1 libaudit1 libpam-modules-bin libpam-modules "

	E22_GM="${E22_GM} libbz2-1.0 libsemanage-common libsemanage2 libsepol2 passwd adduser ifupdown"
	E22_GM="${E22_GM} libblkid1 libmount1 libsmartcols1 mount net-tools"
	E22_GM="${E22_GM} libacl1 libattr1 libgmp10 coreutils"

	dqb "before 0c.s"
	#120726:joskohan jo toimisi näin?
	local y="/sbin/ifup /sbin/ifdown apt-get apt ip netstat ${sd0} ${sr0} mount umount mkdir mktemp"
	
	if [ "${CONF_env}" == "VED" ] ; then
		ipt="/usr/sbin/iptables"
		gg="/usr/bin/gpg"
		dqb "P1SSE"
	else
		dqb "SCHEISS3"
	fi
	
	for x in ${y} ; do ocs ${x} ; done
	sdi="${odio} ${sd0} -i "
	E22_GI="libassuan0 libbz2-1.0 libc6 libgcrypt20 libgpg-error0 libreadline8 libsqlite3-0 gpgconf zlib1g gpg"

	E22_GT=""
	E22_GU=""

	if [ "${CONF_iface}" != "eth0:1" ] ; then
		E22_GT="isc-dhcp-client isc-dhcp-common "
		E22_GU="isc-dhcp "
	fi

	E22_GT="${E22_GT} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11 libnftables1 libedit2"
	E22_GT="${E22_GT} iptables"
	E22_GT="${E22_GT} init-system-helpers" # iptables-persistent netfilter-persistent

	E22_GU="${E22_GU} libnfnet libnetfilter libxtables libmnl libnftnl libnftables libnl-3-200 libnl-route libnl nftables"
	E22_GV="libip iptables_ iptables-" # netfilter-persistent
	
	local t
	t=""
	
	#HUOM. gpg:n opistumis-ongelmalle voisi vähitellen keksiä ratkaisun prkl
	if [ -z "${ipt}" ] || [ -z "${gg}" ] ; then
		[ -z "${1}" ] && exit 99
		[ -d ${1} ] || exit 101

		if [ -z "${2}" ] ; then
			t=$(${mkt} -d) 
		else
			t=${2}
		fi

		cefgh ${1}
		common_pp3 ${1} ${t}
		
		dqb "BF0R3 CVB0"
		csleep 5
	fi
	
	if [ -z "${gg}" ] ; then
		CB01 ${1} ${t}
	fi
	
	if [ -z "${ipt}" ] ; then
		CB02 ${t}
	fi

	dqb "#jäölk ÄYÖYÄ SDDFSDSDGH t. Paska-Ankka"
	ls ${t}/*.deb | wc -l
	csleep 3

	if [ "${CONF_env}" != "VED" ] ; then #chroot-ehto myös?
		for x in iptables ip6tables iptables-restore ip6tables-restore gpg ; do ocs ${x} ; done
	fi

	#HUOM.30626:kts. pre_enforce() kommentit
	[ "${CONF_env}" == "TOOR" ] || CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1
	
	#toistaiseksi näin
	if [ "${CONF_env}" == "DEFAULT" ] ; then
		ocs dhclient
		csleep 1
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
	#oikeastaaan ei tämä fktio ota vastaamn param,,,
	dqb "c0mm0n_lib.ch3ck_b1nar135.2 ))) ${1} ; ${2} ((((((("
	csleep 1

	#120726:toiv pois lähiaikoina ao. tarq
	if [ "${CONF_env}" != "VED" ] ; then
		[ -v sd0 ] || exit 66
	fi
	
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

	INITRD=No
	export INITRD
	lftr="${smr} -rf /run/live/medium/live/initrd.img* "
	
	if [ "${CONF_env}" != "VED" ] ; then #toistaiseksi näin?
		${scm} a-wx /usr/sbin/update-initramfs #kokeeksi tämäkin, vissiin jotyain saa aikaan 050426
	fi

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
	
	if [ -z "${ipt}" ] || [ "${ipt}" == "${odio}" ] || [ "${CONF_env}" == "TOOR" ] ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		[ -v CONF_DIR2 ] || exit 89	

		if [ "${CONF_env}" == "DEFAULT" ] && [ -d ${CONF_DIR2} ] ; then #koitapa päättää miten pitäisi mennä 
			dqb "JST B3F0R:tlb-b a s h"
			[ -s ${CONF_DIR2}/tlb.bash ] || exit 99
			${scm} 0511 ${CONF_DIR2}/tlb.bash

			#tarkoituksella ilman param
			${odio} ${CONF_DIR2}/tlb.bash 
		fi
	fi
}

#==================================================================

function mangle_s() {
	dqb " mangle_s( ${1} ( ${2} ( ${3} )"
	csleep 1

	[ -z "${1}" ] && exit 44
	[ -x ${1} ] || exit 55
	[ -z "${2}" ] && exit 45
	[ -f ${2} ] || exit 54
	[ -z "${3}" ] && exit 65 #no nyt?

	[ -v CONF_algo ] || exit 98
	[ -z "${CONF_algo}" ] && exit 99 

	dqb "pars ok"
	csleep 1

	#150726: $2:selle jatkossa tr-jekku?
	local r=$(echo ${1} | tr -dc a-zA-Z0-9/._)
	local s=$(echo ${2} | tr -dc a-zA-Z0-9/_-)

	${scm} 0555 ${r}
	${sco} root:root ${r}

	#14726:bissiin qsee paskaa näin tai parametrit väärät (ellei sittebn tdstonimi)
	local aa=$(echo ${3} | tr -dc a-zA-Z0-9 )
	r=$(${sah6} ${r})

	local ab=$(echo ${r} | awk '{print $1}' | tr -dc a-fA-F0-9)
	local ac=$(echo ${r} | awk '{print $2}' | tr -dc a-zA-Z0-9./_)	
	echo "${aa} ALL=NOPASSWD:${CONF_algo}:${ab} ${ac}" >> ${s} #{2} ennen
	dqb " mangle_s() done"
}

function dinf() {
	local g
	local t
	local frist=1

	echo -n "#" >> ${1} #toimiiko näin?
	echo -n " $(whoami)" | tr -dc a-zA-Z >> ${1}
	echo -n " localhost=NOPASSWD:" >> ${1}

	for g in $(${odio} find /sbin -type f -name "dhclient-script*" ) ; do
		if [ ${frist} -eq 1 ] ; then 
			frist=0
		else
			echo -n "," >> ${1}
		fi

		echo -n "${CONF_algo}:" >> ${1}
		t=$(${sah6} ${g} | awk '{print $1}' | tr -dc a-fA-F0-9) #TARRKK PRKL
		echo -n ${t} >> ${1}
	done

	echo " /sbin/dhclient-script" >> ${1}
	cat ${1}
	echo "DINSDALE"
	csleep 5
}

function fasdfasd() {
	dqb "fasdfasd ))) ${1} )))"
	#HUOM.ei-olemassaoleva tdstonnimi sallittava parametriksi
	[ -z "${1}" ] && exit 99

	csleep 1
	${odio} touch ${1}
	${sco} $(whoami):$(whoami) ${1}
	${scm} 0644 ${1}
}

function reqwreqw() {
	[ -z "${1}" ] && exit 99
	[ -f ${1} ] || exit 100
	csleep 1
	${sco} 0:0 ${1}
	${scm} a-w ${1}
}

function e_final() {
	dqb "ALOMST FINAL"
	csleep 1
	[ -v CONF_DIR2 ] || exit 99 # sqroot menevä konf jok unno ssa?

	if [ "${CONF_env}" == "DEFAULT" ] && [ -d ${CONF_DIR2} ] ; then 
		${scm} go-rw ${CONF_DIR2}/*
		${scm} 0400 ${CONF_DIR2}/*.sh
		${scm} 0511 ${CONF_DIR2}/*.bash
	fi

	${scm} 0755 /
	${sco} root:root /
	dqb "D+T"
	
	${scm} 0777 /tmp
	${sco} root:root /tmp
	
	csleep 1
	dqb "SALA DE ANALISIS CLINICOS ASD ASD 123"
}

function e_h() {
	dqb "EH ((( ${1} ;; ((( ${2} ))(((((("
	[ -z "${1}" ] && exit 98
	[ -d ${2} ] || exit 99
	dqb "pars.ok"
	csleep 1

	${sco} root:root /home
	${scm} 0755 /home
	
	local f
	local c=$(grep $1 /etc/passwd | wc -l)
	local m=0555

	if [ ${c} -gt 0 ] ; then
		${sco} -R ${1}:${1} ~
		csleep 1
	fi

	csleep 1
	${scm} 0755 ${2}
	dqb "FNID"
	csleep 1
	
	for f in $(find ${2} -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -type f) ; do ${scm} 0444 ${f} ; done
	dqb "HTAO EHT FO HTE TAOG EH)("
	csleep 1

	for f in $(find ${2} -type f -name "*.sh" ) ; do ${scm} ${m} ${f} ; done
	csleep 1

	if [ "${CONF_env}" == "DEFAULT" ] && [ -d ${CONF_DIR2} ] ; then	#tänään näin
		if [ -d ${2}${CONF_DIR2} ] ; then
			${sco} -R root:root ${2}${CONF_DIR2}

			${scm} 0400 ${2}${CONF_DIR2}/*
			${scm} 0511 ${2}${CONF_DIR2}/*.bash
		fi
	fi

	dqb "EH DONE"
	csleep 1
}

function mangle2() {
	[ -z  "${1}" ] && exit 99

	if [ -f ${1} ] ; then
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}

function e_e() {
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
	f=$(date +%F)

	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}

	if [ -f /etc/resolv.conf.${f} ] ; then
		dqb "SADF SADF SADFS ASDGH"
	else
		if [ -h /etc/resolv.conf ] ; then
			c=$(find /etc -type f -name "resolv.conf.*" -size +10c | wc -l )

			if [ ${c} -gt 0 ] ; then 
				${smr} /etc/resolv.conf
			fi
		else
			${svm} /etc/resolv.conf /etc/resolv.conf.${f}
		fi
	fi

	[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
	csleep 2

	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	for f in $(${odio} find /etc -type f -name "rules.*" ) ; do
		${sco} -R root:root ${f}
		${scm} 0400 ${f}
	done
}

function e_v() {
	dqb "e_v()"
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

function enforce_access() {
	dqb "common_lib.enforce_access(${1} , ${2} ))))))"
	[ -z "${1}" ] && exit 67
	[ -z "${2}" ] && exit 68
	
	csleep 1
	dqb "pars.ok"
	
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
	t=$(echo ${1} | cut -d "/" -f 1)

	if [ ! -s /etc/apt/sources.list.${t} ] ; then
		dqb "S3RV1CE F0R A VCANT C0FF1N"
		[ -v mkt ] || exit 99
		[ -z "${mkt}" ] && exit 98

		local h
		h=$(${mkt} -d)
		[ $? -eq 0 ] || exit 97

		csleep 1

		if [ ! -s /etc/apt/sources.list.tmp ] ; then	
			dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"
			csleep 1
			touch ${h}/sources.list.tmp
			local b

			if [ "${CONF_env}" == "TOOR" ] && [ -v CONF_alt_root ] ; then
				b="deb file://${2}"
			else
				b="deb https://REPOSITORY/merged"
			fi

			for x in DISTRO DISTRO-updates DISTRO-security ; do
				echo "${b} ${x} main" >> ${h}/sources.list.tmp
			done
		else
			${svm} /etc/apt/sources.list.tmp ${h}
			fasdfasd ${h}/sources.list.tmp
		fi

		dqb "p1.5.2"
		csleep 1
		local tdmc

		tdmc="sed -i 's/DISTRO/${t}/g'"
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

	[ -v ipt ] || dqb "SHOULD exit 96"
	local c
	local g
	local t

	g=$(date +%F)
	t=$(echo ${1} | cut -d '/' -f 1 | tr -dc a-z) 

	if [ -f /etc/apt/sources.list ] ; then
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:' | wc -l) #TARRKK PRKL

		if [ ${c} -gt 0 ] ; then #ehtona pikemminkin https: poissaolo?
			${svm} /etc/apt/sources.list /etc/apt/sources.list.${g}
			csleep 1
		fi
	fi

	if [ "${CONF_env}" == "TOOR" ] && [ -v CONF_alt_root ] ; then
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

#qseeko tässä jokin? toiv ei enää
function part2() {
	dqb "PART2.5.1 ( $1 , $2 , $3 ((("
	csleep 6

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
			csleep 2

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
			#VAIH:entä dhcp-pakettien poisto jollain ehdolla?
			#010526:ensimmäisellä yrityksellä x meni pois pelistä, joten toistaiseksi kommentteihin
		
			#eth0:1) #jospa konsultoisi man-sivuja tämän kanssa?
			#	${sharpy} modem* wireless* wpa*
			#	${sharpy} iw lm-sensors
			#	${sharpy} isc-dchp*
			#;;
			*)
				${sharpy} modem* wireless* 
				${sharpy} wpa*
				${sharpy} iw lm-sensors

				csleep 10
				dpkg -l wpa*
				csleep 10
			;;
		esac
	fi

	dqb "PART2.5.2 )))))( $1 , $2"
	csleep 1
	${lftr}
	csleep 1

	if [ ! -z "${ipt}" ] ; then
		jules
		local t

		t=$(echo ${2} | tr -d -c 0-9)
		[ -v CONF_DIR2 ] || exit 99

		#ved vai default?
		if [  "${CONF_env}" == "DEFAULT" ] && [ -d ${CONF_DIR2} ] ; then
			${odio} ${CONF_DIR2}tlb.bash ${t}
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

function wopr() {
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

	#csleep 1
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

function cg_udp6() {
	dqb " GENERIC REPLACEMENT FOR daud.lib.UPDP-6 ${1}"
	csleep 10
	[ -z "${1}" ] && exit 65
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

	echo " #VAIH:tulisi selvittää muiten käytännössä toimii eth0:1, sharpy, cg_upd6/(" #esim seur kerran q "exp2 u"
	sleep 5

	#130726:bissiin yritti poistaa dhcp-paketit ruossa alla
	if [ "${CONF_iface}" == "eth0:1" ] ; then
		${sharpy} isc-dchp*
	else
		dqn "NOTR EMOVING DCHP"
	fi

	dqb " GENERIC REPLACEMENT FOR daud.lib.UPDP-6  DONE FOR NOW"
	csleep 10
}

function part3() {
	dqb "))() part3 ${1} ,((()()()()()( ${2} (((((((("
	csleep 1

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 101

	dqb "PARAMS_OK"
	csleep 1

	local n15=0
	local t=""

	if [ -z "${2}" ] ; then
		t=$(${mkt} -d)

		n15=$(find ${1} -type f -name "*.deb" | wc -l)
	else
		t=${2} #jotain mankelointia mukaan?
		common_pp3 ${t} ${t} #toimisiko näin?
		
		n15=$(find ${2} -type f -name "*.deb" | wc -l)
	fi
	
	if [ ${n15} -lt 1 ] ; then
		cefgh ${1}
		#common_pp3 ${1} ${t}
	fi

	csleep 1
	jules

	common_pp3 ${1} ${t} #tämä kai pois jatkossa?
	dqb "AL-fPGA"
	csleep 1

	common_lib_tool ${t} reject_pkgs
	dqb "B3T4"
	csleep 3

	efk1 ${t}/gcc-12-base*.deb ${t}/libgcc-s1*.deb ${t}/libc6*.deb
	dqb "LAcKK.a"
	csleep 3

	for p in ${E22_GS} ; do wopr ${t} ${p} accept_pkgs_1 ; done
	dqb "önEGA-VGA RA"
	csleep 3

	common_lib_tool ${t} accept_pkgs_1
	common_lib_tool ${t} accept_pkgs_2

	dqb "g4RP D0NE"
	csleep 1

#	efk1 ${t}/lib*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 66"
#	csleep 1
#
#	efk1 ${t}/*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 67"	
#	csleep 1

	local f
	for f in $(find ${t} -name "lib*.deb" ) ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
               dqb "part3.1 ok"
               csleep 1
               ${NKVD} ${t}/lib*.deb
	else
               exit 66
	fi

	dqb "LIBS DONE"
	csleep 1
	for f in $(find ${t} -name "*.deb" ) ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
		dqb "part3.2 ok"
		csleep 1
		${NKVD} ${t}/*.deb
	else
	       	exit 67
 	fi

	[ -f ${1}/${CONF_hashfile} ] && ${NKVD} ${1}/${CONF_hashfile}*
	csleep 1	
	other_horrors
}

function process_lib() {
	[ -z "${1}" ] && exit 66
	
	if [ -x "${gg}" ] && [ -s ${1}/lib.sh.sig ] ; then
		dqb "SHOULD ${gg} --verify ${1}/lib.sh.sig ? "
		${gg} --verify ${1}/lib.sh.sig
		[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
		csleep 1
	fi
	
	if [ -d ${1} ] && [ -x ${1}/lib.sh ] ; then
		.  ${1}/lib.sh
	else
		fallback
	fi

	dqb "JSUT BFORE CKEH_BIN 1"
	csleep 1

	check_binaries ${1} ${2}
	[ $? -eq 0 ] || dqb "SHOULD exit 67"
	
	check_binaries2
	[ $? -eq 0 ] || dqb "SHOULD exit 68 också"

	TLA
	dqb "common.process_lib.done()"
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
				exit
			;;
		esac

		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=${opt}
	done
}

#https://stackoverflow.com/questions/16988427/calling-one-bash-script-from-another-script-passing-it-arguments-with-quotes-and
gpo "$@"


#function cptp2() { #TARKKUUTTA PRKL
#	dqb "rot.c tp2 ${1}, ${2}, ${3}"
#
#	[ -z "${1}" ] && exit 99
#	[ -d ${1} ] || exit 97
#
#	dqb "cptp2:pars ok"
#	csleep 10
#
#	#tr-kikkailu tässä ei niitä parhaimpia ideoita 
#	local t
#	t=$(echo ${1} | cut -d "/" -f 1-5 | tr -d -c 0-9a-zA-Z/.)
#
#	if [ -f ${t}/common_lib.sh ] ; then
#		#onkohan tuossa tarkistuksessa pointtia?
#		if [ -s ${t}/common_lib.sh.sig ] && [ ! -z "${gg}" ] ; then
#			${gg} --verify ${t}/common_lib.sh.sig 
#			[ $? -eq 0 ] || echo "SHOULD HALT AND CATCH FIRE NOW"
#		fi
#		if [ -x ${t}/common_lib.sh ] ; then
#			enforce_access $(whoami) ${t}
#		
#			dqb "TRO: running mutilatetc.bash maY be necessary now to fix some things"
#		else
#			dqb "n s 3x3cutabl3 as ${t}/common_lib.sh, needed 2 3nf0rc3 some things  "
#		fi
#		
#		csleep 10
#	fi
#
#	csleep 1
#
#	if [ -d ${t} ] ; then
#		dqb "HAIL2 TH3 TH13F"
#
#		${scm} 0755 ${t}
#		${scm} 0555 ${t}/*.sh
#		${scm} 0444 ${t}/conf*
#		${scm} 0444 ${t}/*.deb
#
#		csleep 1
#	fi
#
#	[ ${debug} -eq 1 ] && ls -las ${1}
#	csleep 1
#	dqb "ALL DONE"
#}
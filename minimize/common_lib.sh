#fktioksi ao. blokki ni ei tartte globaalien mjien kanssa sählätä?

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

#VAIH:vähitellen kehitysYmp kanssa se g_doit ja omega (olisiko jo 06/26?)

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
	dqb "common_lib.fix_sud0.pt0"	
	#DONE:sco, scm asettelu, josko tähän fktioon takaisin kanssa?
	
	sco=$(${odio} which chown)
	[ y"${sco}" == "y" ] && exit 98
	[ -x ${sco} ] || exit 97
	
	scm=$(${odio} which chmod)
	[ y"${scm}" == "y" ] && exit 96
	[ -x ${scm} ] || exit 95
	sco="${odio} ${sco} "
	scm="${odio} ${scm} "	

	if [ "${CONF_env}" == "DEFAULT" ] ; then #EHTPOA SAATTAA JHOUTUA RENKKAAMAAN VIELÄ
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
	
	if [ "${CONF_env}" == "DEFAULT" ] ; then #HYVÄ NÄINB?
		dqb "1NTERBAL SUFFER1NG"

		for f in $(${odio} find /etc -type f -name "rules.*" ) ; do
			#TODO:valmis palikka? mangle2 ei ihan
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

	dqb "cb01"

	ocs dpkg
	ocs tar
	ocs shred
	csleep 1

	dqb "cb02"
	unset sdi
	unset sr0
	unset srat
	unset sah6
	unset NKVD
	csleep 1
	
	dqb "cb03"
	[ -v CONF_algo ] || exit 69
	dqb ${CONF_algo}

	case "${CONF_algo}" in
		sha256)
			ocs sha256sum
			sah6=$(${odio} which sha256sum)
		;;
		sha512)
			ocs sha512sum
			sah6=$(${odio} which sha512sum)
		;;
		*)
			exit 667
		;;
	esac

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
	dqb "cb04"

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

	#ehkä tämmöinen lista kuuluisi konftdstoon?
	#4426:brl ja openssh uutena minimal_live liittyen, pois jos qsee (6426 ssh viskoi pihalle äksästä ennenaikaisesti, toistuuko?)
	PART175_LIST="avahi blu cups exim4 nfs network mdadm sane rpc lm-sensors dnsmasq stubby brltty openssh" #  ssh too soon

	#HUOM.YRITÄ SINÄKIN SAATANAN SIMPANSSI JA VITUN PUOLIAPINA KÄSITTÄÄ ETTÄ EI NÄIN 666!!!
	#sdi=$(${odio} which dpkg)
	#sdi="${odio} ${sdi} -i "
	csleep 2

	#TODO:näille main jotain muutoksia?
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

	#05/26 riittävästi ulinaa resolv.conf kanssa?

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

	if [ "${CONF_env}" == "DEFAULT" ] && [ -d /opt/bin ] ; then
		[ -s /opt/bin/zxcv ] || echo "should exit 98"
		[ -s /opt/bin/zxcv.sig ] || echo "ahouls exit 99"
		[ -s /opt/bin/zxcv.sha ] || echo "shoul.d ext1 8 97"

		${odio} ${sah6} -c /opt/bin/zxcv.sha
		[ $? -gt 0 ] && echo "gh0uls 0f n1n1w3h"

		[ -z "${gg}" ] || ${gg} --verify /opt/bin/zxcv.sig
		[ $? -gt 0 ] && echo "dhoulf exit 126"

		local p=$(pwd)
		cd /
		${odio} ${sah6} -c /opt/bin/zxcv
		[ $? -gt 0 ] && echo "dhoulf exit 1234!!!"
		cd ${p}
	fi

	csleep 1
	dqb "cb0 done"
}

check_bin_0
#
#function jules() { #TÄSSÄKIN VÄÄRIÄÖ MERKKEJÄ?
#other_horrors
#[ ${debug} -eq 1 ] && ${odio} ls -las /etc/iptables
#}
#
#TODO?:jatkosäätöä josqs lähiaikoina? (kts e22.sh, KVG-jutut bissiin uusicksi)
function psqa() {
	dqb "c.Q () () () () ${1} ;;;"
	csleep 1

	[ -z "${1}" ] && exit 97
	[ -d ${1} ] || exit 96
	[ ${debug} -gt 0 ] && ls -las ${1}/${CONF_hashfile}*
	csleep 1

	#return 92 #ei näin?
	#dpkg -V oli tässä josqs , [ -v ] takana

	#040626:tapauksessa CONF_env==TOOR ohittamaan seur 2 riviä?
	[ -v CONF_hashfile ] || exit 98
	[ -z "${CONF_hashfile}" ] && exit 99

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
				${NKVD} ${1}/${CONF_hashfile}.*
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
		local p
		p=$(pwd)
		cd ${1}

		#HUOM.15525:pitäisiköhän reagoida tilanteeseen että asennettavia pak ei ole?
		${sah6} -c ${CONF_hashfile} --ignore-missing

		if [ $? -eq 0 ] ; then
			dqb "Q.KO"
		else
			dqb "SHOULD \${NKVD} ${1}/ \* .deb"
			return 94
		fi

		#TODO:selvitä mikä tämän tdston kanssa on? jääkö tyhjäksi nykyään?		
		[ -f ${1}/${CONF_hashfile}.1 ] && ${sah6} --ignore-missing -c ${CONF_hashfile}.1
		csleep 1
		cd ${p}
	else
		dqb "NO $CONF_algo}SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
		dqb "SHOULD \${NKVD} ${1}/ \*.deb"		
		return 93
	fi

	dqb " DONE WITH THE Q-FEVER () ;;;; (((((("
	csleep 2
}

#040626:tämä vai CB02 missä vääriä merkkejä?
#TODO:shasums:ien kopsaus $2:seen myös?
#TODO:pikemminkin siellä $2-hmistossa käsin se sha-tarkstus?
function common_pp3() {
[ -z "${1}" ] && exit 99
[ -d ${1} ] || exit 101
[ -z "${2}" ] && exit 98
[ -d ${2} ] || exit 102

local q=$(find ${1} -type f -name "*.deb" | wc -l)
local r=$(echo ${1} | cut -d "/" -f 1-5)

if [ ${q} -lt 1 ] ; then
${scm} a-wx ${r}/common_lib.sh
else
psqa ${1}
if [ $? -gt 0 ] ; then
${NKVD} ${1}/*.deb
${NKVD} ${1}/${CONF_hashfile}* #TÄMÄKÖ KUSI KOKO TDSTON?
${NKVD} ${1}/*.tar*
fi

local s
for s in $(grep -v '#' ${1}/${CONF_hashfile} | awk '{print $2}') ; do
${svm} ${1}/${s} ${2}
done

for s in $(grep -v '#' ${1}/${CONF_hashfile}.1 | grep -v drop | awk '{print $2}') ; do
${spc} ${1}/${s} ${2}
done

fi

dqb "COMMON_PP3-DONE()"
}
function efk1() { #tässä vääriä merkkejä?
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
function fromtend() { #tÄSSÄ VÄÄRIÄ MERKKEJÄ?
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
if [ -s ${1}/e.tar.sha ] ; then
${sah6} -c ${1}/e.tar.sha
[ $? -eq 0 ] || ${NKVD} ${1}/e.tar*
fi
efk2 ${1}/e.tar ${1}
${NKVD} ${1}/e.tar
fi
efk2 ${1}/f.tar ${1}
if [ $? -eq 0 ] ; then
[ -x ${gg} ] && ${NKVD} ${1}/f.tar
fi
}

#TODO:sqroot-ympäristön pkaettivalikoiman päivitys, mm. gpg_poistuu:syistä
function CB01() {
	dqb "common.lib.CB01( ${1} (( ${2} )"
	csleep 1

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 100
	[ -z "${2}" ] && exit 98
	[ -d ${2} ] || exit 102
	dqb "pars.0k"
	
#	#josko sittenkin kikkailisi ao. blokin -> cefgh ?
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

	common_pp3 ${1} ${2}
	for p in ${E22_GI} ; do efk1 ${2}/${p}*.deb ; done
	csleep 1
	dqb "iZOMVIE"
	
	#TODO?:tgris-tetris?
	gg=$(${odio} which gpg)
	gv=$(${odio} which gpgv)
	[ -z "${gg}" ] && ${scm} a-wx ${1}/../common_lib.sh #$0 josko näin kuitenkin?
	csleep 1
	dqb "CcC"
	
#	[ -s ${1}/${CONF_hashfile}.bak ] && ${svm} ${1}/${CONF_hashfile}.bak ${1}/${CONF_hashfile}
	common_pp3 ${1} ${2}
	dqb "common.lib.CB01() DONE"
	csleep 1
}

#function message() { #TÄSSÄ VÄÄRIÄ MERKKEJÄ?
#echo "INSTALLING NEW PACKAGES IN x SECS"
#sleep 1
#echo "DO NOT xxx yyy"
#sleep 1
#echo "... FOR POSITIVE ANSWER MAY BREAK THINGS"
#sleep 1
#}
#
function CB02() {
	dqb "CB02()"
	csleep 1
	jules

	[ -z "${1}" ] && exit 99
	[ -d ${1} ] || exit 100
	dqb "c0b2.pars.0k"
	
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
	dqb "c0mm0n_lib.ch3ck_b1nar135 ( ${1} (((((((( ${2} )((((((( "
	csleep 1
	
	dqb "6tr"
	csleep 1
	
	ipt=$(${odio} which iptables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)

	E22_GS="gcc-12-base libgcc-s1 libc6" 	
	E22_GS="${E22_GS} libgmp10 libisl23 libmpfr6 libmpc3 libzstd1 zlib1g"
	E22_GS="${E22_GS} libstdc++6 libgomp1 cpp-12"

	E23_GS="zlib1g libreadline8 groff-base libgdbm6 libpipeline1 libseccomp2 libaudit1 libselinux1 man-db sudo"
	
	E22_GM="libc6 libselinux1"
	E22_GM="${E22_GM} debianutils debconf liblocale-gettext-perl libtext-charwidth-perl libtext-iconv-perl libtext-wrapi18n-perl" # nfs-common
	E22_GM="${E22_GM} debconf-i18n libelf1 libbpf1 " #zlib1,libc6
	E22_GM="${E22_GM} libmnl0 libxtables12 " # oikeastaanm jo toisissakin jutussa mukana

	E22_GM="${E22_GM} libcom-err2 libk5crypto3 libkeyutils1 libkrb5support0 libssl3 libkrb5-3 libkrb5support0"
	E22_GM="${E22_GM} libmnl0 libatm1 libpcre2-8-0 libmd0 libgssapi-krb5-2 "
	E22_GM="${E22_GM} libbsd0 libcap2 libcap2-bin libdb5.3 libtirpc-common libtirpc3 iproute2"

	E22_GM="${E22_GM} isc-dhcp-client isc-dhcp-common"
	E22_GM="${E22_GM} libpam0g libcrypt1 libaudit1 libpam-modules-bin libpam-modules "

	E22_GM="${E22_GM} libbz2-1.0 libsemanage-common libsemanage2 libsepol2 passwd adduser ifupdown"
	E22_GM="${E22_GM} libblkid1 libmount1 libsmartcols1 mount net-tools"
	E22_GM="${E22_GM} libacl1 libattr1 libgmp10 coreutils"

	dqb "before 0c.s"
	local y
	
	if [ "${CONF_env}" == "VED" ] ; then
		y="/sbin/ifup /sbin/ifdown apt-get apt ip netstat ${sd0} ${sr0} mount umount mkdir mktemp" # sha512sum
		ipt="/usr/sbin/iptables"
		gg="/usr/bin/gpg"
		dqb "PISSE"
	else
		dqb "SCHEISSE"
		y="ifup ifdown apt-get apt ip netstat ${sd0} ${sr0} mount umount mkdir mktemp" # kilinwittu.sh  sha512sum
	fi
	
	for x in ${y} ; do ocs ${x} ; done
	sdi="${odio} ${sd0} -i "
	E22_GI="libassuan0 libbz2-1.0 libc6 libgcrypt20 libgpg-error0 libreadline8 libsqlite3-0 gpgconf zlib1g gpg"

	#TODO:gt kanssa muutoksia, kts toinen oksa vastaava fktio

	E22_GT="isc-dhcp-client isc-dhcp-common "
	E22_GT="${E22_GT} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11 libnftables1 libedit2"
	E22_GT="${E22_GT} iptables"
	E22_GT="${E22_GT} init-system-helpers" # iptables-persistent netfilter-persistent

	E22_GU="isc-dhcp libnfnet libnetfilter libxtables libmnl libnftnl libnftables libnl-3-200 libnl-route libnl nftables"
	E22_GV="libip iptables_ iptables-" # netfilter-persistent
	
	dqb "CEPHALIC CAnrAGE"
	local t
	t=""
	csleep 1
	
	if [ -z "${ipt}" ] || [ -z "${gg}" ] ; then
		[ -z "${1}" ] && exit 99
		[ -d ${1} ] || exit 101

		if [ -z "${2}" ]; then
			dqb "TKMP"
			csleep 5
			t=$(${mkt} -d) 
		else
			t=${2}
		fi

		cefgh ${1}
		common_pp3 ${1} ${t}
		
		dqb "BF0R3 CVB0"
		csleep 5
	fi
	
	dqb "M2c -E"
	csleep 1
	
	if [ -z "${gg}" ] ; then
		CB01 ${1} ${t}
	fi
	
	if [ -z "${ipt}" ] ; then
		CB02 ${t}
	fi

	dqb "#jäölk ÄYÖYÄ SDDFSDSDGH t. Paska-Ankka"
	ls ${t}/*.deb | wc -l
	csleep 3

	if [ "${CONF_env}" != "VED" ] ; then
		for x in iptables ip6tables iptables-restore ip6tables-restore gpg ; do ocs ${x} ; done
	fi

	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1
	
	#toistaiseksi näin
	if [ "${CONF_env}" == "DEFAULT" ] ; then
		ocs dhclient
		csleep 1
	fi

	sag=$(${odio} which apt-get)
	sa=$(${odio} which apt) #tar4vitaanko jossain? jep

	som=$(${odio} which mount)
	uom=$(${odio} which umount)
	sifc=$(${odio} which ifconfig)

	dqb "b1nar135 0k"
	csleep 1
}
function check_binaries2() {
	dqb "c0mm0n_lib.ch3ck_b1nar135.2 ))) ${1} ; ${2} ((((((("
	csleep 1
	[ -v sd0 ] || exit 66
	
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
	dqb "netx : pt 2.22 "
	lftr="${smr} -rf /run/live/medium/live/initrd.img* "
	
	if [ "${CONF_env}" != "VED"  ] ; then 
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
	
	#VAIH:CONF_env-juttuja (oliko jo aiemmin? toisessa okssasssa ainakin)
	if [ -z "${ipt}" ] || [ "${ipt}" == "${odio}" ] || [ "${CONF_env}" == "TOOR" ] ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		if [ "${CONF_env}" != "VED" ] ; then #arpoo arpoo (jos ylempi if-lause vähän uusiksi?)	
			
			dqb "JST B3F0R:tlb-b a s h"
			[ -s /opt/bin/tlb.bash ] || exit 99
			${scm} 0511 /opt/bin/tlb.bash

			#tarkoituksella ilman param
			${odio} /opt/bin/tlb.bash 
		fi
	fi
}

#==================================================================

function mangle_s() {
	dqb " mangle_s( ${1} )"
	csleep 1

	[ -z "${1}" ] && exit 44
	[ -x ${1} ] || exit 55 #TÄHÄNKÖ TÖKKÄÄ 050626?
	[ -z "${2}" ] && exit 45 #KUINKA MONTA PARAM?
	[ -f ${2} ] || exit 54

	[ -v CONF_algo ] || exit 98
	[ -z "${CONF_algo}" ] && exit 99 

	dqb "pars ok"
	csleep 1

	local r
	r=$(echo ${1} | tr -dc a-zA-Z0-9/.)
	${scm} 0555 ${r}
	${sco} root:root ${r}

	#toisinkin voisi kai tehdä (ab,ac)
	local aa=$(whoami | tr -dc a-zA-Z0-9 )
	local ab=$(${sah6} ${r} | awk '{print $1}' | tr -dc a-fA-F0-9)
	local ac=$(${sah6} ${r} | awk '{print $2}' | tr -dc a-zA-Z0-9./)	
	echo "${aa} ALL=NOPASSWD:${CONF_algo}:${ab} ${ac}" >> ${2}

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

		echo -n "${CONF_algo}:" >> ${1}
		t=$(${sah6} ${g} | awk '{print $1}' | tr -dc a-fA-F0-9)
		echo -n ${t} >> ${1}
	done

	echo " /sbin/dhclient-script" >> ${1}
	cat ${1}
	echo "DINSDALE"
	csleep 5
}

function fasdfasd() {
	dqb "fasdfasd ))) ${1} )))"
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

	if [ "${CONF_env}" == "DEFAULT" ] && [ -d /opt/bin ] ; then 
		${scm} go-rw /opt/bin/*
		${scm} 0400 /opt/bin/*.sh
		${scm} 0511 /opt/bin/*.bash
	fi

	${scm} 0755 /
	${sco} root:root /
	dqb "D+T"
	
	${scm} 0777 /tmp
	${sco} root:root /tmp
	
	csleep 1
	dqb "ANALISIS CLINICOS ASD ASD 123"
	#exit
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

	#tämäkö siihen "-v vs ei -v"-temppuiluun liittyy?
	for f in $(find ${2} -type f -name "*.sh" ) ; do ${scm} ${m} ${f} ; done
	csleep 1

	if [ "${CONF_env}" != "VED" ] ; then
		#jos antaisi olla näin jnkn aikaa?
		if [ -d ${2}/opt/bin ] ; then
			${sco} -R root:root ${2}/opt/bin

			${scm} 0400 ${2}/opt/bin/*
			${scm} 0511 ${2}/opt/bin/*.bash
		fi
	fi

	dqb "EH DONE"
	csleep 1
}

#function mangle2() {
#	[ -z  "${1}" ] && exit 99
#
#	if [ -f ${1} ] ; then
#		${scm} o-rwx ${1}
#		${sco} root:root ${1}
#	fi
#}
#
#function e_e() {
#	dqb "e_e"
#	csleep 1
#	
#	fix_sudo
#	for f in $(find /etc/sudoers.d/ -type f) ; do mangle2 ${f} ; done
#
#	for f in $(find /etc -name "sudo*" -type f | grep -v log) ; do
#	done
#
#	other_horrors
#	${scm} 0755 /etc
#	${sco} -R root:root /etc
#	${scm} 0555 /etc/network
#	${scm} 0444 /etc/network/*
#
#	for f in $(find /etc/network -type d ) ; do ${scm} 0555 ${f} ; done
#	csleep 1
#
#	local f
#	local c
#
#	f=$(date +%F)
#	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}
#
#	dqb "JUST BEF0RE MUTILATING RESOLV.CONF"
#	csleep 5
#
#	if [ -f /etc/resolv.conf.${f} ] ; then
#		dqb "SADF SADF SADFS ASDGH"
#	else
#		if [ -h /etc/resolv.conf ] ; then
#			c=$(find /etc -type f -name "resolv.conf.*" -size +10c | wc -l )
#
#			if [ ${c} -gt 0 ] ; then 
#				${smr} /etc/resolv.conf
#			fi
#		else
#			${svm} /etc/resolv.conf /etc/resolv.conf.${f}
#		fi
#	fi
#
#	dqb "JUST AFTER MUTILATING RESOLV.CONF"
#	csleep 2
#	[ ${debug} -eq 1 ] && ls -las /etc/resolv.*
#	csleep 2
#
#	${sco} -R root:root /etc/wpa_supplicant
#	${scm} -R a-w /etc/wpa_supplicant
#
#	for f in $(${odio} find /etc -type f -name "rules.*" ) ; do
#		${sco} -R root:root ${f}
#		${scm} 0400 ${f}
#	done
#
#	dqb "EE DONE"
#	csleep 1
#}
#
#function e_v() {
#	dqb "e_v()"
#	${sco} -R root:root /sbin
#	${scm} -R 0755 /sbin
#	dqb "e_V_2 IN 1 SECS"
#	csleep 1
#
#	${sco} root:root /var
#	${scm} 0755 /var
#	${sco} root:staff /var/local
#	${sco} root:mail /var/mail
#	${sco} -R man:man /var/cache/man
#	${scm} -R 0755 /var/cache/man
#	
#	dqb "EV DONE"
#	csleep 1
#}
#
#function enforce_access() {
#	dqb "common_lib.enforce_access(${1} , ${2} ))))))"
#	[ -z "${1}" ] && exit 67
#	[ -z "${2}" ] && exit 68
#	
#	csleep 1
#	dqb "pars.ok"
#	
#	e_e
#	e_v
#	e_h ${1} ${2}
#	e_final
#	jules
#
#	[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables;sleep 2
#}

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

	#TODO?:tesgris,dufo?
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
		#if  $INITRD = No  then ...
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

	#150326:pitäisikohän tehdf vielä toinenkin veuiartlu barm buoksi?
	if [ ! -z "${ipt}"  ] ; then
		jules
		local t

		t=$(echo ${2} | tr -d -c 0-9)

		if [  "${CONF_env}" != "VED"  ] && [ -d /opt/bin ] ; then
			${odio} /opt/bin/tlb.bash ${t}
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

#poistettu komm 050626,toimii:
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

	csleep 1
}

#poistettu komm 050626,toimii:
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
#function cg_udp6() {
#	dqb " GENERIC REPLACEMENT FOR daud.lib.UPDP-6 ${1}"
#	csleep 1
#	[ -z "${1}" ] && exit 65
#	[ -d ${1} ] || exit 66
#	dqb "paramz 0k"
#	csleep 1
#
#	dqb "${1} :"
#	[ ${debug} -eq 1 ] && ls -las ${1}/*.deb | wc -l
#	csleep 3
#
#	dqb "${pkgdir} :"
#	[ ${debug} -eq 1 ] && ls -las ${CONF_pkgdir}/*.deb | wc -l
#	csleep 3
#
#	common_lib_tool ${1} reject_pkgs
#	dqb "D0NE"
#	csleep 1
#}
#
##käytössä?
#function cg_pp2() {
#	dqb " GENERIC REPLACEMENT FOR daud.lib.pre_part2 ${1}"
#	csleep 1
#
#	${odio} /etc/init.d/ntpd stop
#	#$sharpy ntp* jo aiempana
#
#	for f in $(find /etc/init.d -type f -name "ntp*" ) ; do 
#		${odio} ${f} stop
#		csleep 1
#	done
#
#	csleep 2
#	dqb "d0n3"
#}


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
		t=$(mktemp -d)
		#TODO:tässä kåskyttämään common_pp3() ?
		n15=$(find ${1} -type f -name "*.deb" | wc -l)
	else
		t=${2} #jotain mankelointia mukaan?
		n15=$(find ${2} -type f -name "*.deb" | wc -l)
	fi
	
	if [ ${n15} -lt 1 ] ; then
		cefgh ${1}
	fi

	csleep 1
	jules

	common_pp3 ${1} ${t}
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
	other_horrors
}
function process_lib() {
	dqb "process_lib( ${1} ) ${2} (((((((("
	[ -z "${1}" ] && exit 66
	csleep 1
	
	#pointti?
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

	check_binaries ${1} ${2}
	[ $? -eq 0 ] || dqb "SHOULD exit 67"
	
	check_binaries2
	[ $? -eq 0 ] || dqb "SHOULD exit 68 också"

	TLA
	dqb "common.process_lib.done()"
}
#
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

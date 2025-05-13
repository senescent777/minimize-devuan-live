odio=$(which sudo)
[ y"${odio}" == "y" ] && exit 99 
[ -x ${odio} ] || exit 100

sco=$(sudo which chown)
[ y"${sco}" == "y" ] && exit 98
[ -x ${sco} ] || exit 97

scm=$(sudo which chmod)
[ y"${scm}" == "y" ] && exit 96
[ -x ${scm} ] || exit 95

sco="${odio} ${sco} "
scm="${odio} ${scm} "

#HUOM. ei tarvitse cb_listiin mutta muuten tarvitsee asettaa mahd aikaisin
sah6=$(which sha512sum)
distro=$(cat /etc/devuan_version)
n=$(whoami)
PREFIX=~/Desktop/minimize #käyttöön+komftdstoon jos mahd

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function fix_sudo() {
	echo "fix_sud0.pt0"

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

	#dqb "POT. DANGEROUS PT 2"
	#HUOM.250325:onkohan tarkoitus että nämä komennot laittavat sudon epäkuntoon vai ei?
	#${sco} 0:0 /usr/bin/sudo* #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!
	#${scm} -R a-w /usr/bin/sudo* #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!
	#${scm} 4555 ./usr/bin/sudo #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!

	[ ${debug} -eq 1 ] && ls -las /usr/bin/sudo*
	csleep 5
	echo "fix_sud0.d0n3"
}

fix_sudo
#yhteen läjän nämä määrittelyt?
slinky=$(${odio} which ln)
slinky="${odio} ${slinky} -s "
spc=$(${odio} which cp)
svm=$(${odio} which mv)
svm="${odio} ${svm} "
spc="${odio} ${spc} "

function jules() { #HUOM.12525:function puuttui edestä aiemmin
	dqb "LE BIG MAC"

	${scm} -R a+rw /etc/iptables
	echo $?
	dqb "svm= ${svm}"
	dqb "spc= ${spc}"
	csleep 3

	[ -f /etc/iptables/rules.v4 ] && ${svm} /etc/iptables/rules.v4 /etc/iptables/rules.v4.OLD
	[ -f /etc/iptables/rules.v4 ] && ${svm} /etc/iptables/rules.v6 /etc/iptables/rules.v6.OLD

	csleep 3
	${scm} 0444 /etc/default/rules.*

	[ -s /etc/iptables/rules.v4.${dnsm} ] || ${spc} /etc/default/rules.4.${dnsm} /etc/iptables/rules.v4.${dnsm}
	[ -s /etc/iptables/rules.v6.${dnsm} ] || ${spc} /etc/default/rules.6.${dnsm} /etc/iptables/rules.v6.${dnsm}

	${scm} 0400 /etc/default/rules.*
	csleep 3

	[ -h /etc/iptables/rules.v4 ] || ${slinky} /etc/iptables/rules.v4.${dnsm} /etc/iptables/rules.v4
	#HUOM.12525:toimiiko v6sen kanssa?	
	[ -h /etc/iptables/rules.v6 ] || ${slinky} /etc/iptables/rules.v6.${dnsm} /etc/iptables/rules.v6

	csleep 3
	${scm} 0550 /etc/iptables
	${scm} 0440 /etc/iptables/*
}

function message() {
	echo "INSTALLING NEW PACKAGES IN 10 SECS"
	csleep 3
	echo "DO NOT ANSWER \"Yes\" TO QUESTIONS ABOUT IPTABLES";sleep 2
	echo "... FOR POSITIVE ANSWER MAY BREAK THINGS";sleep 3
}

function ocs() {
	local tmp
	tmp=$(sudo which ${1})

	if [ y"${tmp}" == "y" ] ; then
		exit 69 #fiksummankin exit-koodin voisi keksiä
	fi

	if [ ! -x ${tmp} ] ; then
		exit 77
	fi
}

function psqa() {
	dqb "QUASB (THE BURNING) ${1}"

	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		p=$(pwd)
		cd ${1}

		#dpkg -V #HUOM.11525:toistaiseksi jemmaan
		#sleep 5

		${sah6} -c sha512sums.txt --ignore-missing
		[ $? -eq 0 ] || exit 97
		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
	fi

	csleep 3
}

function check_binaries() {
	debug=1
	dqb "c0mm0n_lib.ch3ck_b1nar135(${1} )"
	dqb "sudo= ${odio} "
	csleep 1

	smr=$(${odio} which rm)
	NKVD=$(${odio} which shred)

	ipt=$(sudo which iptables)
	ip6t=$(sudo which ip6tables)
	iptr=$(sudo which iptables-restore)
	ip6tr=$(sudo which ip6tables-restore)

	if [ -s ~/Desktop/minimize/tar-wrapper.sh ] ; then
		dqb "TODO: tar-wrapper.sh"
	else
		srat=$(sudo which tar)
		
		if [ ${debug} -eq 1 ] ; then
			srat="${srat} -v "
		fi
	fi

	if [ y"${ipt}" == "y" ] ; then
		[ z"${1}" == "z" ] && exit 99
		[ -d ~/Desktop/minimize/${1} ] || exit 100

		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		jules

		if [ -s ~/Desktop/minimize/${1}/e.tar ] ; then
			${odio} ${srat} -C / -xf ~/Desktop/minimize/${1}/e.tar
			${odio} ${NKVD} ~/Desktop/minimize/${1}/e.tar  #jompikumpi hoitaa
			${odio} ${smr} ~/Desktop/minimize/${1}/e.tar
		fi

		#psqa ~/Desktop/minimize/${1} #pp3 tekee saman tark
		csleep 3

		pre_part3 ~/Desktop/minimize/${1}
		pr4 ~/Desktop/minimize/${1}

		ipt=$(sudo which iptables)
		ip6t=$(sudo which ip6tables)
		iptr=$(sudo which iptables-restore)
		ip6tr=$(sudo which ip6tables-restore)
	fi

	#voisi kai ocs-kohtaankin viedä ao. blokin sisällön
	[ -x ${ipt} ] || exit 5
	#jospa sanoisi ipv6.disable=1 isolinuxille ni ei tarttisi tässä säätää
	[ -x ${ip6t} ] || exit 5
	[ -x ${iptr} ] || exit 5
	[ -x ${ip6tr} ] || exit 5

	whack=$(sudo which pkill)
	sifu=$(sudo which ifup)
	sifd=$(sudo which ifdown)

	CB_LIST1="/sbin/halt /sbin/reboot /usr/bin/which ${sifu} ${sifd} "
	dqb "second half of c_bin_1"
	csleep 3

	for x in apt-get apt ip netstat dpkg tar mount umount dhclient sha512sum #kilinwittu.sh
		do ocs ${x}
	done
	
	sdi=$(sudo which dpkg)
	sag=$(sudo which apt-get)
	sa=$(sudo which apt)

	sip=$(sudo which ip)
	dqb "sip= ${sip}"
	csleep 3

	snt=$(sudo which netstat)
	som=$(sudo which mount)
	uom=$(sudo which umount)

	dqb "b1nar135 0k"
	csleep 2
}

function check_binaries2() {
	dqb "c0mm0n_lib.ch3ck_b1nar135.2()"

	ipt="${odio} ${ipt} "
	ip6t="${odio} ${ip6t} "
	iptr="${odio} ${iptr} "
	ip6tr="${odio} ${ip6tr} "

	whack="${odio} ${whack} --signal 9 "
	snt="${odio} ${snt} "
	sharpy="${odio} ${sag} remove --purge --yes "
	spd="${odio} ${sdi} -l " #käytössä?
	sdi="${odio} ${sdi} -i "

	#HUOM. ${sag} VIIMEISENÄ
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "

	sip="${odio} ${sip} "
	dqb "sip= ${sip}"
	csleep 3

	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "
	smr="${odio} ${smr} "
	lftr="${smr} -rf /run/live/medium/live/initrd.img* "

	NKVD="${NKVD} -fu "
	NKVD="${odio} ${NKVD} "

	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "

	som="${odio} ${som} "
	uom="${odio} ${uom} "
	
	#HUOM. ei alustetttu tämmöstä dch="${odio} ${dch}"

	dqb "b1nar135.2 0k.2" 
	csleep 2
}

function mangle_s() {
	csleep 1

	[ y"${1}" == "y" ] && exit 44
	[ -x ${1} ] || exit 55
	[ y"${2}" == "y" ] && exit 43
	[ -f ${2} ] || exit 54

	${scm} 0555 ${1}
	${sco} root:root ${1}

	local s
	local n2

	if [ y"${3}" == "y" ] ; then
		n2=$(whoami)
	else
		n2=${3}
	fi

	s=$(sha256sum ${1})
	echo "${n2} localhost=NOPASSWD: sha256: ${s} " >> ${2}
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

function pre_enforce() {
	dqb "common_lib.pre_enforce( ${1} , ${2} )"
	local q
	local f

	q=$(mktemp -d)
	dqb "sudo touch ${q}/meshuggah in 3 secs"
	csleep 2

	touch ${q}/meshuggah
	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 3

	[ -f ${q}/meshuggah ] || exit 33
	dqb "1NF3RN0 0F SACR3D D35TRUCT10N"
	mangle_s ~/Desktop/minimize/changedns.sh ${q}/meshuggah
	csleep 2

	dqb "LETf HOUTRE JOINED IN DARKN355"
	for f in ${CB_LIST1} ; do mangle_s ${f} ${q}/meshuggah ; done
	csleep 3

	dqb "TRAN S1LVAN1AN HUGN3R"
	dinf ${q}/meshuggah
	csleep 2

	if [ -s ${q}/meshuggah ] ; then
		dqb "sudo mv ${q}/meshuggah /etc/sudoers.d in 2 secs"
		csleep 2
		chmod 0440 ${q}/meshuggah
		${sco} root:root ${q}/meshuggah
		${svm} ${q}/meshuggah /etc/sudoers.d
		CB_LIST1=""
		unset CB_LIST1
		#saavuttaakohan tuolla nollauksella mitään? kuitenkin alustetaan
	fi

	#HUOM.12525:jokin lisäehto vielä? enforcen taakse?
	local c4
	c4=$(grep -c ${part0} /etc/fstab)

	if [ ${c4} -lt 1 ] ; then
		${scm} a+w /etc/fstab
		${odio} echo "/dev/disk/by-uuid/${part0} ${dir} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		${scm} a-w /etc/fstab
	fi

	csleep 5
	dqb "common_lib.pre_enforce d0n3"
}

function mangle2() {
	if [ -f ${1} ] ; then
		dqb "MANGLED ${1}"
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}

function enforce_access() {
	dqb " enforce_access( ${1})"

	${scm} 0440 /etc/sudoers.d/*
	${scm} 0750 /etc/sudoers.d
	${sco} -R root:root /etc/sudoers.d

	dqb "changing /sbin , /etc and /var 4 real"

	${sco} -R root:root /sbin
	${scm} -R 0755 /sbin

	for f in $(find /etc/sudoers.d/ -type f) ; do mangle2 ${f} ; done

	for f in $(find /etc -name 'sudo*' -type f | grep -v log) ; do
		mangle2 ${f}
	done

	${scm} 0755 /etc
	${sco} -R root:root /etc #-R liikaa?
	#-R liikaa tässä alla 2 rivillä? nyt 240325 poistettu

	${sco} root:root /var
	${scm} 0755 /var
	${sco} root:staff /var/local
	${sco} root:mail /var/mail
	${sco} -R man:man /var/cache/man
	${scm} -R 0755 /var/cache/man

	${scm} 0755 /
	${sco} root:root /

	${scm} 0777 /tmp
	#${scm} o+t /tmp
	${sco} root:root /tmp

	#ch-jutut siltä varalta että tar tjsp sössii oikeudet tai omistajat
	${sco} root:root /home
	${scm} 0755 /home

	if [ y"${1}" != "y" ] ; then
		dqb "${sco} -R ${1}:${1} ~"
		${sco} -R ${1}:${1} ~
		csleep 5
	fi

	local f
	${scm} 0755 ~/Desktop/minimize

	for f in $(find ~/Desktop/minimize -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ~/Desktop/minimize -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ~/Desktop/minimize -type f -name '*.sh') ; do ${scm} 0755 ${f} ; done
	for f in $(find ~/Desktop/minimize -name '*.deb' -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ~/Desktop/minimize -type f -name 'conf*') ; do ${scm} 0444 ${f} ; done

	f=$(date +%F)
	dqb "F1ND D0N3"
	csleep 1

	${scm} 0555 ~/Desktop/minimize/changedns.sh
	${sco} root:root ~/Desktop/minimize/changedns.sh

	#TODO:{old,new} -> {0,1} ?
	[ -f /etc/resolv.conf.${f} ] || ${spc} /etc/resolv.conf /etc/resolv.conf.${f}
	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}

	#HUOM.120525:näitäkin voi kasautua liikaa?
	[ -f /etc/network/interfaces.${f} ] || ${spc} /etc/network/interfaces /etc/network/interfaces.${f}

	#TODO:{old,new} -> {0,1}
	if [ -s /etc/resolv.conf.new ] && [ -s /etc/resolv.conf.OLD ] ; then
		${smr} /etc/resolv.conf
	fi

	#TODO:{old,new} -> {0,1}
	[ -s /sbin/dclient-script.OLD ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.OLD
	jules

	#wpasupplicant:in kanssa myös jotain säätöä, esim tällaista
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	#VAIH:/e/d/grub-kikkailut tähän ? vai enemmän toisen projektin juttuja
}

function part1_5() {
if [ z"${pkgsrc}" != "z" ] ; then
if [ -d ~/Desktop/minimize/${1} ] ; then
if [ ! -s /etc/apt/sources.list.${1} ] ; then
local g
local h

g=$(date +%F)
dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"

csleep 2
[ -f /etc/apt/sources.list ] && ${svm} /etc/apt/sources.list /etc/apt/sources.list.${g}

h=$(mktemp -d)
touch ${h}/sources.list.${1}

for x in ${1} ${1}-updates ${1}-security ; do
echo "deb https://${pkgsrc}/merged ${x} main" >> ${h}/sources.list.${1}
done

${svm} ${h}/sources.list.${1} /etc/apt/
${slinky} /etc/apt/sources.list.${1} /etc/apt/sources.list
[ ${debug} -eq 1 ] && cat /etc/apt/sources.list
csleep 2
fi
fi
fi

${sco} -R root:root /etc/apt
#tarkempaa sertiä tulisi findin kanssa
${scm} -R a-w /etc/apt/
}

#HUOM.13525:pitäisikö tämän toiminta varmistaa?
function part1() {
	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
	#jatkossa tähän ne tzdata- ja /e/d/locales-jutut?
	#jos jokin näistä kolmesta hoitaisi homman...

	${sifd} ${iface}
	${sifd} -a
	[ ${debug} -eq 1 ] && /sbin/ifconfig;sleep 4

	dqb "${sip} link set ${iface} down"
	${sip} link set ${iface} down
	
	[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	csleep 1
	
	${odio} sysctl -p #/etc/sysctl.conf

if [ y"${ipt}" == "y" ] ; then
	echo "5H0ULD-1N\$TALL-1PTABL35!!!"
else
	for t in INPUT OUTPUT FORWARD ; do
		${ipt} -P ${t} DROP
		dqb "V6"; csleep 2

		${ip6t} -P ${t} DROP
		${ip6t} -F ${t}
	done

	for t in INPUT OUTPUT FORWARD b c e f ; do ${ipt} -F ${t} ; done

	if [ ${debug} -eq 1 ] ; then
		${ipt} -L #
		dqb "V6.b"; csleep 2
		${ip6t} -L # -x mukaan?
		sleep 5
	fi
fi

part1_5 ${1}
${sco} -R root:root /etc/apt
${scm} -R a-w /etc/apt/
dqb "FOUR-LEGGED WHORE (i have Tourettes)"
}

PART175_LIST="avahi bluetooth cups exim4 nfs network-manager ntp mdadm sane rpcbind lm-sensors dnsmasq stubby"

#VAIH:p175 ja p2 uudet versiot mitkä käyttävät em. listaa
#function part176() {
#	dqb "PART176()"
#	csleep 2
#
#	local s
#	local t
#
#	#VAIH:s listaksi konftdstoon ja sitten sammuttelu+poisto yhdess läjässä tjsp?
#	for s in ${PART175_LIST} ; do
#		for t in $(find /etc/init.d -name '${s}*') ; do
#			echo "${odio} /etc/init.d/${} stop"
#			sleep 1
#		done
#	done
#
#	#TODO:whack-jutut vielä varm vuoksi
#
#	${snt} -tulpan
#	csleep 3
#}
#function part2_5() {
#	debug=1
#	dqb "PART2 ${1}"
#	csleep 2
#
#	if [ ${1} -eq 1 ] ; then
#		for s in ${PART175_LIST} ; do
#			${sharpy} ${s}*
#		done
#		#TODO:jälkisiivous
#		#TODO:wlan
#	fi
#
#	#TODO:jules-rules-tulpan
#}

function part175() {
	dqb "PART175()"
	csleep 2

	#VAIH:s listaksi konftdstoon ja sitten sammuttelu+poisto yhdess läjässä tjsp?
	for s in avahi-daemon bluetooth cups cups-browsed exim4 nfs-common network-manager ntp mdadm saned rpcbind lm-sensors dnsmasq stubby ; do
		${odio} /etc/init.d/${s} stop
		sleep 1
	done

	dqb "shutting down some services (4 real) in 3 secs"
	sleep 2

	${whack} cups*
	${whack} avahi*
	${whack} dnsmasq*
	${whack} stubby*
	${whack} nm-applet
	csleep 3

	${snt} -tulpan
	csleep 3
}

function el_loco() {
	dqb "MI LOCO"
	csleep 3
	#TODO:pitäisi kai varmistaa että lokaalit on luotu ennenq ottaa käyttöön, locale-gen...

	#ennen vai jälkeen "dpkg reconfig"-blokin tämä?
	if [ -s /etc/default/locale.tmp ] ; then
		. /etc/default/locale.tmp
		export LC_TIME
		export LANGUAGE
		export LC_ALL
	fi

	#joskohan tarkistus pois jatkossa?
	if [ ${1} -gt 0 ] ; then #HUOM.9525: /e/d/l kopsailu ei välttämättä riitä, josko /e/timezone mukaan kanssa?
		#client-side session_expiration_checks can be a PITA
		${odio} dpkg-reconfigure locales
		${odio} dpkg-reconfigure tzdata
		${scm} a+w /etc/default/locale
		csleep 3

		${odio} cat /etc/default/locale.tmp >> /etc/default/locale
		cat /etc/default/locale
		csleep 3

		cat /etc/timezone
		csleep 3

		${scm} a-w /etc/default/locale
		ls -las /etc/default/lo*
		csleep 3
	fi

	dqb "DN03"
	csleep 2
}

function part2() {
	debug=1
	dqb "PART2 ${1}"
	csleep 2

	if [ ${1} -eq 1 ] ; then
		dqb "PART2-2"
		csleep 5
		${sharpy} network*
		${sharpy} libblu* libcupsfilters* libgphoto* 

		${sharpy} avahi* blu* cups*
		${sharpy} exim*
		${lftr}
		csleep 3

		case ${iface} in
			wlan0)
				dqb "NOT REMOVING WPASUPPLICANT"
				csleep 3
			;;
			*)
				${sharpy} modem* wireless* wpa*
				${sharpy} iw lm-sensors
			;;
		esac

		${sharpy} ntp*
		${lftr}
		csleep 3
		${sharpy} po* pkexec
		${lftr}
		csleep 3
	fi

	dqb "PART2-3"
	csleep 3

	#HUOM.12525:riittäisikö tämä vai myös part3 jälkeen?
	if [ y"${ipt}" != "y" ] ; then
		jules
		${ip6tr} /etc/iptables/rules.v6
		${iptr} /etc/iptables/rules.v4
	fi

	csleep 5
	${lftr}
	csleep 3

	if [ ${debug} -eq 1 ] ; then
		${snt} -tulpan
		sleep 5
	fi

	dqb "PART2 D0N3"
	csleep 5
}

function part3() {
	dqb "part3( ${1} )"
	csleep 1

	[ y"${1}" == "y" ] && exit 1 #mikähän tässäkin on?
	dqb "11"
	csleep 1
	[ -d ${1} ] || exit 2

	#HUOM.230325: jospa ei tässä varmistella sdi:n kanssa, tulee vain nalkutusta
	#sitäpaItsi check_binaries() : in pitäisi hoitaa asia
	dqb "22"
	csleep 1
	psqa ${1}

	#HUOM. dpkg -R olisi myös keksitty
	local f
	for f in $(find ${1} -name 'lib*.deb') ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
		dqb "part3.1 ok"
		csleep 3
		${NKVD} ${1}/lib*.deb
	else
		exit 66
	fi

	for f in $(find ${1} -name '*.deb') ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
		dqb "part3.2 ok"
		csleep 3
		${NKVD} ${1}/*.deb
	else
		exit 67
	fi

	csleep 2
}

function init() {
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
	PREFIX=~/Desktop/minimize #SDAATANAN TUNARI(T)
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
	NKVD=$(${odio} which shred)
	NKVD="${NKVD} -fu "
	PART175_LIST="avahi bluetooth cups exim4 nfs network ntp mdadm sane rpcbind lm-sensors dnsmasq stubby"
}

init

#HUOM.22525:josko nyt 0750 voisi mennä läpi kun taviksena ajellaan
#https://stackoverflow.com/questions/49602024/testing-if-the-directory-of-a-file-is-writable-in-bash-script ei egkä ihan
#https://unix.stackexchange.com/questions/220912/checking-that-user-dotfiles-are-not-group-or-world-writeable josko tämä
#jos nyt olisi tarpeeksi jyrkkää

function init2 {
	local c
	local d
	d=0

	dqb "common_lib.INIT.2"
	csleep 6

	c=$(find /etc -name 'iptab*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 111
	c=$(find /etc -name 'iptab*' -type d -not -user 0 | wc -l)
	[ ${c} -gt 0 ] && exit 112
	c=$(find /etc -name 'iptab*' -type d -not -group 0 | wc -l)
	[ ${c} -gt 0 ] && exit 113
	c=$(find /etc -name 'rules.v*' -type f -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 114
	c=$(find /etc -name 'rules.v*' -type f -not -user 0 | wc -l)
	[ ${c} -gt 0 ] && exit 115
	c=$(find /etc -name 'rules.v*' -type f -not -group 0 | wc -l)
	[ ${c} -gt 0 ] && exit 116
	 
	c=$(find /etc -name 'sudoers*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 117
	c=$(find /etc -name 'sudoers*' -type d -not -user 0 | wc -l)
	[ ${c} -gt 0 ] && exit 118
	c=$(find /etc -name 'sudoers*' -type d -not -group 0 | wc -l)
	[ ${c} -gt 0 ] && exit 119
	c=$(find /etc/sudoers.d -type f -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 120
	c=$(find /etc/sudoers.d -type f -not -user 0 | wc -l)
	[ ${c} -gt 0 ] && exit 121
	c=$(find /etc/sudoers.d -type f -not -group 0 | wc -l)
	[ ${c} -gt 0 ] && exit 122

	csleep 4
}

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

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

	#dqb "POT. DANGEROUS PT 2"
	#HUOM.250325:onkohan tarkoitus että nämä komennot laittavat sudon epäkuntoon vai ei?
	#${sco} 0:0 /usr/bin/sudo* #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!
	#${scm} -R a-w /usr/bin/sudo* #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!
	#${scm} 4555 ./usr/bin/sudo #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!

	[ ${debug} -eq 1 ] && ls -las /usr/bin/sudo*
	csleep 3
	dqb "fix_sud0.d0n3"
}

function other_horrors() {	
	dqb "other_horrors()"
	${spc} /etc/default/rules.* /etc/iptables
	echo $?	

	${scm} 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	${sco} -R root:root /etc/iptables
	${scm} 0400 /etc/default/rules*
	${sco} -R root:root /etc/default

	dqb "other_horrors() DONE"
	csleep 10
}

#HUOM.21525:menee päällekkäin e_ - juttujen toiminnallsiuuden kanssa nmä 2 , voisi yhdistää
fix_sudo
other_horrors

#HUOM.21525.2:tarkistuksia yksinkertaisempi vain pakottaa oikeudet ja omistajat jokatap 
if [ ! -v loose ] ; then
	init2
fi

[ ${debug} -eq 1 ] && ${odio} ls -las /etc/iptables
csleep 5

#EI SITTEN PERKELE ALETA KIKKAILLA /ETC/IPTABLES/RULES KANSSA
#ESIM. PASKOJEN TIKKUJEN KANSSA TULEE TÄYSI SIRKUS 666
# (JA SITTEN ON NE OIKEUDETKIN MITKÄ VOIVAT OLLA PÄIN VITTUA)
#LISÄKSI PAKETTIIN VOI TULLA KAIKENLAISTA YLIMÄÄRÄISTÄ PASKAA SOTKEMAAN JOS EI OLE TARKKA
#... tai muut syyt
function jules() {
	#HUOM.21525:tällaisella sisällöllä fktio turhahko koska other_horrors
	dqb "LE BIG MAC"
	dqb "V8"
	csleep 4

	cp /etc/default/rules.* /etc/iptables
	#HUOM.linkityksen purku vaatisi kai w-oikeudet hmistoon
	[ -h /etc/iptables/rules.v4 ] && ${smr} /etc/iptables/rules.v4
	[ -L /etc/iptables/rules.v6 ] && ${smr} /etc/iptables/rules.v6 #mikä ero, L vs h ?

	${scm} 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	${sco} -R root:root /etc/iptables

	[ ${debug} -eq 1 ] && ${odio} ls -las /etc/iptables
	csleep 6
}

function message() {
	echo "INSTALLING NEW PACKAGES IN 10 SECS"
	csleep 3
	echo "DO NOT ANSWER \"Yes\" TO QUESTIONS ABOUT IPTABLES";sleep 2
	echo "... FOR POSITIVE ANSWER MAY BREAK THINGS";sleep 3
}

function ocs() {
	local tmp
	tmp=$(${odio} which ${1})

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

		#HUOM.15525:pitäisiköhän reagoida tilanteeseen että asennettavia pak ei ole?
		${sah6} -c sha512sums.txt --ignore-missing
		[ $? -eq 0 ] || exit 94
		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
	fi

	csleep 3
}

function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135(${1} )"
	csleep 1

	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)

	if [ -x ${PREFIX}/tar-wrapper.sh ] ; then 
		dqb "TODO: tar-wrapper.sh"
	else
		srat=$(${odio} which tar)
		
		if [ ${debug} -eq 1 ] ; then
			srat="${srat} -v "
		fi
	fi

	if [ y"${ipt}" == "y" ] ; then
		[ z"${1}" == "z" ] && exit 99
		dqb "-d ${PREFIX}/${1} existsts?"
		[ -d ${PREFIX}/${1} ] || exit 101

		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		jules

		if [ -s ${PREFIX}/${1}/e.tar ] ; then
			${odio} ${srat} -C / -xf ${PREFIX}/${1}/e.tar
			${odio} ${NKVD} ${PREFIX}/${1}/e.tar  #jompikumpi hoitaa
			${odio} ${smr} ${PREFIX}/${1}/e.tar
		fi

		#HUOM.21525:olisikohan niin simppeli juttu että dpkg seuraa linkkiä ja nollaa tdston mihin linkki osoittaa?
		[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables ;sleep 6
		#csleep 3

		pre_part3 ${PREFIX}/${1} ${dnsm}
		pr4 ${PREFIX}/${1} ${dnsm}

		[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables ;sleep 6
		other_horrors

		ipt=$(${odio} which iptables)
		ip6t=$(${odio} which ip6tables)
		iptr=$(${odio} which iptables-restore)
		ip6tr=$(${odio} which ip6tables-restore)
	fi

	#jospa sanoisi ipv6.disable=1 isolinuxille ni ei tarttisi tässä säätää
	sifu=$(${odio} which ifup)
	sifd=$(${odio} which ifdown)

	CB_LIST1="/sbin/halt /sbin/reboot /usr/bin/which ${sifu} ${sifd} "
	dqb "second half of c_bin_1"
	csleep 3

	#HUOM.14525:listan 6 ekaa voi poistaa jos tulee ongelmia
	for x in iptables ip6tables iptables-restore ip6tables-restore ifup ifdown apt-get apt ip netstat dpkg tar mount umount dhclient sha512sum #kilinwittu.sh
		do ocs ${x}
	done
	
	sdi=$(${odio} which dpkg)
	sag=$(${odio} which apt-get)
	sa=$(${odio} which apt)
	sip=$(${odio} which ip)
	som=$(${odio} which mount)
	uom=$(${odio} which umount)

	dqb "b1nar135 0k"
	csleep 2
}

function check_binaries2() {
#	debug=1
	dqb "c0mm0n_lib.ch3ck_b1nar135.2()"
	csleep 1

	ipt="${odio} ${ipt} "
	ip6t="${odio} ${ip6t} "
	iptr="${odio} ${iptr} "
	ip6tr="${odio} ${ip6tr} "

	sharpy="${odio} ${sag} remove --purge --yes "
	spd="${odio} ${sdi} -l " #käytössä?
	sdi="${odio} ${sdi} -i "

	#HUOM. ${sag} VIIMEISENÄ
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "
	sip="${odio} ${sip} "
	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "
	smr="${odio} ${smr} "
	lftr="${smr} -rf /run/live/medium/live/initrd.img* "
	NKVD="${odio} ${NKVD} "
	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	
	#HUOM. ei alustetttu tämmöstä dch="${odio} ${dch}"
	dqb "b1nar135.2 0k.2" 
	csleep 1
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
	dqb "1N F3NR0 0F SACR3D D35TRUCT10N"
	mangle_s ${PREFIX}/changedns.sh ${q}/meshuggah
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
		chmod 0440 ${q}/meshuggah #scm

		${sco} root:root ${q}/meshuggah
		${svm} ${q}/meshuggah /etc/sudoers.d

		CB_LIST1=""
		unset CB_LIST1
		#saavuttaakohan tuolla nollauksella mitään? kuitenkin alustetaan
	fi

	local c4
	c4=$(grep -c ${part0} /etc/fstab)

	if [ ${c4} -lt 1 ] ; then
		${scm} a+w /etc/fstab
		${odio} echo "/dev/disk/by-uuid/${part0} ${dir} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		${scm} a-w /etc/fstab
	fi

	csleep 3
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

	dqb "e_e d0n3"
	csleep 1
}

function e_v() {
	dqb "e_v()"
	csleep 1

	${sco} -R root:root /sbin
	${scm} -R 0755 /sbin

	${sco} root:root /var
	${scm} 0755 /var
	${sco} root:staff /var/local
	${sco} root:mail /var/mail
	${sco} -R man:man /var/cache/man
	${scm} -R 0755 /var/cache/man

	dqb "VAN DAMME"
	csleep 1
}

function e_h() {
	dqb "e_h( ${1} )"
	csleep 1

	${sco} root:root /home
	${scm} 0755 /home

	if [ y"${1}" != "y" ] ; then
		dqb "${sco} -R ${1}:${1} ~"
		${sco} -R ${1}:${1} ~
		csleep 5
	fi

	local f
	${scm} 0755 ${PREFIX}

	for f in $(find ${PREFIX} -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ${PREFIX} -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${PREFIX} -type f -name '*.sh') ; do ${scm} 0755 ${f} ; done
	for f in $(find ${PREFIX} -name '*.deb' -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${PREFIX} -type f -name 'conf*') ; do ${scm} 0444 ${f} ; done

	dqb "F1ND D0N3"
	csleep 1

	${scm} 0555 ${PREFIX}/changedns.sh
	${sco} root:root ${PREFIX}/changedns.sh

	dqb "e_h()"
	csleep 1
}

function e_final() {
	dqb "e_final()"
	csleep 1
	local f
	f=$(date +%F)

	#HUOM.15525:interfaces kanssa kikkaiut kuten rules, tartteeko niihin liittyen tehdä tässä jotain?
	[ -f /etc/resolv.conf.${f} ] || ${spc} /etc/resolv.conf /etc/resolv.conf.${f}
	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}

	#HUOM.120525:näitäkin voi kasautua liikaa?
	#HUOM.22525:pitäisiköjän olla: a) spc -> svm b) linkitys ?
	[ -f /etc/network/interfaces.${f} ] || ${spc} /etc/network/interfaces /etc/network/interfaces.${f}

	if [ -h /etc/resolv.conf ] ; then
		if [ -s /etc/resolv.conf.0 ] && [ -s /etc/resolv.conf.1 ] ; then
			${smr} /etc/resolv.conf
		fi
	fi

	#wpasupplicant:in kanssa myös jotain säätöä, esim tällaista
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	dqb "e_final() D0N3"
	csleep 1
}

function enforce_access() {
	dqb " enforce_access( ${1})"
	csleep 1
	dqb "changing /sbin , /etc and /var 4 real"

	e_e
	e_v

	${scm} 0755 /
	${sco} root:root /

	${scm} 0777 /tmp
	#${scm} o+t /tmp
	${sco} root:root /tmp

	#ch-jutut siltä varalta että tar tjsp sössii oikeudet tai omistajat
	e_h ${1}
	e_final

	jules
	[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables;sleep 6
	#VAIH:/e/d/grub-kikkailut tähän ? vai enemmän toisen projektin juttuja
}

#TODO:voisi kai toisellakin tavalla sen sources.list sorkkia, sed edelleen optio pienellä säädöllä
function part1_5() {
	if [ z"${pkgsrc}" != "z" ] ; then
		if [ -d ${PREFIX}/${1} ] ; then
			if [ ! -s /etc/apt/sources.list.${1} ] ; then
				#HUOM. mitä jos onkin s.list.$1 olemassa mutta s.list pitäisi vaihtaa?
				
				local h
				dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"
				csleep 2

				h=$(mktemp -d)
				touch ${h}/sources.list.${1}

				for x in ${1} ${1}-updates ${1}-security ; do
					echo "deb https://${pkgsrc}/merged ${x} main" >> ${h}/sources.list.${1}
				done

				${svm} ${h}/sources.list.${1} /etc/apt/
			fi
		fi
	fi

	${sco} -R root:root /etc/apt
	#tarkempaa sertiä tulisi findin kanssa
	${scm} -R a-w /etc/apt/
}

function part1() {
	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
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
			csleep 5
		fi
	fi

	#HUOM.20525:jatqssa blokki part1_5:teen?
	local c
	local g
	g=$(date +%F)

	#HUOM.20525:onkohan ao. ehto ok?
	if [ -f /etc/apt/sources.list ] ; then
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:'  | wc -l)

		if [ ${c} -gt 0 ] ; then 
			${svm} /etc/apt/sources.list /etc/apt/sources.list.${g}
			csleep 5
		fi
	fi

	#nyt varmaankin joutuu linkitysjutut kopsailemaan muuallekin vai joutuuko?
	part1_5 ${1}

	if [ ! -f /etc/apt/sources.list ] ; then
		if [ -s /etc/apt/sources.list.${1} ] && [ -r /etc/apt/sources.list.${1} ] ; then
			${slinky} /etc/apt/sources.list.${1} /etc/apt/sources.list
		fi	
	fi

	[ ${debug} -eq 1 ] && cat /etc/apt/sources.list
	csleep 2

	${sco} -R root:root /etc/apt
	${scm} -R a-w /etc/apt/
	dqb "FOUR-LEGGED WHORE (i have Tourettes)"
}

function part076() {
	dqb "PART076()"
	csleep 2
	local s
	local t

	for s in ${PART175_LIST} ; do
		dqb ${s}

		for t in $(find /etc/init.d -name ${s}*) ; do
			${odio} ${t} stop
			csleep 1
		done

		${whack} ${s}* #oli pgrep aiemmin
	done

	dqb "alm0st d0n3"
	csleep 2

	${whack} nm-applet
	${snt} #ei välttis toimi jos ennen check_bin kutsutaan

	dqb "P.176 DONE"
	csleep 3
}

function part2_5() {
	#debug=1
	dqb "PART2.5 ${1}"
	csleep 2

	if [ ${1} -eq 1 ] ; then
		for s in ${PART175_LIST} ; do
			dqb "processing ${s}"
			csleep 1

			${sharpy} ${s}*
			csleep 1
		done

		${sharpy} libblu* libcupsfilters* libgphoto* #tartteeko vielä?
		${sharpy} blu*
		${sharpy} po* pkexec
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
	fi

	csleep 2

	if [ y"${ipt}" != "y" ] ; then
		jules

		if [ -s /etc/iptables/rules.v6.${dnsm} ] ; then
			${ip6tr} /etc/iptables/rules.v6.${dnsm}
		fi

		if [ -s /etc/iptables/rules.v4.${dnsm} ] ; then
			${iptr} /etc/iptables/rules.v4.${dnsm}
		fi
	fi

	if [ ${debug} -eq 1 ] ; then
		${snt}
		sleep 5
	fi

	csleep 1
	dqb "PART2.5 ${1} d0ne"
	csleep 2
}

function part3_4real() {
	dqb "part3_4real( ${1} )"
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
	dqb "part3_4real( ${1} ) DONE"
	csleep 1
}

function part3() {
	jules
	pre_part3 ${1} ${2}
	pr4 ${1} ${2}
	part3_4real ${1}
	other_horrors
}

#HUOM.voisi -v käsitellä jo tässä
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
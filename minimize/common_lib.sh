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
	PREFIX=~/Desktop/minimize #josko dirname:lla jatkossa?
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
	smr="${odio} ${smr} "
	NKVD=$(${odio} which shred)
	NKVD="${NKVD} -fu "
	NKVD="${odio} ${NKVD} "

	#PART175_LIST="avahi bluetooth cups exim4 nfs network ntp mdadm sane rpcbind lm-sensors dnsmasq stubby"
	PART175_LIST="avahi blue cups exim4 nfs network mdadm sane rpcbind lm-sensors dnsmasq stubby" # ntp" ntp jemmaan 28525

	sdi=$(${odio} which dpkg)
	spd="${odio} ${sdi} -l " #käytössä?
	sdi="${odio} ${sdi} -i "
	#jospa sanoisi ipv6.disable=1 isolinuxille ni ei tarttisi tässä säätää
	sifu=$(${odio} which ifup)
	sifd=$(${odio} which ifdown)
	sip=$(${odio} which ip)
	sip="${odio} ${sip} "
}

init

#https://stackoverflow.com/questions/49602024/testing-if-the-directory-of-a-file-is-writable-in-bash-script ei egkä ihan
#https://unix.stackexchange.com/questions/220912/checking-that-user-dotfiles-are-not-group-or-world-writeable josko tämä

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
	csleep 2
	dqb "fix_sud0.d0n3"
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
	csleep 2
}

fix_sudo
other_horrors

function jules() {
	dqb "LE BIG MAC"
	#dqb "V8" #josko kommentoituna takaisin se cp
	#${spc} /etc/default/rules.* /etc/iptables
	csleep 2

	other_horrors

	[ ${debug} -eq 1 ] && ${odio} ls -las /etc/iptables
	csleep 2
}

function message() {
	echo "INSTALLING NEW PACKAGES IN x SECS"
	sleep 1
	echo "DO NOT ANSWER \"Yes\" TO QUESTIONS ABOUT IPTABLES"
	sleep 1
	echo "... FOR POSITIVE ANSWER MAY BREAK THINGS"
	sleep 1
}

function ocs() {
	local tmp
	tmp=$(${odio} which ${1})

	if [ y"${tmp}" == "y" ] ; then
		dqb "${1} NOT FOUND"
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
		#sleep 2

		#HUOM.15525:pitäisiköhän reagoida tilanteeseen että asennettavia pak ei ole?
		${sah6} -c sha512sums.txt --ignore-missing
		[ $? -eq 0 ] || exit 94
		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
	fi

	csleep 1
}

function ppp3() {
	dqb "ppp3 ${1}"
	csleep 3

	local c
	local d

	c=$(find ${1} -type f -name '*.deb' | wc -l) #oli:ls -las ip*.deb
	d=$(echo ${1} | cut -d '/' -f 1-5)

	if [ ${c} -lt 1 ] ; then
		#HUOM.23525:kuuluisi varmaankin ohjeistaa kutsuvassa koodissa
		echo "SHOULD REMOVE ${1} /sha512sums.txt"
		echo "\"${scm} a-x ${1} /../common_lib.sh;import2 1 \$something\" MAY ALSO HELP"
		
		#pitäis ikai huomioida että scm voi aiheuttaa sivuvaikutuksia myöhemmin
		${scm} a-x ${d}/common_lib.sh 
		
		#exit 55 HUOM.24525:antaa olla kommenteissa toistaiseksi, ,esim. chimaeran tapauksessa ei välttis ole $distro:n alla .deb aluksi
		#... tosin alkutilanteessa tables pitäisi chimaerasta löytyä	
	fi
}

function efk() {
	${sdi} ${1} #$@ pikemminkin
	[ $? -eq 0 ] && ${smr} ${1}
}

#tähän tablesin asentelu jatkossa?
function common_tbls() {
	dqb "COMMON TABLESD"
	csleep 3

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	[ -z ${2} ] && exit

	local d2
	d2=$(echo ${2} | tr -d -c 0-9)

	dqb "PARAMS_OK"
	csleep 1
	psqa ${1}

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/libip*.deb

	${odio} dpkg -i ${1}/libxtables12_1.8.9-2_amd64.deb 
	[ $? -eq 0 ] && ${NKVD} ${1}/libxtables12_1.8.9-2_amd64.deb 
	csleep 1

	${odio} dpkg -i ${1}/libnftnl*.deb 
	[ $? -eq 0 ] && ${NKVD} ${1}/libnftnl*.deb
	csleep 1

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables_*.deb
	
	csleep 3
	${scm} 0755 /etc/iptables

	${odio} update-alternatives --set iptables /usr/sbin/iptables-legacy
	${odio} update-alternatives --set iptables-restore /usr/sbin/iptables-legacy-restore	
	
	local s
	local t

	s=$(${odio} which iptables-restore)
	t=$(${odio} which ip6tables-restore)

	${odio} ${s} /etc/iptables/rules.v4.${d2}
	${odio} ${t} /etc/iptables/rules.v6.${d2}
	csleep 5

	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/netfilter-persistent*.deb

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=iptables-persistent=1.0.20
	${odio} DEBIAN_FRONTEND=noninteractive dpkg --force-confold -i ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} -f ${1}/iptables-*.deb

	csleep 1
	${scm} 0550 /etc/iptables	

	dqb "common_tblz d0n3"
	csleep 1
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
		dqb "-d ${1} existsts?"
		[ -d ${1} ] || exit 101

		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		jules

		if [ -s ${1}/e.tar ] ; then
			${odio} ${srat} -C / -xf ${1}/e.tar
			${NKVD} ${1}/e.tar  #jompikumpi hoitaa
			${smr} ${1}/e.tar
		fi

		#HUOM.21525:olisikohan niin simppeli juttu että dpkg seuraa linkkiä ja nollaa tdston mihin linkki osoittaa?
		#[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables ;sleep 3

		#common_tbls korvaamaan
		ppp3 ${1}
		#pre_part3
		common_tbls ${1} ${dnsm}
		pr4 ${1}

		#[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables ;sleep 3
		other_horrors

		ipt=$(${odio} which iptables)
		ip6t=$(${odio} which ip6tables)
		iptr=$(${odio} which iptables-restore)
		ip6tr=$(${odio} which ip6tables-restore)
	fi

	#xcalibur-testien älk muutox (halt ja reboot silleen niinqu turhia jos eivät toimi)
	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd} "
	dqb "second half of c_bin_1"
	csleep 1

	#HUOM.14525:listan 6 ekaa voi poistaa jos tulee ongelmia
	#HUOM.25525:dhclient siirretty tilapäisesti ulos listasta excalibur-testien vuoksi, ehkä josqs takaisin
	for x in iptables ip6tables iptables-restore ip6tables-restore ifup ifdown apt-get apt ip netstat dpkg tar mount umount sha512sum # dhclient kilinwittu.sh
		do ocs ${x}
	done
	
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
	
	lftr="${smr} -rf /run/live/medium/live/initrd.img* "
	
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
	dqb "mangle_s ( ${1} , ${2}, ${3} ) " #kaarisulkeet edelleen perseestä
	csleep 1

	[ y"${1}" == "y" ] && exit 44
	[ -x ${1} ] || exit 55

	#HUOM.26525:pitäisiköhän olla jotain lisätarkistuksia $2 ja $3 kanssa?
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

#HUOM.29525:ei tarvitse parametreja tämä
function pre_enforce() {
	dqb "common_lib.pre_enforce()"
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
	mangle_s ${PREFIX}/changedns.sh ${q}/meshuggah
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
	${scm} 0555 /etc/network
	${scm} 0444 /etc/network/*
	${sco} root:root /etc/network #turha koska ylempänä

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

	dqb "V1C.V0N.D00m"
	csleep 1
}

function e_h() {
	debug=1
	dqb "e_h( ${1} , ${2} )"
	csleep 5

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
	csleep 2
	${scm} 0755 ${2}

	for f in $(find ${2} -type d) ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${2} -type f -name '*.sh') ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -name '*.deb' -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${2} -type f -name 'conf*') ; do ${scm} 0444 ${f} ; done

	dqb "F1ND D0N3"
	csleep 1

	${scm} 0555 ${2}/changedns.sh
	${sco} root:root ${2}/changedns.sh

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

	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant

	dqb "e_final() D0N3"
	csleep 1
}

function enforce_access() {
	dqb " enforce_access( ${1} , ${2})"
	csleep 10
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
	[ $debug -eq 1 ] && ${odio} ls -las /etc/iptables;sleep 3
	#VAIH:/e/d/grub-kikkailut tähän ? vai enemmän toisen projektin juttuja
}

#HUOM.25525:cut ao fktioon tai kutsUvaan koodiin koska xcalibur/ceres
#tavoitetila dokumentoituna: https://www.devuan.org/os/packages
#myös https://github.com/topics/sources-list

#debian.ethz.ch voisi jotenkin huomioida?
function part1_5() {
	dqb "part1_5( ${1} )"
	csleep 1
	local t

	#HUOM.28525:pitäisiköhän tilap. sallia /e/a sorkinta tässä?
	t=$(echo ${1} | cut -d '/' -f 1) #jos tämä riittäisi toistaiseksi

	if [ ! -s /etc/apt/sources.list.${t} ] ; then
		if [ ! -s /etc/apt/sources.list.tmp ] ; then	
			local h
			dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"
			csleep 1

			h=$(mktemp -d)
			touch ${h}/sources.list.tmp

			for x in DISTRO DISTRO-updates DISTRO-security ; do
				echo "deb https://REPOSITORY/merged ${x} main" >> ${h}/sources.list.tmp
			done

			${svm} ${h}/sources.list.tmp /etc/apt
		fi

		dqb "p1.5.2()"
		csleep 1

		#HUOM.22525:vaikuttaisi jopa toimivan, seur forWardointi sh:lle
		local tdmc
	
		tdmc="sed -i 's/DISTRO/${t}/g'"
		echo "${odio} ${tdmc} /etc/apt/sources.list.tmp" | bash -s
		csleep 1

		if [ ! -z ${pkgsrc} ] ; then
			tdmc="sed -i 's/REPOSITORY/${pkgsrc}/g'"
			echo "${odio} ${tdmc} /etc/apt/sources.list.tmp" | bash -s
			csleep 1
		fi
	
		echo "${odio} mv /etc/apt/sources.list.tmp /etc/apt/sources.list.${t}" | bash -s
		csleep 1

		dqb "finally"
		csleep 1
	fi

	${sco} -R root:root /etc/apt
	#tarkempaa sertiä tulisi findin kanssa
	${scm} -R a-w /etc/apt/

	[ ${debug} -eq 1 ] && ls -las /etc/apt
	csleep 3

	dqb "p1.5 done"
	csleep 1
}

#oli aiemmin osa part1:stä
function dis() {
	dqb "CHAMBERS OF DIS( ${1} ) "
	[ -z ${1} ] && exit 44
	csleep 1
	
	${scm} 0755 /etc/network
	${sco} -R root:root /etc/network
	${scm} a+r /etc/network/*

	#linkkien nimiin ei tarvitse päiväystä
	if [ -f /etc/network/interfaces ] ; then
		if [ ! -h /etc/network/interfaces ] ; then
			${svm} /etc/network/interfaces /etc/network/interfaces.$(date +%F)
		else
			#${smr} /etc/network/interfaces
			dqb " /e/n/i n0t a l1nk"
		fi
	else
		dqb "/e/n/i n0t f0und"
	fi

	local t
	t=$(echo ${1} | cut -d '/' -f 1) #tr mukaan?

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
	csleep 2

	#jos jokin näistä kolmesta hoitaisi homman...
	#TEHTY:selvitä mikä kolmesta puolestaan rikkoo dbusin (eka ei, toinen kyllä, kolmas ei, sysctl ei)

	${odio} ${sifd} ${iface}
	csleep 1

#	${odio} ${sifd} -a
#	csleep 1
#
	[ ${debug} -eq 1 ] && ${sifc};sleep 2

	dqb "${sip} link set ${iface} down"
	${sip} link set ${iface} down
	[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	csleep 1
	
	${odio} sysctl -p #/etc/sysctl.conf
	csleep 1
	dqb "DONE"
}

#HUOM.29525:ntp sammutetaan nyt lib.pre_part2-reittiä koska excalibur
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

function part1() {
	dqb "PART1( ${1} )"
	csleep 3

	dqb "man date;man hwclock; sudo date --set | sudo hwclock --set --date if necessary"
	csleep 1

	if [ y"${ipt}" == "y" ] ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		for t in INPUT OUTPUT FORWARD ; do
			${ipt} -P ${t} DROP
			dqb "V6"; csleep 1

			${ip6t} -P ${t} DROP
			${ip6t} -F ${t}
		done

		for t in INPUT OUTPUT FORWARD b c e f ; do ${ipt} -F ${t} ; done
	
		if [ ${debug} -eq 1 ] ; then
			${ipt} -L #
			dqb "V6.b"; csleep 1
			${ip6t} -L # -x mukaan?
			csleep 2
		fi
	fi

	local c
	local g
	local t

	g=$(date +%F)
	t=$(echo ${1} | cut -d '/' -f 1) #tr va i ei?

	#HUOM.20525:onkohan ao. ehto ok?
	if [ -f /etc/apt/sources.list ] ; then
		c=$(grep -v '#' /etc/apt/sources.list | grep 'http:'  | wc -l)

		if [ ${c} -gt 0 ] ; then 
			${svm} /etc/apt/sources.list /etc/apt/sources.list.${g}
			csleep 2
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
	dqb "FOUR-LEGGED WHORE (i have Tourettes)"
}

function part2_5() {
	debug=1
	dqb "PART2.5.1 ${1} , ${2}"
	csleep 3

	if [ ${1} -eq 1 ] ; then
		dqb "HGHGUYFLIHLYGLUYROI"
		${lftr}
		${fib} #uutena 27525, xcalibur...
		csleep 3
		
		for s in ${PART175_LIST} ; do
			dqb "processing ${s}"
			#csleep 1

			${sharpy} ${s}*
			csleep 1
		done

		${lftr} #pitäisikö laittaa distro==chimaera taakse näiden takominen
		${sharpy} libblu* libcupsfilters* libgphoto* #tartteeko vielä?
		${lftr}

		${sharpy} pkexec po*
		${lftr}
		${sharpy} python3-cups
		${lftr}
		csleep 1

		case ${iface} in
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
	csleep 3

	${lftr}
	csleep 1

	if [ y"${ipt}" != "y" ] ; then
		jules

		#HUOM. saattaa toimia ilman .$2 koska tables-kikkailuja laitettu uusiksi 26525
		#HUOM.2. josko kuitenkin mankeloisi $2 (TODO)

		if [ -s /etc/iptables/rules.v6.${2} ] ; then
			${ip6tr} /etc/iptables/rules.v6.${2}
		fi

		if [ -s /etc/iptables/rules.v4.${2} ] ; then
			${iptr} /etc/iptables/rules.v4.${2}
		fi
	fi

	if [ ${debug} -eq 1 ] ; then
		${snt}
		sleep 2
	fi

	csleep 1
	dqb "PART2.5 d0ne"
	csleep 1
}

function part3_4real() {
	dqb "part3_4real( ${1} )"
	csleep 1

	[ y"${1}" == "y" ] && exit 1 #mikähän tässäkin on?
	dqb "11"
	csleep 1
	[ -d ${1} ] || exit 2

	dqb "22"
	csleep 1
	psqa ${1}

	#HUOM. dpkg -R olisi myös keksitty
	local f
	for f in $(find ${1} -name 'lib*.deb') ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
		dqb "part3.1 ok"
		csleep 1
		${NKVD} ${1}/lib*.deb
	else
		exit 66
	fi

	for f in $(find ${1} -name '*.deb') ; do ${sdi} ${f} ; done

	if [ $? -eq  0 ] ; then
		dqb "part3.2 ok"
		csleep 1
		${NKVD} ${1}/*.deb
	else
		exit 67
	fi

	[ -f ${1}/sha512sums.txt ] && ${NKVD} ${1}/sha512sums.txt
	csleep 1

	dqb "part3_4real( ${1} ) DONE"
	csleep 1
}

#HUOM.26525:alunperin tablesin asentamista varten, nykyään tehdään check_binaries() kautta sen asennus
function part3() {
	dqb "part3 ${1} ${2}"
	csleep 1
	jules
	ppp3 ${1}

	local d2
	d2=$(echo ${2} | tr -d -c 0-9)

	#pre_part3 ${1} ${d2}
	common_tbls ${1} ${d2}

	pr4 ${1}
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

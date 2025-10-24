function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

if [ -f /.chroot ] ; then
	odio=""
	debug=1

	function itni() {
		dqb "alt-itn1"
		sco=$(which chown)
		scm=$(which chmod)
	}

	#HUOM.141025:oikeastaan pitäisi tarkistaa ennen purkua
	for f in $(find $(pwd) -type f -name 'nekros?'.tar.bz3) ; do
		tar -jxvf ${f}
		sleep 1
		rm ${f}
		sleep 1
	done
else
	function itni() {
		odio=$(which sudo)
		[ y"${odio}" == "y" ] && exit 99 
		[ -x ${odio} ] || exit 100
		
		sco=$(sudo which chown)
		[ y"${sco}" == "y" ] && exit 98
		[ -x ${sco} ] || exit 97
		
		scm=$(sudo which chmod)
		[ y"${scm}" == "y" ] && exit 96
		[ -x ${scm} ] || exit 95
	}

	#https://stackoverflow.com/questions/49602024/testing-if-the-directory-of-a-file-is-writable-in-bash-script ei egkä ihan
	#https://unix.stackexchange.com/questions/220912/checking-that-user-dotfiles-are-not-group-or-world-writeable josko tämä
fi

itni

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

sco="${odio} ${sco} "
scm="${odio} ${scm} "	

#komentorivin parsetyukseen liittyviä juttujamyöskin olisi... esim?
#... ja jotain matskua voisi siirtää riippuvista skripteistä kirjastoon?
	
fix_sudo
other_horrors

#HUOM.0301025:oli jotain urputusta riviltä 161 ,josko jo kunnossa?
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

ocs sha512sum
#HUOM. ei tarvitse cb_listiin mutta muuten tarvitsee asettaa mahd aikaisin
sah6=$(${odio} which sha512sum)

ocs dpkg
sd0=$(${odio} which dpkg)
[ -v sd0 ] || exit 78
[ -z ${sd0} ] && exit 79

unset sdi #tekeeko tämä jotain? kyl , kts check_bin ,, "second half"
dqb "SFDSFDSFDSFDSFDSFDSFDSFDS"
csleep 3

ocs tar
unset sr0
sr0=$(${odio} which tar)
[ -v sr0 ] || exit 80
[ -z ${sr0} ] && exit 81 #sr0 bai sd0?

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

#HUOM.YRITÄ SINÄKIN SAATANAN SIMPANSSI JA VITUN PUOLIAPINA KÄSITTÄÄ ETTÄ EI NÄIN 666!!!
#sdi=$(${odio} which dpkg)
#spd="${odio} ${sdi} -l " #jäänyt turhaksi muuten mutta g_pt2
#sdi="${odio} ${sdi} -i "
csleep 6

sifu=$(${odio} which ifup)
sifd=$(${odio} which ifdown)
sip=$(${odio} which ip)
sip="${odio} ${sip} "

gg=$(${odio} which gpg)
gv=$(${odio} which gpgv)
gi=$(${odio} which genisoimage)
gmk=$(${odio} which grub-mkrescue)
xi=$(${odio} which xorriso)
smd=$(${odio} which mkdir)
sca=$(${odio} which chattr)
sca="${odio} ${sca}"
mkt="${odio} which mktemp"
tig=$(${odio} which git)
gg=$(${odio} which gpg)

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

	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		local p
		p=$(pwd)
		cd ${1}

		if [ -v SOME_CONFIG_OPT ] ; then	
			dpkg -V
			sleep 1
		fi

		#HUOM.15525:pitäisiköhän reagoida tilanteeseen että asennettavia pak ei ole?
		${sah6} -c sha512sums.txt --ignore-missing
		[ $? -eq 0 ] || exit 94

		#local gg
		#gg=$(${odio} which gpg)

		#https://www.gnupg.org/documentation/manuals/gnupg24/gpg.1.html
		#https://www.gnupg.org/documentation/manuals/gnupg24/gpgv.1.html
		
		#HUOM.ao.blokin testausta varten sitten "export2 e ..."
		if [ -x ${gg} ] && [ -v TARGET_Dkname1 ] && [ -v TARGET_Dkname2 ] ; then
			dqb "${gg} --verify ./sha512sums.sig "			
			csleep 3

			pwd
			csleep 3

			${gg} --verify ./sha512sums.sig
			csleep 3
		fi

		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
	fi

	csleep 1
}

function pre_part3_clib() {
	dqb "pre_part3_clib ${1}"
	csleep 1
	pwd

	dqb "find ${1} -type f -name \* .deb"
	csleep 3

	local q
	local r 

	q=$(find ${1} -type f -name '*.deb' | wc -l)
	r=$(echo ${1} | cut -d '/' -f 1-5)

	if [ ${q} -lt 1 ] ; then
		echo "SHOULD REMOVE ${1} /sha512sums.txt"
		echo "\"${scm} a-x ${1} /../common_lib.sh;import2 1 \$something\" MAY ALSO HELP"
		${scm} a-x ${r}/common_lib.sh 
		
		dqb "NO EXIT 55 HERE, CHIMAERA..."
	else
		psqa ${1}
	fi
}

function efk1() {
	dqb "efk1 $@"
	${sdi} $@

	if [ $? -eq 0 ] ; then
		${NKVD} $@
		dqb "ÖK"
	else
		dqb $?
	fi

	csleep 3
}

function efk2() {
	dqb "efk2 $"

	if [ -s ${1} ] && [ -r ${1} ] ; then
		${odio} ${sr0} -C ${2} -xf ${1}
	else
		dqb "WE NEED T0 TALK ABT ${1}"
	fi	

	csleep 1
}

#HUOM.171025:qseeko näissä jokin?
function clib5p() {
	dqb "clib5p( ${1}  , ${2}) "
	[ -d ${1} ] || exit 66
	[ -z "${2}" ] && exit 67
	[ -s ${1}/${2} ] || exit 69

	dqb "WILL START REJECTING PIGS NOW"
	csleep 1

	local p
	local q
	p=$(pwd)
	cd ${1}

	for q in $(grep -v '#' ${2}) ; do ${NKVD} ${q} ; done
	
	csleep 2
	cd ${p}
	dqb "REJECTNG DONE"
}

function clibpre() {
	dqb "clib5p.re( ${1}  , ${2}) "
	[ -d ${1} ] || exit 96
	[ -z "${2}" ] && exit 67
	[ -s ${1}/${2} ] || exit 69 #-r vielä?

	dqb "PARANMS OK"
	csleep 1

	dqb "#ASDFASDFASDF"
	efk1 ${1}/libc6*.deb ${1}/libgcc-s1*.deb ${1}/gcc*.deb
	csleep 4

	local p
	local q
	p=$(pwd)
	cd ${1}

	for q in $(grep -v '#' ${2}) ; do efk1 ${q} ; done
	
	csleep 2
	cd ${p}
	dqb "ERB1L A\$\$UCKfgh"
}


#HUOM.041025:chroot.ympäristössä tietenkin se ympäristömja sudotuksern yht ongelma, keksisikö jotain (KVG)
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

	csleep 3
	dqb "DNÖE"
}

#sillä toisella tyylillä tämä masentelu jatkossa? for ... in ... ?
function common_tbls() {
	dqb "COMMON TABLESD $1, $2"
	csleep 1

	[ y"${1}" == "y" ] && exit	
	[ -d ${1} ] || exit
	[ -z ${2} ] && exit

	local d2
	d2=$(echo ${2} | tr -d -c 0-9)

	dqb "PARAMS_OK"
	csleep 1
	psqa ${1}

	efk1 ${1}/libnfnet*.deb
	csleep 1

	efk1 ${1}/libnetfilter*.deb
	csleep 1

	fromtend ${1}/libip*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/libip*.deb

	efk1 ${1}/libxtables*.deb
	csleep 1

	efk1 ${1}/libnftnl*.deb 
	csleep 1

	#uutena 031925 tämä linbl
	efk1 ${1}/libnl-3-200*.deb
	csleep 3
	efk1 ${1}/libnl-route*.deb 
	csleep 3
	efk1 ${1}/libnl-*.deb 
	csleep 3

	fromtend ${1}/iptables_*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/iptables_*.deb
	
	csleep 1
	${scm} 0755 /etc/iptables

	${odio} update-alternatives --set iptables /usr/sbin/iptables-legacy
	${odio} update-alternatives --set iptables-restore /usr/sbin/iptables-legacy-restore	
	
	local s
	local t

	s=$(${odio} which iptables-restore)
	t=$(${odio} which ip6tables-restore)

	if [ ! -z ${d2} ] ; then
		${odio} ${s} /etc/iptables/rules.v4.${d2}
		${odio} ${t} /etc/iptables/rules.v6.${d2}
		csleep 1
	fi

	fromtend ${1}/netfilter-persistent*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/netfilter-persistent*.deb

	#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=iptables-persistent=1.0.20
	fromtend ${1}/iptables-*.deb
	[ $? -eq 0 ] && ${NKVD} ${1}/iptables-*.deb

	csleep 1
	${scm} 0550 /etc/iptables	

	echo "common_tblz d0n3"
	csleep 10
}

function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135 ${1} "
	csleep 1

	ipt=$(${odio} which iptables)
	ip6t=$(${odio} which ip6tables)
	iptr=$(${odio} which iptables-restore)
	ip6tr=$(${odio} which ip6tables-restore)
	
	local y
	y="ifup ifdown apt-get apt ip netstat ${sd0} ${sr0} mount umount sha512sum dhclient mkdir mktemp" # kilinwittu.sh	
	for x in ${y} ; do ocs ${x} ; done
	dqb "JUST BEFORE"
	csleep 4

	[ -v sr0 ] || exit 102
	[ -v ipt ] || exit 103
	[ -v smd ] || exit 104
	srat=${sr0}
		
	if [ ${debug} -eq 1 ] ; then
		srat="${srat} -v "
	fi
	
	sdi="${odio} ${sd0} -i "

	if [ -z "${ipt}" ] ; then
		[ -z ${1} ] && exit 99
		dqb "-d ${1} existsts?"
		[ -d ${1} ] || exit 101

		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		jules
		sleep 6

		efk2 ${1}/e.tar
		efk2 ${1}/f.tar ${1}

		pre_part3_clib ${1}
		[ -f /.chroot ] && message
		common_tbls ${1} ${dnsm}
		other_horrors

		ipt=$(${odio} which iptables)
		ip6t=$(${odio} which ip6tables)
		iptr=$(${odio} which iptables-restore)
		ip6tr=$(${odio} which ip6tables-restore)
	fi

	CB_LIST1="$(${odio} which halt) $(${odio} which reboot) /usr/bin/which ${sifu} ${sifd}"
	dqb "second half of c_bin_1"
	csleep 1

	[ -v sd0 ] || exit 66
 	[ -v sdi ] || exit 67
	[ -z ${sd0} ] && exit 68
	
	dqb "sd0= ${sd0} "
	dqb "sdi= ${sdi} "
	csleep 6

	for x in iptables ip6tables iptables-restore ip6tables-restore  ; do ocs ${x} ; done
	csleep 6
	
	sag=$(${odio} which apt-get)
	sa=$(${odio} which apt)
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

	#HUOM. ${sag} VIIMEISENÄ
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "
	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "

	lftr="echo # \${smr} -rf  / run / live / medium / live / initrd.img\* " 
	#aiemmin moinen lftr oli tarpeen koska ram uhkasi loppua kesken initrd:n päivittelyn johdosta
	#cp: error writing '/run/live/medium/live/initrd.img.new': No space left on device

	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes "
	fib="${odio} ${sa} --fix-broken install "
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	smd="${odio} ${smd}" #käyttöön
	dqb "b1nar135.2 0k.2" 
	csleep 1
}

function mangle_s() {
	dqb "mangle_s  ${1} , ${2}, ${3}  "
	csleep 1

	[ y"${1}" == "y" ] && exit 44
	[ -x ${1} ] || exit 55

	#HUOM.26525:pitäisiköhän olla jotain lisätarkistuksia $2 ja $3 kanssa?
	[ y"${2}" == "y" ] && exit 45
	[ -f ${2} ] || exit 54

	${scm} 0555 ${1}
	${sco} root:root ${1}

	echo -n "$(whoami)" | tr -dc a-zA-Z >> ${2}
	echo -n " localhost=NOPASSWD:" >> ${2}
	echo -n " sha256: " >> ${2}

	local p
	p=$(sha256sum ${1} | cut -d ' ' -f 1 | tr -dc a-f0-9)

	echo -n ${p} >> ${2}
	echo -n " " >> ${2}
	echo -n ${1} | tr -dc a-zA-Z0-9/. >> ${2}
	echo -e "\n" >> ${2}
}

#...toisaalta sen dhclient-kikkailun voisi palauttaa
function dinf() {
	local g

	for g in $(sha256sum /sbin/dhclient-script* | cut -d ' ' -f 1 | uniq) ; do
		dqb ${g}
	done
}

function pre_enforce() {
	dqb "common_lib.pre_enforce ${1} "

	local q
	local f

	[ -v mkt ] || exit 99
	q=$(mktemp -d) #sittenkin nöäin
	dqb "touch ${q}/meshuggah in 3 secs"

	csleep 1
	touch ${q}/meshuggah

	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 1
	[ -f ${q}/meshuggah ] || exit 33

	if [ ! -v testgris ] ; then
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

		${scm} 0555 /opt/bin/changedns.sh
		${sco} 0:0 /opt/bin/changedns.sh
		mangle_s /opt/bin/changedns.sh ${q}/meshuggah
		csleep 1
	else 
		if [ -v CB_LIST2 ] ; then
			echo "$(whoami) localhost=NOPASSWD: ${CB_LIST2} " >> ${q}/meshuggah
		fi
	fi

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
	fi

	local c4
	c4=0
	
	if [ -v dir ] ; then
		c4=$(grep ${dir} /etc/fstab | wc -l)
	else
		echo "NO SUCH THING AS \$dir"
		exit 99
	fi

	if [ ${c4} -lt 1 ] ; then
		dqb "MUTILAT31NG /E/F-STAB"
		csleep 5
		${scm} a+w /etc/fstab
		${odio} echo "/dev/disk/by-uuid/${part0} ${dir} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		${odio} echo "#/dev/disk/by-uuid/${part1} ${dir2} auto nosuid,noexec,noauto,user 0 2" >> /etc/fstab
		${scm} a-w /etc/fstab
	fi

	csleep 5
	dqb "common_lib.pre_enforce d0n3"
}

function mangle2() { #mikä tätä käyttää nykyään? pl e_fktiot siis...
	if [ -f ${1} ] ; then
		dqb "MANGLED ${1}"
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
	csleep 2
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
	for f in $(find ${2} -type f -name '*.sh') ; do ${scm} 0755 ${f} ; done
	for f in $(find ${2} -name '*.deb' -type f) ; do ${scm} 0444 ${f} ; done
	for f in $(find ${2} -type f -name 'conf*') ; do ${scm} 0444 ${f} ; done

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
	csleep 5
	${sco} -R root:root /etc/wpa_supplicant
	${scm} -R a-w /etc/wpa_supplicant
	dqb "e_final D0N3"
	csleep 1
}
 
#161025:olisiko tässä typoja? vai jossain aiemmin?
function enforce_access() {
	dqb " enforce_access ${1} , ${2}"
	csleep 5
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
	e_final ${iface}

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
		dqb "S3RV1CE F0R A VCANT C0FF§1N"
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
			${sco} ${n}:${n} ${h}/sources.list.tmp
			${scm} 0644 ${h}/sources.list.tmp
		fi

		dqb "p1.5.2"
		csleep 1
		local tdmc
	
		tdmc="sed -i 's/DISTRO/${t}/g'"
		echo "${tdmc} ${h}/sources.list.tmp" | bash -s
		csleep 1

		if [ ! -z ${pkgsrc} ] ; then #CONF_pkgsrc?
			tdmc="sed -i 's/REPOSITORY/${pkgsrc}/g'"
			echo "${tdmc} ${h}/sources.list.tmp" | bash -s
			csleep 1
		fi
	
		${svm} ${h}/sources.list.tmp /etc/apt/sources.list.${t}
		#turhaa kikkailua
		#echo "${odio} mv /etc/apt/sources.list.tmp /etc/apt" | bash -s
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
	[ -z ${1} ] && exit 44
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
	${odio} ${sifd} ${iface}
	csleep 1

#	${odio} ${sifd} -a
#	csleep 1
#
	[ ${debug} -eq 1 ] && ${sifc};sleep 1
	dqb "${sip} link set ${iface} down"
	${sip} link set ${iface} down
	[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	csleep 1
	${odio} sysctl -p
	csleep 1
	dqb "DONE"
}

function part076() {
	dqb "FART076 ${1}"
	csleep 1
	dis ${1}
	local s

	for s in ${PART175_LIST} ; do
		dqb ${s}

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

#161025:olisiko tässä typoja? vai jossain aiemmin?
function part2_5() {
	dqb "PART2.5.1 ${1} , ${2} , ${3}"
	csleep 1

	[ -z ${1} ] && exit 55
	[ -z ${2} ] && exit 56
	#[ -z ${3} ] && exit 57 tareellinen param suttenkään?

	dqb "PARS_OK"
	csleep 1

	if [ ${1} -eq 1 ] ; then
		dqb "pHGHGUYFLIHLYGLUYROI mglwafh..."
		${lftr}
		${fib}
		csleep 1
		
		for s in ${PART175_LIST} ; do
			dqb "processing ${s}"
			${sharpy} ${s}*
			csleep 1
		done

		${lftr}
		${sharpy} libblu* libcupsfilters* libgphoto*
		${lftr}
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
	dqb "part3 ${1} ${2}"
	csleep 1

	jules
	pre_part3_clib ${1}
	csleep 1

	#jatkossa jos jotenkin toisin?
	if [ ! -f /.chroot ] ; then
		clib5p ${1} reject_pkgs
	fi

	clibpre ${1} accept_pkgs_1
	clibpre ${1} accept_pkgs_2

	dqb "4RP DONE"
	csleep 3

#	efk1 ${1}/lib*.deb #HUOM.SAATANAN TONTTU EI SE NÄIN MENE 666
#	[ $? -eq 0 ] || echo "SHOULD exit 66"
#	csleep 1
#
#
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
	csleep 6
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
	other_horrors
}

function slaughter0() {
	local fn2
	local ts2
	fn2=$(echo $1 | awk '{print $1}') 
	ts2=$(sha512sum ${fn2})
	echo ${ts2} | awk '{print $1,$2}' >> ${2}
}

function gpo() {
	dqb "GPO"
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
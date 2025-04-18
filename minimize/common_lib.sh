#bash kutsuvaan skriptiin tulkiksi saattaa aiheuttaa vähemmän nalkutusta kuin sh

odio=$(which sudo)
[ y"${odio}" == "y" ] && exit 99 
[ -x ${odio} ] || exit 100

sco=$(sudo which chown)
[ y"${sco}" == "y" ] && exit 98
[ -x ${sco} ] || exit 97

scm=$(sudo which chmod)
[ y"${scm}" == "y" ] && exit 96
[ -x ${sco} ] || exit 95

sco="${odio} ${sco} "
scm="${odio} ${scm} "

#HUOM. ei tarvitse cb_listiin mutta muuten tarvitsee asettaa mahd aikaisin
sah6=$(which sha512sum)

#distro:n ja n_n alsustus vähitellen tähän ni ai tartte kutsuvissa skeipteissä...

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function fix_sudo() { #function-avainsanan puutteella merkitystä?
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

function mangle2() {
	if [ -f ${1} ] ; then
		dqb "MANGLED ${1}"
		${scm} o-rwx ${1}
		${sco} root:root ${1}
	fi
}

function gpo() {
	local prevopt
	local opt
	prevopt=""

	for opt in $@ ; do 
		parse_opts_1 ${opt}
		parse_opts_2 ${prevopt} ${opt}
		prevopt=opt
	done
}

#TODO:gpo jo käyttöön?

function mangle_s() {
	#dqb "mangle_s( ${1} ${2} ${3})"
	csleep 1

	[ y"${1}" == "y" ] && exit 44
	[ -x ${1} ] || exit 55
	[ y"${2}" == "y" ] && exit 43
	[ -f ${2} ] || exit 54
	#dqb "params_ok"

	${scm} 0555 ${1}
	#HUOM. miksi juuri 5? no six six six että suoritettavaan tdstoon ei tartte kirjoittaa
	${sco} root:root ${1}

	local s
	local n2

	if [ y"${3}" == "y" ] ; then #typo krjattu 310325
		n2=$(whoami)
	else
		n2=${3}
	fi

	s=$(sha256sum ${1})
	echo "${n2} localhost=NOPASSWD: sha256: ${s} " >> ${2}
}

function psqa() {
	dqb "QUASB (THE BURNING) ${1}"

	if [ -s ${1}/sha512sums.txt ] && [ -x ${sah6} ] ; then
		p=$(pwd)
		cd ${1}
		${sah6} -c sha512sums.txt --ignore-missing
		[ $? -eq 0 ] || exit 97

		dqb "sha-test passed"
		cd ${p}
	else
		dqb "NO SHA512SUMS CAN BE CHECK3D FOR R3AQS0N 0R AN0TH3R"
	fi

	csleep 3
}

#TODO:jos mahd ni Python-tyyppinen(?) idea käyttöön ao. fktioon, $cmd=eval_cmd("cmd") tai jopa $array["cmd"]=aval_cmd("cmd")
function check_binaries() {
	dqb "c0mm0n_lib.ch3ck_b1nar135(${1} )"
	dqb "sudo= ${odio} "
	csleep 1

	smr=$(sudo which rm)
	NKVD=$(sudo which shred)
	ipt=$(sudo which iptables)
	ip6t=$(sudo which ip6tables)
	iptr=$(sudo which iptables-restore)
	ip6tr=$(sudo which ip6tables-restore)

	if [ y"${ipt}" == "y" ] ; then
		[ z"${1}" == "z" ] && exit 99
		[ -d ~/Desktop/minimize/${1} ] || exit 100
		dqb "params_ok"
		csleep 1

		echo "SHOULD INSTALL IPTABLES"
		#HUOM.230435: pitäisiköhän jokin toinen tarkistus lisätä tähän?	
		#sha-tark löytyy jo, tarvitseeko muuta?
		
		#HUOM.310325:lisätäännyt vielä tbls-sääntöjen vkopiointi , varm vuoksi
		local f		
		f=$(date +%F)
		#sittenkin -s ?		
		[ -f /etc/iptables/rules.v4.${f}.0 ] || ${spc} /etc/iptables/rules.v4 /etc/iptables/rules.v4.${f}.0
		[ -f /etc/iptables/rules.v6.${f}.0 ] || ${spc} /etc/iptables/rules.v6 /etc/iptables/rules.v6.${f}.0
		#TODO:changedns vastaava kohta tarttisiko muuttaa? 

		psqa ~/Desktop/minimize/${1}	
		pre_part3 ~/Desktop/minimize/${1}
		pr4 ~/Desktop/minimize/${1}

		ipt=$(sudo which iptables)
		ip6t=$(sudo which ip6tables)
		iptr=$(sudo which iptables-restore)
		ip6tr=$(sudo which ip6tables-restore)
	fi

	[ -x ${ipt} ] || exit 5
	#jospa sanoisi ipv6.disable=1 isolinuxille ni ei tarttisi tässä säätää
	[ -x ${ip6t} ] || exit 5
	[ -x ${iptr} ] || exit 5
	[ -x ${ip6tr} ] || exit 5

	sco=$(sudo which chown)
	scm=$(sudo which chmod)
	whack=$(sudo which pkill)
	sifu=$(sudo which ifup)
	sifd=$(sudo which ifdown)
	slinky=$(sudo which ln)
	spc=$(sudo which cp)
	svm=$(sudo which mv)

	CB_LIST1="/sbin/halt /sbin/reboot /usr/bin/which ${sifu} ${sifd} "
	dqb "second half of c_bin_1"
	csleep 5

	for x in apt-get apt ip netstat dpkg tar mount umount dhclient sha512sum #kilinwittu.sh
		do ocs ${x}
	done

	sdi=$(sudo which dpkg)
	sag=$(sudo which apt-get)
	sa=$(sudo which apt)
	sip=$(sudo which ip)
	snt=$(sudo which netstat)

	if [ -s ~/Desktop/minimize/tar-wrapper.sh ] ; then
		dqb "TODO: tar-wrapper.sh"
	else
		srat=$(sudo which tar)

		if [ ${debug} -eq 1 ] ; then
			srat="${srat} -v "
		fi
	fi

	som=$(sudo which mount)
	uom=$(sudo which umount)

	dqb "b1nar135 0k" 
	csleep 3
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
	spd="${odio} ${sdi} -l "
	sdi="${odio} ${sdi} -i "

	#HUOM. ${sag} VIIMEISENÄ
	shary="${odio} ${sag} --no-install-recommends reinstall --yes "
	sag_u="${odio} ${sag} update "
	sag="${odio} ${sag} "

	sco="${odio} ${sco} "
	scm="${odio} ${scm} "
	sip="${odio} ${sip} "

	sa="${odio} ${sa} "
	sifu="${odio} ${sifu} "
	sifd="${odio} ${sifd} "

	smr="${odio} ${smr} "
	lftr="${smr} -rf /run/live/medium/live/initrd.img* "

	NKVD="${NKVD} -fu "
	NKVD="${odio} ${NKVD}"
	slinky="${odio} ${slinky} -s "

	spc="${odio} ${spc} "
	srat="${odio} ${srat} "
	asy="${odio} ${sa} autoremove --yes"

	fib="${odio} ${sa} --fix-broken install"
	som="${odio} ${som} "
	uom="${odio} ${uom} "
	svm="${odio} ${svm}"

	dch="${odio} ${dch}"
	dqb "b1nar135.2 0k.2" 
	csleep 2
}

#pitäisiköhän vartm vuoksi sorkkia tdstojen oikeudet ja omustajuudet salamma?  enforce_access() kyllä hoitaa tuon /sbin...
function dinf() {
#	#HUOM.280325.2:lienee niin että samalle tdstonnimelle voi asEttaa useamman tiivisteen eli /sbin/dhclient-script:in saisi sudoersiin mukaan
#	#, tosin tarvitseeko? ehkä sitten jos estää ifup:ia käynnistelemästä prosesseja
#
#	echo -n "$(whoami) localhost=NOPASSWD: " >> ${1}
#	local frist
	local g
#	frist=1
#
	for g in $(sha256sum /sbin/dhclient-script* | cut -d ' ' -f 1 | uniq) ; do 
#		if [ ${frist} -eq 1 ] ; then 
#			frist=0
#		else
#			echo -n "," >> ${1}
#		fi
#
#		echo -n "sha256:${f}" >> ${1}
		dqb ${g}
	done
#
#	#echo " /sbin/dhclient-script " >> ${1}
#	#cat ${1}
#	#exit
}

function pre_enforce() {
	dqb "common_lib.pre_enforce( ${1} , ${2} )"

	local q
	local f
	q=$(mktemp -d)

	dqb "sudo touch ${q}/meshuggah in 3 secs"
	csleep 3
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

	dqb "common_lib.pre_enforce d0n3"
}

#HUOM.270325:vaikuttaisi siltä että part1() rikkoo chimaeran/äksän/slimin tai sitten uusi tikku tai optinen kiekko olisi kokeilemisen arvoinen juttu
#pas2.sh kutsuu tätä ja vissiin ei aiheuttanut härdelliä
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

	[ -f /etc/resolv.conf.${f} ] || ${spc} /etc/resolv.conf /etc/resolv.conf.${f}
	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}
	[ -f /etc/network/interfaces.${f} ] || ${spc} /etc/network/interfaces /etc/network/interfaces.${f}

	if [ -s /etc/resolv.conf.new ] && [ -s /etc/resolv.conf.OLD ] ; then
		${smr} /etc/resolv.conf 
	fi

	[ -s /sbin/dclient-script.OLD ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.OLD
	#sittenkin -s ?	
	[ -f /etc/iptables/rules.v4.${f} ] || ${spc} /etc/iptables/rules.v4 /etc/iptables/rules.v4.${f}
	[ -f /etc/iptables/rules.v6.${f} ] || ${spc} /etc/iptables/rules.v4 /etc/iptables/rules.v6.${f}

	#050425 lisättyjä seur. blokki
	[ -h  /etc/iptables/rules.v4 ] && ${smr} /etc/iptables/rules.v4
	[ -h  /etc/iptables/rules.v6 ] && ${smr} /etc/iptables/rules.v6
	[ -s /etc/iptables/rules.v4.${dnsm} ] && ${slinky} /etc/iptables/rules.v4.${dnsm} /etc/iptables/rules.v4
	#ao. rivillä DROP kaikkiin riittänee säännöiksi
	[ -s /etc/iptables/rules.v6.${dnsm} ] && ${slinky} /etc/iptables/rules.v6.${dnsm} /etc/iptables/rules.v6
}

function part1_5() {
	if [ z"${pkgsrc}" != "z" ] ; then
		if [ -d ~/Desktop/minimize/${1} ] ; then
			if [ ! -s /etc/apt/sources.list.${1} ] ; then
				local g
				local h

				g=$(date +%F) 
				dqb "MUST MUTILATE sources.list FOR SEXUAL PURPOSES"
				csleep 3

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

#HUOM. onko todellakin näin että tämä rikkoo jotain äksän kanssa kun slim joutuu odottamaan minUUtteja ?
#P.S.. tämä fktio voisi sijaita doit6:sessakin paitsi että se pas2:n testaus-juttu
#part1_5 tarvittaneen muuallakin kuin doit6:dessa nykyään
function part1() {
	#jos jokin näistä kolmesta hoitaisi homman...
	${sifd} ${iface}
	${sifd} -a
	${sip} link set ${iface} down

	[ $? -eq 0 ] || echo "PROBLEMS WITH NETWORK CONNECTION"
	[ ${debug} -eq 1 ] && /sbin/ifconfig;sleep 5 

	if [ y"${ipt}" == "y" ] ; then
		echo "5H0ULD-1N\$TALL-1PTABL35!!!"
	else
		for t in INPUT OUTPUT FORWARD ; do 
			${ipt} -P ${t} DROP
			dqb "V6"; csleep 3
			${ip6t} -P ${t} DROP
			${ip6t} -F ${t}
		done

		for t in INPUT OUTPUT FORWARD b c e f ; do ${ipt} -F ${t} ; done

		if [ ${debug} -eq 1 ] ; then
			${ipt} -L #
			dqb "V6.b"; csleep 3
			${ip6t} -L # -x mukaan?
			sleep 5 
		fi #	
	fi

	part1_5 ${1}
	${sco} -R root:root /etc/apt 
	${scm} -R a-w /etc/apt/
	dqb "FOUR-LEGGED WHORE (maybe i have tourettes)"
}

#HUOM.22325: oli jotain nalkutusta vielä chimaeran päivityspaketista, lib.sh fktiot tai export2 muutettava vasta avasti
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

	local f
	for f in $(find ${1} -name 'lib*.deb') ; do ${sdi} ${f} ; done
	
	if [ $? -eq  0 ] ; then
		dqb "part3.1 ok"
		csleep 5
		${NKVD} ${1}/lib*.deb 
	else
	 	exit 66
	fi

	for f in $(find ${1} -name '*.deb') ; do ${sdi} ${f} ; done	

	if [ $? -eq  0 ] ; then
		dqb "part3.2 ok"
		csleep 5
		${NKVD} ${1}/*.deb 
	else
	 	exit 67
	fi

	csleep 2
}

function ecfx() {
	dqb "echx"

	if [ -s ~/Desktop/minimize/xfce.tar ] ; then
		${srat} -C / -xvf ~/Desktop/minimize/xfce.tar
	fi
}

function vommon() {
	dqb "R (in 6 secs)"; csleep 6
	${odio} passwd
	
	if [ $? -eq 0 ] ; then
		dqb "L (in 6 secs)"; csleep 6
		passwd
	fi

	if [ $? -eq 0 ] ; then
		${whack} xfce4-session
		#HUOM. tässä ei tartte jos myöhemmin joka tap
		exit 	
	fi
}

dqb "common_l1b_l0ad3d_5ucc35fully"

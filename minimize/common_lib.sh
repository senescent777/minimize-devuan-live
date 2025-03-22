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

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#josko joku päivä uskaltaisi kommentoituja rivejä tuiopda takaisin jossain muodossa?
fix_sudo() {
	echo "fix_sud0.pt0"
	${sco} -R 0:0 /etc/sudoers.d #pitääköhän juuri tässä tehdä tämä? jep
	${scm} 0440 /etc/sudoers.d/* 
	
	${sco} -R 0:0 /etc/sudo*
	${scm} -R a-w /etc/sudo*

	dqb "POT. DANGEROUS PT 1"
	#${sco} 0:0 /usr/lib/sudo/* #onko moista daedaluksessa?
	#${sco} 0:0 /usr/bin/sudo* #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!

	dqb "fix_sud0.pt1"
	${scm} 0750 /etc/sudoers.d
	${scm} 0440 /etc/sudoers.d/*
	
	dqb "POT. DANGEROUS PT 2"
	#${scm} -R a-w /usr/lib/sudo/* #onko moista daedaluksessa?
	#${scm} -R a-w /usr/bin/sudo* #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!

	#${scm} 4555 ./usr/bin/sudo #HUOM. LUE VITUN RUNKKARI MAN-SIVUT AJATUKSELLA ENNENQ KOSKET TÄHÄN!!!

	#${scm} 0444 /usr/lib/sudo/sudoers.so #onko moista daedaluksessa?
	[ ${debug} -eq 1 ] && ls -las  /usr/bin/sudo*
	csleep 5	
	echo "fix_sud0.d0n3"
}

fix_sudo

#pr4(), pp3(), p3() distro-spesifisiä, ei tähän tdstoon
#HUOM.20325:ocs() toiminee kuten tarkoitus, testattu on
function ocs() {
	#dqb "ocs(${1})) "
	local tmp
	tmp=$(sudo which ${1})

	if [ y"${tmp}" == "y" ] ; then
		exit 69 #fiksummankin exit-koodin voisi keksiä
	fi

	if [ ! -x ${tmp} ] ; then
		exit 77
	fi
}

#HUOM. jos tätä käyttää ni scm ja sco pitää tietenkin esitellä alussa
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
	#dqb "mangle_s( ${1} ${2})"
	csleep 1

	[ y"${1}" == "y" ] && exit 44
	[ -x ${1} ] || exit 55 #oli -s
	[ y"${2}" == "y" ] && exit 43
	[ -f ${2} ] || exit 54
	#dqb "params_oik"

	${scm} 0555 ${1}
	#HUOM. miksi juuri 5? no six six six että suoritettavaan tdstoon ei tartte kirjoittaa
	${sco} root:root ${1} 

	local s
	s=$(sha256sum ${1})
	${odio} echo "${n} localhost=NOPASSWD: sha256: ${s} " >> ${2}
}

#VAIH:check_bin siirto jonnekin mangle_s tienoille
#TODO:jos mahd ni Python-tyyppinen(?) idea käyttöön ao. fktioon, $cmd=eval_cmd("cmd") tai jhopa $array["cmd"]=aval_cmd("cmd") 
function check_binaries() {
	dqb "ch3ck_b1nar135(${1} )"
	dqb "sudo= ${odio} "
	csleep 1

	[ z"${1}" == "z" ] && exit 99
	[ -d ~/Desktop/minimize/${1} ] || exit 100
	dqb "params_ok"
	csleep 1

	#HUOM. smr-ip6tr tarvitaan changedns:n kanssa
	#HUOM.2. odio, sco ja scm myös
	smr=$(sudo which rm)
	NKVD=$(sudo which shred)
	ipt=$(sudo which iptables)
	ip6t=$(sudo which ip6tables)
	iptr=$(sudo which iptables-restore)
	ip6tr=$(sudo which ip6tables-restore)

	if [ y"${ipt}" == "y" ] ; then
		echo "SHOULD INSTALL IPTABLES"
	
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

	#HUOM.omegaa testessa osoittautui osoitteuatui että /u/b/which on tarpeellinen sudottaa, joten lisätty
	CB_LIST1="${smr} ${NKVD} ${ipt} ${ip6t} ${iptr} ${ip6tr} /sbin/halt /sbin/reboot /usr/bin/which"

	#HUOM. seuraaviakin tarvitaan changedns:n kanssa
	sco=$(sudo which chown)
	scm=$(sudo which chmod)
	whack=$(sudo which pkill)
	sifu=$(sudo which ifup)
	sifd=$(sudo which ifdown)
	slinky=$(sudo which ln)
	spc=$(sudo which cp)
	#sudotettu mv saatttaa myös olla tarpeen tulevbaisuyydessä
	svm=$(sudo which mv)

	CB_LIST1="${CB_LIST1} ${sco} ${scm} ${whack} ${sifu} ${sifd} ${slinky} ${spc} ${svm}"
	local x	

	if [ ${dnsm} -eq 1 ] ; then
		for x in dnsmasq ntpsec stubby ; do
			if [ -x /etc/init.d/${x} ] ; then
				CB_LIST1="${CB_LIST1} /etc/init.d/${x}"
			fi
		done
	fi

	#HUOM. cb_list:in komentojen kanssa pitäsi paramettritkin spekasta, jos mahd, millä saa ajaa
	dqb "second half of c_bin_1"
	csleep 5
	
	#passwd mukaan listaan? ehkä ai tartte
	#HUOM. listan sisältöä joutanee miettiä ja että missä kohtaa ajetaan
	#mangle_s tekee samantap tarkistuksia joten riittää että ocs-kiakkailut niille mitkä eivät cb_list:issä
	
	for x in apt-get apt ip netstat dpkg tar mount umount 
		do ocs ${x} 
	done

	sdi=$(sudo which dpkg)
	sag=$(sudo which apt-get)
	sa=$(sudo which apt)
	sip=$(sudo which ip)
	snt=$(sudo which netstat)
	
	#HUOM. gpgtar olisi vähän parempi kuin pelkkä tar, silleen niinqu tavallaan
	#, tähän liittyen olisi aiheellista tehdä sha-tarkistus -deb-paketeista siltä vavralta ettttä lahoava muistuitiku paskoo paketit	
	srat=$(sudo which tar)

	if [ ${debug} -eq 1 ] ; then
		srat="${srat} -v "
	fi

	som=$(sudo which mount)
	uom=$(sudo which umount)

	#dqb "half_fdone"
	#csleep 1
	#
	#ao. kohtaakin joutaisi miettiä, oli jotain nalkutusta 220325
	#dch=$(find /sbin -name dhclient-script)
	#[ x"${dch}" == "x" ] && exit 6
	#[ -x ${dch} ] || exit 6
	#jos laittaa meshiggah:iin mukaan ni ei voi olla sitä sha-juttus mukana koska x

	#HUOM:tulisi speksata sudolle tarkemmin millä param on ok noita komentoja ajaa
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
	csleep 3
}

function pre_enforce() {
	dqb "common_lib.pre_enforce( ${1} , ${2} )"	

	#HUOM.230624 /sbin/dhclient* joutuisi hoitamaan toisella tavalla q mangle_s	
	local q
	local f
	q=$(mktemp -d)	
	 
	dqb "sudo touch ${q}/meshuggah in 5 secs"
	csleep 3
	touch ${q}/meshuggah

	[ ${debug} -eq 1 ] && ls -las ${q}
	csleep 3
	[ -f ${q}/meshuggah ] || exit 33
	dqb "ANNOYING AMOUNT OF DEBUG"

	if [ z"${1}" != "z" ] ; then
		dqb "333"
		${sco} ${1}:${1} ${q}/meshuggah 
 		${scm} 0660 ${q}/meshuggah #vissiin uskalla tuosta tiukentaa
	fi	

	##HUOM.lib- ja conf- kikkailujen takia ei ehkä kantsikaan ajaa vlouds2:sta sudon kautta kokonaisuudessaan
	##if [ z"${2}" != "z" ] ; then
	##	dqb "FUCKED WITH A KNIFE"
	##	#[ ${debug} -eq 1 ] && ls -las ~/Desktop/minimize/${2}
	##
	##	if [ -d ~/Desktop/minimize/${2} ] ; then
	#		dqb "1NF3RN0 0F SACR3D D35TRUCT10N"
	#		mangle_s ~/Desktop/minimize/changedns.sh ${q}/meshuggah 			
	#		csleep 2
	##	fi
	##fi

	for f in ${CB_LIST1} ; do mangle_s ${f} ${q}/meshuggah ; done
	
	if [ -s ${q}/meshuggah ] ; then
		dqb "sudo mv ${q}/meshuggah /etc/sudoers.d in 5 secs"
		csleep 2

		${scm} a-wx ${q}/meshuggah
		${sco} root:root ${q}/meshuggah	
		${svm} ${q}/meshuggah /etc/sudoers.d
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

	${sco} -R root:root /etc
	for f in $(find /etc/sudoers.d/ -type f) ; do mangle2 ${f} ; done

	for f in $(find /etc -name 'sudo*' -type f | grep -v log) ; do 
		mangle2 ${f}
	done

	${scm} 0755 /etc 
	${sco} -R root:root /var
	${scm} -R 0755 /var

	${sco} root:staff /var/local
	${sco} root:mail /var/mail
		
	${sco} -R man:man /var/cache/man 
	${scm} -R 0755 /var/cache/man

	${scm} 0755 /
	${sco} root:root /

	#ch-jutut siltä varalta että tar sössii oikeudet tai omistajat
	${sco} root:root /home
	${scm} 0755 /home

	#HUOM.140325:riittääköhän ao. tarkistus?
	if [ y"${1}" != "y" ] ; then
		dqb "${sco} -R ${1}:${1} ~"
		${sco} -R ${1}:${1} ~
		csleep 5
	fi
	
	local f
	${scm} 0755 ~/Desktop/minimize	
	for f in $(find ~/Desktop/minimize -type d) ; do ${scm} 0755 ${f} ; done	
	for f in $(find ~/Desktop/minimize -type f) ; do ${scm} 0444 ${f} ; done	
	for f in $(find ~/Desktop/minimize -name '*.sh') ; do ${scm} 0755 ${f} ; done
	f=$(date +%F)

	[ -f /etc/resolv.conf.${f} ] || ${spc} /etc/resolv.conf /etc/resolv.conf.${f}
	[ -f /sbin/dhclient-script.${f} ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.${f}
	[ -f /etc/network/interfaces.${f} ] || ${spc} /etc/network/interfaces /etc/network/interfaces.${f}

	if [ -s /etc/resolv.conf.new ] && [ -s /etc/resolv.conf.OLD ] ; then
		${smr} /etc/resolv.conf 
	fi

	[ -s /sbin/dclient-script.OLD ] || ${spc} /sbin/dhclient-script /sbin/dhclient-script.OLD
	
	#TODO: se man chmod ao. riveihin liittyen, rwt... (kts nyt vielä miten oikeudet menivät ennen sorkintaa)
	#HUOM.280125:uutena seur rivit, poista jos pykii
	#0 drwxrwxrwt 7 root   root   220 Mar 16 22:41 .
	
	${scm} 0777 /tmp
	${sco} root:root /tmp
}

#HUOM.220325:sudotuksessa täytyy huomioida tämän fktion sisältämät komennot
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

				#${sco} ${n}:${n} ${h}/sources.list.${1} 
				#${scm} u+w ${h}/sources.list.${1} #riittääkö u+w nyt?

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

#HUOM.22325: oli jotain nalkuitusta vielä chimaeran päivityspaketista, lib.sh fktiot tai export2 muutettava vasta avasti
function part3() {
	dqb "part3( ${1} )"
	csleep 1

	[ y"${1}" == "y" ] && exit 1 #mikähän tässäkin on?
	dqb "11"
	csleep 1
	[ -d ${1} ] || exit 2

	dqb "22 ${sdi} ${1} / lib \* .deb"
	[ z"${sdi}" == "z" ] && exit 33
	[ -x ${sdi} ] || exit 44 #1. kokeilulla pyki, jemmaan toistaiseksi
	#220325:edelleenm jotain qsee tässsä kohtaa (toistuuko?)	
	csleep 1

	dqb "VAIH: sha512sum -c ${1}/sha512sums.txt;echo \$ ?"
	if [ -s ${1}/sha512sums.txt ] ; then
		sha512sum -c ${1}/sha512sums.txt
		echo $?
		csleep 6
	fi

	local f
	for f in $(find ${1} -name 'lib*.deb') ; do ${sdi} ${f} ; done
	#VAIH:varmistus jotta sdi eityhjä+ajokelpoinen ennenq... (oikeastaan check_binaries* pitäisi hoitaa)

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

	#for .. do .. done saattaisi olla fiksumpi tässä (tai jokin find-loitsu)
	if [ -s ~/Desktop/minimize/xfce.tar ] ; then
		${srat} -C / -xvf ~/Desktop/minimize/xfce.tar
	else 
		if  [ -s ~/Desktop/minimize/xfce070325.tar ] ; then
			${srat} -C / -xvf ~/Desktop/minimize/xfce070325.tar
		fi
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
function pre1() {
	# tosin disto-parametrin vaikutukset voisi testata, sittenq parsetus taas toimii kunnolla(TODO)

	#HUOM.020825:pitäisi kai selvittää mikä paskoo ifup:in, onko se tämä fktio vai jokin muu?
	dqb "pre1 ${1}  ${2} "
	[ -z ${1} ] && exit 66
	[ -z ${2} ] && exit 66
	#VAIH:tokan parametrin(mihin tarvitsee?) tarkistus, toiminee

	csleep 4
	dqb "pars.0k"

	csleep 5
	${sco} -Rv _apt:root ${pkgdir}/partial/
	${scm} -Rv 700 ${pkgdir}/partial/
	csleep 1

	if [ ! -d ${1} ] ; then
		echo "P.V.HH"
		exit 111
	else
		echo "else"
		dqb "5TNA"
		

		local lefid
		lefid=$(echo ${1} | tr -d -c 0-9a-zA-Z/) # | cut -d '/' -f 1-5)
		#HUOM.25725:voi periaatteessa mennä metsään nuo $c ja $l, mutta tuleeko käytännössä sellaista tilannetta vastaan?
	
		enforce_access ${n} ${lefid} #jos jo toimisi
		csleep 1
		dqb "3NF0RC1NG D0N3"
		
		csleep 1
		${scm} 0755 /etc/apt
		${scm} a+w /etc/apt/sources.list*
	fi
}

#HUOM.020825:jossain pitäisi kutsua part1() tai part1_5() jotta sen sources.list:in saisi kohdalleen

function pre2() { #HUOM.010825: ei huomioitu puuttuvaa /o/b/changedns.sh, muuten kai toimii
	#... pl mahdollisesti ifup liittyvät jutut (TODO)
	dqb "pre2 ${1}, ${2} , ${3} , ${4}  ...#WTIN KAARISULKEET STNA" 
	csleep 1

	[ -z ${1} ] && exit 66
	[ -z ${2} ] && exit 67
	[ -z ${3} ] && exit 68
	[ -z ${4} ] && exit 69 #josko nyt jo 31725 olisi kaikki kohdat, mistä kutsitaan, kunnossa
	
	dqb "pars.ok"	
	csleep 1

	local ortsac
	local par4

	#leikkelyt tarpeellisia? exc/ceres takia vissiin on
	ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)
	par4=$(echo ${4} | tr -d -c 0-9)

	#HUOM.020825:vähän enemmän sorkintaa tänne?
	#/e/n alihakemistoihin +x ?
	#/a/wpa kokonaan talteen? /e/n kokonaan talteen?

	if [ -d ${1} ] && [ -x /opt/bin/changedns.sh ] ; then
		dqb "PRKL"

		${odio} /opt/bin/changedns.sh ${par4} ${ortsac}
		echo $?
		csleep 1

		${sifu} ${3}
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

#HUOM.28725:vaikuttaisi toimivan
function tp0() {
	dqb "tp0 ${1} , ${2} , ${3}  "

	if [ -d ${1} ] ; then
		dqb "cleaning up ${1} "
		csleep 1
		${NKVD} ${1}/*.deb
	
		${NKVD} ${1}/sha512sums.txt
		dqb "d0nm3"
	else
		dqb "NO SUCH DIR ${1}"

	fi

	csleep 1
}

function tpq() { #HUOM.020825:toimii
	dqb "tpq ${1} ${2}"
	csleep 1

	[ -z ${1} ] && exit 11
	[ -z ${2} ] && exit 12
	[ -d ${1} ] || exit 22 #uskaltaisiko jommankumman tarkistuksen laittaa takaisin?
	[ -d ${2} ] || exit 23 #pitäisikö mennä näin?

	dqb "paramz 0k"
	csleep 1
	cd ${1}

	dqb "CFG"
	${srat} -jcf ./config.tar.bz2 ./.config/xfce4/xfconf/xfce-perchannel-xml ./.config/pulse
 	csleep 1

	dqb "PUL53"
	${srat} -cf ./pulse.tar /etc/pulse
	csleep 1
	dqb "PR0.F5"

	if [ -x ${2}/profs.sh ] ; then
		dqb "DE PROFUNDIS"
		.  ${2}/profs.sh	

		#HUOM.28725:SOPISI NYT JONKIN AIKAA OLLA EKA PARAMETRI TUOLLEEN ETTÄ FKTION PARAM MUKANA
		#... HARKITAAN MUUTTAMISTA SITTEN JOS OIKEASTI TARVETTA ILMENEE

		exp_prof ${1}/fediverse.tar default-esr
	else
		dqb "export2 p \$file ; import2 1 $file  ?"
		exit 24
	fi

	cd ${2}
}

#VAIH:selv paskooko tämä ifup:in vai ei
function tp1() {
	dqb "tp1 ${1} , ${2} , ${3}  "
	[ -z ${1} ] && exit
	[ -z ${2} ] && exit
	csleep 1

	dqb "params_ok"
	csleep 1
	pwd
	csleep 1

	if [ ${enforce} -eq 1 ] && [ -d ${2} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		tpq ~ ${2}/.. #HUOM.25725:toimiiko näin?
	else
		dqb "PUIG DESTRÖYERR"
	fi

	csleep 1
	${srat} -rvf ${1} /opt/bin/changedns.sh
	local t

	dqb "find -max-depth 1 ~ -type f -name '*.tar*'"
	csleep 2
	for t in $(find ~ -maxdepth 1 -type f -name '*.tar*') ; do ${srat} -rvf ${1} ${t} ; done  
	csleep 2

#	#HUOM! $2/.. EI VAAN TOIMI!!! ÄLÄ SIIS  ITUN KYRPÄ KÄYTÄ SITÄ 666!!!!!
#	#jatkossa tar if-blokin jälkeen?
#	if [  z"${3}" != "z" ] ; then
#		dqb "A"
#		csleep 1
#
#		cd ${3} #tässä oli virhe
#		${srat} --exclude='*.deb' -rvf ${1} ./home/stubby
#		csleep 3
#
#		#TODO:se fiksumpi tapa, voiSiko esim $2:sta leikata $3:n bashilla jotenkin käteväsri?
#		t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 4,5,6,7)
#		echo ${t}
#		#exit
#
#		#TODO:vissiin jatkossa niin että tässä haarassa .example voi ottaa, conf* ei (update.sh liittyi)
#
#		dqb "./home/stubby ./home/devuan/Desktop/minimize" #tässäkin oli virhe
#		${srat} --exclude='*.deb' --exclude='conf*' -rvf ${1} ${t} 
#		#erikseen pitäisi se conf.example lisätä 
#	else
		dqb "B"
		csleep 1
		t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 1-5)

		dqb "${srat} --exclude='*.deb' -rvf ${1} /home/stubby ${t} "
		csleep 3
		
		#pitäisiköhän findilla hakea tar:ille ne .sh, .tar yms. ?
		#... vai stokeekohan ecxldur asioita? ei kai

		${srat} --exclude='*.deb' -rvf ${1} /home/stubby ${t}
#	fi
#pidetääb tämä blokki vielä jemmassa
	dqb "tp1 d0n3"
	csleep 1
}

function luca() {
	dqb "luca ( ${1})"
	csleep 1
	[ -z ${1} ] && exit 11
	[ -s ${1} ] || exit 12

	dqb "prs ok"
	csleep 1

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep rule #| less
	sleep 2

	dqb "JUST BEFORE LOCALES"
	sleep 1

	#VAIH:locale- ja timezone- jutut toisella tavalla, tp2() kutSuvaan koodiin vaikkapa?
	${srat} -rvf ${1} /etc/timezone /etc/localtime 
	#HUOM.22525:tuossa alla locale->local niin saisi localtime:n mukaan mutta -type f
	for f in $(find /etc -type f -name 'local*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done

	echo $?
	sleep 1

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local #| less
	sleep 3
}

function tp2() { #HUOM.020825:joko jo toimisi?
	#debug=1 #pois?
	dqb "tp2 ${1} ${2} ${3}"
	csleep 1

	[ -z ${1} ] && exit 1
	[ -z ${2} ] && exit 2
	[ -z ${3} ] && exit 3
	[ -s ${1} ] || exit 4
	csleep 1

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
	luca ${1}
	csleep 1
	other_horrors

	dqb "B3F0R3 TÖBX"
	csleep 2

	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	dqb "WLAN-RELAT3D"	
	csleep 2

	case ${2} in
		wlan0)
			#tätä koko fktiota ei ajeta jos x ni ei ole ihan pakko kikkailla
			#... tai miten lienee			

			[ ${debug} -eq 1 ] && echo "APW";sleep 3
			${srat} -rvf ${1} /etc/wpa_supplicant/*.conf
			${srat} -tf ${1} | grep wpa
			csleep 3
		;;
		*)
			dqb "non-wlan"
		;;
	esac

	if [ ${enforce} -eq 1 ] ; then #TODO:glob wtt?
		dqb "das asdd"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuggah
	fi

	dqb "DSN"
	csleep 2

	if [ ${3} -eq 1 ] ; then
		local f;for f in $(find /etc -type f -name 'stubby*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name 'dns*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	else
		dqb "n0 5tub"
	fi

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	dqb "tp2 done"
	csleep 1
}

function tp3() { #TODO:testaa uusiksi, mikä paskoo ifup:in, onko se tämä vai ei?
	dqb "tp3 ${1} ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2
	[ -z ${2} ] && exit 3

	dqb "paramz_0k"
	csleep 1

	local p
	local q	
	local r

	r=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-zA-Z)
	[ ${debug} -eq 1 ] && pwd
	dqb "r=${r}"
	csleep 1

	tig=$(${odio} which git) #voisi alustaa jossain aiempana

	p=$(pwd)
	q=$(${mkt} -d)
	cd ${q}
	csleep 1

	#voisi jollain ehdolla estää kloonauksen
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
	${spc} /etc/resolv.conf ./etc/resolv.conf.${dnsm} #TODO.glob wtt

	if [ ! -s ./etc/resolv.conf.1 ] ; then
		 ${spc} ./etc/resolv.conf.new ./etc/resolv.conf.1
	fi

	dqb "N1B.5"
	csleep 2

	#HUOM.010825:/sbin-juttuja ei tullut mukaan
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

	#HUOM.010825:/e/a/sources.list ja /e/a/a.conf tuli mukaan
	dqb "SOUCRES"
	csleep 2

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

	#HUOM.010825:/e/n/i tuli mukaan
	dqb "1NT3RF"
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

function aswasw() { #HUOM.28725:testattu, toimii
	dqb " aswasw ${1}"
	csleep 1

	case ${1} in
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
	dqb " aswasw ${1} DONE"
	csleep 1
}

#HUOM.020825:saattaa olla toimiva
function rmt() {
	#debug=1
	dqb "rmt ${1}, ${2} " #WTUN TYPOT STNA111223456
	csleep 1

	[ -z ${1} ] && exit 1 #nämäkö kusevat edelleen?
	[ -s ${1} ] || exit 2
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
	ls -las ${1} 

	csleep 1
	cd ${p}
	dqb "rmt d0n3"
}

#home/devuan/Desktop/minimize/chimaera/home/devuan/Desktop/minimize/chimaera/tim3stamp
#kyseiselle polulle voisi tehdä jotain jos ilmestyy(TODO)

function tlb() { #VAIH:tarkista toiminta jälleen kerran
	#... oli python3.11 liittyvää nalqtusta ja vähän muutakin 020825	

	#HUOM.MIKSI ASENTAA AVAHIN?
	#debug=1
	dqb "x2.tlb ${1} , ${2}  , ${3}  , ${4} "

	csleep 1
	dqb "\$shary= ${shary}"
	csleep 2

	[ -z ${1} ] && exit 11
	[ -z ${2} ] && exit 12
	[ -z ${3} ] && exit 13
	[ -z ${4} ] && exit 14

	dqb "parx_ok"
	csleep 3

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

	tpc7	#tämän funktio oli? jotain excaliburiin liittyvää kai
	aswasw ${2}
	${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11

	#18725:toimiikohan se debian_interactive-jekku tässä? dpkg!=apt
	${shary} iptables
	${shary} iptables-persistent init-system-helpers netfilter-persistent

	dqb "x2.tlb.part2"
	[ ${debug} -eq 1 ] && ls -las ${pkgdir}
	csleep 2

	#uutena 31525
	udp6 ${pkgdir}

	dqb "a.HAV1"
	csleep 2

	#VAIH:part2_5() jatkossa, nyt jos riittäisi ao. 3 riviä
	${sharpy} libavahi*
	${NKVD} ${pkgdir}/libavahi*	
	${asy}

	dqb "BEFORE PRE2"
	csleep 2

	#actually necessary
	pre2 ${1} ${3} ${2} ${4} 
	other_horrors
	dqb "x2.tlb.done"
}

function tp4() { #TODO:selviTä paskooko tämä ifup:in? ei välttämättä
	#TODO:voisi selvitellä miksi tulee tar:iin ylimääräisiä paketteja
	#apt.conf.d asetuksia ei enää kunnioiteta/pakettien riippuvuudet muuttuneet/jäänyt hmistoon jämiä/jotainmuuta ?

	dqb "tp4 ${1} , ${2} , ${3} , ${4} "
	csleep 1

	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22
	[ -z ${1} ] && exit 11
	[ -z ${3} ] && exit 11
	[ -z ${4} ] && exit 11

	dqb "paramz_ok"
	csleep 1
	
	#jos sen debian.ethz.ch huomioisi jtnkin (muutenkin kuin uudella hmistolla?)
	tlb ${2} ${4} ${3} ${dnsm} #TODO:glob muutt wtt?

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

	dqb "ANTI-AVAH1"
	csleep 1

	${sharpy} libavahi* 
	${NKVD} ${pkgdir}/libavahi*	
	${asy} #tämä vai tuo ylempi mikä mutkistaa asioita?

	dqb "BEFORE UPD6"	
	csleep 1

	#HUOM. jos aikoo gpg'n tuoda takaisin ni jotenkin fiksummin kuin aiempi häsläys kesällä -24
	#... myös gpgtar pitäisi ottaa haltuun
	if [ -d ${2} ] ; then
		pwd
		csleep 1
		udp6 ${pkgdir} 		
		
		csleep 1		
		${svm} ${pkgdir}/*.deb ${2}
		rmt ${1} ${2}
		csleep 1

		${NKVD} ${2}/*.deb
	fi

	dqb "tp4 donew"
	csleep 1
}

function tp5() { #HUOM.020825:testattu sen verran että tekee tar:in , myös polq hukattu
	dqb "tp5 ${1} ${2}"

	[ -z ${1} ] && exit 99
	[ -s ${1} ] || exit 98 #pitäisi varmaan tunkea tgtfileeseen jotain että tästä pääsee läpi
	[ -d ${2} ] || exit 97
 
	dqb "params ok"
	csleep 1

	local q
	q=$(${mkt} -d)

	cd ${q} #antaa nyt cd:n olla toistaiseksi
	[ $? -eq 0 ] || exit 77

	${tig} clone https://github.com/senescent777/more_scripts.git
	[ $? -eq 0 ] || exit 99
	
	#HUOM:{old,new} -> {0,1} ei liity
	[ -s ${2}/profs.sh ] && mv ${2}/profs.sh ${2}/profs.sh.OLD
	mv more_scripts/profs/profs* ${2}

	${scm} 0755 ${2}/profs*
	cd ${2}	
	${srat} -rvf ${1} ./profs.*

	cd ${q}
	dqb "AAMUNK01"
}

function tup() { #TODO:testaa uusiksi, koska param tark
	dqb "tup ${1}, ${2}, ${3}, ${4}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] && mv ${1} ${1}.OLD
	[ -z ${2} ] && exit 11
	[ -d ${2} ] || exit 22

	[ -z ${3} ] && exit 33
	[ -z ${4} ] && exit 55

	dqb "params_ok"
	csleep 1

	#pitäisiköhän kohdehmistostakin poistaa paketit?
	${NKVD} ${pkgdir}/*.deb
	${NKVD} ${2}/*.deb
	dqb "CLEANUP 1 AND 2 DONE, NEXT: apt-get upgrade"
	csleep 1
	
	${fib} #uutena 205.25
	csleep 1
	
	#--yes - vipu mukaan myös?
	${sag} --no-install-recommends upgrade -u
	echo $?
	csleep 1

	dqb "AVA.H1" #josqs takaisin?
	${sharpy} libavahi*
	${NKVD} ${pkgdir}/libavahi*
	
	${asy}
	csleep 1

	dqb "generic_pt2 may be necessary now"	
	csleep 1

	${sifd} ${3}
	csleep 1
	
	dqb " ${3} SHOULD BE DOWN BY NOW"
	csleep 1
	local s

	for s in ${PART175_LIST} ; do #HUOM.turha koska ylempänä... EIKU
		dqb "processing ${s} ..."
		csleep 1

		${NKVD} ${pkgdir}/${s}*
	done

	#HUOM.part076() ja part2_5() on keksitty
	
	case ${3} in

		wlan0)
			dqb "NOT REMOVING WPASUPPLICANT"
			csleep 1
		;;
		*)
			${NKVD} ${pkgdir}/wpa*
			#HUOM.25725:pitäisi kai poistaa wpa-paketit tässä, aptilla myös?
			#... vai lähtisikö vain siitä että g_pt2 ajettu ja täts it
		;;
	esac

	udp6 ${pkgdir}
	dqb "UTP PT 3"
	csleep 1

	${svm} ${pkgdir}/*.deb ${2}
	${odio} touch ${2}/tim3stamp
	${scm} 0644 ${2}/tim3stamp
	${sco} $(whoami):$(whoami) ${2}/tim3stamp

	date > ${2}/tim3stamp
	${srat} -cf ${1} ${2}/tim3stamp
	rmt ${1} ${2}

	dqb "SIELUNV1H0LL1N3N"
	csleep 1
}
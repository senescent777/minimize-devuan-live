#!/bin/bash
#jotain oletuksia kunnes oikea konftdsto saatu lotottua
debug=0 #1
distro=$(cat /etc/devuan_version) # | cut -d '/' -f 1) #160126 cut-kikkailu pois sotkemasta, muualla kun menee toisin
d0=$(pwd)
mode=-2
tgtfile=""

function usage() {
	echo "$0 0 <tgtfile> [distro] [-v]: makes the main package (new way)"
	echo "$0 4 <tgtfile> [distro] [-v]: makes lighter main package (just scripts and config)"
	echo "$0 1 <tgtfile> [distro] [-v]: makes upgrade_pkg"
	echo "$0 e <tgtfile> [distro] [-v]: archives the Essential .deb packages"
	echo "$0 f <tgtfile> [distro] [-v]: archives .deb Files under \$ {d0} /\${distro}"
	echo "$0 p <> [] [] pulls Profs.sh from somewhere"
	echo "$0 q <> [] [] archives firefox settings"
	echo "$0 c is sq-Chroot-env-related option"
	echo "$0 g adds Gpg for signature checks, maybe?"
	echo "$0 t ... option for ipTables"

	echo "$0 -h: shows this message about usage"
}

#TODO:jos muuttaisi blokin koskapa gpo() nykyään? (-h kanssa voisi tehdä toisinkin)
if [ $# -gt 1 ] ; then
	mode=${1}
	[ -f ${1} ] && exit 99
	tgtfile=${2}
else
	#echo "$0 -h"
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se peruslähtökohta (tai sitten saatanallisuus)
function parse_opts_1() {
	dqb "exp2.patse_otps8( ${1}, ${2})"

	if [ -d ${d}/${1} ] ; then
		distro=${1}
		d=${d0}/${distro}
	fi
}

function parse_opts_2() {
	dqb "parseopts_2 ${1} ${2}"
}

#parsetuksen knssa menee jännäksi jos conf pitää ladata ennen common_lib (no parse_opts:iin tiettty muutoksia?)
d=${d0}/${distro}

if [ -s ${d0}/$(whoami).conf ] ; then
	echo "ALT.C0NF1G"
	. ${d0}/$(whoami).conf
else
	if [ -d ${d} ] && [ -s ${d}/conf ] ; then
		. ${d}/conf
	else
	 	exit 57
	fi	
fi

if [ -x ${d0}/common_lib.sh ] ; then 
	. ${d0}/common_lib.sh
else
	echo "FALLBACK"
	echo "chmod +x ${d0}/common_lib.sh may be a good idea now"
	exit 56
	#HUOM.28725:toistaiseksi näin
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 1

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else 
	exit 59
fi

dqb "tar = ${srat} "
#suorituksen keskeytys aLEmpaa näille main jos ei löydy tai -x ?

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${CONF_dnsm} ${distro}
	#[ -x $x ] && exit for 
done

dqb "AFTER GANGRENE SETS IN"
csleep 1

###################261225:josko vähän loiventaisi ao. ehtoja?
if [ -z "${tig}" ] ; then
	#HUOM. kts alempaa mitä git tarvitsee
	echo "sudo apt-get update;sudo apt-get install git"
	#exit 7 #syystä excalibut-testit kommentteihin 16126
fi

if [ -z "${mkt}" ] ; then
	#coreutils vaikuttaisi olevan se paketti mikä sisältää mktemp
	echo "sudo apt-get update;sudo apt-get install coreutils"
	#exit 8 #syystä excalibut-testit kommentteihin 16126
fi
#####################

dqb "e22_pre0"
csleep 1

if [ -x $(dirname $0)/e22.sh ] ; then
	dqb "222"
	.  $(dirname $0)/e22.sh
	csleep 2
else
	exit 58
fi

##HUOM.25525:tapaus excalibur/ceres teettäisi lisähommia, tuskin menee qten alla
#tcdd=$(cat /etc/devuan_version)
#t2=$(echo ${d} | cut -d '/' -f 6 | tr -d -c a-zA-Z/) #tai suoraan $distro?
#	
#if [ ${tcdd} != ${t2} ] ; then
#	dqb "XXX"
#	csleep 1
#	shary="${sag} install --download-only "
#fi
#TODO:t2-kikkailut jatkossa ennen e22?

#https://askubuntu.com/questions/1206167/download-packages-without-installing liittynee

dqb "mode= ${mode}"
dqb "tar= ${srat}"
csleep 1

[ -z "${tgtfile}" ] && exit 99
[ -z "${srat}" ] && exit 66
t=$(echo ${d} | cut -d '/' -f 1-5)

case ${mode} in
	rp)
		[ -s "${tgtfile}" ] || exit 67
		[ -r "${tgtfile}" ] || exit 68
		exit 69
#
#		e22_cleanpkgs ${d}
#		csleep 1
#		
#		${smr} ${d}/f.tar
#		csleep 1
#		
#		#toimiiko tuo exclude? jos ei ni jotain tarttis tehrä
#		#... koko case pois käytöstä vaikka
#	
#		${srat} --exclude 'sha512sums*' --exclude '*pkgs*' -C ${d} -xvf ${tgtfile}
#		[ $? -eq 0 ] && ${svm} ${tgtfile} ${tgtfile}.OLD
#		csleep 1
#
#		#... toimii vissiin mutta laitettu pois pelistä 241225 jokatapauksessa
#			
#		e22_arch ${tgtfile} ${d}
#		cd ${d}
#
#		#sotkee sittenkin liikaa?
#		#${srat} -rvf ${tgtfile} ./accept_pkgs* ./reject_pkgs* ./pkgs_drop
#		
#		#for t in $(${srat} -tf ${tgtfile}) ; do #fråm update2.sh
#		#	${srat} -uvf  ${tgtfile} ${t}
#		#done
#		
#		exit #TODO:j.ollain jekulla voisi hukata exitit näistä case:ista ekasssa switchissa
	;;
	f) 	#140126:jospa ao. blokki toimisi edelleen

		enforce_access ${n} ${t}
		e22_hdr ${tgtfile}
		e22_arch ${tgtfile} ${d}
		e22_ftr ${tgtfile}
		exit
	;;
	q)
		#DONE:testausd (120126) , taitaa toimia
		[ -v CONF_iface ] && ${sifd} ${CONF_iface}

		e22_config1 ~
		${srat} -rvf ${tgtfile} ~/config.tar.bz2

		dqb $?
		csleep 4

		${NKVD} ~/fediverse.tar
		csleep 1

		e22_settings ${d0}
		#btw. mikä olikaan syy että q on tässä ekassa switch-case:ssa? pl siis että turha apt-renkkaus

		for f in $(find ${d0} -maxdepth 1 -name 'fediverse.tar' -or -name 'profs.sh' | grep -v pulse) ; do
			${srat} -rvf ${tgtfile} ${f}
		done

		e22_ftr ${tgtfile}
		dqb "CASE Q D0N3"
		csleep 3
		exit
	;;
	c)
		#1e30126:laati paketin, sisältö:lienee ok
		# tekee paketin (mod ehkä /tmp-hmiston  kiukuttelut)
		#-T - vipu tar:in kanssa käyttöön vai ei? pärjännee ilmankin

		#TODO:icons-hmisto mukaan jtnkin? tai siis mieluummin jhnknin toiseen pakettiin
		#liittyy: sqroot
		
		cd ${d0}
		fasdfasd ${tgtfile}
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}*
		csleep 2
		
		${srat} --exclude '*merd*' -jcvf ${tgtfile} ./*.sh ./pkgs_drop ./${distro}/*.sh ./${distro}/*_pkgs* ./${distro}/pkgs_drop
		e22_ftr ${tgtfile}
		exit
	;;
	g)
		#150126:luuultavasti oksennetut komennot toimivat edelleen
		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=gpg=2.2.40-1.1+deb12u1
		dqb "${sag_u} | ${fib} , when necessary " 

		echo "${shary} ${E22GI}"

		echo "${svm} ${CONF_pkgdir}/*.deb ${d}"
		#oli se e22_ts() kanssa
		echo "$0 f ${tgtfile} ${distro}"
		exit 1
	;;
#	dqb "#TODO:alsaan siirtyminen?"
	p) #120126:toimii, luulisin
	#mihin muuten kosahtaa jos omegan jälkeen tätä ajaa? srat vai fasdfasd vai mikä?

		e22_hdr ${tgtfile}
		e22_profs ${tgtfile} ${d0}
		exit
	;;
	-h)
		usage
	;;
esac

e22_pre1 ${d} ${distro}
[ ${debug} -eq 1 ] && pwd;sleep 6

#291125:voiko sen exitin jo laittaa takaisin vai ei?
[ -x /opt/bin/changedns.sh ] || echo "SHOULD exit 59"
#...saisiko yo skriptin jotenkin yhdistettyä ifup:iin? siihen kun liittyy niitä skriptejä , post-jotain.. (ls /etc/network)

e22_hdr ${tgtfile}
e22_pre2 ${d} ${distro} ${CONF_iface} ${CONF_dnsm}

e22_cleanpkgs ${d}
e22_cleanpkgs ${CONF_pkgdir}

[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

doit=1
csleep 1

case ${mode} in
	0)
		echo "NOT SUPPORTED ANYMORE"
		exit 99
	;;
	3|4) 
		#150126: 3 ja 4 toimi ainakin jnkn aikaa ( TAAS uusi testkierros tulossa 160126, VAIH)
		[ ${debug} -eq 1 ] && ${srat} -tf ${tgtfile} 
		csleep 2
	
		[ -f /opt/bin/zxcv ] && ${NKVD} /opt/bin/zxcv*
		csleep 1
		fasdfasd /opt/bin/zxcv

		e22_ext ${tgtfile} ${distro} ${CONF_dnsm} /opt/bin/zxcv
		dqb "e22_ext DON3, next:rm some rchives"
		csleep 1

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 3 ] ; then
			e22_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
			e22_other_pkgs ${CONF_dnsm}

			[ ${debug} -eq 1 ] && ls -las ${d}
			csleep 1
		else
			doit=0
		fi

		${sifd} ${CONF_iface}
		[ ${debug} -eq 1 ] && ls -las ${d}
		csleep 5

		e22_home ${tgtfile} ${d} ${CONF_enforce} 
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}
		csleep 1

		${srat} -tf ${tgtfile} | grep fediverse
		csleep 5 #jos 5 riittäisi

		e22_pre1 ${d} ${distro}
		dqb "B3F0R3 RP2	"
		csleep 1

		e22_elocal ${tgtfile} ${CONF_iface} ${CONF_dnsm} ${CONF_enforce} ${CONF_dm} /opt/bin/zxcv
		reqwreqw  /opt/bin/zxcv
		csleep 1


				fasdfasd /opt/bin/zxcv.sig	
				e22_tyg /opt/bin/zxcv
				reqwreqw /opt/bin/zxcv.sig			


		${srat} -rvf ${1} /opt/bin/zxcv*
	;;
	#140126 jälleenm uusi yritys, ainakin muutoksena aiempaan dbus-nalqtus
	u|upgrade)
		dqb "CLEANUP 1 AND 2 DONE, NEXT: ${sag} upgrade"
		csleep 1
		[ -v CONF_pkgdir ] || exit 99
		e22_upgp ${tgtfile} ${CONF_pkgdir} ${CONF_iface}
	;;
	#201225:jopsa jatkossa yhdistelisi noita e/t/l/g-tapauksia? (tai vähän jo aloiteltu?)
	e)
		#140126 näyttäisi asentuvan e29 ok live-ymp, sqrootissa asentuu nalkutuksen kanssa koska syyt
		#... tosin pilaakohan seatd sen chmod-groups-jutun?
		
		e22_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
		e22_other_pkgs ${CONF_dnsm}
	;;
	t) 
		#140126:sen g-t-jutun kanssa myös aloiteltu, sisältö asentuu ainakin sqroot-ymp
		#HUOM.wanhat .deb alta pois ennen pak purq jotta pääsee varmuuteen		

		message
		csleep 2
		e22_tblz ${d} ${CONF_iface} ${distro} ${CONF_dnsm}
	;;
	l)
		#... onko se nyt seatd mikä paskoo juttuja vai mitvit? 

		dqb "#ensin wdm-pak as, sitten avsta slim pois?"
		csleep 1
		[ -v CONF_dm ] || exit 77

		#voisi tietysti kjäkin sanoa komentorivillä mitä dm:ää halutaan käyttää		
		e22_dm ${CONF_dm}
	;;
	*)
		echo "-h"
		exit
	;;
esac

if [ -d ${d} ] && [ ${doit} -eq 1 ] ; then 
	e22_hdr ${d}/f.tar 
	#accept/reject/drop - jutut mukaan sqroot varten? vai jtnkn muuten?
	e22_dblock ${d}/f.tar ${d} ${CONF_pkgdir} 

	#.sha mennee mukaan kohteeseen
	e22_ftr ${d}/f.tar 

	${srat} -rvf ${tgtfile} ${d}/f.tar* 
	[ $? -eq 0 ] && ${NKVD} ${d}/f.tar* 
fi

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi

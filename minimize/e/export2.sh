#!/bin/bash
#jotain oletuksia kunnes oikea konftdsto saatu lotottua
debug=0 #1
distro=$(cat /etc/devuan_version | cut -d '/' -f 1) #HUOM.28525:cut pois jatkossa?
d0=$(pwd)
#echo "d0= ${d0}"
mode=-2
tgtfile=""

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

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
	#echo "$0 å ... somehow related 2 pavucontrol "	
	echo "$0 -h: shows this message about usage"	
}

if [ $# -gt 1 ] ; then
	mode=${1}
	tgtfile=${2}
else
	usage
	exit 1	
fi

#"$0 <mode> <file>  [distro] [-v]" olisi se peruslähtökohta (tai sitten saatanallisuus)
function parse_opts_1() {
	dqb "exp2.patse_otps8( ${1}, ${2})"

	case "${1}" in
		-v|--v)
			debug=1
		;;
		*)
			#menisiköhän näin?
			if [ -d ${d}/${1} ] ; then
				distro=${1}
				d=${d0}/${distro}
			fi
		;;
	esac
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
	dqb "FALLBACK"
	dqb "chmod +x ${d0}/common_lib.sh may be a good idea now"
	exit 56 #HUOM.28725:toistaiseksi näin
fi

[ -z ${distro} ] && exit 6
d=${d0}/${distro}

dqb "mode= ${mode}"
dqb "distro=${distro}"
dqb "file=${tgtfile}"
csleep 2

if [ -d ${d} ] && [ -x ${d}/lib.sh ] ; then
	. ${d}/lib.sh
else 
	exit 57
fi

dqb "tar = ${srat} "
#suorituksen keskeytys aLEmpaa näille main jos ei löydy tai -x ?

for x in /opt/bin/changedns.sh ${d0}/changedns.sh ; do
	${scm} 0555 ${x}
	${sco} root:root ${x}
	${odio} ${x} ${dnsm} ${distro}
	#[ -x $x ] && exit for 
done

dqb "AFTER GANGRENE SETS IN"
csleep 1
#HUOM.28925:"tar löytyy ja ajokelpoinen"-tarkistus tdstossa common_lib.sh, ocs()

if [ -z "${tig}" ] ; then
	#HUOM. kts alempaa mitä git tarvitsee
	echo "sudo apt-get update;sudo apt-get install git"
	exit 7
fi

if [ -z "${mkt}" ] ; then
	#coreutils vaikuttaisi olevan se paketti mikä sisältää mktemp
	echo "sudo apt-get update;sudo apt-get install coreutils"
	exit 8
fi

dqb "${sco} -Rv _apt:root ${pkgdir}/partial"
csleep 1
${sco} -Rv _apt:root ${pkgdir}/partial/
${scm} -Rv 700 ${pkgdir}/partial/
csleep 1

#HUOM. ei kovin oleellista ajella tätä skriptiä squashfs-cgrootin siSÄllä
#mutta olisi hyvä voida testailla sq-chrootin ulkopuolella

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
	f) 	#291125:joskohan nykyään jo toimisi
		#...koita muistaa śaada aikaiseksi se sha512sums.sig kanssa josqs(VAIH)
		#251125:saisiko pakotettua alemman case:n kanssa toimimaan?		
		#DONE?:accept/reject-käsittely uusiksi prkl, jospa tämä case ei niitä tdstoja vetäisi mukana jatkossa
		#TODO:se uudelleenpakkaus-testi (kehitysympäristössä koska x)

		enforce_access ${n} ${t}
		e22_arch ${tgtfile} ${d}
		e22_ftr ${tgtfile}
		exit
	;;
	q)
		#301125:teki paketin missä toimivaa sisältöä
		#btw. ffox 147 muutokset enemmän profs.sh asia

		${sifd} ${iface}
		e22_settings ~ ${d0}

		#VAIH:josko takaisin siihen että vain oikeasti tarpeelliset mukaan
		#...esim pulse.tar voisi excludoida
		#btw. mikä olikaan syy että q on tässä ekassa case:ssa? pl siis että turha apt-renkkaus

		for f in $(find ~ -maxdepth 1 -name '*.tar' -or -name '*.bz2' -or -name 'profs.sh' | grep -v pulse) ; do
			${srat} -rvf ${tgtfile} ${f}
		done

		e22_ftr ${tgtfile}
		dqb "CASE Q D0N3"
		csleep 3
		exit
	;;
	c)
		#301125:teki paketin jo eilen, sisältö ehkä ok, live-ympäristössä pientä kiukuttelua mikä toivottavasti jo ohi 
		#sisällön kunto ei tämän casen asia oikeastaan
		#kiukuttelu saattoi liittyä /tmp-hakemistoon tai sitten ei (ehkä mktemp -d auttaa?)

		#HUOM:olisi hyvä olemassa sellainen bz3 tai bz2 missä julk av (ellei sitten jtnkn toisin)		
	
		cd ${d0}
		#JOKO JO ALKAISI OMISTAJAT ASETTUMAAN
		e22_hdr ${tgtfile}
		fasdfasd ${tgtfile}
		fasdfasd ${tgtfile}.bz3
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}
		#exit

		#find-komentoja pystynee kai hinkkaaman vielä

		for f in $(find . -type f -name '*.sh' | grep -v 'e/' | grep -v 'olds/') ; do 
			tar -rvf ${tgtfile} ${f}
		done #tähän ei tarvinne --exclude?

		for f in $(find . -type f -name '*_pkgs*' | grep -v 'e/' | grep -v 'olds/')  ; do 
			tar -rvf ${tgtfile} ${f}
		done
				
		#HUOM.291125:tästä tuli jotain nalkutusta, joskohan jo 301125 kunnossa?
		bzip2 -c ${tgtfile} > ${tgtfile}.bz3

		#${svm} ${tgtfile}.bz2 ${tgtfile}.bz3
		#tgtfile="${tgtfile}".bz3 #tarkoituksella tämä pääte 
		e22_ftr ${tgtfile}.bz3
		exit
	;;
	g)
		#HUOM.291125:edelleen antaa komennot joilla saa paketin aikaiskesi
		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=gpg=2.2.40-1.1+deb12u1
		dqb "${sag_u} | ${fib} , when necessary " 

		echo "${shary} ${E22GI}"
		echo "${svm} ${pkgdir}/*.deb ${d}" #oli se e22_ts() kanssa
		echo "$0 f ${tgtfile} ${distro}"
		exit 1
	;;
#	å) #241125:testattu, oksentaa toimivia komentoja, lisäksi:
#	#1. libgtkmm ja libpangomm  riippuvuuksineen aiheutti nalkutusta, pitäisi niitä listoja päivittää vissiin + riippuvuuksien kanssa vielä iterointia
#	#2. "$0 f" tekemä paketti ei paskonut:slim
#
#	#251125:pavu taisi asentua(tosin "establishing connection") + nalkutusta paketeista: libpolkit, libsystemd
#
#	dqb "#TODO:alsaan siirtyminen?"
#
#		echo "${shary} libatk1.0-0 libasound2 libltdl7 libtdb1 libvorbisfile3 libatkmm-1.6-1v5 libcairomm-1.0-1v5 libpangomm-1.4-1v5 libjson-glib-1.0-common libasyncns0 libsndfile1 libsystemd0"
#
#		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=pavucontrol=5.0-2&eXtra=176.93.249.62
#		echo "${shary} libatkmm-1.6-1v5 libcanberra-gtk3-0 libcanberra0 libglibmm-2.4-1v5 libgtkmm-3.0-1v5 libjson-glib-1.0-0 libpulse-mainloop-glib0 libpulse0 libsigc++-2.0-0v5 "
#		echo "${shary} pavucontrol"
#
#		echo "${svm} ${pkgdir}/*.deb ${d}"
#		echo "$0 f ${tgtfile} ${distro}"
#		exit 1
#	;;
	-h)
		usage
	;;
esac

e22_pre1 ${d} ${distro}
#tgtfile:n kanssa muitakin tarkistuksia kuin -z ?
[ ${debug} -eq 1 ] && pwd;sleep 6

#291125:voiko sen exitin jo laittaa takaisin vai ei?
[ -x /opt/bin/changedns.sh ] || echo "SHOULD exit 59"
#...saisiko yo skriptin jotenkin yhdistettyä ifup:iin? siihen kun liittyy niitä skriptejä , post-jotain.. (ls /etc/network)

e22_hdr ${tgtfile}
e22_pre2 ${d} ${distro} ${iface} ${dnsm}

case ${mode} in
	#johdonmukaisuuden vuoksi 3|4) jatkossa (imp2/exp2)
	0)
		echo "NOT SUPPORTED ANYMORE"
		exit 99
	;;
	3|4) #261125:case 0 teki silloin toimivan paketin /nykyään case 3, josqs uusi testaus)
		#301125:case 4 tekee paketin, sisältö toiminee
		[ ${debug} -eq 1 ] && ${srat} -tf ${tgtfile} 
		csleep 2

		e22_ext ${tgtfile} ${distro} ${dnsm}
		dqb "e22_ext DON3, next:rm some rchives"
		csleep 2

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar
		dqb "srat= ${srat}"
		csleep 2

		e22_hdr ${d}/f.tar
		e22_cleanpkgs ${d}

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 3 ] ; then
			e22_tblz ${d} ${iface} ${distro} ${dnsm}
			e22_other_pkgs ${dnsm}
	
			if [ -d ${d} ] ; then
				#enf_scc ulos d-blokista vai ei?
				e22_dblock ${d}/f.tar ${d}
			fi

			e22_cleanpkgs ${d} #kuinka oleellinen?
			[ ${debug} -eq 1 ] && ls -las ${d}
			csleep 2
		fi

		${sifd} ${iface}
		[ ${debug} -eq 1 ] && ls -las ${d}
		csleep 2
 	
		e22_home ${tgtfile} ${d} ${enforce} 
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}
		csleep 2
		${NKVD} ${d}/*.tar #oli se fktiokin

		e22_pre1 ${d} ${distro}
		dqb "B3F0R3 RP2	"
		csleep 2	
		e22_elocal ${tgtfile} ${iface} ${dnsm} ${enforce}
	;;
#	1|u|upgrade) #261125:tämän casen luoman arkiston sisältämät paketit asentuivat
#		#251125:näyttää tosiaan siltä että päivityspaketin purkaminen itsessään ei riko slimiä, sisällön asentaminen sen sijaan...
#		e22_upgp ${tgtfile} ${d} ${iface}
#
#		e22_ts ${d}
#		${srat} -cf ${1} ${d}/tim3stamp
#		t=$(echo ${d} | cut -d '/' -f 1-5)
#	
#		enforce_access ${n} ${t}
#		e22_arch ${tgtfile} ${d}
#	;;
	p) #HUOM.291125;tekee pak
		e22_settings2 ${tgtfile} ${d0} 
	;;
	e)
		#241125 testattu sen verran että slim ei mennyt rikki ja .deb-pak vissiin asentuivat
		#251125:uudistettukin versio näyttää ulostavan toimivan paketin
		#261125:toimii edelleen vaikka e22_hdr() karsittu
		#301125:tekee paketin, sisällön toimivuus vielä testattava		

		e22_cleanpkgs ${d}
		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_other_pkgs ${dnsm}

		if [ -d ${d} ] ; then
			e22_dblock ${tgtfile} ${d}
		fi
	;;
	t) 
		#301125:tekee paketin, sisällön toimivuus vielä testattava
		e22_cleanpkgs ${d}
		e22_cleanpkgs ${pkgdir}
			
		message
		csleep 3

		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_ts ${d}

		t=$(echo ${d} | cut -d '/' -f 1-5)
		enforce_access ${n} ${t}
		e22_arch ${tgtfile} ${d}
	;;
	*) #281025:tämäkin toiminee
		echo "-h"
		exit
	;;
esac

if [ -s ${tgtfile} ] ; then
	e22_ftr ${tgtfile}
fi
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
	echo "$0 å ... somehow related 2 pavcontrol (TODO)"		
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

case ${mode} in
	f) #121125:uudelleenpakkaus toimii nykyään		
		#...koita muistaa śaada aikaiseksi se sha512sums.sig kanssa josqs(TODO)
		
		e22_arch ${tgtfile} ${d}
		e22_ftr ${tgtfile}
		exit
	;;
	q)
		#HUOM.021125:tekee paketin
		#TODO:ffox 147 muutokset
		${sifd} ${iface}
		e22_settings ~ ${d0}

		#josko takaisin siihen että vain oikeasti tarpeelliset mukaan(TODO)

		for f in $(find ~ -maxdepth 1 -name '*.tar' -or -name '*.bz2' -or -name 'profs.sh') ; do
			${srat} -rvf ${tgtfile} ${f} #--exclude vai ei?
		done

		e22_ftr ${tgtfile}
		dqb "CASE Q D0N3"
		csleep 3
		exit
	;;
	c)
		#HUOM. 021125:tekee paketin
		cd ${d0}
		for f in $(find . -type f -name '*.sh' | grep -v 'e/') ; do ${srat} -rvf ${tgtfile} ${f} ; done #tähän ei tarvinne --exclude?
		for f in $(find . -type f -name '*_pkgs*' | grep -v 'e/')  ; do ${srat} -rvf ${tgtfile} ${f} ; done
				
		bzip2 ${tgtfile}
		mv ${tgtfile}.bz2 ${tgtfile}.bz3
		tgtfile="${tgtfile}".bz3 #tarkoituksella tämä pääte 

		e22_ftr ${tgtfile}
		exit
	;;
	g)
		#HUOM.021125:vaikuttaisi tulevan järkevää outputtia pl. ehkä reinstall sellaisenaan 
		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=gpg=2.2.40-1.1+deb12u1
		dqb "sudo apt-get update"

		echo "${shary} ${E22GI}"
		echo "${svm} ${pkgdir}/*.deb ${d}"
		echo "$0 f ${tgtfile} ${distro}"
		exit 1
	;;
	å)
		dqb "${sag_u}"
		#muut jos löytyisi jo
		echo "${shary} libatkmm libcanberra-gtk3-0 libcanberra0 libglib2.0-0 libglibmm-2.4-1v5 libgtk-3-0 libgtkmm-3.0-1v5 libjson-glib-1.0-0 libpulse-mainloop-glib0 libpulse0 libsigc++-2.0-0v5"
		echo "${shary} pavucontrol"
		echo "${svm} ${pkgdir}/*.deb ${d}"
		echo "$0 f ${tgtfile} ${distro}"
		exit 1
		
	;;
	-h)
		usage
	;;
esac

e22_pre1 ${d} ${distro}
#tgtfile:n kanssa muitakin tarkistuksia kuin -z ?
[ ${debug} -eq 1 ] && pwd;sleep 6

[ -x /opt/bin/changedns.sh ] || echo "SHOULD exit 59" #tilapäisesti jemmaan kunnes x
#...saisiko yo skriptin jotenkin yhdistettyä ifup:iin? siihen kun liittyy niitä skriptejä , post-jotain.. (ls /etc/network)

e22_hdr ${tgtfile}
e22_pre2 ${d} ${distro} ${iface} ${dnsm}

case ${mode} in
	0|4)
		#121125:nämä caset tekevät toimivan paketin
		#, myös f.tar paketit asentuivat eneimmäkseen, joistain tuli nalkutusta

		[ ${debug} -eq 1 ] && ${srat} -tf ${tgtfile} 
		csleep 3

		e22_ext ${tgtfile} ${distro} ${dnsm}
		dqb "e22_ext DON3, next:rm some rchives"
		csleep 3

		[ -f ${d}/e.tar ] && ${NKVD} ${d}/e.tar
		[ -f ${d}/f.tar ] && ${NKVD} ${d}/f.tar

		dqb "srat= ${srat}"
		csleep 5

		e22_hdr ${d}/f.tar
		e22_cleanpkgs ${d}

		#HUOM.31725:jatkossa jos vetelisi paketteja vain jos $d alta ei löydy?
		if [ ${mode} -eq 0 ] ; then
			#HUOM.121125:2 seuraavaa fktiota, onko niiden kanssa jotain ongelmaa vaiko ei?
			e22_tblz ${d} ${iface} ${distro} ${dnsm}
			e22_get_pkgs ${dnsm}
	
			if [ -d ${d} ] ; then
				e22_dblock ${d}/f.tar ${d}
			fi

			e22_cleanpkgs ${d} #kuinka oleellinen?
			[ ${debug} -eq 1 ] && ls -las ${d}
			csleep 5
		fi

		${sifd} ${iface}
		[ ${debug} -eq 1 ] && ls -las ${d}
		csleep 5
 	
		e22_home ${tgtfile} ${d} ${enforce} 
		[ ${debug} -eq 1 ] && ls -las ${tgtfile}
		csleep 4
		${NKVD} ${d}/*.tar #oli se fktiokin

		e22_pre1 ${d} ${distro}
		dqb "B3F0R3 RP2	"
		csleep 5	
		e22_elocal ${tgtfile} ${iface} ${dnsm} ${enforce}
	;;
	1|u|upgrade) #121125:toimii nyt testatusti jollain lailla
		e22_cleanpkgs ${d}
		e22_upgp ${tgtfile} ${d} ${iface}
	;;
	p) #HUOM. 021125:tekee paketin
		e22_settings2 ${tgtfile} ${d0} 
	;;
	e)  #HUOM.021125:tekee edelleen paketin			
		e22_cleanpkgs ${d}
		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_get_pkgs ${dnsm}

		if [ -d ${d} ] ; then
			e22_hdr ${d}/f.tar
			e22_dblock ${d}/f.tar ${d}
			cd ${d}
			${srat} -rvf ${tgtfile} ./f.tar #tämäkö jäi puuttumaan?
		fi
	;;
	t) #HUOM.021125:edelleen tekee paketin missä toivottavaa sisältöä
		e22_cleanpkgs ${d}
		e22_cleanpkgs ${pkgdir}
			
		message
		csleep 6

		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_ts ${d}
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
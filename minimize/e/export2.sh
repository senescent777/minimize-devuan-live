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
	echo "$0 å ... somehow related 2 pavucontrol " #VAIH		
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
	f) 	#241125:joskohan nykyään jo toimisi
		#...koita muistaa śaada aikaiseksi se sha512sums.sig kanssa josqs(TODO)
		
		enforce_access ${n} ${t}
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
		#HUOM.021125:vaikuttaisi tulevan järkevää outputtia 
		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=gpg=2.2.40-1.1+deb12u1
		dqb "sudo apt-get update"

		echo "${shary} ${E22GI}"
		echo "${svm} ${pkgdir}/*.deb ${d}"
		echo "$0 f ${tgtfile} ${distro}"
		exit 1
	;;
	å) #241125:testattu, oksentaa toimivia komentoja, lisäksi:
	#1. libgtkmm ja libpangomm  riippuvuuksineen aiheutti nalkutusta, pitäisi niitä listoja päivittää vissiin + riippuvuuksien kanssa vielä iterointia
	#2. "$0 f" tekemä paketti ei paskonut:slim
 
		dqb "${sag_u}"


		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libstdc++6=12.2.0-14+deb12u1&eXtra=176.93.249.62
		# Depends:gcc-12-base (= 12.2.0-14+deb12u1), libc6 (>= 2.36), libgcc-s1 (>= 4.2)

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libsigc++-2.0-0v5=2.12.0-1&eXtra=176.93.249.62
		# Depends:libc6 (>= 2.4), libgcc-s1 (>= 3.0), libstdc++6 (>= 4.6)

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libpulse0=16.1+dfsg1-2+b1&eXtra=176.93.249.62
		# Depends:libasyncns0 (>= 0.3), libc6 (>= 2.34), libdbus-1-3 (>= 1.9.14), libsndfile1 (>= 1.0.20), libsystemd0, libx11-6, libx11-xcb1 (>= 2:1.8.1), libxcb1

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libpulse-mainloop-glib0=16.1+dfsg1-2+b1&eXtra=176.93.249.62
		# Depends:libc6 (>= 2.4), libglib2.0-0 (>= 2.28.0), libpulse0 (= 16.1+dfsg1-2+b1)

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libjson-glib-1.0-0=1.6.6-1&eXtra=176.93.249.62
		# Depends:libjson-glib-1.0-common (>= 1.6.6-1), libc6 (>= 2.4), libglib2.0-0 (>= 2.55.2)

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libgtkmm-3.0-1v5=3.24.7-1&eXtra=176.93.249.62
		# Depends:libatkmm-1.6-1v5 (>= 2.28.3), libc6 (>= 2.14), libcairomm-1.0-1v5 (>= 1.14.3), libgcc-s1 (>= 3.0), libgdk-pixbuf-2.0-0 (>= 2.35.5), libglib2.0-0 (>= 2.41.1), libglibmm-2.4-1v5 (>= 2.66.4), libgtk-3-0 (>= 3.24.0), libpangomm-1.4-1v5 (>= 2.46.2), libsigc++-2.0-0v5 (>= 2.6.1), libstdc++6 (>= 5.2)

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libgtk-3-0=3.24.38-2~deb12u3&eXtra=176.93.249.62
		# Depends:<isompi läjä>

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libglibmm-2.4-1v5=2.66.5-2&eXtra=176.93.249.62
		# Depends:libc6 (>= 2.32), libgcc-s1 (>= 3.0), libglib2.0-0 (>= 2.61.2), libsigc++-2.0-0v5 (>= 2.9.1), libstdc++6 (>= 11)
		
		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libglib2.0-0=2.74.6-2+deb12u7&eXtra=176.93.249.62
		# Depends:libc6 (>= 2.34), libffi8 (>= 3.4), libmount1 (>= 2.35.2-7~), libpcre2-8-0 (>= 10.22), libselinux1 (>= 3.1~), zlib1g (>= 1:1.2.2)

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libcanberra0=0.30-10
		# Depends:libasound2 (>= 1.0.16), libc6 (>= 2.33), libltdl7 (>= 2.4.7), libtdb1 (>= 1.2.7+git20101214), libvorbisfile3 (>= 1.1.2), sound-theme-freedesktop

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libcanberra-gtk3-0=0.30-10&eXtra=176.93.249.62
		# Depends:libc6 (>= 2.4), libcanberra0 (>= 0.12), libglib2.0-0 (>= 2.12.0), libgtk-3-0 (>= 3.0.0), libx11-6

		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=libatkmm-1.6-1v5=2.28.3-1&eXtra=176.93.249.62
		# Depends:libatk1.0-0 (>= 2.12.0), libc6 (>= 2.4), libgcc-s1 (>= 3.0), libglib2.0-0 (>= 2.33.14), libglibmm-2.4-1v5 (>= 2.66.4), libsigc++-2.0-0v5 (>= 2.2.0), libstdc++6 (>= 4.1.1)


		#https://pkginfo.devuan.org/cgi-bin/package-query.html?c=package&q=pavucontrol=5.0-2&eXtra=176.93.249.62
		echo "${shary} libpangomm-1.4-1v5 libcairomm-1.0-1v5 libglibmm-2.4-1v5 libatkmm-1.6-1v5 libcanberra-gtk3-0 libcanberra0 libglib2.0-0 libgtk-3-0 libgtkmm-3.0-1v5 libjson-glib-1.0-0 libpulse-mainloop-glib0 libpulse0 libsigc++-2.0-0v5 libstdc++6 "
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
		#241125:case 4 tekee toimivan paketin (entä 0?)
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
			e22_other_pkgs ${dnsm}
	
			if [ -d ${d} ] ; then
				#enf_scc ulos d-blokista vai ei?
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
	1|u|upgrade) #VAIH:testaapa uusicksi TAAAS
		#e22_cleanpkgs ${d} #tarpeellinen?
		e22_upgp ${tgtfile} ${d} ${iface}

		e22_ts ${d}
		${srat} -cf ${1} ${d}/tim3stamp
		t=$(echo ${d} | cut -d '/' -f 1-5)
	
		enforce_access ${n} ${t}
		e22_arch ${tgtfile} ${d}
	;;
	p) #HUOM. 021125:tekee paketin
		e22_settings2 ${tgtfile} ${d0} 
	;;
	e)
		#241125 testattu sen verran että slim ei mennyt rikki ja .deb-pak vissiin asentuivat
		#VAIH:jotenkin kätevästi muodostetun pkaetin purq&asennus (import2 pikemminkin?)
		#eli uudemman kerran muodostetutun paketin teStaus

		e22_cleanpkgs ${d}
		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_other_pkgs ${dnsm}

		if [ -d ${d} ] ; then
			#$d/f,tar -> $tggile?

			e22_hdr ${tgtfile} #${d}/f.tar
			e22_dblock ${tgtfile} ${d}  #${d}/f.tar ${d}

			#cd ${d}
			#${srat} -rvf  ./f.tar #tämäkö jäi puuttumaan?
		fi
	;;
	t) 
		#241125 ensimmäisellä yrityksellä ei saanut aikaiseksi .deb-pak sis tar, uusi yritys kohta
		#toisella syntyi jo toimiva pak

		e22_cleanpkgs ${d}
		e22_cleanpkgs ${pkgdir}
			
		message
		csleep 6

		e22_tblz ${d} ${iface} ${distro} ${dnsm}
		e22_ts ${d}

		t=$(echo ${d} | cut -d '/' -f 1-5) #josko nyt?
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
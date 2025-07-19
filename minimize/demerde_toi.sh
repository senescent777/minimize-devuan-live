#!/bin/bash

#HUOM. näiden skriptien kanssa bash tulkkina aiheuttaa vähemmän nalkutusta kuin sh
debug=0
branch=""

#VAIH:jos mahd ni git hakemaan vaihToehtoisen oksan? man-sivuja pitäisi taas kahlata niin maan perkeleesti ja tasaiseenm
#TODO:mktemp-kikkailut pois, plain old git clone tilalle ja täts it
#VAIH:tämäkin modatun kiekon squashfs sisälle (aluksi modattuun .iso:on)

function parse_opts_1() {
	dqb "p1"
}

function parse_opts_2() {
	dqb "p2"
}

#if [ -x ~/Desktop/minimize/common_lib.sh ] ; then #TODO:includointi jatkossa toisin
#	. ~/Desktop/minimize/common_lib.sh #HUOM. tarvitsiko tästä jota9in?
#fi

#tig ja mkt alustukset jatkossa check_binaries():iin? no mkt ehkä
tig=$(sudo which git)

if [ x"${tig}" == "x" ] ; then
	echo "sudo apt-get install git"
	exit 7
fi

mkt=$(which mktemp)
if [ x"${mkt}" == "x" ] ; then
	echo "sudo apt-get install mktemp"
	exit 7
fi

#parametrie nkäsittely voisi mennä fiksumminkin
if [ $# -gt 0 ] ; then
	dqb "params_ok"

	if [ "${1}" == "-v" ] ; then
		debug=1
		branch=${2}
	else
		branch=${1}
		[ "${2}" == "-v" ] && debug=1
	fi
else
	echo "${0} [-v] [branch] | ${0} [branch] [-v]"
	exit 66
fi

dqb "branch=${branch}"
q=$(${mkt} -d)
cd ${q}

dqb "BFROE tig"
csleep 2

${tig} clone https://github.com/senescent777/minimize-devuan-live.git
[ $? -gt 0] && exit #onko tässä jokin juttu?

dqb "TGI KO"
csleep 2

cd minimize-devuan-live
[ ${debug} -eq 1 ] && ls -laRs;sleep 3
#[ -d ~/Desktop/minimize ] || mkdir ~/Desktop/minimize;sleep 3 #TODO:uusiksi t kohta

dqb "mkdir d00n3"
csleep 2

#qsee vai ei?
#if [ ! -s  ~/Desktop/minimize.OLD.tar ] ; then TODO:uusiksi tää blokki
#	tar -cvf ~/Desktop/minimize.OLD.tar ~/Desktop/minimize
#else
#	dqb "minimize.OLD.tar exists"		
#fi
	
dqb "tar done"
csleep 2

#TODO:uusix ao. 2 riviä
#for f in $(find ~/Desktop/minimize -type f -name '*.sh') ; do rm ${f} ; done
#for f in $(find ~/Desktop/minimize -type f -name '*.desktop') ; do rm ${f} ; done
dqb "RM D0N3"
csleep 2

#cp minimize/* ~/Desktop/minimize #cp toiminee paremminq mv TODO
#mv isolinux ~/Desktop/
#mv boot  ~/Desktop/
deb "D0N3 M0V1NG"
csleep 2

#if [ -x ~/Desktop/minimize/common_lib.sh ] ; then
#	. ~/Desktop/minimize/common_lib.sh
#	enforce_access ${n}
#else
#	${sco} 0:0 /
#	${scm} 0755 /
#	${sco} 0:0 /home
#	${scm} 0755 /home
#
#	${sco} -R ${n}:${n} ~ 
#	${scm} -R a-wx ~/Desktop/minimize
#	${scm} 0755 ~/Desktop/minimize 
#
#	for t in $(find ~/Desktop/minimize -type d) ; do ${scm} 0755 ${t}; done
#	for t in $(find ~/Desktop/minimize -type f -name '*.sh') ; do ${scm} 0755 ${t}; done
#	for t in $(find ~/Desktop/minimize -type f -name 'conf*') ; do ${scm} 0444 ${t}; done
#	for t in $(find ~/Desktop/minimize -type f -name '*.deb') ; do ${scm} 0444 ${t}; done
#	
#	${sco} 0:0 ~/Desktop/minimize/changedns.sh
#	${scm} 0555 ~/Desktop/minimize/changedns.sh
#fi
#
#cd ~/Desktop/minimize
echo "./export2.sh 0 /tmp/vomit.tar \${distro}"
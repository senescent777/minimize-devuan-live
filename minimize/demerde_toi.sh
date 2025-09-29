#!/bin/bash
#HUOM. näiden skriptien kanssa bash tulkkina aiheuttaa vähemmän nalkutusta kuin sh
debug=0
branch=""
d0=$(pwd)
echo "d0=${d0}"

#VAIH:jos mahd ni git hakemaan vaihToehtoisen oksan? man-sivuja pitäisi taas kahlata niin maan perkeleesti ja tasaiseenm
#TODO:mktemp-kikkailut pois, plain old git clone tilalle ja täts it ?
#HUOM.020825:jos tämä poistaa $distro/lib.sh niin korjattava ei-poistamaan (vimmeisi oli pikemmnkin conf)

function parse_opts_1() {
	dqb "p1"
}

function parse_opts_2() {
	dqb "p2"
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh #HUOM. tarvitsiko tästä jota9in?
fi

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

#TODO:konftdstoon urlin alkuosa?
${tig} clone https://github.com/senescent777/minimize-devuan-live.git
[ $? -gt 0 ] && exit

dqb "TGI KO"
csleep 2

cd minimize-devuan-live
[ ${debug} -eq 1 ] && ls -laRs;sleep 3
[ -d ${d0} ] || mkdir ${d0};sleep 3

dqb "mkdir d00n3"
csleep 2

#qsee vai ei?
if [ ! -s  ${d0}.OLD.tar ] ; then
	tar -cvf ${d0}.OLD.tar ${d0}
else
	dqb "minimize.OLD.tar exists"		
fi
	
dqb "tar done"
csleep 2

#joutuisi oikeastaan muuttamaan? mutta antaa olla koska x
for f in $(find ${d0} -type f -name '*.sh') ; do rm ${f} ; done
for f in $(find ${d0} -type f -name '*.desktop') ; do rm ${f} ; done

dqb "RM D0N3"
csleep 2

#TODO:alihmistojen sisältö tulisi kopsata kanssa
cp minimize/* ${d0}

#mv isolinux ~/Desktop/ #tarttisikohan näille tehdä jotain?
#mv boot  ~/Desktop/
dqb "D0N3 M0V1NG"
csleep 2

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh
	enforce_access ${n}
else
	${sco} 0:0 /
	${scm} 0755 /
	${sco} 0:0 /home
	${scm} 0755 /home

	${sco} -R ${n}:${n} ~ 
	${scm} -R a-wx ${d0}
	${scm} 0755 ${d0} 

	for t in $(find ${d0} -type d) ; do ${scm} 0755 ${t}; done
	for t in $(find ${d0} -type f -name '*.sh') ; do ${scm} 0755 ${t}; done
	for t in $(find ${d0} -type f -name 'conf*') ; do ${scm} 0444 ${t}; done
	for t in $(find ${d0} -type f -name '*.deb') ; do ${scm} 0444 ${t}; done
	
	${sco} 0:0 ${d0}/changedns.sh
	${scm} 0555 ${d0}/changedns.sh

	${sco} 0:0 /opt/bin/changedns.sh
	${scm} 0555 /opt/bin/changedns.sh
fi

cd ${d0}
echo "./export2.sh 0 /tmp/vomit.tar \${distro}"
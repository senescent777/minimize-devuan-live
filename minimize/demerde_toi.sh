#!/bin/bash
#HUOM. näiden skriptien kanssa bash tulkkina aiheuttaa vähemmän nalkutusta kuin sh
debug=0
branch=""
d0=$(pwd)
echo "d0=${d0}"

#TODO:mktemp-kikkailut pois, plain old git clone tilalle ja täts it
#HUOM.020825:jos tämä poistaa $distro/lib.sh niin korjattava ei-poistamaan (vimmeisi oli pikemmnkin conf)

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

function parse_opts_1() {
	dqb "p1"
}

function parse_opts_2() {
	dqb "p2"
}

if [ -x ${d0}/common_lib.sh ] ; then
	. ${d0}/common_lib.sh #mihin tätä tarvitaan nykyään?
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

if [ ! -z ${branch} ] ; then
	branch="--branch ${branch} "
fi

#TODO:jatkossa tämä skripti toiseen hakemistoon
dqb "branch=${branch}"
q=$(${mkt} -d)
cd ${q}
[ ${debug} -eq 1 ] && pwd
dqb "BFROE tig"
csleep 2

BASEURL="github.com/senescent777"
${tig} clone ${branch} https://${BASEURL}/minimize-devuan-live.git 
[ $? -gt 0 ] && exit
#exit

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

cp minimize/* ${d0}
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
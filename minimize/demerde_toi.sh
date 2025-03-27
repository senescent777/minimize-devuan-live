#!/bin/bash

#HUOM. näiden skriptien kanssa bash tulkkina aiheuttaa vähemmän nalkutusta kuin sh
debug=0
branch=""
#VAIH:jos mahd ni git hakemaan vaihToehtoisen oksan?
#TODO:mktemp-kikkailut pois, plain old git clone tilalle ja täts it

if [ -x ~/Desktop/minimize/common_lib.sh ] ; then
	. ~/Desktop/minimize/common_lib.sh #HUOM. tarvitsiko tästä jota9in?
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

${tig} clone https://github.com/senescent777/minimize-devuan-live
cd minimize-devuan-live
[ ${debug} -eq 1 ] && ls -laRs;sleep 6

[ -d ~/Desktop/minimize ] || mkdir  ~/Desktop/minimize;sleep 6

#if [ -d ~/Desktop/minimize ] ; then
	#lototaan aiemman sisällön kanssa vaikka näin
	if [ ! -d ~/Desktop/minimize.OLD ] ; then
		mkdir ~/Desktop/minimize.OLD
		mv ~/Desktop/minimize/* ~/Desktop/minimize.OLD
	else
		rm ~/Desktop/minimize/*
	fi

	csleep 6
	mv minimize/* ~/Desktop/minimize
#fi

#jos tämä ao. oikeuksien sorkkiminen olisi hyvä
n=$(whoami)
${sco} -R ${n}:${n} ~ 
${scm} -R a-wx ~/Desktop/minimize
${scm} 0755 ~/Desktop/minimize 

for t in $(find ~/Desktop/minimize -type d) ; do ${scm} 0755 ${t}; done
for t in $(find ~/Desktop/minimize -type f -name '*.sh') ; do ${scm} 0755 ${t}; done
for t in $(find ~/Desktop/minimize -type f -name 'conf*') ; do ${scm} 0444 ${t}; done
for t in $(find ~/Desktop/minimize -type f -name '*.deb') ; do ${scm} 0444 ${t}; done

${sco} 0:0 ~/Desktop/minimize/changedns.sh
${scm} 0555 ~/Desktop/minimize/changedns.sh

cd ~/Desktop/minimize
echo "./export2.sh 0 /tmp/vomit.tar \${distro}"
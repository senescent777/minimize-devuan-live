#!/bin/bash

#HUOM. näiden skriptien kanssa bash tulkkina aiheuttaa vähemmän nalkutusta kuin sh
debug=0
distro="" #HUOM.250325:aika turha tuo distro tässä skriptissä
branch=""
#VAIH:jos mahd ni git hakemaan vaihToehtoisen oksan?

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
	distro=${1}

	if [ "${2}" == "-v" ] ; then
		debug=1
		branch=${3}
	else
		branch=${2}
		[ "${3}" == "-v" ] && debug=1
	fi
else
	echo "${0} <distro> [-v] [branch] | ${0} <distro> [branch] [-v]"
	exit 66
fi

if [ -d ~/Desktop/minimize/${distro} ] ; then
	dqb "tgt dir exists"
else
	echo "NO SUCH THING AS ~/Desktop/minimize/${distro} "
	exit 67
fi

dqb "distro=${distro}"
dqb "branch=${branch}"

q=$(${mkt} -d)
cd ${q}

${tig} clone https://github.com/senescent777/minimize-devuan-live
cd minimize-devuan-live
[ ${debug} -eq 1 ] && ls -laRs;sleep 6

if [ -d ~/Desktop/minimize ] ; then
	#fiksummankin systeemin voisi keksiä mutta nyt näin
	mv ~/Desktop/minimize ~/Desktop/minimize.OLD
	mv minimize/* ~/Desktop/minimize
fi

chmod 0755 ~/Desktop/minimize/${distro}
chmod 0755 ~/Desktop/minimize/${distro}/*.sh

cd ~/Desktop/minimize
echo "./export2.sh 0 /tmp/vomit.tar ${distro}"
#!/bin/bash
#HUOM. näiden skriptien kanssa bash tulkkina aiheuttaa vähemmän nalkutusta kuin sh
debug=1

if [ -x ~/Desktop/minimize/common_lib.sh ] ; then
	. ~/Desktop/minimize/common_lib.sh #HUOM. tarvitsiko tästä jota9in?
fi

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
else
	echo "P.V.HH"
	exit 66
fi

if [ -d ~/Desktop/minimize/${1} ] ; then
	dqb "tgt dir exists"
else
	echo "NO SUCH THING AS ~/Desktop/minimize/${1} "
	exit 67
fi

q=$(${mkt} -d)
cd ${q}

${tig} clone https://github.com/senescent777/minimize-devuan-live
cd minimize-devuan-live
[ ${debug} -eq 1 ] && ls -laRs;sleep 10

if [ -d ~/Desktop/minimize ] ; then #HUOM. pitäisköhän tämä muuttaa?
	#echo "shred -fu ~/Desktop/minimize/* "
	echo "rm -rf ~/Desktop/minimize/*"
	echo "mv minimize/* ~/Desktop/minimize"
fi

${scm} 0755 ~/Desktop/minimize/${1}
${scm} 0755 ~/Desktop/minimize/${1}/*.sh

cd ~/Desktop/minimize
echo "./export2.sh 0 /tmp/vomit.tar ${1}"
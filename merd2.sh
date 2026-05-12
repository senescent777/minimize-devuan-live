#!/bin/bash
debug=0
branch=""
d0=$(pwd)

CONF_BASEURL="github.com/senescent777"
CONF_BASE=minimize
CONF_PT2=minimize-devuan-live
CONF_LIB=minimize/common_lib.sh
distro=$(cat /etc/devuan_version)

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

#TODO:näiden 2 hyväksi jotain josqs
#function parse_opts_1 () {}
#function parse_opts_2 () {}

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
	echo "${0} [-v] <branch> | ${0} <branch> [-v]"
	exit 66
fi

if [ ! -z "${branch}" ] ; then
	branch=$(echo ${branch} | tr -dc a-zA-Z0-9/.)
	branch="--branch ${branch}"
fi

dqb "branch=${branch}"
tig=$(sudo which git)

if [ -z "${tig}" ] ; then
	echo "sudo apt-get install git"
	exit 7
fi

if [ -d ./${CONF_PT2} ] ; then
	dqb "rm -rf ./${CONF_PT2} SOON"
	csleep 3
	rm -rf ./${CONF_PT2}
	[ $? -gt 0 ] && exit
fi

csleep 2

dqb "BFROE tig"
csleep 2
${tig} clone ${branch} https://${CONF_BASEURL}/${CONF_PT2}.git
[ $? -gt 0 ] && exit

dqb "TGI KO"
csleep 2

#HUOM.konfiguraatio olisi hyvä jättää hukkaamatta, toisaalta wanhat tauhkat hyvä saada pois sotkemasta
#(conf kanssa olisi hyvä keksiä jotain josqs, jos ei muuten niin conf.example)

#VAIH:toisestakin sijainnista voisi yrittää
if  [ -s ./${CONF_BASE}/${distro}/conf ] ; then
	sudo cp ./${CONF_BASE}/${distro}/conf ./$(whoami).conf
else
	if [ -s ./${CONF_BASE}.OLD/${distro}/conf ] ; then
		sudo cp ./${CONF_BASE}.OLD/${distro}/conf ./$(whoami).conf
	else
		exit 58
	fi
fi

ls -las ./*.conf
csleep 5
exit 59

if [ -d  ./${CONF_BASE}.OLD ] ; then
	for f in $(find ./${CONF_BASE}.OLD -type f -not -name conf) ; do
		dqb "sudo rm ${f}"
		sudo rm ${f}
		csleep 1
	done
fi

sudo mv ./${CONF_BASE} ./${CONF_BASE}.OLD
mv ./${CONF_PT2}/* .
[ -s ./${CONF_LIB} ] && chmod 0555 ./${CONF_LIB} 

dqb "FN0C"
csleep 1

if [ ! -s ./${CONF_BASE}.OLD/${distro}/conf ] ; then
	dqb "N0 SUCH THNG AS ./${CONF_BASE}.OLD/${distro}/conf"
fi

dqb "NEXT:common_lib"
csleep 1

if [ -x ./${CONF_LIB} ] ; then
	#TODO?:/o/b-juttuja oli kanssa? (mv lähinnä)
	for d in $(find ${d0} -type f -name "*.sh") ; do chmod 0555 ${d} ; done

	#. ./${CONF_LIB}
	#enforce_access $(whoami) ${d0}/${CONF_BASE}

	sudo chmod 0511 /opt/bin/*.bash
	#josko nyt jo?
	for d in $(find ${d0} -type f -name "*.sh") ; do chmod 0555 ${d} ; done
else
	echo "SMTHING WR0NG W/ ${CONF_LIB}"
fi

#210426:vissiin onnistui jo vetämään 7thson-oksan, kertaalleen?
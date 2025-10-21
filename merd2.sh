#!/bin/bash
debug=0
branch=""
d0=$(pwd)
echo "d0=${d0}"
BASEURL="github.com/senescent777"
#VAIH:MUUTOKSET TAKAISIN PRKL TAAS!!!!!
PT2=minimize-devuan-live

function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

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
	branch="--branch ${branch}"
fi

dqb "branch=${branch}"
tig=$(sudo which git)

if [ x"${tig}" == "x" ] ; then
	echo "sudo apt-get install git"
	exit 7
fi

dqb "BFROE tig"
csleep 2
${tig} clone ${branch} https://${BASEURL}/${PT2}.git
[ $? -gt 0 ] && exit

dqb "TGI KO"
csleep 2
echo "JA SIT JOTAIN (TODO)"

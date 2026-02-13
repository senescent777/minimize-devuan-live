#!/bin/bash
debug=0
branch=""
d0=$(pwd)
echo "d0=${d0}"
BASEURL="github.com/senescent777"
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
	echo "${0} [-v] <branch> | ${0} <branch> [-v]"
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

#pitäisiköhän ao. rivien shteen thdä jtain?
echo "mv minimize minimize.OLD"
echo "mv ${PT2}/* ."
echo "[ -x minimize/common_lib.sh ] && . minimize/common_lib.sh"
echo "[ -x minimize/common_lib.sh ] && enforce_access \${n} \${t} "
echo "mv minimize.OLD/\$distro/conf minimize/\$distro"

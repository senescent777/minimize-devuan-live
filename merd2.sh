#!/bin/bash
debug=0
branch=""
d0=$(pwd)
echo "d0=${d0}"
CONF_BASEURL="github.com/senescent777"
CONF_PT2=minimize-devuan-live
distro=$(cat /etc/devuan_version)

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

if [ ! -z "${branch}" ] ; then
	branch=$(echo ${branch} | tr -dc a-zA-Z0-9/.)
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
${tig} clone ${branch} https://${CONF_BASEURL}/${CONF_PT2}.git
[ $? -gt 0 ] && exit

dqb "TGI KO"
csleep 2

#020426:toimii
mv minimize minimize.OLD
mv ${CONF_PT2}/* .

#TODO:voisi taas selvittää, ovatko 1take-haaran matskut toimintaqntoisia? (7426) 
[ -x minimize/common_lib.sh ] && . minimize/common_lib.sh
[ -x minimize/common_lib.sh ] && enforce_access $(whoami) ${d0}/minimize
mv minimize.OLD/${distro}/conf minimize/${distro}

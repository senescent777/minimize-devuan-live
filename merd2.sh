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

if [ -z "${tig}"  ] ; then
	echo "sudo apt-get install git"
	exit 7
fi

dqb "rm -rf  ${CONF_PT2} SOON"
csleep 3
[ -d ${CONF_PT2} ] && rm -rf ${CONF_PT2}
[ $? -gt 0 ] && exit
csleep 2

dqb "BFROE tig"
csleep 2
${tig} clone ${branch} https://${CONF_BASEURL}/${CONF_PT2}.git
[ $? -gt 0 ] && exit

dqb "TGI KO"
csleep 2

#020426:toimii
mv minimize minimize.OLD
mv ${CONF_PT2}/* .

#DONE:voisi taas selvittää, ovatko 1take-haaran matskut toimintaqntoisia? enimmäkseen (130426)
#TODO:sen man1.  - jutut kys- haaran e22:seen? vai sittenkin e/update2 else-haara hoitamaan?
[ -s minimize/common_lib.sh ] && chmod 0555 minimize/common_lib.sh 
echo $?

dqb "FN0C"
csleep 1

if [ -s minimize.OLD/${distro}/conf ] ; them
	mv minimize.OLD/${distro}/conf minimize/${distro}
else
	dqb "V.M.P"
fi

dqb "NEXT:common_lib"
csleep 1

if [ -x minimize/common_lib.sh ] ; then
	#TODO:/o/b-juttuja oli kanssa

	#josko nyt jo?
	for d in $(find ${d0} -type f -name "*.sh") ; do chmod 0555 ${d} ; done

	#140426:knftydston puute kenteis estää seur rivien toiminnan (tekisikö jotain?)
	. minimize/common_lib.sh
	enforce_access $(whoami) ${d0}/minimize

	#josko nyt jo?
	for d in $(find ${d0} -type f -name "*.sh") ; do chmod 0555 ${d} ; done
else
	echo "SMTHING WR0NG W/ minimize/common_lib"
fi




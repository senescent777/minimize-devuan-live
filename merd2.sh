#!/bin/bash
debug=0
branch=""
d0=$(pwd)
echo "d0=${d0}"
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

if [ x"${tig}" == "x" ] ; then
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

#tässä jotain sössimistä?
mv ./${CONF_BASE} ./${CONF_BASE}.OLD
mv ./${CONF_PT2}/* .

[ -s ./${CONF_LIB} ] && chmod 0555 ./${CONF_LIB} 
echo $?

dqb "FN0C"
csleep 1

#160426:TOIMIIKO TÄMÄ KOHTA VAI EI?
if [ -s ./${CONF_BASE}.OLD/${distro}/conf ] ; then
	mv ./${CONF_BASE}.OLD/${distro}/conf ./${CONF_BASE}/${distro}/conf
else
	dqb "N0.C0NF"
fi

echo $?
dqb "NEXT:common_lib"
csleep 1

if [ -x ./${CONF_LIB} ] ; then
	#TODO:/o/b-juttuja oli kanssa

	#josko nyt jo?
	for d in $(find ${d0} -type f -name "*.sh") ; do chmod 0555 ${d} ; done

	#TODO:konftdston kanssa jotain
	#TODO:"exp2 4" urputtamaan jos profs.sh puuttuu

	. ./${CONF_LIB}
	enforce_access $(whoami) ${d0}/${CONF_BASE}

	#josko nyt jo?
	for d in $(find ${d0} -type f -name "*.sh") ; do chmod 0555 ${d} ; done
else
	echo "SMTHING WR0NG W/ ${CONF_LIB}"
fi
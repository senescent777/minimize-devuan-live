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
	echo "${0} [-v] [branch] | ${0} [branch] [-v]"
	exit 66
fi

if [ ! -z ${branch} ] ; then
	branch="--branch ${2}"
fi

dqb "branch=${branch}"
#q=$(${mkt} -d)
#cd ${q}
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

#if [ -x ${d0}/common_lib.sh ] ; then
#	. ${d0}/common_lib.sh
#	enforce_access ${n}
#else
#	${sco} 0:0 /
#	${scm} 0755 /
#	${sco} 0:0 /home
#	${scm} 0755 /home
#
#	${sco} -R ${n}:${n} ~ 
#	${scm} -R a-wx ${d0}
#	${scm} 0755 ${d0} 
#
#	for t in $(find ${d0} -type d) ; do ${scm} 0755 ${t}; done
#	for t in $(find ${d0} -type f -name '*.sh') ; do ${scm} 0755 ${t}; done
#	for t in $(find ${d0} -type f -name 'conf*') ; do ${scm} 0444 ${t}; done
#	for t in $(find ${d0} -type f -name '*.deb') ; do ${scm} 0444 ${t}; done
#	
#	${sco} 0:0 ${d0}/changedns.sh
#	${scm} 0555 ${d0}/changedns.sh
#
#	${sco} 0:0 /opt/bin/changedns.sh
#	${scm} 0555 /opt/bin/changedns.sh
#fi

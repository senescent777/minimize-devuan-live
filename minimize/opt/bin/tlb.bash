#!/bin/bash
debug=1

if [ -f /.chroot ] ; then
        odio=""
else
        odio=$(which sudo)
fi

function dqb() {
        [ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
        [ ${debug} -eq 1 ] && sleep ${1}
}

dqb "odio: ${odio}"

function tlah() {
	if [ ${1} -gt 0 ] ; then
		dqb "tlb: SHOULD / sb1n / h4lt npow"
		csleep 1
		[ ${debug} -eq 1 ] || /sbin/halt
	fi
}

function ocs() {
	dqb "tlb.ocs ${1} "
	local tmp2
	tmp2=$(${odio} which ${1})

	if [ y"${tmp2}" == "y" ] ; then
		dqb "KAKKA-HÄTÄ ${1} "
		exit 82
	fi

	if [ ! -x ${tmp2} ] ; then
		exit 77
	fi
}

for x in iptables ip6tables iptables-restore ip6tables-restore ; do
	#dqb ${x}
	ocs ${x}
	tlah $?
done

ipt=$(${odio} which iptables)
ip6t=$(${odio} which ip6tables)
iptr=$(${odio} which iptables-restore)
ip6tr=$(${odio} which ip6tables-restore)

csleep 1
dqb "tbl.bahs: 0 cc of \??? intravenompously stat"
c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
c2=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)

if [ ${c} -gt 0 ] || [ ${c2} -gt 0 ] ; then
	for t in INPUT OUTPUT FORWARD ; do
		${ipt} -P ${t} DROP
		tlah $?
		dqb "V4 ${t} $?" #; csleep 1

		${ipt} -F ${t}
		tlah $?

		${ip6t} -P ${t} DROP
		tlah $?
		dqb "V6 ${t} $?" #; csleep 1

		${ip6t} -F ${t}
		tlah $?
		dqb "V6 -GF ${t} $?" #; csleep 1
	done

	#jatkossa jokin array voisi sisltää nuo
	#tuliko tuosta muuten jotain nalkutusta?
	for t in e b u v c f ; do
		#${ipt} -P ${t} DROP
		#dqb $?

		${ipt} -F ${t}
		dqb $?

		#${ip6t} -P ${t} DROP
		#dqb $?

		${ip6t} -F ${t}
		dqb $?
	done
fi

csleep 2
c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
tlah ${c}

c=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
tlah ${c}

dqb "accept that"
csleep 1
[ -z "${1}" ] && exit #1

p=$(echo ${1} | tr -d -c 0-9)
dqb "bfore -f"
csleep 1

[ -f /etc/iptables/rules.v4.${p} ] || tlah 1
[ -f /etc/iptables/rules.v6.${p} ] || tlah 1
dqb "bfore -s"
csleep 1

[ -s /etc/iptables/rules.v4.${p} ] || tlah 1
[ -s /etc/iptables/rules.v6.${p} ] || tlah 1
dqb "just bfore iptr"
csleep 1

#"-r" - tark ei vissiin tarpeellinen, to state the obv

${iptr} /etc/iptables/rules.v4.${p}
tlah $?
csleep 1

dqb "v4 reloaded ok"

${ip6tr} /etc/iptables/rules.v6.${p}
tlah $?
csleep 1
dqb "v6 reloaded ok"

${ipt} -D INPUT 8
${ipt} -D INPUT 7
${ipt} -D OUTPUT 9
${ipt} -D OUTPUT 8
#exit 99

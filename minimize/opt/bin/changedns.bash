debug=1
mode=-1
distro=$(cat /etc/devuan_version)

if [ -f /.chroot ] ; then
	odio=""
else
	odio=$(which sudo)
fi

chmod a-wx ./clouds*
chown root:root ${0}
chmod 0511 ${0}


function dqb() {
	[ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
	[ ${debug} -eq 1 ] && sleep ${1}
}

sah6=$(which sha512sum)

mode=${1}
g_d0=$(dirname $0)

function gf() {
	csleep 1

	[ -z "${1}" ] && exit 103
	local c2

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type d -not -user 0 | wc -l)
	else
		c2=$(${odio} find ${1} -name '${2}*' -type d -not -user 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 104

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type d -not -group 0 | wc -l)
	else
		c2=$(${odio} find ${1} -name '${2}*' -type d -not -group 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 105
}

function gh() {

	csleep 1

	[ -z "${1}" ] && exit 108
	local c2


	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type f  -not -user 0 | wc -l)
	else
	
		c2=$(${odio} find ${1} -type f -name '${2}*' -not -user 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 106

	if [ -z "${2}" ] ; then
		c2=$(${odio} find ${1} -type f -not -group 0 | wc -l)
	else
		c2=$(${odio} find ${1} -type f -name '${2}*' -not -group 0 | wc -l)
	fi

	[ ${c2} -gt 0 ] && exit 107
}

function epr1() {
	csleep 1
	local c

    	c=$(find ${g_d0}/.. -type d -perm /o+w,g+w | wc -l)
    	[ ${c} -gt 0 ] && exit 106


	c=$(find /etc -name 'iptab*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 111

       	c=$(find /etc -name 'iptab*' -type d -perm /g+w | wc -l)
        [ ${c} -gt 0 ] && exit 123

	gf /etc iptab
	${odio} rm /etc/default/rules*

	[ ${c} -gt 0 ] && exit 114

	c=$(${odio} find /etc -name 'rules.v?.?' -type f -perm /g+x,g+w | wc -l)
      	[ ${c} -gt 0 ] && exit 124

	gh /etc rules.v

	c=$(find /etc -name 'sudoers*' -type d -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 117
	gf /etc sudoers

	c=$(find /etc/sudoers.d -type f -perm /o+w,o+r,o+x | wc -l)
	[ ${c} -gt 0 ] && exit 120
	gf /etc/sudoers.d

	if [ -x /usr/sbin/ntpd ] ; then

		c=$(find /etc -name 'ntp*' -type f -perm /o+w | wc -l)
        	[ ${c} -gt 0 ] && exit 126
		gh /etc ntp
	fi
}

epr1

function p3r1m3tr() {

	csleep 1


	chmod 0400 /etc/iptables/*
	chmod 0550 /etc/iptables
	chown -R root:root /etc/iptables
	chmod 0400 /etc/default/rules*
	chown -R root:root /etc/default

	local p
	p=$(pwd)
	cd /

	${sah6} --ignore-missing -c ${g_d0}/zxcv
	[ $? -eq 0 ] || exit 66
	cd ${p}

	chmod 0400 ${g_d0}/zxcv*
	chown root:root ${g_d0}/zxcv*

	if [ -s ${g_d0}/zxcv.sig ] ; then
		local g
		g=$(which gpg)

		if [ ! -z "${gg}" ] && [ -x ${gg} ] ; then
			${gg} --verify ${g_d0}/zxcv.sig
			[ $? -gt 0 ] && exit 126
		fi
	fi

	/bin/netstat -tulpan;sleep 2

}

p3r1m3tr

	1)
		echo "maybe ok"
	;;
	*)
		echo "${0} <mode> [other_params]";exit 13
	;;
esac


csleep 1


smr=$(${odio} which rm)
ipt=$(${odio} which iptables)
slinky=$(${odio} which ln)
spc=$(${odio} which cp)
slinky="${slinky} -s "
sco=$(${odio} which chown)
scm=$(${odio} which chmod)
svm=$(${odio} which mv)

ip6t=$(${odio} which ip6tables)
iptr=$(${odio} which iptables-restore)
ip6tr=$(${odio} which ip6tables-restore)

function tod_dda() { 
	echo "tod_dda( ${1} ) "
}

function dda_snd() {
	echo "dda_snd( ${1})"

	local t
	local u


	if [ ${u} -gt 0 ] ; then

		${ipt} -A u -p udp -m udp -s ${t} --sport 53 -j ACCEPT 
		${ipt} -A v -p udp -m udp -d ${t} --dport 53 -j ACCEPT
	else

		${ipt} -A b -p udp -m udp -s ${t} --sport 53 -j ACCEPT 
		${ipt} -A e -p udp -m udp -d ${t} --dport 53 -j ACCEPT
	fi
}

function ptn_dda() {
	local t

	${ipt} -A b -p udp -m udp -s ${t} --sport 123 -j ACCEPT
	${ipt} -A e -p udp -m udp -d ${t} --dport 123 -j ACCEPT
}


function clouds_pp1() {
	csleep 1
	local f

	for f in /etc/resolv.conf /etc/dhcp/dhclient.conf ; do
				${smr} ${f}
				
	
	done

	if [ -s /sbin/dhclient-script.1 ] || [ -s /sbin/dhclient-script.0 ] ; then 	
		${smr} /sbin/dhclient-script
		[ $? -gt 0 ] && echo "FAILURE TO CPMPLY WHIOLE TRYINMG TO REMOVE DHCLIENT-SCRIPT"
	fi

	if [ -h /etc/network/interfaces ] ; then
		${smr} /etc/network/interfaces
	else
		${svm} /etc/network/interfaces /etc/network/interfaces.OLD
	fi

}


function tlah() {
	if [ ${1} -gt 0 ] ; then

		csleep 1
		[ ${debug} -eq 1 ] || /sbin/halt
	fi
}

function clouds_pp3() {
	csleep 5

	[ -z "${1}" ] && /sbin/halt
	csleep 1

	csleep 1
	p3r1m3tr

	local c
	c=$(${ipt} -L  | grep policy | grep ACCEPT | wc -l)
	tlah ${c}

	c=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
	tlah ${c}

	csleep 2

	local p
	p=$(echo ${1} | tr -d -c 0-9)

	csleep 2

	[ -f /etc/iptables/rules.v4.${p} ] || tlah 1
        [ -f /etc/iptables/rules.v6.${p} ] || tlah 1

	csleep 2

	[ -s /etc/iptables/rules.v4.${p} ] || tlah 1
	[ -s /etc/iptables/rules.v6.${p} ] || tlah 1

	csleep 2


	${iptr} /etc/iptables/rules.v4.${p}
	tlah $?
	csleep 2



	${ip6tr} /etc/iptables/rules.v6.${p}
	tlah $?
	csleep 2
	

	${ipt} -D INPUT 8
	${ipt} -D INPUT 7
	${ipt} -D OUTPUT 9
	${ipt} -D OUTPUT 8


	csleep 2

}

function clouds_pre() {
	
	csleep 1

	[ -z "${1}" ] && exit 65

	local t

	csleep 1

	for t in INPUT OUTPUT FORWARD ; do
		${ipt} -P ${t} DROP
		tlah $?
		

		${ipt} -F ${t}
		tlah $?

		${ip6t} -P ${t} DROP
		tlah $?


		${ip6t} -F ${t}
		tlah $?

	done

	clouds_pp1
	csleep 1



	csleep 1

	clouds_pp3 ${t}
	csleep 1


	[ -f /etc/resolv.conf.${t} ] && ${slinky} /etc/resolv.conf.${t} /etc/resolv.conf
	[ ${debug} -eq 1 ] && ls -las /etc/resolv*;sleep 1

	[ -f /etc/dhcp/dhclient.conf.${t} ] && ${slinky} /etc/dhcp/dhclient.conf.${t} /etc/dhcp/dhclient.conf
	[ -f /sbin/dhclient-script.${t} ] && ${spc} /sbin/dhclient-script.${t} /sbin/dhclient-script


	[ -f /etc/network/interfaces.${t} ] && ${slinky} /etc/network/interfaces.${t} /etc/network/interfaces
	[ y"${ipt}" == "y" ] && exit 666

}

function clouds_post() {


	csleep 1
	local f
	g=$(pwd)
	cd /

	#	${scm} 0444 ${f}
	#	${sco} root:root ${f}
	#done

	cd ${g}

	for f in $(find /sbin -type f -name 'dhclient*') ; do
		${scm} 0555 ${f}
		${sco} root:root ${f}
	done

	p3r1m3tr

	for f in $(find /etc -type f -name 'ntp*') ; do
		${scm} 0444 ${f}
                ${sco} root:root ${f}
	done

	${scm} 0555 /etc/dhcp
	${scm} 0555 /sbin
	${scm} 0555 /etc/network
	${sco} root:root /etc/network 
	${scm} 0555 /etc/init.d/ntpsec
	${sco} 0:0 /etc/init.d/ntpsec

	if [ -x /usr/sbin/ntpd ] ; then
		${ipt} -A INPUT -p udp -m udp --sport 123 -j b 
		${ipt} -A OUTPUT -p udp -m udp --dport 123 -j e


		csleep 1
		
		csleep 1
	fi

	#if [ ${debug} -eq 1 ] ; then
		csleep 2
		echo "===================666======================================"
		csleep 2
		csleep 1 


}

function clouds_case0_0() {

	${ipt} -F e
	${ipt} -F b


}

function clouds_case1_0() {
	echo "c10"
}

function clouds_case0_1() {

	csleep 1

	if [ -s  /etc/resolv.conf ] ; then
	else
	

		if [ z"${CONF_dsn}" != "z" ] ; then
			for s in ${CONF_dsn} ;  do dda_snd ${s} ; done
		fi
	fi
}

function clouds_case1_1() {
	if [ -s /home/stubby/.stubby.yml ] ; then
	else
	

		if [ z"${CONF_dsn}" != "z" ] ; then
			for s in ${CONF_dsn} ;  do tod_dda ${s} ; done
		fi
	fi
}

function clouds_case0_2() {
	/etc/init.d/dnsmasq stop
	${whack} dnsmasq*
}

function clouds_case1_2() {
	echo "dns";sleep 1
	/etc/init.d/dnsmasq restart
	pgrep dnsmasq

}

echo "TODO:TÄMÄ ABOMINAATION KIRJOITUS UUSIKSI TYHJÄSTÄ"


case ${mode} in 
	0)
		clouds_case0_0
		clouds_case0_1
		clouds_case0_2
	;;
	1)
		clouds_case1_0
		clouds_case1_1
		clouds_case1_2
	;;
	*)
		echo "MEE HIMAAS LEIKKIMÄHÄN"
	;;
esac

clouds_post

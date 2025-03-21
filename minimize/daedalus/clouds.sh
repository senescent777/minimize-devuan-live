##!/bin/bash
#
##HUOM.100325:jatqssa common_lib käyttöön vai ei? tai jopa distroille yhteinen versio?
#smr=$(sudo which rm)
#ipt=$(sudo which iptables)
#ip6t=$(sudo which ip6tables)
#iptr=$(sudo which iptables-restore)
#ip6tr=$(sudo which ip6tables-restore)
#slinky=$(sudo which ln)
#spc=$(sudo which cp)
#slinky="${slinky} -s "
#sco=$(sudo which chown)
#scm=$(sudo which chmod)
#whack=$(sudo which pkill)
#debug=0
#VAIH:tarpellisten juttujen siirto -> lib, sitten roskikseen 
##testit ehkä jatkossa common_lib_in pre-osuuteen


#

#
#case ${1} in 
#	0)
#		${slinky} /etc/resolv.conf.OLD /etc/resolv.conf
#		${slinky} /etc/dhcp/dhclient.conf.OLD /etc/dhcp/dhclient.conf
#		${spc} /sbin/dhclient-script.OLD /sbin/dhclient-script
#
#		if [ y"${ipt}" == "y" ] ; then
#			dqb "SHOULD 1NSTALL TABL35"
#		else
#			${ipt} -A INPUT -p udp -m udp --sport 53 -j b 
#			${ipt} -A OUTPUT -p udp -m udp --dport 53 -j e
#
#			for s in $(grep -v '#' /etc/resolv.conf | grep names | grep -v 127. | awk '{print $2}') ; do dda_snd ${s} ; done	
#		fi
#
#		${odio} /etc/init.d/dnsmasq stop
#		${odio} /etc/init.d/ntpsec stop
#		csleep 3
#		${whack} dnsmasq*
#		${whack} ntp*
#	;;
#	1)
#		echo "WORK IN PROGRESS"
#
#		if [ -s /etc/resolv.conf.new ] ; then
#			echo "r30lv.c0nf alr3ady 3x15t5"
#		else
#			${odio} touch /etc/resolv.conf.new
#			${scm} a+w /etc/resolv.conf.new
#			${odio} echo "nameserver 127.0.0.1" > /etc/resolv.conf.new
#			${scm} 0444 /etc/resolv.conf.new
#			${sco} root:root /etc/resolv.conf.new
#		fi
#
#		${slinky} /etc/resolv.conf.new /etc/resolv.conf
#		${slinky} /etc/dhcp/dhclient.conf.new /etc/dhcp/dhclient.conf
#		${spc} /sbin/dhclient-script.new /sbin/dhclient-script
#
#		if [ y"${ipt}" == "y" ] ; then
#			echo "SHOULD 1NSTALL TABL35"
#		else
#			${ipt} -A INPUT -p tcp -m tcp --sport 853 -j b
#			${ipt} -A OUTPUT -p tcp -m tcp --dport 853 -j e
#			for s in $(grep -v '#' /home/stubby/.stubby.yml | grep address_data | cut -d ':' -f 2) ; do tod_dda ${s} ; done
#		fi
#
#		dqb "dns";csleep 2
#		${odio} /etc/init.d/dnsmasq restart
#		pgrep dnsmasq
#
#		dqb "stu";csleep 2
#		${whack} stubby* #090325: pitäisiköhän tämä muuttaa?
#		csleep 3	
#			
#		[ -f /run/stubby.pid ] || sudo touch /run/stubby.pid
#		${sco} devuan:devuan /run/stubby.pid #$n
#		${scm} 0644 /run/stubby.pid 
#		csleep 3
#
#		su devuan -c '/usr/bin/stubby -C /home/stubby/.stubby.yml -g'
#		pgrep stubby
#	;;
#esac



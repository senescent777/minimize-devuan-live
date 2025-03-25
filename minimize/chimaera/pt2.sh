#!/bin/bash

d=$(dirname $0)
[ -s ${d}/conf ] && . ${d}/conf
. ~/Desktop/minimize/common_lib.sh
[ -s ${d}/lib.sh ] && . ${d}/lib.sh


${scm} 0555 ~/Desktop/minimize/changedns.sh
${sco} root:root ~/Desktop/minimize/changedns.sh
${fib}

if [ $# -gt 0 ] ; then  
	if [ "${1}" == "-v" ] ; then
		debug=1
	fi
fi

#HUOM.120325:mitäköhän tämän kanssa tekee? ehkä oltava distro-kohtainen

#tarvitseeko?
#c=$(find ${d} -name '*.deb' | wc -l)
#[ ${c} -gt 0 ] || removepkgs=0
${odio} which iptables; csleep 3

#onkohan hyvä näin?
if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	${sharpy} libblu* libcupsfilters* libgphoto* libopts25
	${sharpy} network* avahi* blu* cups* exim*
	${odio} which iptables; csleep 3
	${sharpy} rpc* nfs* 
	${sharpy} modem* wireless* wpa* iw lm-sensors
fi

#==============================================================
#HUOM! PAKETIT procps, mtools JA mawk JÄTETTÄVÄ RAUHAAN!!!
#==============================================================
${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} amd64-microcode atril* at-spi2-core coinor*
${asy} 

${lftr}
${fib}
${sharpy} dirmngr discover* distro-info-data efibootmgr exfalso ftp gcr
${asy}

${odio} which dhclient; ${odio} which ifup; csleep 3
${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} ghostscript gir* gdisk gpg-* gpgconf gpgsm gparted
${asy}
${odio} which dhclient; ${odio} which ifup; csleep 3
${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} gsasl* gsfonts* gstreamer*
${asy}
${odio} which dhclient; ${odio} which ifup; csleep 3 #tulostuksetkin dbg taakse?
${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} htop 
${asy}
${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} intel-microcode
${asy}
${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
${odio} which iptables; csleep 3

${lftr}
${sharpy} mdadm 
${asy}
csleep 6
${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
${odio} which iptables; csleep 3

${lftr}
${sharpy} lvm2
${asy}
csleep 6
${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
${odio} which iptables; csleep 3

${lftr}
${sharpy} mailcap mariadb-common
${asy}
${lftr}
${odio} which dhclient; ${odio} which ifup; csleep 3
${fib}
${odio} which iptables; csleep 3

${sharpy} mokutil mysql-common orca openssh*
${asy}
${lftr}
${odio} which iptables; csleep 3

${sharpy} speech* system-config* telnet tex* udisks2 uno* ure* upower
${sa} autoremove --yes
${odio} which dhclient; ${odio} which ifup; csleep 3
${fib}
${odio} which iptables; csleep 3

${lftr}
${sharpy} vim* xorriso xfburn
${asy}
${odio} which iptables; csleep 3

${sharpy} iucode-tool libgstreamer* os-prober po*
${asy}

${odio} which dhclient; ${odio} which ifup; csleep 3
${fib}
${odio} which iptables; csleep 3

${lftr}
${sharpy} ppp 
${asy}
csleep 1

${lftr}
${sharpy} ristretto
${asy}
csleep 1

${sharpy} screen shim* samba* 
${asy}
csleep 1
${odio} which iptables; csleep 3

${lftr}
${sharpy} procmail
${asy}
csleep 1

${lftr}
${sharpy} squashfs-tools
${asy}
csleep 6

${lftr}
${sharpy} grub*
${asy}
csleep 6

${lftr}
${sharpy} libgsm*
${asy} 
csleep 6

${lftr}
${NKVD} /var/cache/apt/archives/*.deb
${NKVD} ${d}/*.deb 
${NKVD} /tmp/*.tar 
${smr} -rf /tmp/tmp.*
${smr} /usr/share/doc #rikkookohan jotain nykyään?
df
#mimimize-hmiston siivous kanssa?
${odio} which dhclient; ${odio} which ifup; csleep 3
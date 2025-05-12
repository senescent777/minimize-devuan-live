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

#VAIH:pitäisi kai miettiä tämä kohta, ideana doit-skriptin puolella kai että ei poisteta iptables jos ei korvaavaa pakerria
if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2_pre 1
	part2 1 #${removepkgs}
fi

${odio} which iptables; csleep 3

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

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} ghostscript gir* gdisk gpg-* gpgconf gpgsm gparted
${asy}

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} gsasl* gsfonts* gstreamer*
${asy}

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3 #tulostuksetkin dbg taakse?
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} htop 
${asy}

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${fib}
${sharpy} intel-microcode
${asy}

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${sharpy} mdadm 
${asy}
csleep 6

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${sharpy} lvm2
${asy}
csleep 6

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
csleep 5
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${sharpy} mailcap mariadb-common
${asy}
${lftr}

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
${fib}
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${sharpy} mokutil mysql-common orca openssh*
${asy}
${lftr}
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${sharpy} speech* system-config* telnet tex* udisks2 uno* ure* upower
${sa} autoremove --yes

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
${fib}
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${lftr}
${sharpy} vim* xorriso xfburn
${asy}

[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

${sharpy} iucode-tool libgstreamer* os-prober po*
${asy}

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3
${fib}
[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

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

[ ${debug} -eq 1 ] && ${odio} which iptables; csleep 3

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
${smr} /usr/share/doc 
df

[ ${debug} -eq 1 ] && ${odio} which dhclient; ${odio} which ifup; csleep 3

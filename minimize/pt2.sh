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

dqb "a-e"
csleep 5

#onkohan hyvä näin?
#VAIH:pitäisi kai miettiä tämä kohta, ideana kai että ei poisteta iptables jos ei korvaavaa pakerria
if [ ${removepkgs} -eq 1 ] ; then
	dqb "kö"
else
	part2 1 #${removepkgs}
fi

#HUOM. ao. rivillä 2. viimeisessä syystä vain core
${sharpy} amd64-microcode iucode-tool arch-test at-spi2-core bubblewrap
${sharpy} atril* coinor* cryptsetup debootstrap
${sharpy} dmidecode discover* dirmngr #tuleekohan viimeisestä ongelma? vissiin ei
${sharpy} doc-debian docutils* 
${sharpy} efibootmgr exfalso 

${asy} 
${lftr}
csleep 5

dqb "f1"
csleep 5
${sharpy} fdisk ftp*
${sharpy} gdisk gcr
${asy} 
${lftr}
csleep 5

#gnupg poisto täs kohtaa hyvä idea? vai veikö dirmngr mukanaan jo?
dqb "g2"
csleep 5
${sharpy} ghostscript gir* gnupg*
${sharpy} gpg-* gpgconf gpgsm gsasl-common
${sharpy} shim* grub* 
${sharpy} gsfonts gstreamer*
${asy} 
${lftr}
csleep 5

#gnome-* poisto veisi myös: task-desktop task-xfce-desktop
#gpg* kanssa: The following packages have unmet dependencies:
# apt : Depends: gpgv but it is not going to be installed or
#                gpgv2 but it is not going to be installed or
#                gpgv1 but it is not going to be installed
#HUOM. grub* poisto voi johtaa shim-pakettien päivitykseen
#gsettings* voi viedä paljon paketteja mukanaan

dqb "iii"
csleep 5
${sharpy} intel-microcode iucode-tool
${sharpy} htop inetutils-telnet
${asy} 
${lftr}
csleep 5

#lib-paketteihin ei yleisessä tapauksessa kande koskea eikä live-
#... libgstreamer ja libgsm uutena (060125)
${sharpy} libpoppler* libuno* libreoffice* libgsm* libgstreamer*

#HUOM! PAKETIT procps, mtools JA mawk JÄTETTÄVÄ RAUHAAN!!!
dqb "l-o"
csleep 5
${sharpy} lvm2 mdadm  
${sharpy} mailcap mlocate
${sharpy} mokutil mariadb-common mysql-common
${sharpy} netcat-traditional openssh*
${sharpy} os-prober #orca saattaa poistua jo aiemmin
${asy} 
${lftr}
csleep 5

#uutena 290425 (pois jos kusee)
${sharpy} nfs-common rpcbind
csleep 5
#TODO:libcolor* mukaan?

dqb "p"
csleep 5
${sharpy} ppp procmail ristretto 
${sharpy} screen
${asy} 
${lftr}
csleep 5

${sharpy} pkexec po* refracta*
#samba poistunee jo aiemmin?
${sharpy} squashfs-tools samba* system-config*
${asy} 
${lftr}
csleep 5

dqb "t"
csleep 5
${sharpy} telnet 
${sharpy} tex*
${asy} 
${lftr}
csleep 5

dqb "u"
csleep 5
${sharpy} uno* ure*
${sharpy} upower vim* # udisks* saattaa poistua jo aiemmin
${asy} 
${lftr}
csleep 5

dqb "x"
csleep 5
${sharpy} xorriso xfburn
${asy} 
${sharpy} xorriso 
${asy} 
csleep 5
 
dqb "y"
csleep 5
${sharpy} xfburn
${asy} 
csleep 5

${lftr}
${NKVD} ${pkgdir}/*.deb
${NKVD} ${pkgdir}/*.bin 
${NKVD} ${d}/*.deb 
${NKVD} /tmp/*.tar
${smr} /tmp/tmp.*
${smr} /usr/share/doc #rikkookohan jotain nykyään? (vuonna 2005 ei rikkonut)
#squ.ash voisi vilkaista kanssa liittyen (vai oliko mitään hyödyllistä siellä vielä?)
df
${odio} which dhclient; ${odio} which ifup; csleep 6

dqb "${scm} a-wx $0 in 6 secs "
csleep 6
${scm} a-wx $0 

#whack xfce so that the ui is reset
${whack} xfce4-session
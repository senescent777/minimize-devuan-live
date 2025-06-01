###!/bin/bash
#d=$(dirname $0)
#[ -s ${d}/conf ] && . ${d}/conf
#
#function parse_opts_1() {
#	case "${1}" in
#		-v|--v)
#			debug=1
#		;;
#	esac
#}
#
#function parse_opts_2() {
#	dqb "parseopts_2 ${1} ${2}"
#}
#
#. ~/Desktop/minimize/common_lib.sh
#[ -s ${d}/lib.sh ] && . ${d}/lib.sh
#
#${scm} 0555 ~/Desktop/minimize/changedns.sh
#${sco} root:root ~/Desktop/minimize/changedns.sh
#${fib}
#
##if [ $# -gt 0 ] ; then  
##	if [ "${1}" == "-v" ] ; then
##		debug=1
##	fi
##fi
##
#dqb "a-e"
#csleep 5
#
#if [ ${removepkgs} -eq 1 ] ; then
#	dqb "kö"
#else
#	part2_pre 1
#	part2_5 1 #HUOM.15425: oli part2 1
#fi
#
##libgutls-dane, aiheuttaako härdelliä jos poistaa? ei näköjään
#
##HUOM. ao. rivillä 2. viimeisessä syystä vain core
#${sharpy} amd64-microcode iucode-tool arch-test at-spi2-core 
#${sharpy} bubblewrap atril* coinor* cryptsetup* debootstrap
#
##HUOM.23525:poistettavien listaa pystyisi ehkä säätämään vielä, dpkg -l
#
#${asy} 
#${lftr}
#csleep 5
#${sharpy} dmidecode discover* dirmngr #tuleekohan viimeisestä ongelma? vissiin ei
#${sharpy} doc-debian docutils* efibootmgr exfalso 
#${sharpy} fdisk ftp* gdisk gcr
#
#${asy} 
#${lftr}
#csleep 5
#
###gnome-* poisto veisi myös: task-desktop task-xfce-desktop
###gpg* kanssa: The following packages have unmet dependencies:
### apt : Depends: gpgv but it is not going to be installed or
###                gpgv2 but it is not going to be installed or
###                gpgv1 but it is not going to be installed
###HUOM. grub* poisto voi johtaa shim-pakettien päivitykseen
###gsettings* voi viedä paljon paketteja mukanaan
#
#dqb "g2"
#csleep 5
#
#${sharpy} ghostscript gir* gnupg* gpg-*
#${sharpy} gpgconf gpgsm gsasl-common shim*
#${sharpy} grub* gsfonts gstreamer*
#${sharpy} intel-microcode iucode-tool htop inetutils-telnet
#
#${asy} 
#${lftr}
#csleep 5
#
##lib-paketteihin ei yleisessä tapauksessa kande koskea eikä live-
##libgssapi-krb5 tarpeellinen?
##HUOM! PAKETIT procps, mtools JA mawk JÄTETTÄVÄ RAUHAAN!!! (tai mtools ehkä uskaltaa kun o muitsa poistettu ensin)
#
##HUOM.15525:uutena libcolor, näytti poistavan liikaa joten jemmaan
##${sharpy} libcolor* 
##csleep 5
#
#${sharpy} libpoppler* libuno* libreoffice* libgsm* libgstreamer*
#${sharpy} lvm2 lynx* mdadm mailcap
#
#${asy} 
#${lftr}
#csleep 5
#
#${sharpy} mlocate mokutil mariadb-common mysql-common
#${sharpy} netcat-traditional openssh* os-prober #orca saattaa poistua jo aiemmin
#${sharpy} nfs-common rpcbind
#
#csleep 5
#dqb "p"
#csleep 5
#
#${sharpy} ppp procmail ristretto screen
#${sharpy} pkexec po* refracta* squashfs-tools
#
#${asy} 
#${lftr}
#csleep 5
#
##HUOM.15525 vaikuttaisi toimivan, ajon jälkeen x toimii edelleen
#${sharpy} samba* system-config* telnet tex* 
#
##VAIH:, python3*, , voisiko niitä karsia?
#${sharpy} syslinux* mythes isolinux libgssapi-krb5-2
#
#${sharpy} uno* ure* upower vim* # udisks* saattaa poistua jo aiemmin
#${asy} 
#${lftr}
#csleep 5
#
#dqb "x"
#csleep 5
#${sharpy} xorriso xfburn
#${asy} 
#
#${lftr}
##${NKVD} ${pkgdir}/*.deb
##${NKVD} ${pkgdir}/*.bin 
##${NKVD} ${d}/*.deb 
##${NKVD} /tmp/*.tar
##${smr} -rf /tmp/tmp.*
##${smr} /usr/share/doc #rikkookohan jotain nykyään? (vuonna 2005 ei rikkonut)
###squ.ash voisi vilkaista kanssa liittyen (vai oliko mitään hyödyllistä siellä vielä?)
##df
##${odio} which dhclient; ${odio} which ifup; csleep 6
#
#t2pf
#
#dqb "${scm} a-wx $0 in 6 secs "
#csleep 6
#${scm} a-wx $0 
#
##whack xfce so that the ui is reset
${whack} xfce4-session


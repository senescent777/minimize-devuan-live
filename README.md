1. boot a live cd (for example Chimaera desktop live)
2. sudo mount /dev/$usbdrive /mnt/ -o ro
3. cd /;sudo tar -xvf /mnt/$archive.tar
4. sudo umount /mnt
5. cd ~/Desktop/minimize
6. ./$distro/doIt6.sh

-----------------------------------------------------------

export2.sh can be used to make a tar ($archive)  out of this project with 0 as first param
	1 as first param makes an upgrade-package for dpkg to install
	(i'm yet to confirm if the current version works or not)

import2.sh 
	is a shortcut for installing more recent this project into a running live distro
	it can be used to install upgrades to .deb packages also

demerde_toi.sh
	can soon be used to install the most recent version of this project into a running live distro

$distro/pt2.sh removes little more packages, if you want even lighter filesystem.squashfs
	https://github.com/senescent777/some_scripts/blob/main/skripts/export/squ.ash.export can be used some day to make that .squashfs from / - partition


omega.desktop is supposed to disable "Ubuntu-style sudo" , potentially dangerous


ifdown.desktop, ifdown(-a).desktop turns off network connection
ifup.desktop, ifup(-a).desktop turn on network connection
pt2.desktop is graphical shortcut for pt2.sh (doesn't work right now)
do_it6.desktop is graphical shortcut for do_It6.sh (doesn't work right now)
(warning: i haven't recently tested if those .desktop files do what they¨re supposed to)

clouds2.sh can be used to change the network configuration to use plain-old-DNS and that's all folks , there is something going on with Daedalus and stubby i have to figure out
(if there's problem with DNS, this script may be helpful)

P.S. there may be some problems withy access rights, chmod 0755 *.sh/chmod 0755 $distro/chmod 0644 $distro/conf*/chmod 0755 $distro/*.sh helps with those
P.P.S. the elder scripts are moved into olds/ , they used to work (i think)

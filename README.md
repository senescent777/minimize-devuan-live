1. boot a live cd (for example Chimaera desktop live)
2. sudo mount /dev/$usbdrive /mnt/ -o ro
3. cd /;sudo tar -xvf /mnt/$archive.tar
4. sudo umount /mnt
5. cd ~/Desktop/minimize
6. cp conf.example $distro; mv $distro/conf.example $distro/conf; $EDITOR $distro/conf #for initial config
7. ./$distro/doIt6.sh

-----------------------------------------------------------

- export2.sh can be used to make a tar ($archive)  out of this project with 0 as first param
	1 as first param makes an upgrade-package for dpkg to install
	(i'm yet to confirm if the current version works or not)

- import2.sh 
	is a shortcut for installing more recent version of this project into a running live distro
	it can also be used to install upgrades to .deb packages

- demerde_toi.sh
	can soon be used to install the most recent version of this project into a running live distro

- $distro/pt2.sh removes little more packages, if you want even lighter filesystem.squashfs
	https://github.com/senescent777/some_scripts/blob/main/skripts/export/squ.ash.export can be used some day to make that .squashfs from / - partition


- about all those .desktop-files: i have to warn you, haven't recently tested if those  do what they're supposed to (some day i will)

- changedns.sh can be used to change the network configuration to use plain-old-DNS and that's all folks , there is something going on with Daedalus and stubby i have to figure out
(if there's problem with DNS, this script may be helpful)

P.S. there may be some problems with access rights, invocation "chmod 0755 *.sh;chmod 0755 $distro;chmod 0644 $distro/conf*;chmod 0755 $distro/*.sh" helps with those. Shoulf fix that.

P.P.S. the elder scripts are moved into olds/ , they used to work (i think)



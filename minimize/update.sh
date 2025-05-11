#!/bin/bash
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
u=0

if [ z"${distro}" != "z" ] ; then
	if [ -s ~/Desktop/minimize/${distro}/conf ] ; then
		. ~/Desktop/minimize/${distro}/conf
		[ -d ${dir} ] && mount ${dir}
		[ $? -eq 0 ] && u=1
	fi
fi

tgt=${1}
[ -f ${tgt} ] || exit 1

for f in $(find ~/Desktop/minimize/ -name 'conf*') ; do tar -f ${tgt} -rv ${f} ; done
for f in $(find ~/Desktop/minimize/ -name '*.sh') ; do tar -f ${tgt} -rv ${f} ; done
for f in $(find /etc -name 'locale*') ; do tar -f ${tgt} -rv ${f} ; done
tar -f ${tgt} -rv /etc/timezone

[ ${u} -eq 1 ] && umount ${dir}

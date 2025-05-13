#!/bin/bash
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
u=0
v=0

#TODO:tapaus $dir valmiiksi mountattu, miksi urputtaa? korjaa

if [ z"${distro}" != "z" ] ; then
	if [ -s ~/Desktop/minimize/${distro}/conf ] ; then
		. ~/Desktop/minimize/${distro}/conf

		if [ -d ${dir} ] ; then
			v=$(grep -c ${dir} /proc/mounts)

			if [ ${v} -lt 1 ] ; then			
				mount ${dir}
		
				if [ $? -eq 0 ] ; then
					u=1
					sleep 5
				fi
			fi
		fi
	fi
fi

tgt=${1}

if [ -f ${tgt} ] ; then
	#TODO:sudotus sittenkin wttuun
	for f in $(find ~/Desktop/minimize/ -name 'conf*') ; do sudo tar -f ${tgt} -rv ${f} ; done
	for f in $(find ~/Desktop/minimize/ -name '*.sh') ; do sudo tar -f ${tgt} -rv ${f} ; done
	for f in $(find /etc -name 'locale*') ; do sudo tar -f ${tgt} -rv ${f} ; done
	sudo tar -f ${tgt} -rv /etc/timezone
else	
	exit 1
fi

if [ ${u} -eq 1 ] ; then
	umount ${dir}
	sleep 5
fi
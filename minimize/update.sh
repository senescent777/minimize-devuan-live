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
				echo "HAVE TO MOUNT";sleep 1			
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

tcmd=$(which tar)
#jos ei tällä lähde taas toimimaan niin $2 sanomaan sudotetaanko vai ei?

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		tcmd="sudo ${tcmd} "
	fi
fi
 

if [ -f ${tgt} ] ; then
	for f in $(find ~/Desktop/minimize/ -name 'conf*') ; do ${tcmd} -f ${tgt} -rv ${f} ; done
	for f in $(find ~/Desktop/minimize/ -name '*.sh') ; do ${tcmd} -f ${tgt} -rv ${f} ; done
	for f in $(find /etc -name 'locale*') ; do ${tcmd} -f ${tgt} -rv ${f} ; done
	${tcmd} -f ${tgt} -rv /etc/timezone
else	
	exit 1
fi

if [ ${u} -eq 1 ] ; then
	ls -las ${tgt}
	sleep 3
	echo "WILL UMOUNT SOON";sleep 1
	umount ${dir}
	sleep 5
fi
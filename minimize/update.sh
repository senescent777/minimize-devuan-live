#!/bin/bash
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
u=0
v=0

#TODO:tapaus $dir valmiiksi mountattu, miksi urputtaa?
# korjaa muutkin kiukutteluT samalla jos mahd (JOKO JO 21525???)
#... tai siis jos vielä toistuu juuri tuo

if [ z"${distro}" != "z" ] ; then
	if [ -s ~/Desktop/minimize/${distro}/conf ] ; then
		. ~/Desktop/minimize/${distro}/conf
		echo "CNF F0UND"; sleep 1

		if  [ -v dir ] && [ -d ${dir} ] ; then
			#v=$(grep -c ${dir} /proc/mounts) #qseeko tässä jokin? aiempi tapa parempi?
			v=$(grep ${dir} /proc/mounts | wc -l)

			if [ ${v} -lt 1 ] ; then
				echo "HAVE TO MOUNT";sleep 1			
				mount ${dir}
		
				if [ $? -eq 0 ] ; then
					u=1
					sleep 5
				fi
			fi
		else
			echo "${dir} NOT DOUNF"; sleep 1		
		fi
	fi
fi

tgt=${1}
tcmd=$(which tar)
spc=$(which cp)
scm=$(which chmod)
#jos ei tällä lähde taas toimimaan niin $2 sanomaan sudotetaanko vai ei?

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
		scm="sudo ${scm} "
	fi
fi

echo "PARAMS CHECKED"
sleep 1

if [ -f ${tgt} ] ; then
	read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
	#HUOM. pelkästään .deb-paketteja sisältävien kalojen päivityksestä pitäisi urputtaa	

	if [ "${confirm}" == "Y" ] ; then
		${spc} ${tgt} ${tgt}.OLD #vaiko mv?
		sleep 3

		#HUOM.21525:mutenkähän tuo -uv -rv sijaan?
		for f in $(find ~/Desktop/minimize/ -name 'conf*') ; do ${tcmd} -f ${tgt} -rv ${f} ; done
		for f in $(find ~/Desktop/minimize/ -name '*.sh') ; do ${tcmd} -f ${tgt} -rv ${f} ; done
		
		for f in $(find /etc -name 'locale*') ; do
			if [ -s ${f} ] && [ -r ${f} ] ; then
				${tcmd} -f ${tgt} -rv ${f}
			fi
		done

		#HUOM.oikeuksien pakottaminen mukaan tai if -r loopin sisälle , sama export2 kanssa (VAIH)
		${scm} 0755 /etc/iptables
		${scm} 0444 /etc/iptables/*
		${scm} 0444 /etc/default/rules*
		sleep 5
				
		for f in $(find /etc -name 'rules*') ; do
			if [ -s ${f} ] && [ -r ${f} ] ; then
				${tcmd} -f ${tgt} -rv ${f}
			fi
		done #JOSKO NYT SKEOILU VÄHENISI PRKL

		sleep 5
		${scm} 0400 /etc/default/rules*
		${scm} 0400 /etc/iptables/*
		${scm} 0550 /etc/iptables
		sleep 5

		${tcmd} -f ${tgt} -rv /etc/timezone #tarttisiko jotain muutakin lisätä tssä?
		sleep 3

		#HUOM.saattaa urputtaa $tgt polusta riippuen
		sudo touch ${tgt}.sha
		sudo chmod 0666 ${tgt}.sha
		sudo sha512sum ${tgt} > ${tgt}.sha
		sha512sum -c ${tgt}.sha
 	
		echo "DONE UPDATING"
		sleep 2
	fi
else	
	exit 1
fi

ls -las ${tgt}
sleep 3

if [ ${u} -eq 1 ] ; then	
	echo "WILL UMOUNT SOON";sleep 1
	umount ${dir}
	sleep 5
fi

#ettei unohtuisi umount
grep ${dir} /proc/mounts
#!/bin/bash
distro=$(cat /etc/devuan_version) #voisi olla komentoriviparametrikin jatkossa?
u=0
v=0

d0=$(dirname $0)
echo "d0=${d0}"
#[ z"${distro}" == "z" ] && exit 6
#TODO:tähän tai exp2 muutoksia siihen kehitysymp liittyen ?
d=${d0}/${distro}

tgt=${1}
tcmd=$(which tar)
spc=$(which cp)
scm=$(which chmod)
sco=$(which chown)
som=$(which mount)
uom=$(which umount)

if [ $# -gt 1 ] ; then
	if [ ${2} -eq 1 ] ; then
		tcmd="sudo ${tcmd} "
		spc="sudo ${spc} "
		scm="sudo ${scm} "
		sco="sudo ${sco} "
		som="sudo ${som} "
		uom="sudo ${uom} "
	fi
fi

echo "PARAMS CHECKED"
sleep 1

if [ z"${distro}" != "z" ] ; then
	if [ -s ${d}/conf ] ; then
		. ${d}/conf
		echo "CNF F0UND"; sleep 1

		if  [ -v dir ] && [ -d ${dir} ] ; then
			v=$(grep ${dir} /proc/mounts | wc -l)
			u=1 #tdstojärj paskoontumiseN välttämiseksi

			if [ ${v} -lt 1 ] ; then
				echo "HAVE TO MOUNT";sleep 1			
				${som} ${dir}
		
				if [ $? -eq 0 ] ; then
					sleep 5
				fi
			fi
		else
			echo "${dir} N0T DOUNF"; sleep 1		
		fi
	fi
fi

if [ -f ${tgt} ] ; then
	#pelkästään .deb-paketteja sisältävien kalojen päivityksestä pitäisi urputtaa	
	${tcmd} -tf ${1} | grep '.deb'
	sleep 3

	read -p "U R ABT TO UPDATE ${tgt} , SURE ABOUT THAT?" confirm
	[ "${confirm}" != "Y" ] && exit 

	function process_entry() {
		${tcmd} -f ${1} -rv ${2}
	}

	#update,export2 :mikä ero?

	${spc} ${tgt} ${tgt}.OLD #vaiko mv?
	sleep 2
	process_entry ${tgt} /opt/bin/changedns.sh
	sleep 2

	if [ -v testgris ] && [ -d ${testgris} ] ; then #vaatii sitten conf:iin muutoksia kanssa
		cd ${testgris}
		p="."
	else
		echo "SOMTHING ELSE"
		p=$(pwd)

		#menisiköhän vaikka näin
		for f in $(find ${p}/ -name 'conf*') ; do process_entry ${tgt} ${f} ; done

		#lototaan vielä näin
		for f in $(find ~ -maxdepth 1 -type f -name '*.tar*') ; do process_entry ${tgt} ${f} ; done
	fi

	#HUOM.21525:mItenkähän tuo -uv -rv sijaan?
	dqb "find ${p}/ asd asd asd "
	csleep 2

	for f in $(find ${p}/ -name '*.example') ; do process_entry ${tgt} ${f} ; done
	for f in $(find ${p}/ -name '*.sh') ; do process_entry ${tgt} ${f} ; done

#	#HUOM.030825:tar-kohta tästä pois jatkossa koska ylempänä jo?
#	for f in $(find ${p}/ -maxdepth 1 -type f -name '*.tar*') ; do
#		echo "PCROCESSING : ${f}"
#		process_entry ${tgt} ${f}
#		sleep 1
#	done
	
	#HUOM.030825:localet ja timezone saavat olla kuten nyt?
	#jos ei erikseen muuttele niin samat q pakettia purkaessa
	#eikä juuressa sijaitsevien kanssa tartte kikkailla polun kanssa
	#/e sisältö voidaan tuupata takaisin arkistoon jos on siitä alunperin purettu, muuten voi tulla ongelmia
	#... tai mikä olikaan jutun juoni tuolloin?

	#... pitäisiköhän miettiä mitä otetaan arkistoon ja missä tilanteessa?

	for f in $(find /etc -type f -name 'locale*') ; do
		if [ -s ${f} ] && [ -r ${f} ] ; then
			process_entry ${tgt} ${f}
		fi
	done

	#jos git:n kanssa menisi ni  alaiset voisi commitoida suoraan?
	#sen sijaan /e alaiset?pitäisikö kasata johonkin pakettiin ja se commitoida?

	#tuossa yllä find ilman tiukempaa name-rajausta vetäisi ylimääräisiä mukaan, toisaalta /e/localtime on linkki

	process_entry ${tgt} /etc/timezone
	process_entry ${tgt} /etc/localtime

	#firefoxin käännösasetukset pikemminkin export2:n hommia 

	${scm} 0755 /etc/iptables
	${scm} 0444 /etc/iptables/*
	${scm} 0444 /etc/default/rules*
	sleep 2
	
	if [ ! -v testgris ] || [ ! -d ${testgris} ] ; then	#HUOM.061025:milloin viimeksi tätä blokkia testattu?	
		for f in $(find /etc -name 'rules*') ; do #type f mukaan?
			if [ -s ${f} ] && [ -r ${f} ] ; then
				process_entry ${tgt} ${f}
			fi
		done #JOSKO NYT SKEOILU VÄHENISI PRKL
	fi

	${scm} 0400 /etc/default/rules*
	${scm} 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	sleep 2

	#pitäisi kai tehdä jotain että tuoreimmat muutokset /e/n ja /e/a menevät tar:iin asti? typojen korjaus olisi hyvä alku

	#TODO:/e/n- ja /e/a-kohdat uusiksi jatkossa? (liittyiköhän se luca?)
	if [ ! -v testgris ] || [ ! -d ${testgris} ] ; then
		#HUOM.24525:distro-kohtainen /e/n/interfaces, onko järkee vai ei?
		for f in $(find /etc/network -type f -name 'interface*' -and -not -name '*.202*') ; do process_entry ${tgt} ${f} ; done

		#uutena 28525
		for f in $(find /etc/apt -type f -name 'sources*' -and -not -name '*.202*') ; do process_entry ${tgt} ${f} ; done
		sleep 2
	fi

	#uutena 031025, siltä varalta että paska osuu tuulettimeem niinqu
	for f in $(find  /etc/wpa_supplicant/ -type f) ; do process_entry ${tgt} ${f} ; done

	#HUOM.saattaa urputtaa $tgt polusta riippuen
	#HUOM.2:miten toimii omegan ajon jälkeen?
	#HUOM.3:oli jotain urputusta näillä main 031025(edelleen 071025?)
	#HUOM.4.:pqska tikku vai paskooko tämä skripti arkistoja? (091025)

	echo "sudo touch ${tgt}.sha"
	sleep 3

	sudo touch ${tgt}.sha
	${scm} 0666 ${tgt}.sha
	${sco} $(whoami):$(whoami) ${tgt}.sha

	echo "sha512sum ${tgt} > ${tgt}.sha"
	sleep 3
	sha512sum ${tgt} > ${tgt}.sha
	sleep 2

	sha512sum -c ${tgt}.sha
 	#HUOM.29925:tähän ei sitten gpg-kikkailua
	echo "DONE UPDATING"
	sleep 2
else	
	exit 1
fi

ls -las ${tgt}
sleep 3

if [ ${u} -eq 1 ] ; then	
	echo "WILL UMOUNT SOON";sleep 1
	${uom} ${dir}
	sleep 5
fi

echo "LEST WE FORGET:"
grep ${dir} /proc/mounts
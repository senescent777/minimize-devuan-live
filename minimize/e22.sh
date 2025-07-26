function pre1() { #TODO:tesatattva
	dqb "pre1 ${1}  ${2} "
	[ -z ${1} ] && exit 666

	csleep 5
	${sco} -Rv _apt:root ${pkgdir}/partial/
	${scm} -Rv 700 ${pkgdir}/partial/
	csleep 1

	if [ ! -d ${1} ] ; then
		echo "P.V.HH"
		exit 111
	else
		echo "else"
		dqb "5TNA"
		
		local ostrac
		local lefid
		lefid=$(echo ${1} | tr -d -c 0-9a-zA-Z/) # | cut -d '/' -f 1-5)
		#HUOM.25725:voi periaatteessa mennä metsään nuo $c ja $l, mutta tuleeko käytännössä sellaista tilannetta vastaan?
	
		enforce_access ${n} ${lefid} #qseeko tässä jokin???

		ostrac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)
		csleep 1
		dqb "3NF0RC1NG D0N3"
		
		csleep 1
		${scm} 0755 /etc/apt
		${scm} a+w /etc/apt/sources.list*
	fi
}

#function pre2() { #VAIH
#	debug=1
#	dqb "pre2 ${1}, ${2} , ${3} ...#WTIN KAARISULKEET STNA" 
#
#	[ -z ${1} ] && exit 66
#	[ -z ${2} ] && exit 67
#	[ -z ${3} ] && exit 68
#
#	local ortsac
#	ortsac=$(echo ${2} | cut -d '/' -f 1 | tr -d -c a-z)
#
#	if [ -d ${1} ] ; then
#		dqb "PRKL"
#		${odio} /opt/bin/changedns.sh ${dnsm} ${ortsac} #TODO	:dnsm paramtriksi
#		csleep 1
#
#		${sifu} ${3} #iface}
#		[ ${debug} -eq 1 ] && ${sifc}
#		csleep 1
#
#		${sco} -Rv _apt:root ${pkgdir}/partial/
#		${scm} -Rv 700 ${pkgdir}/partial/
#
#		${sag_u}
#		csleep 1
#	else
#		echo "P.V.HH"
#		exit 111
#	fi
#
#	echo "PRE 2DONE"
#	sleep 2
#}

function tp0() {
	dqb "tp0 ${1} , ${2} , ${3}  "

	if [ -d ${2} ] ; then
		dqb "cleaning up ${2} "
		csleep 1
		${NKVD} ${2}/*.deb
		${NKVD} ${2}/*.tar
		${NKVD} ${2}/sha512sums.txt
		dqb "d0nm3"
	else
		dqb "NO SUCH DIR ${2}"
	fi

	csleep 1
}

#pois koemmenteista 26726.18 tienboilla, takaisin kommentteihin jos qsee
function tpq() { #HUOM.24725:tämän casen output vaikuttaa järkevältä, lisää testejä myöhemmin		
	debug=1
	dqb "tpq ${1} ${2}"

	[ -d ${1} ] || exit 22
	[ -d ${1} ] || exit 23	

	dqb "paramz 0k"
	csleep 1
	cd ${1}

	${srat} -jcf ./config.tar.bz2 ./.config/xfce4/xfconf/xfce-perchannel-xml ./.config/pulse /etc/pulse

	if [ -x ${2}/profs.sh ] ; then
		dqb "DE PROFUNDIS"
		.  ${2}/profs.sh	
		exp_prof ./fediverse.tar default-esr
	else
		dqb "1nT0 TH3 M0RB1D R31CH"	
	fi

	cd ${2}
}

function tp1() {
	dqb "tp1 ${1} , ${2} , ${3}  "
	[ -z ${1} ] && exit
	dqb "params_ok"
	csleep 1
	pwd
	csleep 1

	#26726:tähän asti ok

	if [ ${enforce} -eq 1 ] && [ -d ${2} ] ; then
		dqb "FORCEFED BROKEN GLASS"
		tpq ~ ${2}/.. #HUOM.25725:toimiiko näin?
	else
		dqb "PUIG DESTRÖYERR"
	fi

	#26726:tähän asti ok

	csleep 1
	${srat} -rvf ${1} /opt/bin/changedns.sh

	#26726:tähän asti ok

	#jatkossa tar if-blokin jälkeen?
	if [ -d ${3} ] ; then
		cd ${3} #tässä oli virhe
		${srat} --exclude='*.deb' -rvf  ${1} ./home/stubby
		csleep 3

		#TODO:se fiksumpi tapa, voiaiko esim $2:sta leikata $3:n bashilla jotenkin käteväsri?
		local t=$(echo ${2} | tr -d -c 0-9a-zA-Z/ | cut -d / -f 4,5,6,7)
		echo ${t}
		#exit

		#mettään menee edelleen, uusiksi 
		dqb "./home/stubby ./home/devuan/Desktop/minimize" #tässäkin oli virhe
		${srat} --exclude='*.deb' --exclude='conf*' -rvf ${1} ${t} #2}/.. 
	else
		${srat} --exclude='*.deb' -rvf ${1} /home/stubby ${d0} #globaalit wttuun tästäkin
	fi

	dqb "tp1 d0n3"
	csleep 1
}

function tp2() { #HUOM.26725:voisi TAAS testata
	debug=1
	dqb "tp2 ${1} ${2}"

	[ -z ${1} ] && exit 1
	[ -s ${1} ] || exit 2

	dqb "params_ok"
	csleep 1
	#26726:tähän astu ok

	${scm} 0755 /etc/iptables
	${scm} 0444 /etc/iptables/rules*
	${scm} 0444 /etc/default/rules*

	for f in $(find /etc -type f -name 'interfaces*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done
	dqb "JUST BEFORE URLE	S"
	csleep 1

	for f in $(find /etc -type f -name 'rules*' -and -not -name '*.202*') ; do
		if [ -s ${f} ] && [ -r ${f} ] ; then
			${srat} -rvf ${1} ${f}
		else
			echo "SUURI HIRVIKYRPÄ ${f} "
			echo "5H0ULD exit 666"
			sleep 1
		fi
	done

	echo $?
	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep rule | less
	sleep 2

	dqb "JUST BEFORE LOCALES"
	sleep 1

	${srat} -rvf ${1} /etc/timezone /etc/localtime 
	#HUOM.22525:tuossa alla locale->local niin saisi localtime:n mukaan mutta -type f
	for f in $(find /etc -type f -name 'local*' -and -not -name '*.202*') ; do ${srat} -rvf ${1} ${f} ; done

	echo $?
	sleep 1

	[ ${debug} -eq 1 ] && ${srat} -tf ${1} | grep local | less
	csleep 1
	other_horrors

	#HUOM.23525:tähän tökkäsi kun mode=4 && a-x common
	if [ -r /etc/iptables ] || [ -w /etc/iptables ] || [ -r /etc/iptables/rules.v4 ] ; then
		echo "/E/IPTABLES sdhgfsdhgf"
		exit 112
	fi

	case ${iface} in #TODO:iface parametriksi?
		wlan0)
			[ ${debug} -eq 1 ] && echo "APW";sleep 3
			${srat} -rvf ${1} /etc/wpa_supplicant/*.conf
			${srat} -tf ${1} | grep wpa
			csleep 3
		;;
		*)
			dqb "non-wlan"
		;;
	esac

	if [ ${enforce} -eq 1 ] ; then #TODO:glob wtt?
		dqb "das asdd"
	else
		${srat} -rf ${1} /etc/sudoers.d/meshuggah
	fi

	if [ ${dnsm} -eq 1 ] ; then #TODO:glob wtt
		local f;for f in $(find /etc -type f -name 'stubby*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
		for f in $(find /etc -type f -name 'dns*' -and -not -name '*.202*') ; do ${srat} -rf ${1} ${f} ; done
	fi

	${srat} -rf ${1} /etc/init.d/net*
	${srat} -rf ${1} /etc/rcS.d/S*net*
	dqb "tp2 done"
	csleep 1
}
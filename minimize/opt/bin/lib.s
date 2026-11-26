echo "VAIH:PITÄISI VARMISTAA IHAN AIKUISTEN OIKEASTI ETTÄ ACCEPT-TILANTEESEEN EI PERKELE JÄÄDÄ!!!!!"
sleep 20

if [ -v CONF_env ] && [ "${CONF_env}" == "TOOR" ] ; then
	#jotain tarttis ensin... KTS VAIKKAPA setup2.bash
        odio=""
else
        odio=$(which sudo)
fi

function dqb() {
        [ ${debug} -eq 1 ] && echo ${1}
}

function csleep() {
        [ ${debug} -eq 1 ] && sleep ${1}
}

dqb "odio: ${odio}"

function tlah() {
	if [ ${1} -gt 0 ] ; then
		echo "SHOULD / sb1n / h4lt npow"
		sleep 20
		[ ${debug} -eq 1 ] || /sbin/halt
	fi
}

function ocs() {
	dqb "ocs ${1} "
	local tmp2
	tmp2=$(${odio} which ${1})

	if [ y"${tmp2}" == "y" ] ; then
		dqb "KAKKA-HÄTÄ ${1} "
		echo "SHOULD H n C F NOW!!!"
		sleep 20
		exit 82
	fi

	if [ ! -x ${tmp2} ] ; then
		echo "SHOULD HCF() NOW"
		sleep 20
		exit 77
	fi
}


#TODO?:jokin loivennus jos /sbin/ifconfig listaa vain lo-ifacen? tai "ip link show | grep up | ec -l" jotenkin
#TODO?:/etc/rcS.d alaiset linkit, saisiko niitä starttaamaan sen tables-persistentin 

for x in iptables ip6tables iptables-restore ip6tables-restore gpg chmod chown ; do
	#dqb ${x}
	ocs ${x}
	tlah $?
done

ipt=$(${odio} which iptables)
ip6t=$(${odio} which ip6tables)
iptr=$(${odio} which iptables-restore)
ip6tr=$(${odio} which ip6tables-restore)

csleep 1
dqb "0 cc of \??? intravenompously stat"
c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
c2=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)

if [ ${c} -gt 0 ] || [ ${c2} -gt 0 ] ; then
	for t in INPUT OUTPUT FORWARD ; do
		${ipt} -P ${t} DROP
		tlah $?
		dqb "V4 ${t} $?" #; csleep 1

		#pitäisikö huuhdella myÖs v4-taulut?
		${ipt} -F ${t}
		tlah $?

		${ip6t} -P ${t} DROP
		tlah $?
		dqb "V6 ${t} $?" #; csleep 1

		${ip6t} -F ${t}
		tlah $?
		dqb "V6 -GF ${t} $?" #; csleep 1
	done

	#jatkossa jokin array voisi sisltää nuo
	for t in e b u v c f ; do
		#${ipt} -P ${t} DROP #miski -P kommenteissa? NO TIETENKIN KOSKA 666!!!
		#dqb $?

		${ipt} -F ${t}
		dqb $?

		#${ip6t} -P ${t} DROP
		#dqb $?

		${ip6t} -F ${t}
		dqb $?
	done
fi

csleep 2
c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
tlah ${c}

c=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
tlah ${c}

dqb "accept that"
csleep 1
##TODO?:jokin loivennus jos /sbin/ifconfig listaa vain lo-ifacen? tai "ip link show | grep up | ec -l" jotenkin
##TODO?:/etc/rcS.d alaiset linkit, saisiko niitä starttaamaan sen tables-persistentin 
#
#for x in iptables ip6tables iptables-restore ip6tables-restore ; do
#	#dqb ${x}
#	ocs ${x}
#	tlah $?
#done
#
#ipt=$(${odio} which iptables)
#ip6t=$(${odio} which ip6tables)
#iptr=$(${odio} which iptables-restore)
#ip6tr=$(${odio} which ip6tables-restore)
#
#csleep 1
#dqb "0 cc of \??? intravenomously stat"
#c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
#c2=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
#
#if [ ${c} -gt 0 ] || [ ${c2} -gt 0 ] ; then
#	for t in INPUT OUTPUT FORWARD ; do
#		${ipt} -P ${t} DROP
#		tlah $?
#		dqb "V4 ${t} $?" #; csleep 1
#
#		#pitäisikö huuhdella myÖs v4-taulut?
#		${ipt} -F ${t}
#		tlah $?
#
#		${ip6t} -P ${t} DROP
#		tlah $?
#		dqb "V6 ${t} $?" #; csleep 1
#
#		${ip6t} -F ${t}
#		tlah $?
#		dqb "V6 -GF ${t} $?" #; csleep 1
#	done
#
#	#jatkossa jokin array voisi sisltää nuo
#	for t in e b u v c f ; do
#		#${ipt} -P ${t} DROP #miski -P kommenteissa? NO TIETENKIN KOSKA 666!!!
#		#dqb $?
#
#		${ipt} -F ${t}
#		dqb $?
#
#		#${ip6t} -P ${t} DROP
#		#dqb $?
#
#		${ip6t} -F ${t}
#		dqb $?
#	done
#fi
#
#csleep 2
#c=$(${ipt} -L | grep policy | grep ACCEPT | wc -l)
#tlah ${c}
#
#c=$(${ip6t} -L | grep policy | grep ACCEPT | wc -l)
#tlah ${c}
#
#dqb "accept that"
#csleep 1

case "${CONF_algo}" in
	sha256)
		sah6=$(${odio} which sha256sum)
	;;
	sha512)
		sah6=$(${odio} which sha512sum)
	;;
esac

#TODO:tähän -z, .x sah6 liittyen

#olisi se ocs()...
sco=$(${odio} which chown)
[ y"${sco}" == "y" ] && exit 98
[ -x ${sco} ] || exit 97
	
scm=$(${odio} which chmod)
[ y"${scm}" == "y" ] && exit 96
[ -x ${scm} ] || exit 95

sco="${odio} ${sco} "
scm="${odio} ${scm} "	

function p3r1m3tr() {
	${scm} 0400 /etc/iptables/*
	${scm} 0550 /etc/iptables
	${sco} -R root:root /etc/iptables
	${scm} 0400 /etc/default/rules*
	${sco} -R root:root /etc/default
}

p3r1m3tr
#TODO:jotain sha-gpg-tarq näille main?
#gp,gh-kikkailuja myös?
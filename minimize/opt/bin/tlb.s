#se suuri mölinä jos resolv.conf puuttuu
if [ ! -f /etc/resolv.conf ] ; then
	echo "ULIULIULI 666"
	sleep 99
else
	cat /etc/resolv.conf
	sleep 9
fi

#tarkoituksella näin
[ -z "${1}" ] && exit

p=$(echo ${1} | tr -d -c 0-9)
dqb "bfore -f"
csleep 1

[ -f /etc/iptables/rules.v4.${p} ] || tlah 1
[ -f /etc/iptables/rules.v6.${p} ] || tlah 1
dqb "bfore -s"
csleep 1

[ -s /etc/iptables/rules.v4.${p} ] || tlah 1
[ -s /etc/iptables/rules.v6.${p} ] || tlah 1
dqb "just bfore iptr"
csleep 1

#"-r" - tark ei vissiin tarpeellinen, to state the obv

${iptr} /etc/iptables/rules.v4.${p}
tlah $?
csleep 1

dqb "v4 reloaded ok"

${ip6tr} /etc/iptables/rules.v6.${p}
tlah $?
csleep 1
dqb "v6 reloaded ok"



${ipt} -D INPUT 8
${ipt} -D INPUT 7
${ipt} -D OUTPUT 9
${ipt} -D OUTPUT 8
#exit 99
#=========================PART 0 ENDS HERE=================================================================
function pr4() {
psqa ${1}
#TODO:dnsm-jutuille jos tekisijojo tain , esim. stubby+dnsmasq toimimaan ni ei tartte noita poistella
if [ ${dnsm} -eq 1 ] ; then
${NKVD} ${1}/stubby*
${NKVD} ${1}/libgetdns*
${NKVD} ${1}/dnsmasq*
fi
}
function pre_part3() {
if [ ${dnsm} -eq 1 ] ; then
${sdi} ${1}/dns-root-data*.deb
${NKVD} ${1}/dns-root-data*.deb
fi
${sdi} ${1}/perl-modules-*.deb
${NKVD} ${1}/perl-modules-*.deb
}
#TODO:testaa tämän toiminta
function udp6() {
${shary} libip4tc2 libip6tc2 libxtables12 netbase libmnl0 libnetfilter-conntrack3 libnfnetlink0 libnftnl11
${shary} iptables
${shary} iptables-persistent init-system-helpers netfilter-persistent
pre2 ${2}
csleep 6
}
function part2_pre() {
if [ ${1} -eq 1 ] ; then
${sharpy} libopts25
${sharpy} rpc* nfs*
fi
csleep 3
}
check_binaries ${distro}
check_binaries2
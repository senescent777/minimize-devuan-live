if [ -x ${d0}/e/e22.sh ] ; then
	.  ${d0}/e/e22.sh
	[ $? -gt 0 ] && exit 66
	csleep 1

	.  ${d0}/e/e23.sh
	[ $? -gt 0 ] && exit 67
	csleep 1
else
	echo "NO BACKEND FOUND"
	exit 58
fi

case "${mode}" in
#	rp) #080326:toistaiseksi jemmaan, kiukuttelua (takaisin komm josqs?)
#		[ -s "${tgtfile}" ] || exit 67
#		[ -r "${tgtfile}" ] || exit 68
#		e22_rpg ${tgtfile} ${d}
#17426:josqs ta,aisin kommenteista?
#	;;
	f) #170426:osaa tehdä paketin edelleen
		enforce_access $(whoami) ${t}
		e22_arch ${tgtfile} ${d} ${gbk}
		
		#HUOM! EIPÄ KIKKAILLA sha512sums.txt KANSSA, tar.sha PAREMPI IDEA
		#, PITÄÄ VAIN SAADA AIKAISEKSI common_lib.ah HUOMIOIMAAN SE
	;;
	q)
		#170326:tekee edelleen arkiston, sisältö kenties ok
		[ -v CONF_default_arhcive ] || exit 33
		[ -v CONF_default_arhcive2 ] || exit 34
		[ -v CONF_default_arhcive3 ] || exit 35

		e23_qrs ${tgtfile} ${d0} ${CONF_default_arhcive2} ${CONF_default_arhcive} ${CONF_default_arhcive3}
	;;
	c) #ainakin 160426 tIEnoilla toimi viimeksi
		e22_cde ${tgtfile} ${d0} ${distro}
	;;
	p) #170326:lienee kunnossa
		[ -v CONF_default_arhcive3 ] || exit 66
		csleep 1
		[ -v CONF_iface ] && ${sifu} ${CONF_iface}
		e23_profs ${tgtfile} ${d0} ${CONF_default_arhcive3}	
	;;
	-h)
		usage
	;;
#	b)
#		#230326:tekee jo jotain, vielä sietää miettiä onko siinä pointtia mitä tekee
#		for f in $(find ${d0} -type f -name "*lib.sh") ; do
#			e22_ftr ${f}
#		done
#	;;
	*)
		cont=1
	;;
esac
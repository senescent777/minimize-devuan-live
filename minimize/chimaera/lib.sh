#=========================PART 0 ENDS HERE=================================================================
function pr4() {
	#HUOM. stubby,dns-siivoamiset voisi olla riippuivaisua konfiguraatiosta
	dqb "pr4 (${1})"
	${NKVD} ${1}/stubby*
	${NKVD} ${1}/libgetdns*

	#uutena
	${NKVD} ${1}/dnsmasq*
	dqb "d0n3"
}

#HUOM.170325:git näköjään asentuu pr4((), pre3() - vaiheiden aikana vaikka vähän nalkutusta tuleekin(josko nalkutuksen poistaisi)
#HUOM.21035: toimiiko nuo sdi-jutut tädssä myös check_bin() kautta? pitäisikö?
#HUOM.230325:tuoreemmat nalkutukset import2.sh kautta, josko tekisi jotain? (TODO)
function pre_part3() {
	dqb "pre_part3( ${1})"
	${sdi} ${1}/dns-root-data*.deb
	${NKVD} ${1}/dns-root-data*.deb

	#uutena, pois jos qsee	
	${sdi} ${1}/perl-modules-*.deb
	${NKVD} ${1}/perl-modules-*.deb
}


dqb "BIL-UR-SAG"
check_binaries ${distro}
check_binaries2 
dqb "UMULAMAHRI"

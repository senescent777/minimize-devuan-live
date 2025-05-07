function whack() {
	#sudo /usr/bin/pkill --signal 9 $1
	${whack} ${1}
}

function prepare() {
	local tmpdir
	tmpdir=$(mktemp -d)
	#[ $? -gt 0 ] && exit #jokohan nut toimisi tarkistus
	[ x"${tmpdir}" == "x" ] && exit 99

	#[ -s ${1} ] && tar -C ${tmpdir} -xvf ${1}
	[ -s ${1} ] && ${srat} -C ${tmpdir} -xf ${1}
	[ -d ${tmpdir}/home ] && ${smr} -rf ${tmpdir}/home
	[ -f ${tmpdir}/.rnd ] && ${smr} -rf ${tmpdir}/.rnd

	#jotain nalkutusta saattaa tulla
	#${svm} ${tmpdir}/prefs.js ${tmpdir}/user.js
}
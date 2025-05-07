function whack() {
	#sudo /usr/bin/pkill --signal 9 $1
	${whack} ${1}
}

function prepare() {
	tmpdir=$(mktemp -d)
	#[ -s ${1} ] && tar -C ${tmpdir} -xvf ${1}
	[ -s ${1} ] && ${srat} -C ${tmpdir} -xf ${1}

	#jotain nalkutusta saattaa tulla
	#${svm} ${tmpdir}/prefs.js ${tmpdir}/user.js
}
echo "INSTALLING MIDDLEWARE"
sleep 3

function whack() {
	#sudo /usr/bin/pkill --signal 9 $1
	${whack} ${1}
}

#TODO:tmpdir parametriksi
function prepare() {
	debug=1
	dqb "prepare(${1}) "
	csleep 5

#	local tmpdir
#	tmpdir=$(mktemp -d)

	echo $?
	csleep 5

	[ -s ${1} ] && ${srat} -C ${tmpdir} -xvf ${1}

	if [ x"${tmpdir}" != "x" ] ; then
		if [ -d ${tmpdir} ] ; then
			#kolmaskin komento voisi olla bloki n sisällä
			
		fi
	fi

	#jotain nalkutusta saattaa tulla
	#${svm} ${tmpdir}/prefs.js ${tmpdir}/user.js
	dqb "PERP D0N3"
}
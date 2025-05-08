echo "INSTALLING MIDDLEWARE"
sleep 3

function whack() {
	${whack} ${1}
}

#TODO:fktion ulostusta tarvitsevassa koodissa mv find:in avulla ni turhat jää matkalle
function prepare() {
	debug=1
	dqb "prepare(${1}, ${2}) "
	csleep 5

	[ x"${1}" == "x" ] && exit 33
	[ y"${2}" == "y" ] && exit 44
	dqb "params_ok"

	if [ -s ${1} ] ; then
		if [ -d ${2} ] ; then
			dqb "POPPER.3"
			csleep 5

			${srat} -C ${2} -xvf ${1}
			#jotain nalkutusta saattaa tulla
			#${svm} ${tmpdir}/prefs.js ${tmpdir}/user.js
		fi
	fi

	csleep 5
	dqb "PERP D0N3"
}
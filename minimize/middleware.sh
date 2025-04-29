#jatkossa sitten common_lib käyttöön

function whack() {
	sudo /usr/bin/pkill --signal 9 $1
}

function prepare() {
	tmpdir=$(mktemp -d)
	[ -s ${1} ] && tar -C ${tmpdir} -xvf ${1}
}
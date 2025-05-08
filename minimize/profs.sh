#netscape/mozilla/firefox profiles can be a Pain In the Ass

cprof_1_1() {
	debug=1	
	dqb "cprof1 ${1} ${2}"
	csleep 5

		tmp=$(grep $1 /etc/passwd | wc -l)

		if [ $tmp -gt 0 ] ; then 
			if [ -d /home/$1/.mozilla ] ; then
				sudo shred /home/$1/.mozilla/*
				sudo rm -rf /home/$1/.mozilla 
			fi
	
	
			sudo mkdir -p /home/$1/.mozilla/firefox
			sudo chown -R $1:$1 /home/$1/.mozilla/firefox
		fi

	if [ ${debug} -eq 1 ] ; then
		echo "AFTER MKDIR";sleep 5
		ls -las /home/$1/.mozilla/firefox;sleep 6
		echo "eEXIT CPROF_1_1($1)"
	fi
}

cprof_1_2() {
	debug=1
	dqb "cpfor_12 ${1},${2}"

	fox=$(sudo which firefox)

		tmp=$(grep $1 /etc/passwd | wc -l)

		if [ $tmp -gt 0 ] ; then 
			if [ -x $fox ] ; then
				cd /home/$1
				sudo -u $1 $fox&
	
				if [ $? -eq 0 ] ; then
					sleep 5
					whack firefox-esr 
					whack firefox 
				fi
			else
				echo "https://www.youtube.com/watch?v=PjotFePip2M" 
			fi
		fi

	csleep 5
}

#TODO:vissiinkin tmpdir parametriksi
cprof_1_3() {
	debug=1
	[ -d /home/$2/.mozilla/firefox ] || exit 68
	cd /home/${2}/.mozilla/firefox
	
	if [ ${debug} -eq 1 ] ; then
		pwd;sleep 6 
		echo "CPROF_1_3_1";sleep 5
		ls -las /home/${2}/.mozilla/firefox;sleep 6
	fi

		tget=$(ls | grep $1 | tail -n 1) 

		sudo chown ${2}:${2} ./${tget}
		sudo chmod 0700 ./${tget}
		
		if [ x"${tget}" != "x" ] ; then 
			cd ${tget}
		fi

	#HUOM!MISSÄ TMPDIR ASETETAAN
	if [ x"${tmpdir}" != "x" ] ; then
		if [ -d ${tmpdir} ] ; then
			if [ ${debug} -eq 1 ] ; then
				echo -n "pwd=";pwd
				echo "IN 6 SECONDS: sudo mv $tmpdir/* ."
				sleep 6
			fi

			sudo mv ${tmpdir}/* . #TÄMÄN KANSSA TARKKUUTTA PERKELE
			sudo chown -R ${2}:${2} ./* 		
	
			if [ ${debug} -eq 1 ] ; then
				echo "AFT3R MV";sleep 6
				ls -las;sleep 5
			fi	

			sudo shred -fu ${tmpdir}/*
			sudo rm -rf ${tmpdir}
		fi
	fi

	csleep 5
	dqb "CPROF13 D0N3"
}

cprof_2_1() {
	debug=1
	dqb "CPFOR21 ${1} , ${2}"
	csleep 3

	if [ x$1 != x ] ; then 
		sudo chown -R $1:$1 /home/$1

		if [ -d /home/$1/.mozilla ] ; then 
			sudo chown -R $1:$1 /home/$1/.mozilla
			sudo chmod -R go-rwx /home/$1/.mozilla 	
		fi

		[ -d /home/$1/Downloads ] || sudo mkdir /home/$1/Downloads

		sudo chown -R $1:$1 /home/$1/Downloads
		sudo chmod u+wx /home/$1/Downloads
		sudo chmod o+w /tmp 
	fi

	dqb "d0n3"
	csleep 3
}

copyprof() {
	dqb "cprof ${1} ${2}"
	csleep 3
	cd /home/$2 

	if [ x$2 != x ] ; then 
		if [ -d /home/$2 ] ; then 
			sudo chmod 0700 /home/$2


			cprof_1_1 $2
			cprof_1_2 $2
			exit 99
			cprof_1_3 $1 $2
			cprof_2_1 $2
		fi
	fi

	dqb "cpforf dnoe"
	csleep 3
}

function exp_prof() {
	dqb "exp_pros ${1} ${2}"
	local tget
	local p
	local f
	
	csleep 3
	
	tget=$(ls ~/.mozilla/firefox/ | grep ${2} | tail -n 1)
	p=$(pwd)

	cd ~/.mozilla/firefox/${tget}
	dqb "TG3T=${tget}"
	csleep 2

	${odio} touch ./rnd
	${sco} ${n}:${n} ./rnd
	${scm} 0644 ./rnd
	dd if=/dev/random bs=6 count=1 > ./rnd

	${srat} -cvf ${1} ./rnd
	for f in $(find . -name '*.js') ; do ${srat} -rf ${1} ${f} ; done
	#*.js ja *.json kai oleellisimmat kalat
	cd ${p}

	cslep 5
	dqb "eprof.D03N"
}
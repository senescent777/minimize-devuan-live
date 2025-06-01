#!/bin/bash
n=$(whoami)
mode=0

if [ $# -gt 0 ] ; then
	mode=${1}
fi

#HUOM.250325:onnistuukohan ihan näin pienellä rikkoa chimaera/x/slim? toivoisi ettei
#pari ensimmäistä arvausta oli jotta part1 tai pre_enforce paskovat asioita
#29525 päivitys: common_lib , fktio dis() , kommentoidut kohdat

[ ${mode} -gt 1 ] && . ~/Desktop/minimize/chimaera/conf
[ ${mode} -gt 2 ] && . ~/Desktop/minimize/common_lib.sh
[ ${mode} -gt 3 ] && . ~/Desktop/minimize/chimaera/lib.sh
[ ${mode} -gt 4 ] && pre_enforce ${n} chimaera 
[ ${mode} -gt 5 ] && enforce_access ${n} #tämä ei vielä riko äksää
[ ${mode} -gt 6 ] && part1 chimaera #HUOM.290325 oli nimenomaan part1 mikä paskoi asioita
[ ${mode} -gt 0 ] && sleep 5

pkill --signal 9 xfce4-session

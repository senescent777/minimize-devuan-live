#!/bin/bash
mode=${1}
n=$(whoami)
.  ~/Desktop/minimize/chimaera/conf
#HUOM.250325:onnistuukohan ihan näin pienellä rikkoa chimaera?

case ${1} in #to state the obvious:if parempi tämmöiseen qu case
	0)
		sleep 5
	;;
	1)
		. ~/Desktop/minimize/common_lib.sh
		sleep 5
	;;
	2)
		. ~/Desktop/minimize/common_lib.sh
		. ~/Desktop/minimize/chimaera/lib.sh
		sleep 5
	;;
	3)
		#HUOM.25325;tämä taisi vielä pelata
		. ~/Desktop/minimize/common_lib.sh
		. ~/Desktop/minimize/chimaera/lib.sh
		enforce_access ${n} 
		sleep 5
	;;
	4)
		#tässä taas part1 laittoi kusemaan, ilmankin pre_enforcea, luulisin
		. ~/Desktop/minimize/common_lib.sh
		. ~/Desktop/minimize/chimaera/lib.sh
		
		pre_enforce ${n} chimaera 
		enforce_access ${n}
		part1 chimaera
		sleep 5
	;;
	*)
		echo "MEE VITTUUN"
	;;
esac


pkill --signal 9 xfce4-session

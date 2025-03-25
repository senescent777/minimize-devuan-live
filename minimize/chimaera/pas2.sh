#!/bin/bash
mode=${1}

case ${1}
	0)
		sleep 5
	;;
	case 1)
		. ~/Desktop/minimize/common_lib.sh
		sleep 5
	;;
	case 2)
		. ~/Desktop/minimize/common_lib.sh
		.  ~/Desktop/minimize/chimaera/lib.sh
		sleep 5
	;;
esac


pkill --signal 9 xfce4-session
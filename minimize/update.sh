#!/bin/bash
tgt=${1}
[ -f ${tgt} ] || exit 1

#TODO:tähän kenties jotain muutoksia, liittyen fstab:in sorkkimiseen
for f in $(find ~/Desktop/minimize/ -name 'conf*') ; do sudo tar -f ${tgt} -rv ${f} ; done
for f in $(find ~/Desktop/minimize/ -name '*.sh') ; do sudo tar -f ${tgt} -rv ${f} ; done

sudo tar -f ${tgt} -rv /etc/default/locale* /etc/timezone
#!/bin/bash

exdir=$(dirname $0)
pfx=$(mktemp -d /tmp/$(basename $0).XXXXXXXXXX) || exit 1

for sourcefile in *.md
do

    # yeah, I could have done this way better, but "cut" is what I could remember
    id=$(echo ${sourcefile} | cut -d '.' -f 1 | cut -d '-' -f 4- | egrep '^[0-9]+' );

    if [ -n "${id}" ]; then
    
        tmpfile=${pfx}/${sourcefile}
        cp ${sourcefile} ${tmpfile}
        
        echo $id $tmpfile $sourcefile

        awk -v id=$id -f ${exdir}/addid.awk $tmpfile > $sourcefile

    fi
done

exit 0

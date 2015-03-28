#!/bin/sh

for f in *.md; do
    # yeah, I could have done this way better, but "cut" is what I could remember
    id=`echo $f | cut -d '.' -f 1 | cut -d '-' -f 4- | egrep '^[0-9]+'`;

    if [ -n "$id" ]; then
        echo awk -v $id addid.awk $f
    fi

done


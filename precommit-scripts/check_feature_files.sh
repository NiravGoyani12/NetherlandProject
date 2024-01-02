#!/bin/bash
disallowed="@torun"

git diff --cached --name-status | while read x file; do
    if [ "$x" == 'D' ]; then continue; fi
    if egrep $disallowed $file ; then
        echo "ERROR: Disallowed expression \"${disallowed}\" in file: ${file}"
        exit 1
    fi
    done
exit $?
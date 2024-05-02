#!/bin/sh
# kos-ports ##version##
#
# utils/clean-all.sh
# Copyright (C) 2015 Lawrence Sebald
#

cd ${KOS_PORTS}

for _dir in ${KOS_PORTS}/* ; do
    if [ -d "${_dir}" ] ; then
        if [ -f "${_dir}/Makefile" ] ; then
            echo "Cleaning in ${_dir}..."
            ${KOS_MAKE} -C "${_dir}" clean
        fi
    fi
done

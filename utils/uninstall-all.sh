#!/bin/sh
# kos-ports ##version##
#
# utils/uninstall-all.sh
# Copyright (C) 2015 Lawrence Sebald
#

cd ${KOS_PORTS}

for _dir in ${KOS_PORTS}/* ; do
    if [ -d "${_dir}" ] ; then
        if [ -f "${_dir}/Makefile" ] ; then
            echo "Uninstalling in ${_dir}..."
            ${KOS_MAKE} -C "${_dir}" uninstall
        fi
    fi
done

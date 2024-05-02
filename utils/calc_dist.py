#!/usr/bin/env python
# kos-ports ##version##
#
# utils/calc_dist.py
# Copyright (C) 2015 Lawrence Sebald
#

import os
import sys
import hashlib

for arg in sys.argv[1:]:
    h = hashlib.sha256()
    with open(arg, 'rb') as f:
        buf = f.read(1024*1024)
        while len(buf) > 0:
            h.update(buf)
            buf = f.read(1024*1024)
        print("SHA256 (%s) = %s" % (arg, h.hexdigest()))
        print("SIZE (%s) = %d" % (arg, os.path.getsize(arg)))

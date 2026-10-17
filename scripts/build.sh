#!/bin/bash

cd "`dirname \"$0\"`/.."

emmake make clean
CFLAGS="${CFLAGS:-} -std=gnu11" emconfigure autoreconf -fiv
CFLAGS="${CFLAGS:-} -std=gnu11" ac_cv_exeext=".html" emconfigure ./configure --host=none-none-none

emmake make

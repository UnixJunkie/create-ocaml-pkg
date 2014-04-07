#!/usr/bin/env bash

set -x

# requires fpm for package creation; cf. https://github.com/jordansissel/fpm

# TODO:cd to you OCaml source tree

PREFIX=/usr/local/ocaml-destdir
./configure -prefix $PREFIX
make opt.opt
# Install to a separate directory, for fpm to capture later on
DESTDIR=/tmp/ocaml-destdir-test
mkdir -p $DESTDIR
make install DESTDIR=$DESTDIR
# give read and exec perms to group and others
find $DESTDIR -readable   | xargs -L1 chmod go+r
find $DESTDIR -executable | xargs -L1 chmod go+x

#sudo rpm -e ocaml-destdir-1.0-1.x86_64 # uninstall previous
#\rm ocaml-destdir-1.0-1.x86_64.rpm # rm previously created package

# create package, change deb to rpm (or rpm to deb) if you need
fpm -s dir -t rpm -n ocaml-destdir -C $DESTDIR usr

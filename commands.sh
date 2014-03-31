#!/usr/bin/env bash

# requires fpm for package creation; cf. https://github.com/jordansissel/fpm

wget http://caml.inria.fr/pub/distrib/ocaml-4.01/ocaml-4.01.0.tar.gz
tar xzf ocaml-4.01.0.tar.gz
cd ocaml-4.01.0
./configure -prefix /usr/local/ocaml-4.01.0
make opt.opt
sudo su - # ROOT FROM NOW ON
make install
# give read and exec perms to group and others
find /usr/local/ocaml-4.01.0/ -readable   | xargs -L1 chmod go+r
find /usr/local/ocaml-4.01.0/ -executable | xargs -L1 chmod go+x
exit # NO MORE ROOT
# create package, change deb to rpm if you need
fpm -s dir -t deb -n ocaml-4.01.0 /usr/local/ocaml-4.01.0

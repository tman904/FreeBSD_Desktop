#!/bin/sh

p=`top -b |grep Xorg |cut -d " " -f1`
kill $p

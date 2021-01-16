#!/usr/bin/env bash
go test -cflags="-I./php-lib/ -I./php-lib/main -I./php-lib/TSRM -I./php-lib/Zend -I./php-lib/ext" -ldflags="-r ./php-lib/sapi/embed/.libs/ " $*

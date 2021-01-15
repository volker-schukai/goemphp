#!/usr/bin/env bash

if [ ! -e ./php-version ] || [ ! -s ./php-version ]; then
	echo "FATAL: Please run bootstrap.sh first."
	exit 1
fi

PHP_VER=`cat php-version`

#case $PHP_VER in
#7.4)
#	PHP_SO=php7
#	PHP_C=php_embed.c.7
#  ;;
#*)
#	PHP_SO=php8
#	PHP_C=php_embed.c.8
#	echo "FATAL: Under development"
#	exit 1
#  ;;
#esac

PHP_SO=php_embed.o
PHP_C=php_embed.c

cp php-srcs/*/sapi/embed/php_* .

PWD=`pwd`

sed "s/%PHP.SO%/${PHP_SO}/" php_embed.go.template | sed "s\\%PWD%\\${PWD}\\g" > php-embed.go

exit 0

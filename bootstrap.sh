#!/usr/bin/env bash
set -e

help() {
	printf "Usage: $0 [PHP version]\n\n"
	printf " * The PHP version can be one of 7.4 8.0 \n"
}

[ -z $1 ] && help && exit

PHP_VER=$1

PHP_7_4_D=php-7.4.14
PHP_8_0_D=php-8.0.1

PHP_7_4=http://php.net/get/${PHP_7_4_D}.tar.bz2/from/this/mirror
PHP_8_0=http://php.net/get/${PHP_8_0_D}.tar.bz2/from/this/mirror

case $PHP_VER in
7.4)
	TAR=$PHP_7_4
	DIR=$PHP_7_4_D
  ;;
*)
 	TAR=$PHP_8_0
	DIR=$PHP_8_0_D
  ;;
esac

WORK_DIR=php-srcs
mkdir -p $WORK_DIR
[ -d $WORK_DIR/$DIR ] && echo "FATAL: $DIR already existed. Please remove $DIR manually and run $0 again." && exit

pushd .
cd $WORK_DIR

wget -O php.tar.bz2 $TAR
tar jxvf php.tar.bz2
rm php.tar.bz2
cd $DIR 
./configure --build=x86_64-linux-gnu --host=x86_64-linux-gnu --sysconfdir=/etc --localstatedir=/var --mandir=/usr/share/man \
            --disable-debug --disable-rpath --disable-static --with-pic --with-layout=GNU --with-pear=/usr/share/php \
            --enable-calendar --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-bcmath \
            --with-bz2 --enable-ctype --with-iconv --enable-exif --enable-ftp \
            --with-gettext --enable-mbstring --enable-shmop --enable-sockets \
            --with-zlib --with-openssl=/usr \
            --enable-soap --with-mhash=yes  \
            --enable-dtrace --without-mm --with-curl=shared,/usr --with-enchant=shared,/usr \
            --with-zlib-dir=/usr --with-gmp=shared,/usr \
            --enable-intl=shared --with-ldap=shared,/usr --with-ldap-sasl=/usr \
            --with-pspell=shared,/usr \
            --with-xsl=shared,/usr \
            --with-xmlrpc=shared --enable-embed --with-libdir=/lib/x86_64-linux-gnu


# --with-mysql-sock=/var/run/mysqld/mysqld.sock --with-mysqli=shared,/usr/bin/mysql_config --with-unixODBC=shared,/usr --with-pgsql=shared,/usr
# --with-snmp=shared,/usr --with-tidy=shared,/usr --enable-wddx --enable-zip  --with-gd=shared,/usr --enable-gd-native-ttf  --with-png-dir --with-freetype-dir
# --with-recode --with-libxml-dir, --with-jpeg-dir, --with-xpm-dir --with-jpeg-dir=shared,/usr  --with-xpm-dir=shared,/usr/X11R6

make
popd
echo $PHP_VER > php-version
#unlink php-lib
ln -s $WORK_DIR/$DIR php-lib

echo "Congratulations!!!"

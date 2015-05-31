#!/bin/bash
MYSQL_ROOT="WikiFMROOTPWD"
echo 'mysql-server-5.5 mysql-server/root_password password '$MYSQL_ROOT | debconf-set-selections
echo 'mysql-server-5.5 mysql-server/root_password_again password '$MYSQL_ROOT | debconf-set-selections

echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password ' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password '$MYSQL_ROOT | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password ' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

gpg --keyserver keys.gnupg.net --recv-keys 5C927F7C
gpg -a --export 5C927F7C | apt-key add -
echo "deb [arch=amd64] http://parsoid.wmflabs.org:8080/deb wmf-production main" > /etc/apt/sources.list.d/parsoid.wmflabs.org.list
apt-get update

apt-get install -y mysql-server
apt-get install -y parsoid
apt-get install -y phpmyadmin rsync php5-gd php5-xcache php-pear \
 gcc g++ make python python-pip python-dev \
 python-virtualenv libjpeg-dev libz-dev libfreetype6-dev liblcms-dev \
 libxml2-dev libxslt-dev ocaml-nox git-core python-imaging python-lxml \
 texlive-latex-recommended ploticus dvipng imagemagick pdftk git

cat > /root/.my.cnf << EndOfMessage
[client]
user=root
password=$MYSQL_ROOT
EndOfMessage

{
 echo "update mysql.user set host='%' where user='root' LIMIT 1;"
 echo "delete from mysql.user where host != '%' and user = 'root';"
 echo "flush privileges;"
} | mysql


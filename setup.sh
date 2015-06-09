#!/bin/bash
MYSQL_ROOT="WikiFMROOT"
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

curl -sL https://deb.nodesource.com/setup | bash -

for p in \
 screen \
 sudo \
 redis-server \
 zip \
 nodejs \
 mysql-server \
 build-essential \
 nodejs \
 parsoid \
 phpmyadmin \
 rsync \
 git \
 curl \
 php5 \
 phpunit \
 php5-cli \
 texlive-xetex \
 texlive-latex-recommended \
 texlive-latex-extra \
 texlive-generic-extra \
 texlive-fonts-recommended \
 texlive-fonts-extra \
 fonts-hosny-amiri \
 fonts-farsiweb \
 fonts-nafees \
 fonts-arphic-uming \
 fonts-arphic-ukai \
 fonts-droid fonts-baekmuk \
 texlive-lang-all \
 latex-xcolor \
 poppler-utils \
 imagemagick \
 librsvg2-bin \
 libjpeg-progs \
 djvulibre-bin \
 unzip ; do
 apt-get install -y $p
done

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

cat > /root/.my.cnf << EndOfMessage
[client]
user=root
password=$MYSQL_ROOT
EndOfMessage

echo "update mysql.user set host='%' where user='root' LIMIT 1;" | mysql
echo "delete from mysql.user where host != '%' and user = 'root';" | mysql
echo "flush privileges;" | mysql

OCG=/var/lib/ocg
getent passwd ocg || useradd -r -d $OCG ocg
mkdir $OCG
cd $OCG
test -d mw-ocg-service || git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator mw-ocg-service
test -d mw-ocg-bundler || git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator/bundler mw-ocg-bundler
test -d mw-ocg-latexer || git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator/latex_renderer mw-ocg-latexer
test -d mw-ocg-texter  || git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator/text_renderer mw-ocg-texter
for d in mw-ocg-service mw-ocg-bundler mw-ocg-latexer mw-ocg-texter; do
 cd $d
 git checkout $(git tag -l | sort -V | tail -1)
 cd ..
done
npm install es6-shim prfun  commander domino linewrap tmp sqlite3 -g
for f in mw-ocg-service mw-ocg-bundler mw-ocg-latexer mw-ocg-texter ; do
 cd $f
 npm install
 cd ..
done
cd mw-ocg-service
cat <<EOF > localsettings.js
// for mw-ocg-service
module.exports = function(config) {
  // change the port here if you are running parsoid on a different port
  config.backend.bundler.parsoid_api = "http://localhost:8000";
  // the prefix here should match \$wgDBname in your LocalSettings.php
  config.backend.bundler.parsoid_prefix = "localhost";
  // Use the Parsoid "v1" API
  // config.backend.bundler.additionalArgs = [ '--api-version=parsoid1' ];
}

EOF
chown ocg:ocg $OCG -R

cat <<EOF > /etc/mediawiki/parsoid/settings.js
"use strict";

exports.setup = function( parsoidConfig ) {
	parsoidConfig.setInterwiki( 'wiki', 'http://localhost/api.php' );
	parsoidConfig.debug = true;
	parsoidConfig.useSelser = true;
	parsoidConfig.allowCORS = '*';
	parsoidConfig.serverPort = 8000;
};
EOF

echo "Aggiungere a /etc/rc.local"
echo
echo "cd /var/lib/ocg/mw-ocg-service/"
echo "screen -mdS mw-ocg-service ./mw-ocg-service.js -c localsettings.js"
echo

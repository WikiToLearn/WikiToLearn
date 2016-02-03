#!/bin/bash


# NOTE If you add a symlink here, please add it also to clean-symlinks.sh

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

cd $CWD;

# should be a no-op, but you never know...
$CWD/clean-symlinks.sh

# do the symlinks dance
ln -s ../LocalSettings.php mediawiki/LocalSettings.php
ln -s ../../Neverland mediawiki/skins/Neverland
ln -s ../extensions mediawiki/extensions
ln -s ../favicon.ico mediawiki/favicon.ico
ln -s ../vendor/mediawiki mediawiki/vendor

for e in SyntaxHighlight_GeSHi ParserHooks ; do
 test -d vendor/$e || mkdir -p vendor/$e
 rm -Rfv mediawiki/extensions/$e/vendor
 ln -s ../../vendor/$e mediawiki/extensions/$e/vendor
done

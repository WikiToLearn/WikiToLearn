"use strict";

exports.setup = function( parsoidConfig ) {
        parsoidConfig.setInterwiki( 'dewikitolearn', 'http://de.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'enwikitolearn', 'http://en.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'eswikitolearn', 'http://es.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'frwikitolearn', 'http://fr.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'itwikitolearn', 'http://it.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'ptwikitolearn', 'http://pt.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'svwikitolearn', 'http://sv.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'metawikitolearn', 'http://meta.wikitolearn.org/api.php' );
        parsoidConfig.setInterwiki( 'poolwikitolearn', 'http://pool.wikitolearn.org/api.php' );
        parsoidConfig.debug = true;
        parsoidConfig.useSelser = true;
        parsoidConfig.allowCORS = '*';
        parsoidConfig.serverPort = 8000;
};

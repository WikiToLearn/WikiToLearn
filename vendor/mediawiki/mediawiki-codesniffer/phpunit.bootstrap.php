<?php

// Load CodeSniffer CLI class
call_user_func( function() {
	if ( !class_exists( 'PHP_CodeSniffer_CLI' ) ) {
		$composer['local'] = dirname( dirname( dirname( __FILE__ ) ) );
		$composer['wmfjenkins'] = '/srv/deployment/integration/phpcs/';
		foreach( $composer as $location ) {
			$location = $location . '/vendor/squizlabs/php_codesniffer/CodeSniffer/CLI.php';
			if( file_exists( $location ) ) {
				require_once $location;
				break;
			}
		}
		if( !class_exists( 'PHP_CodeSniffer_CLI' ) ) {
			require_once 'PHP/CodeSniffer/CLI.php';
		}
	}
} );

// Load Test Helper
require_once dirname( __FILE__ ) . '/TestHelper.php';

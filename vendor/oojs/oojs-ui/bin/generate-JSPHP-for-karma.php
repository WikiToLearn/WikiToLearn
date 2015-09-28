<?php

// Quick and dirty autoloader to make it possible to run without Composer.
spl_autoload_register( function ( $class ) {
	$class = preg_replace( '/^OOUI\\\\/', '', $class );
	foreach ( array( 'elements', 'layouts', 'themes', 'widgets', '.' ) as $dir ) {
		$path = "../php/$dir/$class.php";
		if ( file_exists( $path ) ) {
			require_once $path;
			return;
		}
	}
} );

$testSuiteJSON = file_get_contents( 'JSPHP-suite.json' );
$testSuite = json_decode( $testSuiteJSON, true );
$testSuiteOutput = array();

function new_OOUI( $class, $config = array() ) {
	$class = "OOUI\\" . $class;
	return new $class( $config );
}
function unstub( &$value ) {
	if ( is_string( $value ) && substr( $value, 0, 13 ) === '_placeholder_' ) {
		$value = json_decode( substr( $value, 13 ), true );
		array_walk_recursive( $value['config'], 'unstub' );
		$value = new_OOUI( $value['class'], $value['config'] );
	}
}
// Keep synchronized with tests/index.php
$themes = array( 'ApexTheme', 'MediaWikiTheme' );
foreach ( $themes as $theme ) {
	OOUI\Theme::setSingleton( new_OOUI( $theme ) );
	foreach ( $testSuite as $className => $tests ) {
		foreach ( $tests as $test ) {
			// Unstub placeholders
			$config = $test['config'];
			array_walk_recursive( $config, 'unstub' );
			$config['infusable'] = true;
			$instance = new_OOUI( $test['class'], $config );
			$testSuiteOutput[$theme][$className][] = "$instance";
		}
	}
}

$testSuiteOutputJSON = json_encode( $testSuiteOutput, JSON_PRETTY_PRINT );

echo "var testSuiteConfigs = $testSuiteJSON;\n\n";
echo "var testSuitePHPOutput = $testSuiteOutputJSON;\n\n";
echo file_get_contents( 'JSPHP.test.karma.js' );

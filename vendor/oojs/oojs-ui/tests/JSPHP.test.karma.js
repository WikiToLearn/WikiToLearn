QUnit.module( 'JSPHP' );

( function () {
	// Generate some tests based on the test suite data and HTML from PHP version.
	var theme, klassName,
		themes = {
			ApexTheme: new OO.ui.ApexTheme(),
			MediaWikiTheme: new OO.ui.MediaWikiTheme()
		};

	function unstub( value ) {
		var config;
		if ( typeof value === 'string' && value.substr( 0, 13 ) === '_placeholder_' ) {
			value = JSON.parse( value.substr( 13 ) );
			config = OO.copy( value.config, null, unstub );
			return new OO.ui[ value.class ]( config );
		}
	}

	function makeTest( theme, klassName, tests, output ) {
		QUnit.test( theme + ': ' + klassName, tests.length * 2, function ( assert ) {
			var test, config, instance, infused, $fromPhp, i, testName;
			OO.ui.theme = themes[ theme ];
			for ( i = 0; i < tests.length; i++ ) {
				test = tests[ i ];
				// Unstub placeholders
				config = OO.copy( test.config, null, unstub );

				instance = new OO.ui[ test.class ]( config );
				$fromPhp = $( $.parseHTML( output[ i ] ) );

				$( 'body' ).append( instance.$element, $fromPhp );

				// Updating theme classes is normally debounced, we need to do it immediately
				instance.debouncedUpdateThemeClasses();

				testName = JSON.stringify( test.config );
				assert.equalDomElement( instance.$element[ 0 ], $fromPhp[ 0 ], testName, true );

				infused = OO.ui.infuse( $fromPhp[ 0 ] );
				infused.debouncedUpdateThemeClasses();

				assert.equalDomElement( instance.$element[ 0 ], infused.$element[ 0 ], testName + ' (infuse)' );
				instance.$element.add( infused.$element ).detach();
			}
		} );
	}

	/*global testSuiteConfigs, testSuitePHPOutput */
	for ( klassName in testSuiteConfigs ) {
		for ( theme in themes ) {
			makeTest(
				theme,
				klassName,
				testSuiteConfigs[ klassName ],
				testSuitePHPOutput[ theme ][ klassName ]
			);
		}
	}

} )();

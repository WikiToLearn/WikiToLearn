<?php

/**
 * @group TemplateData
 */
class TemplateDataBlobTest extends MediaWikiTestCase {

	protected function setUp() {
		parent::setUp();

		$this->setMwGlobals( array(
			'wgLanguageCode' => 'en',
			'wgContLang' => Language::factory( 'en' ),
		) );
	}

	/**
	 * Helper method to generate a string that gzip can't compress.
	 *
	 * Output is consistent when given the same seed.
	 */
	private static function generatePseudorandomString( $length, $seed ) {
		mt_srand( $seed );

		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$characters_max = strlen( $characters ) - 1;

		$string = '';

		for ( $i = 0; $i < $length; $i++ ) {
			$string .= $characters[mt_rand( 0, $characters_max )];
		}

		return $string;
	}

	public static function provideParse() {
		$cases = array(
			array(
				'input' => '[]
				',
				'status' => 'Property "templatedata" is expected to be of type "object".'
			),
			array(
				'input' => '{
					"params": {}
				}
				',
				'output' => '{
					"description": null,
					"params": {},
					"paramOrder": [],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'status' => true,
				'msg' => 'Minimal valid blob'
			),
			array(
				'input' => '{
					"params": {},
					"foo": "bar"
				}
				',
				'status' => 'Unexpected property "foo".',
				'msg' => 'Unknown properties'
			),
			array(
				'input' => '{}',
				'status' => 'Required property "params" not found.',
				'msg' => 'Empty object'
			),
			array(
				'input' => '{
					"foo": "bar"
				}
				',
				'status' => 'Unexpected property "foo".',
				'msg' => 'Unknown properties invalidate the blob'
			),
			array(
				'input' => '{
					"params": {
						"foo": {}
					}
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": null,
							"description": null,
							"default": null,
							"example": null,
							"required": false,
							"suggested": false,
							"deprecated": false,
							"aliases": [],
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["foo"],
					"sets": [],
					"format": null,
					"maps": {}
				}
				',
				'msg' => 'Optional properties are added if missing'
			),
			array(
				'input' => '{
					"params": {
						"comment": {
							"type": "string/line"
						}
					}
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"comment": {
							"label": null,
							"description": null,
							"default": null,
							"example": null,
							"autovalue": null,
							"required": false,
							"suggested": false,
							"deprecated": false,
							"aliases": [],
							"type": "line"
						}
					},
					"paramOrder": ["comment"],
					"sets": [],
					"format": null,
					"maps": {}
				}
				',
				'msg' => 'Old string/* types are mapped to the unprefixed versions'
			),
			array(
				'input' => '{
					"description": "User badge MediaWiki developers.",
					"params": {
						"nickname": {
							"label": null,
							"description": "User name of user who owns the badge",
							"default": "Base page name of the host page",
							"example": null,
							"required": false,
							"suggested": true,
							"aliases": [
								"1"
							]
						}
					}
				}
				',
				'output' => '{
					"description": {
						"en": "User badge MediaWiki developers."
					},
					"params": {
						"nickname": {
							"label": null,
							"description": {
								"en": "User name of user who owns the badge"
							},
							"default": {
								"en": "Base page name of the host page"
							},
							"example": null,
							"required": false,
							"suggested": true,
							"deprecated": false,
							"aliases": [
								"1"
							],
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["nickname"],
					"sets": [],
					"format": null,
					"maps": {}
				}
				',
				'msg' => 'InterfaceText is expanded to langcode-keyed object, assuming content language'
			),
			array(
				'input' => '{
					"description": "Document the documenter.",
					"params": {
						"1d": {
							"description": "Description of the template parameter",
							"required": true,
							"default": "example"
						},
						"2d": {
							"inherits": "1d",
							"default": "overridden"
						}
					}
				}
				',
				'output' => '{
					"description": {
						"en": "Document the documenter."
					},
					"params": {
						"1d": {
							"label": null,
							"description": {
								"en": "Description of the template parameter"
							},
							"example": null,
							"required": true,
							"suggested": false,
							"default": {
								"en": "example"
							},
							"deprecated": false,
							"aliases": [],
							"type": "unknown",
							"autovalue": null
						},
						"2d": {
							"label": null,
							"description": {
								"en": "Description of the template parameter"
							},
							"example": null,
							"required": true,
							"suggested": false,
							"default": {
								"en": "overridden"
							},
							"deprecated": false,
							"aliases": [],
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["1d", "2d"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'msg' => 'The inherits property copies over properties from another parameter '
					. '(preserving overides)'
			),
			array(
				'input' => '{
					"params": {},
					"sets": [
						{
							"label": "Example"
						}
					]
				}',
				'status' => 'Required property "sets.0.params" not found.'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
						}
					},
					"sets": [
						{
							"params": ["foo"]
						}
					]
				}',
				'status' => 'Required property "sets.0.label" not found.'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
						},
						"bar": {
						}
					},
					"sets": [
						{
							"label": "Foo with Quux",
							"params": ["foo", "quux"]
						}
					]
				}',
				'status' => 'Invalid value for property "sets.0.params[1]".'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
						},
						"bar": {
						},
						"quux": {
						}
					},
					"sets": [
						{
							"label": "Foo with Quux",
							"params": ["foo", "quux"]
						},
						{
							"label": "Bar with Quux",
							"params": ["bar", "quux"]
						}
					]
				}',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": null,
							"required": false,
							"example": null,
							"suggested": false,
							"description": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						},
						"bar": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						},
						"quux": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["foo", "bar", "quux"],
					"sets": [
						{
							"label": {
								"en": "Foo with Quux"
							},
							"params": ["foo", "quux"]
						},
						{
							"label": {
								"en": "Bar with Quux"
							},
							"params": ["bar", "quux"]
						}
					],
					"format": null,
					"maps": {}
				}',
				'status' => true
			),
			array(
				'input' => '{
					"description": "Testing some template description.",
					"params": {
						"bar": {
							"label": "Bar label",
							"description": "Bar description",
							"default": "Baz",
							"example": "Foo bar baz",
							"autovalue": "{{SomeTemplate}}",
							"required": true,
							"suggested": false,
							"deprecated": false,
							"aliases": [ "foo", "baz" ],
							"type": "line"
						}
					}
				}
				',
				'output' => '{
					"description": {
						"en": "Testing some template description."
					},
					"params": {
						"bar": {
							"label": {
								"en": "Bar label"
							},
							"description": {
								"en": "Bar description"
							},
							"default": {
								"en": "Baz"
							},
							"example": {
								"en": "Foo bar baz"
							},
							"autovalue": "{{SomeTemplate}}",
							"required": true,
							"suggested": false,
							"deprecated": false,
							"aliases": [ "foo", "baz" ],
							"type": "line"
						}
					},
					"paramOrder": ["bar"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'msg' => 'Parameter attributes preserve information.'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
						},
						"bar": {
						}
					},
					"sets": [],
					"maps": {
						"application": {
							"things": [
								"foo",
								["bar", "quux"]
							]
						}
					}
				}',
				'status' => 'Invalid parameter "quux" for property "maps.application.things".'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
						},
						"bar": {
						}
					},
					"sets": [],
					"maps": {
						"application": {
							"things": {
								"appbar": "bar",
								"appfoo": "foo"
							}
						}
					}
				}',
				'status' => 'Property "maps.application.things" is expected to be of type "string|array".'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
						},
						"bar": {
						}
					},
					"sets": [],
					"maps": {
						"application": {
							"things": [
								[ true ]
							]
						}
					}
				}',
				'status' => 'Property "maps.application.things[0][0]" is expected to be of type "string".'
			),
			array(
				'input' => '{
					"params": {
						"foo": {}
					},
					"format": "meshuggah format"
				}',
				'status' => 'Property "format" is expected to be "inline" or "block".'
			),
			array(
				// Should be long enough to trigger this condition after gzipping.
				'input' => '{
					"description": "' . self::generatePseudorandomString( 100000, 42 ) . '",
					"params": {}
				}',
				'status' => 'Data too large to save (75,226 bytes, limit is 65,535)'
			),
		);
		$calls = array();
		foreach ( $cases as $case ) {
			$calls[] = array( $case );
		}
		return $calls;
	}

	protected static function getStatusText( Status $status ) {
		$str = $status->getHtml();
		// Based on wfMessage()->parse
		$m = array();
		if ( preg_match( '/^<p>(.*)\n?<\/p>\n?$/sU', $str, $m ) ) {
			// Unescape char references for things like "[, "]" and "|" for
			// cleaner test assertions and output
			$str = Sanitizer::decodeCharReferences( $m[1] );
		}
		return $str;
	}

	private static function ksort( Array &$input ) {
		ksort( $input );
		foreach ( $input as $key => &$value ) {
			if ( is_array( $value ) ) {
				self::ksort( $value );
			}
		}
	}

	/**
	 * PHPUnit'a assertEquals does weak comparison, use strict instead.
	 *
	 * There is a built-in assertSame, but that only strictly compares
	 * the top level structure, not the invidual array values.
	 *
	 * so "array( 'a' => '' )" still equals "array( 'a' => null )"
	 * because empty string equals null in PHP's weak comparison.
	 *
	 * @param mixed $expected
	 * @param mixed $actual
	 */
	protected function assertStrictJsonEquals( $expected, $actual, $message = null ) {
		// Lazy recursive strict comparison: Serialise to JSON and compare that
		// Sort first to ensure key-order
		$expected = json_decode( $expected, /* assoc = */ true );
		$actual = json_decode( $actual, /* assoc = */ true );
		self::ksort( $expected );
		self::ksort( $actual );

		$this->assertEquals(
			FormatJson::encode( $expected, true ),
			FormatJson::encode( $actual, true ),
			$message
		);
	}

	protected function assertTemplateData( Array $case ) {
		// Expand defaults
		if ( !isset( $case['status'] ) ) {
			$case['status'] = true;
		}
		if ( !isset( $case['msg'] ) ) {
			$case['msg'] = is_string( $case['status'] ) ? $case['status'] : 'TemplateData assertion';
		}
		if ( !isset( $case['output'] ) ) {
			if ( is_string( $case['status'] ) ) {
				$case['output'] = '{
					"description": null,
					"params": {},
					"sets": [],
					"maps": {},
					"format": null,
					"paramOrder": []
				}';
			} else {
				$case['output'] = $case['input'];
			}
		}

		$t = TemplateDataBlob::newFromJSON( $case['input'] );
		$actual = $t->getJSON();
		$status = $t->getStatus();
		if ( !$status->isGood() ) {
			$this->assertEquals(
				$case['status'],
				self::getStatusText( $status ),
				'Status: ' . $case['msg']
			);
		} else {
			$this->assertEquals(
				$case['status'],
				$status->isGood(),
				'Status: ' . $case['msg']
			);
		}

		$this->assertStrictJsonEquals(
			$case['output'],
			$actual,
			$case['msg']
		);

		// Assert this case roundtrips properly by running through the output as input.

		$t = TemplateDataBlob::newFromJSON( $case['output'] );

		$status = $t->getStatus();
		if ( !$status->isGood() ) {
			$this->assertEquals(
				$case['status'],
				self::getStatusText( $status ),
				'Roundtrip status: ' . $case['msg']
			);
		}

		$this->assertStrictJsonEquals(
			$case['output'],
			$t->getJSON(),
			'Roundtrip: ' . $case['msg']
		);

	}

	/**
	 * @dataProvider provideParse
	 */
	public function testParse( Array $case ) {
		$this->assertTemplateData( $case );
	}

	/**
	 * Verify we can gzdecode() which came in PHP 5.4.0. Mediawiki needs a
	 * fallback function for it.
	 * If this test fail, we are most probably attempting to use gzdecode()
	 * with PHP before 5.4.
	 *
	 * @see bug 54058
	 */
	public function testGetJsonForDatabase() {
		// Compress JSON to trigger the code pass in newFromDatabase that ends
		// up calling gzdecode().
		$gzJson = gzencode( '{}' );
		$templateData = TemplateDataBlob::newFromDatabase( $gzJson );
		$this->assertInstanceOf( 'TemplateDataBlob', $templateData );
	}

	public static function provideGetDataInLanguage() {
		$cases = array(
			array(
				'input' => '{
					"description": {
						"de": "German",
						"nl": "Dutch",
						"en": "English",
						"de-formal": "German (formal address)"
					},
					"params": {}
				}
				',
				'output' => '{
					"description": "German",
					"params": {},
					"paramOrder": [],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'de',
				'msg' => 'Simple description'
			),
			array(
				'input' => '{
					"description": "Hi",
					"params": {}
				}
				',
				'output' => '{
					"description": "Hi",
					"paramOrder": [],
					"params": {},
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Non multi-language value returned as is (expands to { "en": value } for' .
					' content-lang, "fr" falls back to "en")'
			),
			array(
				'input' => '{
					"description": {
						"nl": "Dutch",
						"de": "German"
					},
					"params": {}
				}
				',
				'output' => '{
					"description": "Dutch",
					"params": {},
					"paramOrder": [],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Try content language before giving up on user language and fallbacks'
			),
			array(
				'input' => '{
					"description": {
						"es": "Spanish",
						"de": "German"
					},
					"params": {}
				}
				',
				'output' => '{
					"description": null,
					"params": {},
					"paramOrder": [],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Description is optional, use null if no suitable fallback'
			),
			array(
				'input' => '{
					"description": {
						"de": "German",
						"nl": "Dutch",
						"en": "English"
					},
					"params": {}
				}
				',
				'output' => '{
					"description": "German",
					"params": {},
					"paramOrder": [],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'de-formal',
				'msg' => '"de-formal" falls back to "de"'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
							"label": {
								"fr": "French",
								"en": "English"
							}
						}
					}
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": "French",
							"required": false,
							"example": null,
							"suggested": false,
							"description": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["foo"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Simple parameter label'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
							"default": {
								"fr": "French",
								"en": "English"
							}
						}
					}
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"default": "French",
							"required": false,
							"suggested": false,
							"description": null,
							"deprecated": false,
							"aliases": [],
							"label": null,
							"type": "unknown",
							"autovalue": null,
							"example": null
						}
					},
					"paramOrder": ["foo"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Simple parameter default value'
			),
			array(
				'input' => '{
					"params": {
						"foo": {
							"label": {
								"es": "Spanish",
								"de": "German"
							}
						}
					}
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["foo"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Parameter label is optional, use null if no matching fallback'
			),
			array(
				'input' => '{
					"params": {
						"foo": {}
					},
					"sets": [
						{
							"label": {
								"es": "Spanish",
								"de": "German"
							},
							"params": ["foo"]
						}
					]
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["foo"],
					"sets": [
						{
							"label": "Spanish",
							"params": ["foo"]
						}
					],
					"format": null,
					"maps": {}
				}
				',
				'lang' => 'fr',
				'msg' => 'Set label is not optional, choose first available key as final fallback'
			),
		);
		$calls = array();
		foreach ( $cases as $case ) {
			$calls[] = array( $case );
		}
		return $calls;
	}

	/**
	 * @dataProvider provideGetDataInLanguage
	 */
	public function testGetDataInLanguage( Array $case ) {

		// Change content-language to be non-English so we can distinguish between the
		// last 'en' fallback and the content language in our tests
		$this->setMwGlobals( array(
			'wgLanguageCode' => 'nl',
			'wgContLang' => Language::factory( 'nl' ),
		) );

		if ( !isset( $case['msg'] ) ) {
			$case['msg'] = is_string( $case['status'] ) ? $case['status'] : 'TemplateData assertion';
		}

		$t = TemplateDataBlob::newFromJSON( $case['input'] );
		$status = $t->getStatus();

		$this->assertTrue(
			$status->isGood() ?: self::getStatusText( $status ),
			'Status is good: ' . $case['msg']
		);

		$actual = $t->getDataInLanguage( $case['lang'] );
		$this->assertJsonStringEqualsJsonString(
			$case['output'],
			json_encode( $actual ),
			$case['msg']
		);
	}

	public static function provideParamOrder() {
		$cases = array(
			array(
				'input' => '{
					"params": {
						"foo": {},
						"bar": {},
						"baz": {}
					}
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						},
						"bar": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						},
						"baz": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["foo", "bar", "baz"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'msg' => 'Normalisation adds paramOrder'
			),
			array(
				'input' => '{
					"params": {
						"foo": {},
						"bar": {},
						"baz": {}
					},
					"paramOrder": ["baz", "foo", "bar"]
				}
				',
				'output' => '{
					"description": null,
					"params": {
						"foo": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						},
						"bar": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						},
						"baz": {
							"label": null,
							"required": false,
							"suggested": false,
							"description": null,
							"example": null,
							"deprecated": false,
							"aliases": [],
							"default": null,
							"type": "unknown",
							"autovalue": null
						}
					},
					"paramOrder": ["baz", "foo", "bar"],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'msg' => 'Custom paramOrder'
			),
			array(
				'input' => '{
					"params": {
						"foo": {},
						"bar": {},
						"baz": {}
					},
					"paramOrder": ["foo", "bar"]
				}
				',
				'status' => 'Required property "paramOrder[2]" not found.',
				'msg' => 'Incomplete paramOrder'
			),
			array(
				'input' => '{
					"params": {}
				}
				',
				'output' => '{
					"description": null,
					"params": {},
					"paramOrder": [],
					"sets": [],
					"format": null,
					"maps" : {}
				}
				',
				'msg' => 'Empty parameter object produces empty array paramOrder'
			),
			array(
				'input' => '{
					"params": {
						"foo": {},
						"bar": {},
						"baz": {}
					},
					"paramOrder": ["foo", "bar", "baz", "quux"]
				}
				',
				'status' => 'Invalid value for property "paramOrder[3]".',
				'msg' => 'Unknown params in paramOrder'
			),
			array(
				'input' => '{
					"params": {
						"foo": {},
						"bar": {},
						"baz": {}
					},
					"paramOrder": ["foo", "bar", "baz", "bar"]
				}
				',
				'status' => 'Property "paramOrder[3]" ("bar") is a duplicate of ' .
					'"paramOrder[1]".',
				'msg' => 'Duplicate params in paramOrder'
			),
		);
		$calls = array();
		foreach ( $cases as $case ) {
			$calls[] = array( $case );
		}
		return $calls;
	}

	/**
	 * @dataProvider provideParamOrder
	 */
	public function testParamOrder( Array $case ) {
		$this->assertTemplateData( $case );
	}
}

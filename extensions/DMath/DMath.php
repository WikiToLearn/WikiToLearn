<?php

if (!defined('MEDIAWIKI')){
	die();
}

$wgHooks['ParserFirstCallInit'][] = 'DmathParse::onParserSetup';


class DmathParse {
	
	function onParserSetup(Parser $parser)
	{
		$parser->setHook('dmath', 'DmathParse::dmathTagHook' );
	}
	
	function dmathTagHook( $content, $attributes, $parser ) {
		$attributes['display'] = 'block';
		if ( array_key_exists( 'type', $attributes ) ) {
			$tag = $attributes['type'];
			$content = ' \\begin{'.$tag.'} '.$content.'\\end{'.$tag.'}';
		}
		return MathHooks::mathTagHook($content, $attributes, $parser);
	}

	
}

?>
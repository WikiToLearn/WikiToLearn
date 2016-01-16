<?php

if (!defined('MEDIAWIKI')){
    die();
}

class DMathParse {
    
    function onParserFirstCallSetup(Parser $parser) {
        $parser->setHook('dmath', 'DMathParse::dmathTagHook' );
        
    }
    
    function dmathTagHook( $content, $attributes, $parser, $dad ) {
        
        $attributes['display'] = 'block';
        if ( array_key_exists( 'type', $attributes ) ) {
            $tag = $attributes['type'];
            $content = ' \\begin{'.$tag.'} '.$content.'\\end{'.$tag.'}';
        }
        return MathHooks::mathTagHook($content, $attributes, $parser);
    }
}

?>
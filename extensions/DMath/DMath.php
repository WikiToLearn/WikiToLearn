<?php

if (!defined('MEDIAWIKI')){
    die();
}

if(function_exists('wfLoadExtension')) {
    wfLoadExtension('DMath');
    
    wfWarn( "Deprecated entry point to DMath. Please use wfLoadExtension('DMath').");
    
}
else
{
    die("MediaWiki version 1.25+ is required to use the DMath extension");
}

?>
<?php

// This files is only needed to import the schema of the shared database,
// overriding the normal config
require_once("LocalSettings.php");
$wgDBname = "sharedwikitolearn";

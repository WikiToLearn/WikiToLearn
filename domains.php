<?php
$wiki_allow_domains = array(
    "wikitolearn.org",
    getenv('WTL_DOMAIN_NAME')
);

$wiki_hostname = strtolower(isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : getenv('WIKI'));
$wiki = substr($wiki_hostname, 0, strpos($wiki_hostname, "."));
$wiki_domain = substr($wiki_hostname, strlen($wiki) + 1);

if(in_array($wiki_hostname,$wiki_allow_domains)) {
 $wiki_domain = $wiki_hostname;
}

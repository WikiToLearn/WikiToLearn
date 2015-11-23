<?php
$wiki_allow_domains = array(
    "wikitolearn.org",
    "dev.wikitolearn.org",
    "pre.wikitolearn.org",
    "local.wikitolearn.org",
    "direct.wikitolearn.org",
    "tuttorotto.eu",
    "tuttorotto.org",
    "tuttorotto.biz"
);

$wiki_hostname = strtolower(isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : getenv('WIKI'));
$wiki = substr($wiki_hostname, 0, strpos($wiki_hostname, "."));
$wiki_domain = substr($wiki_hostname, strlen($wiki) + 1);


# MediaWiki coding conventions

## Abstract

This project implements a set of rules for use with [PHP CodeSniffer]

See [MediaWiki conventions] on our wiki :-)

## How to install

1. Install PHP Code Sniffer:

```
pear install PHP_CodeSniffer
```

2. Clone this repository in /some/path

```
git clone ... </some/path>
```

3. Set up an alias to load the new standard

```
alias phpcsmw='phpcs --standard=</some/path>/MediaWiki'
```

You might want to add the alias in your shell startup file (ex: ~/.bashrc).

4. Run

```
$ cd /path/to/mediawiki-core
$ phpcsmw includes/Title.php
<warnings and errors are shown>
$
```

Fix & commit


## TODO

* Actually implements the various conventions
* Migrate the old code-utils/check-vars.php

[PHP CodeSniffer]: https://pear.php.net/package/PHP_CodeSniffer
[MediaWiki conventions]: http://www.mediawiki.org/wiki/Manual:Coding_conventions

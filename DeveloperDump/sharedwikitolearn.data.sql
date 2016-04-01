-- MySQL dump 10.13  Distrib 5.6.29, for Linux (x86_64)
--
-- Host: localhost    Database: sharedwikitolearn
-- ------------------------------------------------------
-- Server version	5.6.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `interwiki`
--

LOCK TABLES `interwiki` WRITE;
/*!40000 ALTER TABLE `interwiki` DISABLE KEYS */;
INSERT INTO `interwiki` VALUES ('acronym','http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=$1',0,0,'',''),('advogato','http://www.advogato.org/$1',0,0,'',''),('annotationwiki','http://www.seedwiki.com/page.cfm?wikiid=368&doc=$1',0,0,'',''),('arxiv','http://www.arxiv.org/abs/$1',0,0,'',''),('c2find','http://c2.com/cgi/wiki?FindPage&value=$1',0,0,'',''),('cache','http://www.google.com/search?q=cache:$1',0,0,'',''),('commons','http://commons.wikimedia.org/wiki/$1',0,0,'',''),('corpknowpedia','http://corpknowpedia.org/wiki/index.php/$1',0,0,'',''),('dictionary','http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1',0,0,'',''),('disinfopedia','http://www.disinfopedia.org/wiki.phtml?title=$1',0,0,'',''),('docbook','http://wiki.docbook.org/topic/$1',0,0,'',''),('doi','http://dx.doi.org/$1',0,0,'',''),('drumcorpswiki','http://www.drumcorpswiki.com/index.php/$1',0,0,'',''),('dwjwiki','http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1',0,0,'',''),('elibre','http://enciclopedia.us.es/index.php/$1',0,0,'',''),('emacswiki','http://www.emacswiki.org/cgi-bin/wiki.pl?$1',0,0,'',''),('en','//en.wikitolearn.org/$1',1,1,'',''),('foldoc','http://foldoc.org/?$1',0,0,'',''),('foxwiki','http://fox.wikis.com/wc.dll?Wiki~$1',0,0,'',''),('freebsdman','http://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1',0,0,'',''),('gej','http://www.esperanto.de/cgi-bin/aktivikio/wiki.pl?$1',0,0,'',''),('gentoo-wiki','http://gentoo-wiki.com/$1',0,0,'',''),('google','http://www.google.com/search?q=$1',0,0,'',''),('googlegroups','http://groups.google.com/groups?q=$1',0,0,'',''),('hammondwiki','http://www.dairiki.org/HammondWiki/$1',0,0,'',''),('hewikisource','http://he.wikisource.org/wiki/$1',1,0,'',''),('hrwiki','http://www.hrwiki.org/index.php/$1',0,0,'',''),('imdb','http://us.imdb.com/Title?$1',0,0,'',''),('itwiki','//it.wikitolearn.org/$1',1,1,'',''),('jargonfile','http://sunir.org/apps/meta.pl?wiki=JargonFile&redirect=$1',0,0,'',''),('jspwiki','http://www.jspwiki.org/wiki/$1',0,0,'',''),('keiki','http://kei.ki/en/$1',0,0,'',''),('kmwiki','http://kmwiki.wikispaces.com/$1',0,0,'',''),('linuxwiki','http://linuxwiki.de/$1',0,0,'',''),('lojban','http://www.lojban.org/tiki/tiki-index.php?page=$1',0,0,'',''),('lqwiki','http://wiki.linuxquestions.org/wiki/$1',0,0,'',''),('lugkr','http://lug-kr.sourceforge.net/cgi-bin/lugwiki.pl?$1',0,0,'',''),('mathsongswiki','http://SeedWiki.com/page.cfm?wikiid=237&doc=$1',0,0,'',''),('meatball','http://www.usemod.com/cgi-bin/mb.pl?$1',0,0,'',''),('mediawikiwiki','http://www.mediawiki.org/wiki/$1',0,0,'',''),('mediazilla','https://bugzilla.wikimedia.org/$1',1,0,'',''),('memoryalpha','http://www.memory-alpha.org/en/index.php/$1',0,0,'',''),('metawiki','http://sunir.org/apps/meta.pl?$1',0,0,'',''),('metawikimedia','http://meta.wikimedia.org/wiki/$1',0,0,'',''),('moinmoin','http://purl.net/wiki/moin/$1',0,0,'',''),('mozillawiki','http://wiki.mozilla.org/index.php/$1',0,0,'',''),('mw','http://www.mediawiki.org/wiki/$1',0,0,'',''),('oeis','http://www.research.att.com/cgi-bin/access.cgi/as/njas/sequences/eisA.cgi?Anum=$1',0,0,'',''),('openfacts','http://openfacts.berlios.de/index.phtml?title=$1',0,0,'',''),('openwiki','http://openwiki.com/?$1',0,0,'',''),('patwiki','http://gauss.ffii.org/$1',0,0,'',''),('pmeg','http://www.bertilow.com/pmeg/$1.php',0,0,'',''),('ppr','http://c2.com/cgi/wiki?$1',0,0,'',''),('pythoninfo','http://wiki.python.org/moin/$1',0,0,'',''),('rfc','http://www.rfc-editor.org/rfc/rfc$1.txt',0,0,'',''),('s23wiki','http://is-root.de/wiki/index.php/$1',0,0,'',''),('seattlewiki','http://seattle.wikia.com/wiki/$1',0,0,'',''),('seattlewireless','http://seattlewireless.net/?$1',0,0,'',''),('senseislibrary','http://senseis.xmp.net/?$1',0,0,'',''),('slashdot','http://slashdot.org/article.pl?sid=$1',0,0,'',''),('sourceforge','http://sourceforge.net/$1',0,0,'',''),('squeak','http://wiki.squeak.org/squeak/$1',0,0,'',''),('susning','http://www.susning.nu/$1',0,0,'',''),('svgwiki','http://wiki.svg.org/$1',0,0,'',''),('tavi','http://tavi.sourceforge.net/$1',0,0,'',''),('tejo','http://www.tejo.org/vikio/$1',0,0,'',''),('theopedia','http://www.theopedia.com/$1',0,0,'',''),('tmbw','http://www.tmbw.net/wiki/$1',0,0,'',''),('tmnet','http://www.technomanifestos.net/?$1',0,0,'',''),('tmwiki','http://www.EasyTopicMaps.com/?page=$1',0,0,'',''),('twiki','http://twiki.org/cgi-bin/view/$1',0,0,'',''),('uea','http://www.tejo.org/uea/$1',0,0,'',''),('unreal','http://wiki.beyondunreal.com/wiki/$1',0,0,'',''),('usemod','http://www.usemod.com/cgi-bin/wiki.pl?$1',0,0,'',''),('vinismo','http://vinismo.com/en/$1',0,0,'',''),('webseitzwiki','http://webseitz.fluxent.com/wiki/$1',0,0,'',''),('why','http://clublet.com/c/c/why?$1',0,0,'',''),('wiki','http://c2.com/cgi/wiki?$1',0,0,'',''),('wikia','http://www.wikia.com/wiki/$1',0,0,'',''),('wikibooks','http://en.wikibooks.org/wiki/$1',1,0,'',''),('wikicities','http://www.wikia.com/wiki/$1',0,0,'',''),('wikif1','http://www.wikif1.org/$1',0,0,'',''),('wikihow','http://www.wikihow.com/$1',0,0,'',''),('wikimedia','http://wikimediafoundation.org/wiki/$1',0,0,'',''),('wikinews','http://en.wikinews.org/wiki/$1',1,0,'',''),('wikinfo','http://www.wikinfo.org/index.php/$1',0,0,'',''),('wikipedia','http://en.wikipedia.org/wiki/$1',1,0,'',''),('wikiquote','http://en.wikiquote.org/wiki/$1',1,0,'',''),('wikisource','http://wikisource.org/wiki/$1',1,0,'',''),('wikispecies','http://species.wikimedia.org/wiki/$1',1,0,'',''),('wikitravel','http://wikitravel.org/en/$1',0,0,'',''),('wikiversity','http://en.wikiversity.org/wiki/$1',1,0,'',''),('wikt','http://en.wiktionary.org/wiki/$1',1,0,'',''),('wiktionary','http://en.wiktionary.org/wiki/$1',1,0,'',''),('wlug','http://www.wlug.org.nz/$1',0,0,'',''),('zwiki','http://zwiki.org/$1',0,0,'',''),('zzz wiki','http://wiki.zzz.ee/index.php/$1',0,0,'','');
/*!40000 ALTER TABLE `interwiki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1837,'Flow talk page manager','','','',NULL,'','20160212111621','7fd25dc19efd062762ba42b80f17f45e',NULL,NULL,NULL,'20160212111616',72,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_properties`
--

LOCK TABLES `user_properties` WRITE;
/*!40000 ALTER TABLE `user_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_properties` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-27 12:43:20

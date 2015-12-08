-- MySQL dump 10.13  Distrib 5.6.27, for Linux (x86_64)
--
-- Host: localhost    Database: itwikitolearn
-- ------------------------------------------------------
-- Server version	5.6.27

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
-- Table structure for table `archive`
--

DROP TABLE IF EXISTS `archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive` (
  `ar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar_namespace` int(11) NOT NULL DEFAULT '0',
  `ar_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ar_text` mediumblob NOT NULL,
  `ar_comment` varbinary(767) NOT NULL,
  `ar_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ar_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `ar_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ar_minor_edit` tinyint(4) NOT NULL DEFAULT '0',
  `ar_flags` tinyblob NOT NULL,
  `ar_rev_id` int(10) unsigned DEFAULT NULL,
  `ar_text_id` int(10) unsigned DEFAULT NULL,
  `ar_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ar_len` int(10) unsigned DEFAULT NULL,
  `ar_page_id` int(10) unsigned DEFAULT NULL,
  `ar_parent_id` int(10) unsigned DEFAULT NULL,
  `ar_sha1` varbinary(32) NOT NULL DEFAULT '',
  `ar_content_model` varbinary(32) DEFAULT NULL,
  `ar_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`ar_id`),
  KEY `name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `ar_usertext_timestamp` (`ar_user_text`,`ar_timestamp`),
  KEY `ar_revid` (`ar_rev_id`),
  KEY `usertext_timestamp` (`ar_user_text`,`ar_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive`
--

LOCK TABLES `archive` WRITE;
/*!40000 ALTER TABLE `archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT '0',
  `cat_subcats` int(11) NOT NULL DEFAULT '0',
  `cat_files` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Pagine_che_richiamano_file_inesistenti',1,0,0),(2,'HSF',1,0,0);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorylinks`
--

DROP TABLE IF EXISTS `categorylinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorylinks` (
  `cl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `cl_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `cl_sortkey` varbinary(230) NOT NULL DEFAULT '',
  `cl_sortkey_prefix` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `cl_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cl_collation` varbinary(32) NOT NULL DEFAULT '',
  `cl_type` enum('page','subcat','file') NOT NULL DEFAULT 'page',
  UNIQUE KEY `cl_from` (`cl_from`,`cl_to`),
  KEY `cl_sortkey` (`cl_to`,`cl_type`,`cl_sortkey`,`cl_from`),
  KEY `cl_timestamp` (`cl_to`,`cl_timestamp`),
  KEY `cl_collation` (`cl_collation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorylinks`
--

LOCK TABLES `categorylinks` WRITE;
/*!40000 ALTER TABLE `categorylinks` DISABLE KEYS */;
INSERT INTO `categorylinks` VALUES (8,'Pagine_che_richiamano_file_inesistenti','WTL INTRO','','2015-12-08 22:32:39','uppercase','page'),(9,'HSF','HSF PAGE','','2015-12-08 22:32:39','uppercase','page');
/*!40000 ALTER TABLE `categorylinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_tag`
--

DROP TABLE IF EXISTS `change_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_tag` (
  `ct_rc_id` int(11) DEFAULT NULL,
  `ct_log_id` int(11) DEFAULT NULL,
  `ct_rev_id` int(11) DEFAULT NULL,
  `ct_tag` varchar(255) NOT NULL,
  `ct_params` blob,
  UNIQUE KEY `change_tag_rc_tag` (`ct_rc_id`,`ct_tag`),
  UNIQUE KEY `change_tag_log_tag` (`ct_log_id`,`ct_tag`),
  UNIQUE KEY `change_tag_rev_tag` (`ct_rev_id`,`ct_tag`),
  KEY `change_tag_tag_id` (`ct_tag`,`ct_rc_id`,`ct_rev_id`,`ct_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_tag`
--

LOCK TABLES `change_tag` WRITE;
/*!40000 ALTER TABLE `change_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `echo_email_batch`
--

DROP TABLE IF EXISTS `echo_email_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `echo_email_batch` (
  `eeb_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eeb_user_id` int(10) unsigned NOT NULL,
  `eeb_event_priority` tinyint(3) unsigned NOT NULL DEFAULT '10',
  `eeb_event_id` int(10) unsigned NOT NULL,
  `eeb_event_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`eeb_id`),
  UNIQUE KEY `echo_email_batch_user_event` (`eeb_user_id`,`eeb_event_id`),
  KEY `echo_email_batch_user_hash_priority` (`eeb_user_id`,`eeb_event_hash`,`eeb_event_priority`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `echo_email_batch`
--

LOCK TABLES `echo_email_batch` WRITE;
/*!40000 ALTER TABLE `echo_email_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `echo_email_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `echo_event`
--

DROP TABLE IF EXISTS `echo_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `echo_event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `event_variant` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `event_agent_id` int(10) unsigned DEFAULT NULL,
  `event_agent_ip` varchar(39) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `event_page_namespace` int(10) unsigned DEFAULT NULL,
  `event_page_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `event_extra` blob,
  `event_page_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `echo_event_type` (`event_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `echo_event`
--

LOCK TABLES `echo_event` WRITE;
/*!40000 ALTER TABLE `echo_event` DISABLE KEYS */;
INSERT INTO `echo_event` VALUES (1,'page-linked',NULL,NULL,'127.0.0.1',NULL,NULL,'a:3:{s:17:\"link-from-page-id\";i:2;s:10:\"page_title\";s:12:\"Dipartimenti\";s:14:\"page_namespace\";i:0;}',NULL),(2,'page-linked',NULL,NULL,'127.0.0.1',NULL,NULL,'a:3:{s:17:\"link-from-page-id\";i:2;s:10:\"page_title\";s:12:\"Come_aiutare\";s:14:\"page_namespace\";i:0;}',NULL),(3,'page-linked',NULL,NULL,'127.0.0.1',NULL,NULL,'a:3:{s:17:\"link-from-page-id\";i:2;s:10:\"page_title\";s:13:\"WikiFM_Thanks\";s:14:\"page_namespace\";i:0;}',NULL),(4,'page-linked',NULL,NULL,'127.0.0.1',NULL,NULL,'a:3:{s:17:\"link-from-page-id\";i:2;s:10:\"page_title\";s:13:\"WikiFM_Stats2\";s:14:\"page_namespace\";i:0;}',NULL),(5,'page-linked',NULL,NULL,'127.0.0.1',NULL,NULL,'a:3:{s:17:\"link-from-page-id\";i:6;s:10:\"page_title\";s:12:\"Hall_of_fame\";s:14:\"page_namespace\";i:0;}',NULL);
/*!40000 ALTER TABLE `echo_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `echo_notification`
--

DROP TABLE IF EXISTS `echo_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `echo_notification` (
  `notification_event` int(10) unsigned NOT NULL,
  `notification_user` int(10) unsigned NOT NULL,
  `notification_timestamp` binary(14) NOT NULL,
  `notification_read_timestamp` binary(14) DEFAULT NULL,
  `notification_bundle_base` tinyint(1) NOT NULL DEFAULT '1',
  `notification_bundle_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `notification_bundle_display_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  UNIQUE KEY `user_event` (`notification_user`,`notification_event`),
  KEY `echo_notification_user_base_read_timestamp` (`notification_user`,`notification_bundle_base`,`notification_read_timestamp`),
  KEY `echo_notification_user_base_timestamp` (`notification_user`,`notification_bundle_base`,`notification_timestamp`,`notification_event`),
  KEY `echo_notification_user_hash_timestamp` (`notification_user`,`notification_bundle_hash`,`notification_timestamp`),
  KEY `echo_notification_user_hash_base_timestamp` (`notification_user`,`notification_bundle_display_hash`,`notification_bundle_base`,`notification_timestamp`),
  KEY `echo_user_timestamp` (`notification_user`,`notification_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `echo_notification`
--

LOCK TABLES `echo_notification` WRITE;
/*!40000 ALTER TABLE `echo_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `echo_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `echo_target_page`
--

DROP TABLE IF EXISTS `echo_target_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `echo_target_page` (
  `etp_user` int(10) unsigned NOT NULL DEFAULT '0',
  `etp_page` int(10) unsigned NOT NULL DEFAULT '0',
  `etp_event` int(10) unsigned NOT NULL DEFAULT '0',
  `etp_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`etp_id`),
  KEY `echo_target_page_user_page_event` (`etp_user`,`etp_page`,`etp_event`),
  KEY `echo_target_page_user_event` (`etp_user`,`etp_event`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `echo_target_page`
--

LOCK TABLES `echo_target_page` WRITE;
/*!40000 ALTER TABLE `echo_target_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `echo_target_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externallinks`
--

DROP TABLE IF EXISTS `externallinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externallinks` (
  `el_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `el_from` int(10) unsigned NOT NULL DEFAULT '0',
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
  PRIMARY KEY (`el_id`),
  KEY `el_from` (`el_from`,`el_to`(40)),
  KEY `el_to` (`el_to`(60),`el_from`),
  KEY `el_index` (`el_index`(60))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `externallinks`
--

LOCK TABLES `externallinks` WRITE;
/*!40000 ALTER TABLE `externallinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `externallinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filearchive`
--

DROP TABLE IF EXISTS `filearchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `fa_archive_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted_reason` varbinary(767) DEFAULT '',
  `fa_size` int(10) unsigned DEFAULT '0',
  `fa_width` int(11) DEFAULT '0',
  `fa_height` int(11) DEFAULT '0',
  `fa_metadata` mediumblob,
  `fa_bits` int(11) DEFAULT '0',
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT NULL,
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description` varbinary(767) DEFAULT NULL,
  `fa_user` int(10) unsigned DEFAULT '0',
  `fa_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fa_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fa_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fa_id`),
  KEY `fa_name` (`fa_name`,`fa_timestamp`),
  KEY `fa_storage_group` (`fa_storage_group`,`fa_storage_key`),
  KEY `fa_deleted_timestamp` (`fa_deleted_timestamp`),
  KEY `fa_user_timestamp` (`fa_user_text`,`fa_timestamp`),
  KEY `fa_sha1` (`fa_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filearchive`
--

LOCK TABLES `filearchive` WRITE;
/*!40000 ALTER TABLE `filearchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `filearchive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedimages`
--

DROP TABLE IF EXISTS `flaggedimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedimages` (
  `fi_rev_id` int(10) unsigned NOT NULL,
  `fi_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `fi_img_timestamp` varbinary(14) DEFAULT NULL,
  `fi_img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fi_rev_id`,`fi_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedimages`
--

LOCK TABLES `flaggedimages` WRITE;
/*!40000 ALTER TABLE `flaggedimages` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedpage_config`
--

DROP TABLE IF EXISTS `flaggedpage_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedpage_config` (
  `fpc_page_id` int(10) unsigned NOT NULL,
  `fpc_select` int(11) NOT NULL,
  `fpc_override` tinyint(1) NOT NULL,
  `fpc_level` varbinary(60) DEFAULT NULL,
  `fpc_expiry` varbinary(14) NOT NULL DEFAULT 'infinity',
  PRIMARY KEY (`fpc_page_id`),
  KEY `fpc_expiry` (`fpc_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedpage_config`
--

LOCK TABLES `flaggedpage_config` WRITE;
/*!40000 ALTER TABLE `flaggedpage_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedpage_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedpage_pending`
--

DROP TABLE IF EXISTS `flaggedpage_pending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedpage_pending` (
  `fpp_page_id` int(10) unsigned NOT NULL,
  `fpp_quality` tinyint(1) NOT NULL,
  `fpp_rev_id` int(10) unsigned NOT NULL,
  `fpp_pending_since` varbinary(14) NOT NULL,
  PRIMARY KEY (`fpp_page_id`,`fpp_quality`),
  KEY `fpp_quality_pending` (`fpp_quality`,`fpp_pending_since`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedpage_pending`
--

LOCK TABLES `flaggedpage_pending` WRITE;
/*!40000 ALTER TABLE `flaggedpage_pending` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedpage_pending` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedpages`
--

DROP TABLE IF EXISTS `flaggedpages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedpages` (
  `fp_page_id` int(10) unsigned NOT NULL,
  `fp_reviewed` tinyint(1) NOT NULL DEFAULT '0',
  `fp_pending_since` varbinary(14) DEFAULT NULL,
  `fp_stable` int(10) unsigned NOT NULL,
  `fp_quality` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`fp_page_id`),
  KEY `fp_reviewed_page` (`fp_reviewed`,`fp_page_id`),
  KEY `fp_quality_page` (`fp_quality`,`fp_page_id`),
  KEY `fp_pending_since` (`fp_pending_since`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedpages`
--

LOCK TABLES `flaggedpages` WRITE;
/*!40000 ALTER TABLE `flaggedpages` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedpages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedrevs`
--

DROP TABLE IF EXISTS `flaggedrevs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedrevs` (
  `fr_rev_id` int(10) unsigned NOT NULL,
  `fr_rev_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `fr_page_id` int(10) unsigned NOT NULL,
  `fr_user` int(10) unsigned NOT NULL,
  `fr_timestamp` varbinary(14) NOT NULL,
  `fr_quality` tinyint(1) NOT NULL DEFAULT '0',
  `fr_tags` mediumblob NOT NULL,
  `fr_flags` tinyblob NOT NULL,
  `fr_img_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fr_img_timestamp` varbinary(14) DEFAULT NULL,
  `fr_img_sha1` varbinary(32) DEFAULT NULL,
  PRIMARY KEY (`fr_rev_id`),
  KEY `page_rev` (`fr_page_id`,`fr_rev_id`),
  KEY `page_time` (`fr_page_id`,`fr_rev_timestamp`),
  KEY `page_qal_rev` (`fr_page_id`,`fr_quality`,`fr_rev_id`),
  KEY `page_qal_time` (`fr_page_id`,`fr_quality`,`fr_rev_timestamp`),
  KEY `fr_img_sha1` (`fr_img_sha1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedrevs`
--

LOCK TABLES `flaggedrevs` WRITE;
/*!40000 ALTER TABLE `flaggedrevs` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedrevs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedrevs_promote`
--

DROP TABLE IF EXISTS `flaggedrevs_promote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedrevs_promote` (
  `frp_user_id` int(10) unsigned NOT NULL,
  `frp_user_params` mediumblob NOT NULL,
  PRIMARY KEY (`frp_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedrevs_promote`
--

LOCK TABLES `flaggedrevs_promote` WRITE;
/*!40000 ALTER TABLE `flaggedrevs_promote` DISABLE KEYS */;
INSERT INTO `flaggedrevs_promote` VALUES (6,'uniqueContentPages=1\ntotalContentEdits=2\neditComments=2\nrevertedEdits=0');
/*!40000 ALTER TABLE `flaggedrevs_promote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedrevs_statistics`
--

DROP TABLE IF EXISTS `flaggedrevs_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedrevs_statistics` (
  `frs_timestamp` varbinary(14) NOT NULL,
  `frs_stat_key` varchar(255) NOT NULL,
  `frs_stat_val` bigint(20) NOT NULL,
  PRIMARY KEY (`frs_stat_key`,`frs_timestamp`),
  KEY `frs_timestamp` (`frs_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedrevs_statistics`
--

LOCK TABLES `flaggedrevs_statistics` WRITE;
/*!40000 ALTER TABLE `flaggedrevs_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedrevs_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedrevs_tracking`
--

DROP TABLE IF EXISTS `flaggedrevs_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedrevs_tracking` (
  `ftr_from` int(10) unsigned NOT NULL DEFAULT '0',
  `ftr_namespace` int(11) NOT NULL DEFAULT '0',
  `ftr_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  UNIQUE KEY `from_namespace_title` (`ftr_from`,`ftr_namespace`,`ftr_title`),
  KEY `namespace_title_from` (`ftr_namespace`,`ftr_title`,`ftr_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedrevs_tracking`
--

LOCK TABLES `flaggedrevs_tracking` WRITE;
/*!40000 ALTER TABLE `flaggedrevs_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedrevs_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flaggedtemplates`
--

DROP TABLE IF EXISTS `flaggedtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flaggedtemplates` (
  `ft_rev_id` int(10) unsigned NOT NULL,
  `ft_namespace` int(11) NOT NULL DEFAULT '0',
  `ft_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ft_tmp_rev_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ft_rev_id`,`ft_namespace`,`ft_title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flaggedtemplates`
--

LOCK TABLES `flaggedtemplates` WRITE;
/*!40000 ALTER TABLE `flaggedtemplates` DISABLE KEYS */;
/*!40000 ALTER TABLE `flaggedtemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_ext_ref`
--

DROP TABLE IF EXISTS `flow_ext_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_ext_ref` (
  `ref_src_object_id` binary(11) NOT NULL,
  `ref_src_object_type` varbinary(32) NOT NULL,
  `ref_src_workflow_id` binary(11) NOT NULL,
  `ref_src_namespace` int(11) NOT NULL,
  `ref_src_title` varbinary(255) NOT NULL,
  `ref_target` varbinary(255) NOT NULL,
  `ref_type` varbinary(16) NOT NULL,
  UNIQUE KEY `flow_ext_ref_idx` (`ref_src_namespace`,`ref_src_title`,`ref_type`,`ref_target`,`ref_src_object_type`,`ref_src_object_id`),
  UNIQUE KEY `flow_ext_ref_revision` (`ref_src_namespace`,`ref_src_title`,`ref_src_object_type`,`ref_src_object_id`,`ref_type`,`ref_target`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_ext_ref`
--

LOCK TABLES `flow_ext_ref` WRITE;
/*!40000 ALTER TABLE `flow_ext_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_ext_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_revision`
--

DROP TABLE IF EXISTS `flow_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_revision` (
  `rev_id` binary(11) NOT NULL,
  `rev_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `rev_type_id` binary(11) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0',
  `rev_user_id` bigint(20) unsigned NOT NULL,
  `rev_user_ip` varbinary(39) DEFAULT NULL,
  `rev_user_wiki` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `rev_parent_id` binary(11) DEFAULT NULL,
  `rev_flags` tinyblob NOT NULL,
  `rev_content` mediumblob NOT NULL,
  `rev_change_type` varbinary(255) DEFAULT NULL,
  `rev_mod_state` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `rev_mod_user_id` bigint(20) unsigned DEFAULT NULL,
  `rev_mod_user_ip` varbinary(39) DEFAULT NULL,
  `rev_mod_user_wiki` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `rev_mod_timestamp` varchar(14) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `rev_mod_reason` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `rev_last_edit_id` binary(11) DEFAULT NULL,
  `rev_edit_user_id` bigint(20) unsigned DEFAULT NULL,
  `rev_edit_user_ip` varbinary(39) DEFAULT NULL,
  `rev_edit_user_wiki` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `rev_content_length` int(11) NOT NULL DEFAULT '0',
  `rev_previous_content_length` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rev_id`),
  UNIQUE KEY `flow_revision_unique_parent` (`rev_parent_id`),
  KEY `flow_revision_type_id` (`rev_type`,`rev_type_id`),
  KEY `flow_revision_user` (`rev_user_id`,`rev_user_ip`,`rev_user_wiki`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_revision`
--

LOCK TABLES `flow_revision` WRITE;
/*!40000 ALTER TABLE `flow_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_subscription`
--

DROP TABLE IF EXISTS `flow_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_subscription` (
  `subscription_workflow_id` int(10) unsigned NOT NULL,
  `subscription_user_id` bigint(20) unsigned NOT NULL,
  `subscription_user_wiki` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `subscription_create_timestamp` varchar(14) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `subscription_last_updated` varchar(14) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  UNIQUE KEY `flow_subscription_unique_user_workflow` (`subscription_workflow_id`,`subscription_user_id`,`subscription_user_wiki`),
  KEY `flow_subscription_lookup` (`subscription_user_id`,`subscription_user_wiki`,`subscription_last_updated`,`subscription_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_subscription`
--

LOCK TABLES `flow_subscription` WRITE;
/*!40000 ALTER TABLE `flow_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_topic_list`
--

DROP TABLE IF EXISTS `flow_topic_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_topic_list` (
  `topic_list_id` binary(11) NOT NULL,
  `topic_id` binary(11) DEFAULT NULL,
  UNIQUE KEY `flow_topic_list_pk` (`topic_list_id`,`topic_id`),
  KEY `flow_topic_list_topic_id` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_topic_list`
--

LOCK TABLES `flow_topic_list` WRITE;
/*!40000 ALTER TABLE `flow_topic_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_topic_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_tree_node`
--

DROP TABLE IF EXISTS `flow_tree_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_tree_node` (
  `tree_ancestor_id` binary(11) NOT NULL,
  `tree_descendant_id` binary(11) NOT NULL,
  `tree_depth` smallint(6) NOT NULL,
  UNIQUE KEY `flow_tree_node_pk` (`tree_ancestor_id`,`tree_descendant_id`),
  UNIQUE KEY `flow_tree_constraint` (`tree_descendant_id`,`tree_depth`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_tree_node`
--

LOCK TABLES `flow_tree_node` WRITE;
/*!40000 ALTER TABLE `flow_tree_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_tree_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_tree_revision`
--

DROP TABLE IF EXISTS `flow_tree_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_tree_revision` (
  `tree_rev_descendant_id` binary(11) NOT NULL,
  `tree_rev_id` binary(11) NOT NULL,
  `tree_orig_user_id` bigint(20) unsigned NOT NULL,
  `tree_orig_user_ip` varbinary(39) DEFAULT NULL,
  `tree_orig_user_wiki` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `tree_parent_id` binary(11) DEFAULT NULL,
  PRIMARY KEY (`tree_rev_id`),
  KEY `flow_tree_descendant_rev_id` (`tree_rev_descendant_id`,`tree_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_tree_revision`
--

LOCK TABLES `flow_tree_revision` WRITE;
/*!40000 ALTER TABLE `flow_tree_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_tree_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_wiki_ref`
--

DROP TABLE IF EXISTS `flow_wiki_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_wiki_ref` (
  `ref_src_object_id` binary(11) NOT NULL,
  `ref_src_object_type` varbinary(32) NOT NULL,
  `ref_src_workflow_id` binary(11) NOT NULL,
  `ref_src_namespace` int(11) NOT NULL,
  `ref_src_title` varbinary(255) NOT NULL,
  `ref_target_namespace` int(11) NOT NULL,
  `ref_target_title` varbinary(255) NOT NULL,
  `ref_type` varbinary(16) NOT NULL,
  KEY `flow_wiki_ref_idx` (`ref_src_namespace`,`ref_src_title`,`ref_type`,`ref_target_namespace`,`ref_target_title`,`ref_src_object_type`,`ref_src_object_id`),
  KEY `flow_wiki_ref_revision` (`ref_src_namespace`,`ref_src_title`,`ref_src_object_type`,`ref_src_object_id`,`ref_type`,`ref_target_namespace`,`ref_target_title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_wiki_ref`
--

LOCK TABLES `flow_wiki_ref` WRITE;
/*!40000 ALTER TABLE `flow_wiki_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_wiki_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_workflow`
--

DROP TABLE IF EXISTS `flow_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_workflow` (
  `workflow_id` binary(11) NOT NULL,
  `workflow_wiki` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `workflow_namespace` int(11) NOT NULL,
  `workflow_page_id` int(10) unsigned NOT NULL,
  `workflow_title_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `workflow_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `workflow_last_update_timestamp` binary(14) NOT NULL,
  `workflow_lock_state` int(10) unsigned NOT NULL,
  `workflow_type` varbinary(16) NOT NULL,
  PRIMARY KEY (`workflow_id`),
  KEY `flow_workflow_lookup` (`workflow_wiki`,`workflow_namespace`,`workflow_title_text`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_workflow`
--

LOCK TABLES `flow_workflow` WRITE;
/*!40000 ALTER TABLE `flow_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historical_thread`
--

DROP TABLE IF EXISTS `historical_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historical_thread` (
  `hthread_id` int(8) unsigned NOT NULL,
  `hthread_revision` int(8) unsigned NOT NULL,
  `hthread_contents` blob NOT NULL,
  `hthread_change_type` int(4) unsigned NOT NULL,
  `hthread_change_object` int(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`hthread_id`,`hthread_revision`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historical_thread`
--

LOCK TABLES `historical_thread` WRITE;
/*!40000 ALTER TABLE `historical_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `historical_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hitcounter`
--

DROP TABLE IF EXISTS `hitcounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hitcounter` (
  `hc_id` int(10) unsigned NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1 MAX_ROWS=25000;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hitcounter`
--

LOCK TABLES `hitcounter` WRITE;
/*!40000 ALTER TABLE `hitcounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `hitcounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `img_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT '0',
  `img_width` int(11) NOT NULL DEFAULT '0',
  `img_height` int(11) NOT NULL DEFAULT '0',
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT '0',
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT NULL,
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description` varbinary(767) NOT NULL,
  `img_user` int(10) unsigned NOT NULL DEFAULT '0',
  `img_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `img_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_name`),
  KEY `img_usertext_timestamp` (`img_user_text`,`img_timestamp`),
  KEY `img_size` (`img_size`),
  KEY `img_timestamp` (`img_timestamp`),
  KEY `img_sha1` (`img_sha1`(10)),
  KEY `img_media_mime` (`img_media_type`,`img_major_mime`,`img_minor_mime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagelinks`
--

DROP TABLE IF EXISTS `imagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT '0',
  `il_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `il_from_namespace` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `il_from` (`il_from`,`il_to`),
  UNIQUE KEY `il_to` (`il_to`,`il_from`),
  KEY `il_backlinks_namespace` (`il_to`,`il_from_namespace`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagelinks`
--

LOCK TABLES `imagelinks` WRITE;
/*!40000 ALTER TABLE `imagelinks` DISABLE KEYS */;
INSERT INTO `imagelinks` VALUES (8,'W2LIntroBG.png',10);
/*!40000 ALTER TABLE `imagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interwiki`
--

DROP TABLE IF EXISTS `interwiki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interwiki` (
  `iw_prefix` varchar(32) NOT NULL,
  `iw_url` blob NOT NULL,
  `iw_local` tinyint(1) NOT NULL,
  `iw_trans` tinyint(4) NOT NULL DEFAULT '0',
  `iw_api` blob NOT NULL,
  `iw_wikiid` varchar(64) NOT NULL,
  UNIQUE KEY `iw_prefix` (`iw_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interwiki`
--

LOCK TABLES `interwiki` WRITE;
/*!40000 ALTER TABLE `interwiki` DISABLE KEYS */;
INSERT INTO `interwiki` VALUES ('acronym','http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=$1',0,0,'',''),('advogato','http://www.advogato.org/$1',0,0,'',''),('annotationwiki','http://www.seedwiki.com/page.cfm?wikiid=368&doc=$1',0,0,'',''),('arxiv','http://www.arxiv.org/abs/$1',0,0,'',''),('c2find','http://c2.com/cgi/wiki?FindPage&value=$1',0,0,'',''),('cache','http://www.google.com/search?q=cache:$1',0,0,'',''),('commons','http://commons.wikimedia.org/wiki/$1',0,0,'',''),('corpknowpedia','http://corpknowpedia.org/wiki/index.php/$1',0,0,'',''),('dictionary','http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1',0,0,'',''),('disinfopedia','http://www.disinfopedia.org/wiki.phtml?title=$1',0,0,'',''),('docbook','http://wiki.docbook.org/topic/$1',0,0,'',''),('doi','http://dx.doi.org/$1',0,0,'',''),('drumcorpswiki','http://www.drumcorpswiki.com/index.php/$1',0,0,'',''),('dwjwiki','http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1',0,0,'',''),('elibre','http://enciclopedia.us.es/index.php/$1',0,0,'',''),('emacswiki','http://www.emacswiki.org/cgi-bin/wiki.pl?$1',0,0,'',''),('foldoc','http://foldoc.org/?$1',0,0,'',''),('foxwiki','http://fox.wikis.com/wc.dll?Wiki~$1',0,0,'',''),('freebsdman','http://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1',0,0,'',''),('gej','http://www.esperanto.de/cgi-bin/aktivikio/wiki.pl?$1',0,0,'',''),('gentoo-wiki','http://gentoo-wiki.com/$1',0,0,'',''),('google','http://www.google.com/search?q=$1',0,0,'',''),('googlegroups','http://groups.google.com/groups?q=$1',0,0,'',''),('hammondwiki','http://www.dairiki.org/HammondWiki/$1',0,0,'',''),('hewikisource','http://he.wikisource.org/wiki/$1',1,0,'',''),('hrwiki','http://www.hrwiki.org/index.php/$1',0,0,'',''),('imdb','http://us.imdb.com/Title?$1',0,0,'',''),('jargonfile','http://sunir.org/apps/meta.pl?wiki=JargonFile&redirect=$1',0,0,'',''),('jspwiki','http://www.jspwiki.org/wiki/$1',0,0,'',''),('keiki','http://kei.ki/en/$1',0,0,'',''),('kmwiki','http://kmwiki.wikispaces.com/$1',0,0,'',''),('linuxwiki','http://linuxwiki.de/$1',0,0,'',''),('lojban','http://www.lojban.org/tiki/tiki-index.php?page=$1',0,0,'',''),('lqwiki','http://wiki.linuxquestions.org/wiki/$1',0,0,'',''),('lugkr','http://lug-kr.sourceforge.net/cgi-bin/lugwiki.pl?$1',0,0,'',''),('mathsongswiki','http://SeedWiki.com/page.cfm?wikiid=237&doc=$1',0,0,'',''),('meatball','http://www.usemod.com/cgi-bin/mb.pl?$1',0,0,'',''),('mediawikiwiki','http://www.mediawiki.org/wiki/$1',0,0,'',''),('mediazilla','https://bugzilla.wikimedia.org/$1',1,0,'',''),('memoryalpha','http://www.memory-alpha.org/en/index.php/$1',0,0,'',''),('metawiki','http://sunir.org/apps/meta.pl?$1',0,0,'',''),('metawikimedia','http://meta.wikimedia.org/wiki/$1',0,0,'',''),('moinmoin','http://purl.net/wiki/moin/$1',0,0,'',''),('mozillawiki','http://wiki.mozilla.org/index.php/$1',0,0,'',''),('mw','http://www.mediawiki.org/wiki/$1',0,0,'',''),('oeis','http://www.research.att.com/cgi-bin/access.cgi/as/njas/sequences/eisA.cgi?Anum=$1',0,0,'',''),('openfacts','http://openfacts.berlios.de/index.phtml?title=$1',0,0,'',''),('openwiki','http://openwiki.com/?$1',0,0,'',''),('patwiki','http://gauss.ffii.org/$1',0,0,'',''),('pmeg','http://www.bertilow.com/pmeg/$1.php',0,0,'',''),('ppr','http://c2.com/cgi/wiki?$1',0,0,'',''),('pythoninfo','http://wiki.python.org/moin/$1',0,0,'',''),('rfc','http://www.rfc-editor.org/rfc/rfc$1.txt',0,0,'',''),('s23wiki','http://is-root.de/wiki/index.php/$1',0,0,'',''),('seattlewiki','http://seattle.wikia.com/wiki/$1',0,0,'',''),('seattlewireless','http://seattlewireless.net/?$1',0,0,'',''),('senseislibrary','http://senseis.xmp.net/?$1',0,0,'',''),('slashdot','http://slashdot.org/article.pl?sid=$1',0,0,'',''),('sourceforge','http://sourceforge.net/$1',0,0,'',''),('squeak','http://wiki.squeak.org/squeak/$1',0,0,'',''),('susning','http://www.susning.nu/$1',0,0,'',''),('svgwiki','http://wiki.svg.org/$1',0,0,'',''),('tavi','http://tavi.sourceforge.net/$1',0,0,'',''),('tejo','http://www.tejo.org/vikio/$1',0,0,'',''),('theopedia','http://www.theopedia.com/$1',0,0,'',''),('tmbw','http://www.tmbw.net/wiki/$1',0,0,'',''),('tmnet','http://www.technomanifestos.net/?$1',0,0,'',''),('tmwiki','http://www.EasyTopicMaps.com/?page=$1',0,0,'',''),('twiki','http://twiki.org/cgi-bin/view/$1',0,0,'',''),('uea','http://www.tejo.org/uea/$1',0,0,'',''),('unreal','http://wiki.beyondunreal.com/wiki/$1',0,0,'',''),('usemod','http://www.usemod.com/cgi-bin/wiki.pl?$1',0,0,'',''),('vinismo','http://vinismo.com/en/$1',0,0,'',''),('webseitzwiki','http://webseitz.fluxent.com/wiki/$1',0,0,'',''),('why','http://clublet.com/c/c/why?$1',0,0,'',''),('wiki','http://c2.com/cgi/wiki?$1',0,0,'',''),('wikia','http://www.wikia.com/wiki/$1',0,0,'',''),('wikibooks','http://en.wikibooks.org/wiki/$1',1,0,'',''),('wikicities','http://www.wikia.com/wiki/$1',0,0,'',''),('wikif1','http://www.wikif1.org/$1',0,0,'',''),('wikihow','http://www.wikihow.com/$1',0,0,'',''),('wikimedia','http://wikimediafoundation.org/wiki/$1',0,0,'',''),('wikinews','http://en.wikinews.org/wiki/$1',1,0,'',''),('wikinfo','http://www.wikinfo.org/index.php/$1',0,0,'',''),('wikipedia','http://en.wikipedia.org/wiki/$1',1,0,'',''),('wikiquote','http://en.wikiquote.org/wiki/$1',1,0,'',''),('wikisource','http://wikisource.org/wiki/$1',1,0,'',''),('wikispecies','http://species.wikimedia.org/wiki/$1',1,0,'',''),('wikitravel','http://wikitravel.org/en/$1',0,0,'',''),('wikiversity','http://en.wikiversity.org/wiki/$1',1,0,'',''),('wikt','http://en.wiktionary.org/wiki/$1',1,0,'',''),('wiktionary','http://en.wiktionary.org/wiki/$1',1,0,'',''),('wlug','http://www.wlug.org.nz/$1',0,0,'',''),('zwiki','http://zwiki.org/$1',0,0,'',''),('zzz wiki','http://wiki.zzz.ee/index.php/$1',0,0,'','');
/*!40000 ALTER TABLE `interwiki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipblocks`
--

DROP TABLE IF EXISTS `ipblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ipb_reason` varbinary(767) NOT NULL,
  `ipb_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ipb_auto` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_anon_only` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_create_account` tinyint(1) NOT NULL DEFAULT '1',
  `ipb_enable_autoblock` tinyint(1) NOT NULL DEFAULT '1',
  `ipb_expiry` varbinary(14) NOT NULL DEFAULT '',
  `ipb_range_start` tinyblob NOT NULL,
  `ipb_range_end` tinyblob NOT NULL,
  `ipb_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_block_email` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_allow_usertalk` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_parent_block_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ipb_id`),
  UNIQUE KEY `ipb_address` (`ipb_address`(255),`ipb_user`,`ipb_auto`,`ipb_anon_only`),
  KEY `ipb_user` (`ipb_user`),
  KEY `ipb_range` (`ipb_range_start`(8),`ipb_range_end`(8)),
  KEY `ipb_timestamp` (`ipb_timestamp`),
  KEY `ipb_expiry` (`ipb_expiry`),
  KEY `ipb_parent_block_id` (`ipb_parent_block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipblocks`
--

LOCK TABLES `ipblocks` WRITE;
/*!40000 ALTER TABLE `ipblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iwlinks`
--

DROP TABLE IF EXISTS `iwlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iwlinks` (
  `iwl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `iwl_prefix` varbinary(20) NOT NULL DEFAULT '',
  `iwl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  UNIQUE KEY `iwl_from` (`iwl_from`,`iwl_prefix`,`iwl_title`),
  KEY `iwl_prefix_title_from` (`iwl_prefix`,`iwl_title`,`iwl_from`),
  KEY `iwl_prefix_from_title` (`iwl_prefix`,`iwl_from`,`iwl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iwlinks`
--

LOCK TABLES `iwlinks` WRITE;
/*!40000 ALTER TABLE `iwlinks` DISABLE KEYS */;
INSERT INTO `iwlinks` VALUES (1,'itwiki','Pagina_principale');
/*!40000 ALTER TABLE `iwlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_cmd` varbinary(60) NOT NULL DEFAULT '',
  `job_namespace` int(11) NOT NULL,
  `job_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `job_params` blob NOT NULL,
  `job_timestamp` varbinary(14) DEFAULT NULL,
  `job_random` int(10) unsigned NOT NULL DEFAULT '0',
  `job_token` varbinary(32) NOT NULL DEFAULT '',
  `job_token_timestamp` varbinary(14) DEFAULT NULL,
  `job_sha1` varbinary(32) NOT NULL DEFAULT '',
  `job_attempts` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`job_id`),
  KEY `job_cmd` (`job_cmd`,`job_namespace`,`job_title`,`job_params`(128)),
  KEY `job_timestamp` (`job_timestamp`),
  KEY `job_sha1` (`job_sha1`),
  KEY `job_cmd_token` (`job_cmd`,`job_token`,`job_random`),
  KEY `job_cmd_token_id` (`job_cmd`,`job_token`,`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,'recentChangesUpdate',-1,'UltimeModifiche','a:1:{s:4:\"type\";s:5:\"purge\";}','20151208223238',1763409496,'',NULL,'03sl2jhccmyg7fkhkztup3h3op2dxxn',0),(3,'refreshLinks',0,'Come_aiutare','a:4:{s:5:\"table\";s:13:\"templatelinks\";s:9:\"recursive\";b:1;s:16:\"rootJobSignature\";s:40:\"e27ad5d84f63e96684712dbf46450174b32a1386\";s:16:\"rootJobTimestamp\";s:14:\"20151208223238\";}','20151208223238',2063876910,'',NULL,'1375nsyrwoxunlr7cmhl80upv07vgfk',0),(4,'htmlCacheUpdate',0,'Come_aiutare','a:3:{s:5:\"pages\";a:1:{i:2;a:2:{i:0;i:0;i:1;s:17:\"Pagina_principale\";}}s:16:\"rootJobSignature\";s:40:\"e0386d3bef069fb2961fbe5e505396b2a70d9cd7\";s:16:\"rootJobTimestamp\";s:14:\"20151208223238\";}','20151208223238',2084555862,'',NULL,'95p8rllewz1huj5d7l6r9ty2cfys27d',0),(5,'refreshLinks',0,'Dipartimenti','a:4:{s:5:\"table\";s:13:\"templatelinks\";s:9:\"recursive\";b:1;s:16:\"rootJobSignature\";s:40:\"ebaae0d0803f7f937721fa795a04d65397c5ce0a\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',1967740738,'',NULL,'poggbalih86kr4b54kbwg1ton5esjlf',0),(7,'refreshLinks',0,'WikiFM_Stats2','a:4:{s:5:\"table\";s:13:\"templatelinks\";s:9:\"recursive\";b:1;s:16:\"rootJobSignature\";s:40:\"eb747cc0362589ef268a5e68b57b706fe5e460f5\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',268736245,'',NULL,'c16yt3nersvwzlqkp5mlwwesjn0vvbn',0),(8,'htmlCacheUpdate',0,'WikiFM_Stats2','a:3:{s:5:\"pages\";a:1:{i:2;a:2:{i:0;i:0;i:1;s:17:\"Pagina_principale\";}}s:16:\"rootJobSignature\";s:40:\"5ae9fc6ab82142eda915288708a86240926e21d2\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',1373880632,'',NULL,'46pyvjq9uu4ndmhyhbpth3opb39vb5q',0),(9,'refreshLinks',0,'WikiFM_Thanks','a:4:{s:5:\"table\";s:13:\"templatelinks\";s:9:\"recursive\";b:1;s:16:\"rootJobSignature\";s:40:\"c7658a86f365a487c383279fbbe2d002dc2729c3\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',1664643455,'',NULL,'9obz7r7yme1kchalwxzu8sucncesalj',0),(10,'htmlCacheUpdate',0,'WikiFM_Thanks','a:3:{s:5:\"pages\";a:1:{i:2;a:2:{i:0;i:0;i:1;s:17:\"Pagina_principale\";}}s:16:\"rootJobSignature\";s:40:\"7c1cb54fe9544be9da6265c064a4c237054f82a5\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',1144243011,'',NULL,'hi3spnxaonnnvyy6uzj7fd7j27ar2l0',0),(11,'refreshLinks',10,'Dipartimento','a:4:{s:5:\"table\";s:13:\"templatelinks\";s:9:\"recursive\";b:1;s:16:\"rootJobSignature\";s:40:\"e25326e03d3460e5352cf87aebdc503a84d32fbc\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',681420288,'',NULL,'eltrc00b0xvs76mjb9g38ksc32te3ct',0),(12,'htmlCacheUpdate',10,'Dipartimento','a:3:{s:5:\"pages\";a:2:{i:3;a:2:{i:0;i:0;i:1;s:12:\"Come_aiutare\";}i:4;a:2:{i:0;i:0;i:1;s:12:\"Dipartimenti\";}}s:16:\"rootJobSignature\";s:40:\"b512910ccd9c0a2c15ef791676f0571a65ace213\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',1739836934,'',NULL,'p6jv5fmoi9f96zisura2a76um1fwp11',0),(13,'refreshLinks',10,'WTL_Intro','a:4:{s:5:\"table\";s:13:\"templatelinks\";s:9:\"recursive\";b:1;s:16:\"rootJobSignature\";s:40:\"1c8d9438cb1f9893e584eae3d18848e5a8e0d80d\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',278895830,'',NULL,'bc6ovymuj388ajxyhrb97t5j1vyyir3',0),(14,'htmlCacheUpdate',10,'WTL_Intro','a:3:{s:5:\"pages\";a:1:{i:2;a:2:{i:0;i:0;i:1;s:17:\"Pagina_principale\";}}s:16:\"rootJobSignature\";s:40:\"49aba479c15987efd3ff0cb79535f7f01b9464e2\";s:16:\"rootJobTimestamp\";s:14:\"20151208223239\";}','20151208223239',1642290586,'',NULL,'1lk0jtdf54igtnbgn6nsk7geikxna3q',0);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `l10n_cache`
--

DROP TABLE IF EXISTS `l10n_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l10n_cache` (
  `lc_lang` varbinary(32) NOT NULL,
  `lc_key` varchar(255) NOT NULL,
  `lc_value` mediumblob NOT NULL,
  KEY `lc_lang_key` (`lc_lang`,`lc_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `l10n_cache`
--

LOCK TABLES `l10n_cache` WRITE;
/*!40000 ALTER TABLE `l10n_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `l10n_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `langlinks`
--

DROP TABLE IF EXISTS `langlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langlinks` (
  `ll_from` int(10) unsigned NOT NULL DEFAULT '0',
  `ll_lang` varbinary(20) NOT NULL DEFAULT '',
  `ll_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  UNIQUE KEY `ll_from` (`ll_from`,`ll_lang`),
  KEY `ll_lang` (`ll_lang`,`ll_title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `langlinks`
--

LOCK TABLES `langlinks` WRITE;
/*!40000 ALTER TABLE `langlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `langlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_search`
--

DROP TABLE IF EXISTS `log_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_search` (
  `ls_field` varbinary(32) NOT NULL,
  `ls_value` varchar(255) NOT NULL,
  `ls_log_id` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `ls_field_val` (`ls_field`,`ls_value`,`ls_log_id`),
  KEY `ls_log_id` (`ls_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_search`
--

LOCK TABLES `log_search` WRITE;
/*!40000 ALTER TABLE `log_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logging`
--

DROP TABLE IF EXISTS `logging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logging` (
  `log_type` varbinary(32) NOT NULL,
  `log_action` varbinary(32) NOT NULL,
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_user` int(10) unsigned NOT NULL DEFAULT '0',
  `log_namespace` int(11) NOT NULL DEFAULT '0',
  `log_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `log_comment` varbinary(767) NOT NULL DEFAULT '',
  `log_params` blob NOT NULL,
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `log_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `log_page` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `type_time` (`log_type`,`log_timestamp`),
  KEY `user_time` (`log_user`,`log_timestamp`),
  KEY `page_time` (`log_namespace`,`log_title`,`log_timestamp`),
  KEY `times` (`log_timestamp`),
  KEY `log_user_type_time` (`log_user`,`log_type`,`log_timestamp`),
  KEY `log_page_id_time` (`log_page`,`log_timestamp`),
  KEY `type_action` (`log_type`,`log_action`,`log_timestamp`),
  KEY `log_user_text_type_time` (`log_user_text`,`log_type`,`log_timestamp`),
  KEY `log_user_text_time` (`log_user_text`,`log_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logging`
--

LOCK TABLES `logging` WRITE;
/*!40000 ALTER TABLE `logging` DISABLE KEYS */;
/*!40000 ALTER TABLE `logging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `math`
--

DROP TABLE IF EXISTS `math`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `math` (
  `math_inputhash` varbinary(16) NOT NULL,
  `math_outputhash` varbinary(16) NOT NULL,
  `math_html_conservativeness` tinyint(4) NOT NULL,
  `math_html` text,
  `math_mathml` text,
  UNIQUE KEY `math_inputhash` (`math_inputhash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `math`
--

LOCK TABLES `math` WRITE;
/*!40000 ALTER TABLE `math` DISABLE KEYS */;
/*!40000 ALTER TABLE `math` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mathoid`
--

DROP TABLE IF EXISTS `mathoid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mathoid` (
  `math_inputhash` varbinary(16) NOT NULL,
  `math_input` text NOT NULL,
  `math_tex` text,
  `math_mathml` text,
  `math_svg` text,
  `math_style` tinyint(4) DEFAULT NULL,
  `math_input_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`math_inputhash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mathoid`
--

LOCK TABLES `mathoid` WRITE;
/*!40000 ALTER TABLE `mathoid` DISABLE KEYS */;
/*!40000 ALTER TABLE `mathoid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_deps`
--

DROP TABLE IF EXISTS `module_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_deps` (
  `md_module` varbinary(255) NOT NULL,
  `md_skin` varbinary(32) NOT NULL,
  `md_deps` mediumblob NOT NULL,
  UNIQUE KEY `md_module_skin` (`md_module`,`md_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_deps`
--

LOCK TABLES `module_deps` WRITE;
/*!40000 ALTER TABLE `module_deps` DISABLE KEYS */;
INSERT INTO `module_deps` VALUES ('mediawiki.ui.button','neverland','[\"/var/www/WikiToLearn/mediawiki/resources/src/mediawiki.ui/components/buttons.less\",\"/var/www/WikiToLearn/mediawiki/resources/src/mediawiki.less/mediawiki.mixins.less\",\"/var/www/WikiToLearn/mediawiki/resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"/var/www/WikiToLearn/mediawiki/resources/src/mediawiki.less/mediawiki.ui/mixins.less\"]');
/*!40000 ALTER TABLE `module_deps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `msg_resource`
--

DROP TABLE IF EXISTS `msg_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_resource` (
  `mr_resource` varbinary(255) NOT NULL,
  `mr_lang` varbinary(32) NOT NULL,
  `mr_blob` mediumblob NOT NULL,
  `mr_timestamp` binary(14) NOT NULL,
  UNIQUE KEY `mr_resource_lang` (`mr_resource`,`mr_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `msg_resource`
--

LOCK TABLES `msg_resource` WRITE;
/*!40000 ALTER TABLE `msg_resource` DISABLE KEYS */;
INSERT INTO `msg_resource` VALUES ('ext.uls.init','en','{}','20151208223316'),('ext.uls.interface','en','{\"ext-uls-language-settings-preferences-link\":\"More language settings\",\"ext-uls-select-language-settings-icon-tooltip\":\"Language settings\",\"ext-uls-undo-language-tooltip-text\":\"Language changed from $1\",\"uls-plang-title-languages\":\"Languages\"}','20151208223316'),('ext.uls.preferences','en','{}','20151208223316'),('ext.uls.pt','en','{}','20151208223317'),('ext.uls.webfonts','en','{}','20151208223316'),('ext.uls.webfonts.fonts','en','{}','20151208223316'),('ext.uls.webfonts.repository','en','{}','20151208223316'),('jquery.accessKeyLabel','en','{\"brackets\":\"[$1]\",\"word-separator\":\" \"}','20151208223316'),('jquery.checkboxShiftClick','en','{}','20151208223317'),('jquery.client','en','{}','20151208223316'),('jquery.cookie','en','{}','20151208223316'),('jquery.getAttrs','en','{}','20151208223317'),('jquery.highlightText','en','{}','20151208223317'),('jquery.makeCollapsible','en','{\"collapsible-collapse\":\"Collapse\",\"collapsible-expand\":\"Expand\"}','20151208223317'),('jquery.mw-jump','en','{}','20151208223317'),('jquery.mwExtension','en','{}','20151208223316'),('jquery.placeholder','en','{}','20151208223317'),('jquery.suggestions','en','{}','20151208223317'),('jquery.tipsy','en','{}','20151208223316'),('jquery.uls.data','en','{}','20151208223316'),('jquery.webfonts','en','{}','20151208223316'),('mediawiki.Uri','en','{}','20151208223316'),('mediawiki.action.view.postEdit','en','{\"postedit-confirmation-created\":\"The page has been created.\",\"postedit-confirmation-restored\":\"The page has been restored.\",\"postedit-confirmation-saved\":\"Your edit was saved.\"}','20151208223317'),('mediawiki.api','en','{}','20151208223316'),('mediawiki.cldr','en','{}','20151208223316'),('mediawiki.cookie','en','{}','20151208223317'),('mediawiki.jqueryMsg','en','{}','20151208223316'),('mediawiki.language','en','{\"and\":\" and\",\"comma-separator\":\", \",\"word-separator\":\" \"}','20151208223316'),('mediawiki.language.data','en','{}','20151208223316'),('mediawiki.language.init','en','{}','20151208223316'),('mediawiki.legacy.ajax','en','{}','20151208223316'),('mediawiki.legacy.wikibits','en','{}','20151208223316'),('mediawiki.libs.pluralruleparser','en','{}','20151208223316'),('mediawiki.notify','en','{}','20151208223316'),('mediawiki.page.ready','en','{}','20151208223317'),('mediawiki.page.startup','en','{}','20151208223316'),('mediawiki.searchSuggest','en','{\"searchsuggest-containing\":\"containing...\",\"searchsuggest-search\":\"Search\"}','20151208223317'),('mediawiki.template','en','{}','20151208223317'),('mediawiki.user','en','{}','20151208223316'),('mediawiki.util','en','{}','20151208223316'),('user.defaults','en','{}','20151208223316'),('user.options','en','{}','20151208223315'),('user.tokens','en','{}','20151208223315');
/*!40000 ALTER TABLE `msg_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `msg_resource_links`
--

DROP TABLE IF EXISTS `msg_resource_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_resource_links` (
  `mrl_resource` varbinary(255) NOT NULL,
  `mrl_message` varbinary(255) NOT NULL,
  UNIQUE KEY `mrl_message_resource` (`mrl_message`,`mrl_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `msg_resource_links`
--

LOCK TABLES `msg_resource_links` WRITE;
/*!40000 ALTER TABLE `msg_resource_links` DISABLE KEYS */;
INSERT INTO `msg_resource_links` VALUES ('mediawiki.language','and'),('jquery.accessKeyLabel','brackets'),('jquery.makeCollapsible','collapsible-collapse'),('jquery.makeCollapsible','collapsible-expand'),('mediawiki.language','comma-separator'),('ext.uls.interface','ext-uls-language-settings-preferences-link'),('ext.uls.interface','ext-uls-select-language-settings-icon-tooltip'),('ext.uls.interface','ext-uls-undo-language-tooltip-text'),('mediawiki.action.view.postEdit','postedit-confirmation-created'),('mediawiki.action.view.postEdit','postedit-confirmation-restored'),('mediawiki.action.view.postEdit','postedit-confirmation-saved'),('mediawiki.searchSuggest','searchsuggest-containing'),('mediawiki.searchSuggest','searchsuggest-search'),('ext.uls.interface','uls-plang-title-languages'),('jquery.accessKeyLabel','word-separator'),('mediawiki.language','word-separator');
/*!40000 ALTER TABLE `msg_resource_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objectcache`
--

DROP TABLE IF EXISTS `objectcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objectcache` (
  `keyname` varbinary(255) NOT NULL DEFAULT '',
  `value` mediumblob,
  `exptime` datetime DEFAULT NULL,
  UNIQUE KEY `keyname` (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objectcache`
--

LOCK TABLES `objectcache` WRITE;
/*!40000 ALTER TABLE `objectcache` DISABLE KEYS */;
/*!40000 ALTER TABLE `objectcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oldimage`
--

DROP TABLE IF EXISTS `oldimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oldimage` (
  `oi_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `oi_archive_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_width` int(11) NOT NULL DEFAULT '0',
  `oi_height` int(11) NOT NULL DEFAULT '0',
  `oi_bits` int(11) NOT NULL DEFAULT '0',
  `oi_description` varbinary(767) NOT NULL,
  `oi_user` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `oi_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT NULL,
  `oi_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `oi_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `oi_sha1` varbinary(32) NOT NULL DEFAULT '',
  KEY `oi_usertext_timestamp` (`oi_user_text`,`oi_timestamp`),
  KEY `oi_name_timestamp` (`oi_name`,`oi_timestamp`),
  KEY `oi_name_archive_name` (`oi_name`,`oi_archive_name`(14)),
  KEY `oi_sha1` (`oi_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oldimage`
--

LOCK TABLES `oldimage` WRITE;
/*!40000 ALTER TABLE `oldimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `oldimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_namespace` int(11) NOT NULL,
  `page_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `page_restrictions` tinyblob NOT NULL,
  `page_counter` bigint(20) unsigned NOT NULL DEFAULT '0',
  `page_is_redirect` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_is_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_random` double unsigned NOT NULL,
  `page_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `page_latest` int(10) unsigned NOT NULL,
  `page_len` int(10) unsigned NOT NULL,
  `page_content_model` varbinary(32) DEFAULT NULL,
  `page_links_updated` varbinary(14) DEFAULT NULL,
  `page_lang` varbinary(35) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,0,'Main_Page','',8,0,0,0.835027575799,'20150520220536',2,98,'wikitext',NULL,NULL),(2,0,'Pagina_principale','',0,0,1,0.927893816349,'20151208223239',3,763,'wikitext','20151208223238',NULL),(3,0,'Come_aiutare','',0,0,1,0.945288608012,'20151208223238',4,1033,'wikitext','20151208223238',NULL),(4,0,'Dipartimenti','',0,0,1,0.80722085107,'20151208223239',5,1367,'wikitext','20151208223239',NULL),(5,0,'WikiFM_Stats2','',0,0,1,0.438754816924,'20151208223239',6,489,'wikitext','19691231235959',NULL),(6,0,'WikiFM_Thanks','',0,0,1,0.955176717457,'20151208223239',7,374,'wikitext','20151208223239',NULL),(7,10,'Dipartimento','',0,0,1,0.981169269603,'20151208223239',8,102,'wikitext','20151208223239',NULL),(8,10,'WTL_Intro','',0,0,1,0.207097051299,'20151208223239',9,391,'wikitext','20151208223239',NULL),(9,10,'HSF_Page','',0,0,1,0.190215747302,'20151208223239',10,210,'wikitext','20151208223239',NULL),(10,10,'HSF_Page_C++','',0,0,1,0.041249686217,'20151208223239',11,233,'wikitext','20151208223239',NULL);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_props`
--

DROP TABLE IF EXISTS `page_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  `pp_sortkey` float DEFAULT NULL,
  PRIMARY KEY (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`),
  UNIQUE KEY `pp_propname_sortkey_page` (`pp_propname`,`pp_sortkey`,`pp_page`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_props`
--

LOCK TABLES `page_props` WRITE;
/*!40000 ALTER TABLE `page_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_restrictions`
--

DROP TABLE IF EXISTS `page_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_restrictions` (
  `pr_page` int(11) NOT NULL,
  `pr_type` varbinary(60) NOT NULL,
  `pr_level` varbinary(60) NOT NULL,
  `pr_cascade` tinyint(4) NOT NULL,
  `pr_user` int(11) DEFAULT NULL,
  `pr_expiry` varbinary(14) DEFAULT NULL,
  `pr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pr_page`,`pr_type`),
  UNIQUE KEY `pr_id` (`pr_id`),
  KEY `pr_typelevel` (`pr_type`,`pr_level`),
  KEY `pr_level` (`pr_level`),
  KEY `pr_cascade` (`pr_cascade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_restrictions`
--

LOCK TABLES `page_restrictions` WRITE;
/*!40000 ALTER TABLE `page_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagelinks`
--

DROP TABLE IF EXISTS `pagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `pl_namespace` int(11) NOT NULL DEFAULT '0',
  `pl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `pl_from_namespace` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `pl_from` (`pl_from`,`pl_namespace`,`pl_title`),
  UNIQUE KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`),
  KEY `pl_backlinks_namespace` (`pl_namespace`,`pl_title`,`pl_from_namespace`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagelinks`
--

LOCK TABLES `pagelinks` WRITE;
/*!40000 ALTER TABLE `pagelinks` DISABLE KEYS */;
INSERT INTO `pagelinks` VALUES (10,0,'C++',10),(2,0,'Come_aiutare',0),(2,0,'Dipartimenti',0),(6,0,'Hall_of_fame',0),(9,0,'Main_Page_HSF',10),(10,0,'Main_Page_HSF',10),(2,0,'WikiFM_Stats2',0),(2,0,'WikiFM_Thanks',0),(3,10,'Dipartimento',0),(4,10,'Dipartimento',0),(2,10,'WTL_Intro',0);
/*!40000 ALTER TABLE `pagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protected_titles`
--

DROP TABLE IF EXISTS `protected_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason` varbinary(767) DEFAULT NULL,
  `pt_timestamp` binary(14) NOT NULL,
  `pt_expiry` varbinary(14) NOT NULL DEFAULT '',
  `pt_create_perm` varbinary(60) NOT NULL,
  PRIMARY KEY (`pt_namespace`,`pt_title`),
  KEY `pt_timestamp` (`pt_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protected_titles`
--

LOCK TABLES `protected_titles` WRITE;
/*!40000 ALTER TABLE `protected_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `protected_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycache`
--

DROP TABLE IF EXISTS `querycache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycache` (
  `qc_type` varbinary(32) NOT NULL,
  `qc_value` int(10) unsigned NOT NULL DEFAULT '0',
  `qc_namespace` int(11) NOT NULL DEFAULT '0',
  `qc_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `querycache`
--

LOCK TABLES `querycache` WRITE;
/*!40000 ALTER TABLE `querycache` DISABLE KEYS */;
/*!40000 ALTER TABLE `querycache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycache_info`
--

DROP TABLE IF EXISTS `querycache_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycache_info` (
  `qci_type` varbinary(32) NOT NULL DEFAULT '',
  `qci_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  UNIQUE KEY `qci_type` (`qci_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `querycache_info`
--

LOCK TABLES `querycache_info` WRITE;
/*!40000 ALTER TABLE `querycache_info` DISABLE KEYS */;
INSERT INTO `querycache_info` VALUES ('activeusers','20151208223315');
/*!40000 ALTER TABLE `querycache_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycachetwo`
--

DROP TABLE IF EXISTS `querycachetwo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycachetwo` (
  `qcc_type` varbinary(32) NOT NULL,
  `qcc_value` int(10) unsigned NOT NULL DEFAULT '0',
  `qcc_namespace` int(11) NOT NULL DEFAULT '0',
  `qcc_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `qcc_namespacetwo` int(11) NOT NULL DEFAULT '0',
  `qcc_titletwo` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  KEY `qcc_type` (`qcc_type`,`qcc_value`),
  KEY `qcc_title` (`qcc_type`,`qcc_namespace`,`qcc_title`),
  KEY `qcc_titletwo` (`qcc_type`,`qcc_namespacetwo`,`qcc_titletwo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `querycachetwo`
--

LOCK TABLES `querycachetwo` WRITE;
/*!40000 ALTER TABLE `querycachetwo` DISABLE KEYS */;
/*!40000 ALTER TABLE `querycachetwo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recentchanges`
--

DROP TABLE IF EXISTS `recentchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recentchanges` (
  `rc_id` int(11) NOT NULL AUTO_INCREMENT,
  `rc_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `rc_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `rc_namespace` int(11) NOT NULL,
  `rc_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `rc_comment` varbinary(767) NOT NULL DEFAULT '',
  `rc_minor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_bot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_cur_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_this_oldid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_last_oldid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_patrolled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_ip` varbinary(40) NOT NULL DEFAULT '',
  `rc_old_len` int(11) DEFAULT NULL,
  `rc_new_len` int(11) DEFAULT NULL,
  `rc_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_logid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_log_type` varbinary(255) DEFAULT NULL,
  `rc_log_action` varbinary(255) DEFAULT NULL,
  `rc_params` blob,
  `rc_source` varbinary(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title` (`rc_namespace`,`rc_title`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_ns_usertext` (`rc_namespace`,`rc_user_text`),
  KEY `rc_user_text` (`rc_user_text`,`rc_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recentchanges`
--

LOCK TABLES `recentchanges` WRITE;
/*!40000 ALTER TABLE `recentchanges` DISABLE KEYS */;
INSERT INTO `recentchanges` VALUES (1,'20150520220031',6,'Roopi',0,'Main_Page','Created page with \"Knowledge only grows if shared.  Page under construction - please see [[it:Pagina principale]]\"',0,0,1,1,1,0,1,0,'93.50.167.127',0,94,0,0,NULL,'','','mw.new'),(2,'20150520220536',6,'Roopi',0,'Main_Page','',0,0,0,1,2,1,0,0,'93.50.167.127',94,98,0,0,NULL,'','','mw.edit');
/*!40000 ALTER TABLE `recentchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redirect`
--

DROP TABLE IF EXISTS `redirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redirect` (
  `rd_from` int(10) unsigned NOT NULL DEFAULT '0',
  `rd_namespace` int(11) NOT NULL DEFAULT '0',
  `rd_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `rd_interwiki` varchar(32) DEFAULT NULL,
  `rd_fragment` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`rd_from`),
  KEY `rd_ns_title` (`rd_namespace`,`rd_title`,`rd_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redirect`
--

LOCK TABLES `redirect` WRITE;
/*!40000 ALTER TABLE `redirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `redirect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision`
--

DROP TABLE IF EXISTS `revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_text_id` int(10) unsigned NOT NULL,
  `rev_comment` varbinary(767) NOT NULL,
  `rev_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rev_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `rev_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `rev_minor_edit` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rev_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rev_len` int(10) unsigned DEFAULT NULL,
  `rev_parent_id` int(10) unsigned DEFAULT NULL,
  `rev_sha1` varbinary(32) NOT NULL DEFAULT '',
  `rev_content_model` varbinary(32) DEFAULT NULL,
  `rev_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`rev_id`),
  UNIQUE KEY `rev_page_id` (`rev_page`,`rev_id`),
  KEY `rev_timestamp` (`rev_timestamp`),
  KEY `page_timestamp` (`rev_page`,`rev_timestamp`),
  KEY `user_timestamp` (`rev_user`,`rev_timestamp`),
  KEY `usertext_timestamp` (`rev_user_text`,`rev_timestamp`),
  KEY `page_user_timestamp` (`rev_page`,`rev_user`,`rev_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=1024;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision`
--

LOCK TABLES `revision` WRITE;
/*!40000 ALTER TABLE `revision` DISABLE KEYS */;
INSERT INTO `revision` VALUES (1,1,1,'Created page with \"Knowledge only grows if shared.  Page under construction - please see [[it:Pagina principale]]\"',6,'Roopi','20150520220031',0,0,94,0,'hjk5u4otz9hw1uqcs9zpakvdwciw6nb',NULL,NULL),(2,1,2,'',6,'Roopi','20150520220536',0,0,98,1,'7d4lk50m99vabfrqc7j4tmuixa4ad50',NULL,NULL),(3,2,3,'',0,'172.17.42.1','20151018201852',0,0,763,0,'c6v0k6eqkbjknkybxuu73zzo7kzld0m',NULL,NULL),(4,3,4,'',0,'172.17.42.1','20151018201633',0,0,1033,0,'csh94dbr1vuwzi8jhlieer7scpuhcq7',NULL,NULL),(5,4,5,'',0,'Grigoletti','20151018175804',0,0,1367,0,'9a41chnoqi1vnj17yokcig3mpmhwxgw',NULL,NULL),(6,5,6,'una versione importata',0,'Grigoletti','20151018112201',1,0,489,0,'q6iiikx58hnej9uh2h22k5ffp7atxnf',NULL,NULL),(7,6,7,'una versione importata',0,'Grigoletti','20151018112205',1,0,374,0,'8xt36hi4v28euk2ai4nvmcqqkwtp4io',NULL,NULL),(8,7,8,'',0,'Roopi','20130520155310',0,0,102,0,'hemxqk4mb0cw1hvxdmofj0wx8ftui4l',NULL,NULL),(9,8,9,'',0,'Grigoletti','20151018180215',0,0,391,0,'f1skcvyrb8tsa2auayvqza9z3uv904q',NULL,NULL),(10,9,10,'',0,'Grigoletti','20151107223025',0,0,210,0,'qtrgdmtjq3tbeq7d9qy0f8p4zf9wbzx',NULL,NULL),(11,10,11,'',0,'Grigoletti','20151107223307',0,0,233,0,'gb10fuk7b7dw2bxs0g10rknr6r0dum0',NULL,NULL);
/*!40000 ALTER TABLE `revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `si_page` int(10) unsigned NOT NULL,
  `si_title` varchar(255) NOT NULL DEFAULT '',
  `si_text` mediumtext NOT NULL,
  FULLTEXT KEY `si_title` (`si_title`),
  FULLTEXT KEY `si_text` (`si_text`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'main page',' knowledge only grows ifu800 shared. page under construction - please seeu800 itu800 pagina principale '),(1,'main page',' knowledge only grows ifu800 shared. page under construction - please seeu800 itwiki pagina principale '),(2,'pagina principale',' wtl_intro titolo wikitolearn vuole creare libri diu800 testo liberi collaborativi eu800 facilmente accessibili. lau800 nostra filosofia u8c3a8 riassunta nelu800 motto u8e2809cil sapere siu800 accresce solo seu800 condivisou8e2809d. nella nostra piattaforma lu800\'insegnamento eu800 lu800\'apprendimento convergono nella stesura eu800 nelu800 perfezionamento cooperativo diu800 note appunti eu800 libri diu800 testo organizzabili eu800 riu800-assemblabili secondo leu800 esigenze specifiche degli utenti. dipartimenti come aiutare unu800 grazie au800... wikifm thanks statistiche wikifm stats2 '),(3,'come aiutare',' cosa posso fare come posso farlo siamo unu800 progetto libero cheu800 valorizza  tutti  iu800 tipi diu800 contributi. ogni pagina u8c3a8 modificabile eu800 puoi cominciare au800 partecipare dau800 subito dove credi diu800 potere essere piu8c3b9 utile. ecco alcuni suggerimenti peru800 cominciare dipartimento titolo come aiutare studente immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 studenteu82epngu800 dipartimento titolo come aiutare professore immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 professoreu82epngu800 dipartimento titolo come aiutare traduttore immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 traduttoreu82epngu800 dipartimento titolo come aiutare hacker immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 hackeru82epngu800 '),(4,'dipartimenti',' dipartimento titolo biologia eu800 biotecnologie immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 bioscienze-grayu82epngu800 dipartimento titolo chimica immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 chimica-grayu82epngu800 dipartimento titolo economia immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 economiau82epngu800 dipartimento titolo fisica immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 fisicau82epngu800 dipartimento titolo informatica immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 informaticau82epngu800 dipartimento titolo ingegneria immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 ingegneria-grayu82epngu800 dipartimento titolo matematica immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 matematicau82epngu800 dipartimento titolo medicina immagine poolu82ewikitolearnu82eorgu800 skins neverland images badges itu800 medicina-grayu82epngu800 '),(5,'wikifm stats2','   special statistics numberofarticles    articoli  diu800 scienze eu800   special statistics numberoffiles    file  caricati.   special statistics numberofedits   modifiche dalu800 1u800 maggio 2012. special contributionscores 10u800 30u800 nosort notools --- special contributionscores 10u800 60u800 nosort notools -- speciale contributionscores mostra altre statistiche... '),(6,'wikifm thanks',' -- file abbabassa_foto_profilou82ejpgu8e2808e 138px thumb utente abbabassa paolo bassanese -- quiu800 vengono presentati iu800 membri della comunitu8c3a0 cheu800 hanno contribuito maggiormente alla costruzione diu800 questo progetto eu800 pertanto hanno ricevuto unu800 riconoscimento particolare chiu800 saru8c3a0 ilu800 prossimo trovi altri ringraziamenti speciali nella hall ofu800 fame '),(7,'dipartimento',' titolo '),(8,'wtlu800 intro',' wtl_intro titolo titolo delu800 corso contenuto questo eu800\' ilu800 contenuto delu800 corso file w2lintrobgu82epngu800 link altu800 titolo '),(9,'hsfu800 page',' ---- this page belongs tou800 theu800 main page hsfu800 list ofu800 courses ofu800 hepu800 software foundation. main page hsfu800 gou800 back onu800 theu800 main page . categoria hsfu800 '),(10,'hsfu800 page cu800',' ---- this page belongs tou800 theu800 main page hsfu800 list ofu800 courses ofu800 hepu800 software foundation. main page hsfu800 gou800 back onu800 theu800 main page cu800 gou800 back tou800 theu800 cu800 chapters . ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_identifiers`
--

DROP TABLE IF EXISTS `site_identifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_identifiers` (
  `si_site` int(10) unsigned NOT NULL,
  `si_type` varbinary(32) NOT NULL,
  `si_key` varbinary(32) NOT NULL,
  UNIQUE KEY `site_ids_type` (`si_type`,`si_key`),
  KEY `site_ids_site` (`si_site`),
  KEY `site_ids_key` (`si_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_identifiers`
--

LOCK TABLES `site_identifiers` WRITE;
/*!40000 ALTER TABLE `site_identifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_identifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_stats`
--

DROP TABLE IF EXISTS `site_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_stats` (
  `ss_row_id` int(10) unsigned NOT NULL,
  `ss_total_views` bigint(20) unsigned DEFAULT '0',
  `ss_total_edits` bigint(20) unsigned DEFAULT '0',
  `ss_good_articles` bigint(20) unsigned DEFAULT '0',
  `ss_total_pages` bigint(20) DEFAULT '-1',
  `ss_users` bigint(20) DEFAULT '-1',
  `ss_active_users` bigint(20) DEFAULT '-1',
  `ss_images` int(11) DEFAULT '0',
  UNIQUE KEY `ss_row_id` (`ss_row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_stats`
--

LOCK TABLES `site_stats` WRITE;
/*!40000 ALTER TABLE `site_stats` DISABLE KEYS */;
INSERT INTO `site_stats` VALUES (1,NULL,11,0,10,158,0,0);
/*!40000 ALTER TABLE `site_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `site_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_global_key` varbinary(32) NOT NULL,
  `site_type` varbinary(32) NOT NULL,
  `site_group` varbinary(32) NOT NULL,
  `site_source` varbinary(32) NOT NULL,
  `site_language` varbinary(32) NOT NULL,
  `site_protocol` varbinary(32) NOT NULL,
  `site_domain` varchar(255) NOT NULL,
  `site_data` blob NOT NULL,
  `site_forward` tinyint(1) NOT NULL,
  `site_config` blob NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `sites_global_key` (`site_global_key`),
  KEY `sites_type` (`site_type`),
  KEY `sites_group` (`site_group`),
  KEY `sites_source` (`site_source`),
  KEY `sites_language` (`site_language`),
  KEY `sites_protocol` (`site_protocol`),
  KEY `sites_domain` (`site_domain`),
  KEY `sites_forward` (`site_forward`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_summary`
--

DROP TABLE IF EXISTS `tag_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_summary` (
  `ts_rc_id` int(11) DEFAULT NULL,
  `ts_log_id` int(11) DEFAULT NULL,
  `ts_rev_id` int(11) DEFAULT NULL,
  `ts_tags` blob NOT NULL,
  UNIQUE KEY `tag_summary_rc_id` (`ts_rc_id`),
  UNIQUE KEY `tag_summary_log_id` (`ts_log_id`),
  UNIQUE KEY `tag_summary_rev_id` (`ts_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_summary`
--

LOCK TABLES `tag_summary` WRITE;
/*!40000 ALTER TABLE `tag_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatelinks`
--

DROP TABLE IF EXISTS `templatelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `tl_namespace` int(11) NOT NULL DEFAULT '0',
  `tl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `tl_from_namespace` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `tl_from` (`tl_from`,`tl_namespace`,`tl_title`),
  UNIQUE KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`),
  KEY `tl_backlinks_namespace` (`tl_namespace`,`tl_title`,`tl_from_namespace`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatelinks`
--

LOCK TABLES `templatelinks` WRITE;
/*!40000 ALTER TABLE `templatelinks` DISABLE KEYS */;
INSERT INTO `templatelinks` VALUES (2,0,'Come_aiutare',0),(2,0,'Dipartimenti',0),(2,0,'WikiFM_Stats2',0),(2,0,'WikiFM_Thanks',0),(3,10,'Dipartimento',0),(4,10,'Dipartimento',0),(2,10,'WTL_Intro',0),(8,10,'WTL_Intro',10);
/*!40000 ALTER TABLE `templatelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `text`
--

DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text` (
  `old_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_text` mediumblob NOT NULL,
  `old_flags` tinyblob NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=10240;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text`
--

LOCK TABLES `text` WRITE;
/*!40000 ALTER TABLE `text` DISABLE KEYS */;
INSERT INTO `text` VALUES (1,'Knowledge only grows if shared.\n\nPage under construction - please see [[it:Pagina principale]]','utf-8'),(2,'Knowledge only grows if shared.\n\nPage under construction - please see [[itwiki:Pagina principale]]','utf-8'),(3,'{{WTL_Intro|titolo=WikiToLearn vuole creare libri di testo liberi, collaborativi e facilmente accessibili.\n<br/><small class=\"hidden-xs\">La nostra filosofia è riassunta nel motto “Il sapere si accresce solo se condiviso”. Nella nostra piattaforma l\'insegnamento e l\'apprendimento convergono nella stesura e nel perfezionamento cooperativo di note, appunti e libri di testo, organizzabili e ri-assemblabili secondo le esigenze specifiche degli utenti.</small>}}\n\n<div class=\"container-fluid\">\n<div class=\"row\">\n<div class=\"col-xs-12\">\n{{:Dipartimenti}}\n{{:Come aiutare}}\n</div>\n\n<div class=\"col-xs-12 col-sm-6\">\n<h2> Un grazie a... </h2>\n{{:WikiFM Thanks}}\n</div>\n<div class=\"col-xs-12 col-sm-6\">\n<h2> Statistiche </h2>\n{{:WikiFM Stats2}}\n</div>\n</div>\n</div>','utf-8'),(4,'<h2>Cosa posso fare? Come posso farlo?</h2>\nSiamo un progetto libero che valorizza \'\'\'tutti\'\'\' i tipi di contributi. Ogni pagina è modificabile e puoi cominciare a partecipare da subito dove credi di potere essere più utile.\nEcco alcuni suggerimenti per cominciare:\n<div class=\"container-fluid\">\n<div class=\"row\">\n<div class=\"thumbnails row\">\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Come aiutare/Studente\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/studente.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Come aiutare/Professore\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/professore.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Come aiutare/Traduttore\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/traduttore.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Come aiutare/Hacker\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/hacker.png}}\n</div>\n</div>\n</div>\n</div>','utf-8'),(5,'<div class=\"container-fluid\">\n<div class=\"row\">\n<div class=\"thumbnails row\">\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Biologia e Biotecnologie\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/bioscienze-gray.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Chimica\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/chimica-gray.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Economia\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/economia.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Fisica\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/fisica.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Informatica\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/informatica.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Ingegneria\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/ingegneria-gray.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Matematica\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/matematica.png}}\n</div>\n<div class=\"col-xs-12 col-sm-3\">\n{{Dipartimento\n|Titolo=Medicina\n|Immagine=//pool.wikitolearn.org/skins/Neverland/images/badges/it/medicina-gray.png}}\n</div>\n</div>\n</div>\n</div>','utf-8'),(6,'<div style=\"text-align: left;\">\n\'\'\'[[Special:Statistics|{{NUMBEROFARTICLES}}]]\'\'\' \'\'\'articoli\'\'\' di scienze e \'\'\'[[Special:Statistics|{{NUMBEROFFILES}}]]\'\'\' \'\'\'file\'\'\' caricati.<br/>\n\'\'\'[[Special:Statistics|{{NUMBEROFEDITS}}]]\'\'\' modifiche dal 1 Maggio 2012.<br/>\n</div>\n\n<div style=\"clear:both;\">\n{{Special:ContributionScores/10/30/nosort,notools}}\n</div>\n<div>\n<!---{{Special:ContributionScores/10/60/nosort,notools}}-->\n</div>\n[[Speciale:ContributionScores|mostra altre statistiche...]]','utf-8'),(7,'<div>\n<!-- [[File:Abbabassa_foto_profilo.jpg‎|138px|thumb|[[Utente:Abbabassa|Paolo Bassanese]]]] -->\n\nQui vengono presentati i membri della comunità che hanno contribuito maggiormente alla costruzione di questo progetto e, pertanto, hanno ricevuto un riconoscimento particolare :)\n\nChi sarà il prossimo?\n\n</div>\nTrovi altri ringraziamenti speciali nella [[Hall of fame]]','utf-8'),(8,'[[{{{Titolo}}}|\n<div class=\"thumbnail\">\n<img data-src=\"holder.js/50x50\" src=\"{{{Immagine}}}\">\n</div>]]','utf-8'),(9,'<noinclude>\n{{WTL_Intro|titolo=Titolo del corso|contenuto=Questo e\' il contenuto del corso}}\n</noinclude>\n<includeonly><div class=\"row\" style=\"height:113px;\">\n<div class=\"col-xs-12\" style=\"position: absolute; z-index: -1;\">[[File:W2LIntroBG.png|link=|alt=]]</div>\n<div class=\"col-xs-12\" style=\"padding-left: 120px; padding-top: 3px; text-align:right;\">{{{titolo}}}</div>\n</div></includeonly>','utf-8'),(10,'----\n<div class=\"alert alert-warning\"><center>This page belongs to the [[Main Page HSF|list of courses]] of HEP Software Foundation. [[Main Page HSF|Go back on the main page]].</center></div>\n\n[[Categoria:HSF]]','utf-8'),(11,'----\n<div class=\"alert alert-warning\"><center>This page belongs to the [[Main Page HSF|list of courses]] of HEP Software Foundation. </center><br>\n[[Main Page HSF|Go back on the main page]],\n[[C++|Go back to the C++ Chapters]].</div>','utf-8');
/*!40000 ALTER TABLE `text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread`
--

DROP TABLE IF EXISTS `thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread` (
  `thread_id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `thread_root` int(8) unsigned NOT NULL,
  `thread_ancestor` int(8) unsigned NOT NULL,
  `thread_parent` int(8) unsigned DEFAULT NULL,
  `thread_summary_page` int(8) unsigned DEFAULT NULL,
  `thread_subject` varchar(255) DEFAULT NULL,
  `thread_author_id` int(10) unsigned DEFAULT NULL,
  `thread_author_name` varchar(255) DEFAULT NULL,
  `thread_modified` char(14) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `thread_created` char(14) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `thread_editedness` int(1) NOT NULL DEFAULT '0',
  `thread_article_namespace` int(11) NOT NULL,
  `thread_article_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `thread_article_id` int(8) unsigned NOT NULL,
  `thread_type` int(4) unsigned NOT NULL DEFAULT '0',
  `thread_sortkey` varchar(255) NOT NULL DEFAULT '',
  `thread_replies` int(8) DEFAULT '-1',
  `thread_signature` tinyblob,
  PRIMARY KEY (`thread_id`),
  UNIQUE KEY `thread_root` (`thread_root`),
  UNIQUE KEY `thread_root_2` (`thread_root`),
  KEY `thread_ancestor` (`thread_ancestor`,`thread_parent`),
  KEY `thread_article_title` (`thread_article_namespace`,`thread_article_title`,`thread_sortkey`),
  KEY `thread_article` (`thread_article_id`,`thread_sortkey`),
  KEY `thread_modified` (`thread_modified`),
  KEY `thread_created` (`thread_created`),
  KEY `thread_summary_page` (`thread_summary_page`),
  KEY `thread_author_name` (`thread_author_id`,`thread_author_name`),
  KEY `thread_sortkey` (`thread_sortkey`),
  KEY `thread_parent` (`thread_parent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread`
--

LOCK TABLES `thread` WRITE;
/*!40000 ALTER TABLE `thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread_history`
--

DROP TABLE IF EXISTS `thread_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread_history` (
  `th_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `th_thread` int(10) unsigned NOT NULL,
  `th_timestamp` varbinary(14) NOT NULL,
  `th_user` int(10) unsigned NOT NULL,
  `th_user_text` varchar(255) NOT NULL,
  `th_change_type` int(10) unsigned NOT NULL,
  `th_change_object` int(10) unsigned NOT NULL,
  `th_change_comment` tinytext NOT NULL,
  `th_content` longblob NOT NULL,
  PRIMARY KEY (`th_id`),
  KEY `th_thread_timestamp` (`th_thread`,`th_timestamp`),
  KEY `th_timestamp_thread` (`th_timestamp`,`th_thread`),
  KEY `th_user_text` (`th_user`,`th_user_text`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread_history`
--

LOCK TABLES `thread_history` WRITE;
/*!40000 ALTER TABLE `thread_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `thread_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread_pending_relationship`
--

DROP TABLE IF EXISTS `thread_pending_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread_pending_relationship` (
  `tpr_thread` int(10) unsigned NOT NULL,
  `tpr_relationship` varbinary(64) NOT NULL,
  `tpr_title` varbinary(255) NOT NULL,
  `tpr_type` varbinary(32) NOT NULL,
  PRIMARY KEY (`tpr_thread`,`tpr_relationship`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread_pending_relationship`
--

LOCK TABLES `thread_pending_relationship` WRITE;
/*!40000 ALTER TABLE `thread_pending_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `thread_pending_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread_reaction`
--

DROP TABLE IF EXISTS `thread_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread_reaction` (
  `tr_thread` int(10) unsigned NOT NULL,
  `tr_user` int(10) unsigned NOT NULL,
  `tr_user_text` varbinary(255) NOT NULL,
  `tr_type` varbinary(64) NOT NULL,
  `tr_value` int(11) NOT NULL,
  PRIMARY KEY (`tr_thread`,`tr_user`,`tr_user_text`,`tr_type`,`tr_value`),
  KEY `tr_user_text_value` (`tr_user`,`tr_user_text`,`tr_type`,`tr_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread_reaction`
--

LOCK TABLES `thread_reaction` WRITE;
/*!40000 ALTER TABLE `thread_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `thread_reaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transcache`
--

DROP TABLE IF EXISTS `transcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcache` (
  `tc_url` varbinary(255) NOT NULL,
  `tc_contents` text,
  `tc_time` binary(14) DEFAULT NULL,
  UNIQUE KEY `tc_url_idx` (`tc_url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transcache`
--

LOCK TABLES `transcache` WRITE;
/*!40000 ALTER TABLE `transcache` DISABLE KEYS */;
/*!40000 ALTER TABLE `transcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updatelog`
--

DROP TABLE IF EXISTS `updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatelog` (
  `ul_key` varchar(255) NOT NULL,
  `ul_value` blob,
  PRIMARY KEY (`ul_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updatelog`
--

LOCK TABLES `updatelog` WRITE;
/*!40000 ALTER TABLE `updatelog` DISABLE KEYS */;
INSERT INTO `updatelog` VALUES ('cl_fields_update',NULL),('convert transcache field',NULL),('DeleteDefaultMessages',NULL),('echo_event-event_agent_ip-/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql',NULL),('echo_event-event_agent_ip-/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_agent_ip-size.sql',NULL),('echo_event-event_extra-/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql',NULL),('echo_event-event_extra-/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_extra-size.sql',NULL),('echo_event-event_variant-/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql',NULL),('echo_event-event_variant-/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_variant_nullability.sql',NULL),('filearchive-fa_major_mime-patch-fa_major_mime-chemical.sql',NULL),('fix protocol-relative URLs in externallinks',NULL),('FlowFixLog',NULL),('FlowPopulateLinksTables',NULL),('FlowSetUserIp',NULL),('FlowUpdateRecentChanges',NULL),('FlowUpdateRevisionContentLength:version2',NULL),('FlowUpdateRevisionTypeId',NULL),('FlowUpdateUserWiki',NULL),('flow_revision-rev_change_type-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-censor_to_suppress.sql',NULL),('flow_revision-rev_change_type-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-rev_change_type_update.sql',NULL),('flow_revision-rev_user_ip-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-revision_user_ip.sql',NULL),('flow_subscription-subscription_user_id-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-subscription_user_id.sql',NULL),('flow_workflow-workflow_id-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-88bit_uuids.sql',NULL),('flow_workflow-workflow_wiki-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-increase_width_wiki_fields.sql',NULL),('image-img_major_mime-patch-img_major_mime-chemical.sql',NULL),('mime_minor_length',NULL),('oldimage-oi_major_mime-patch-oi_major_mime-chemical.sql',NULL),('populate *_from_namespace',NULL),('populate category',NULL),('populate fa_sha1',NULL),('populate img_sha1',NULL),('populate log_search',NULL),('populate log_usertext',NULL),('populate rev_len',NULL),('populate rev_len and ar_len',NULL),('populate rev_parent_id',NULL),('populate rev_sha1',NULL),('recentchanges-rc_comment-patch-editsummary-length.sql',NULL),('recentchanges-rc_source-/var/www/WikiToLearn/extensions/Flow/db_patches/patch-rc_source.sql',NULL),('updatelist-1.22wmf3-1432152515','a:196:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:184;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:185;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:186;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:187;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:188;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:189;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:190;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:191;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:192;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:193;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:194;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:195;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432153186','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158612','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158618','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158621','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158961','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432159055','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432159302','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.25.2-14496139430','a:248:{i:0;a:1:{i:0;s:26:\"disableContentHandlerUseDB\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:2;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:3;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:4;a:1:{i:0;s:13:\"doIndexUpdate\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:18:\"new_name_timestamp\";i:3;s:21:\"patch-rc-newindex.sql\";}i:7;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:10;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:11;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:12;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:13;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:14;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:16;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:17;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:19;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:20;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:21;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:22;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:23;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:24;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:26;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:27;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:33;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:34;a:1:{i:0;s:15:\"doNamespaceSize\";}i:35;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:36;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:37;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:38;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:39;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:40;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:42;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:43;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:44;a:1:{i:0;s:15:\"doWatchlistNull\";}i:45;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:46;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:47;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:48;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:49;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:51;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:52;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:55;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:56;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:58;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:59;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:61;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:62;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:63;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:65;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:66;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:77;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:78;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:79;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:84;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:85;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:86;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:89;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:90;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:92;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:93;a:1:{i:0;s:18:\"doPopulateParentId\";}i:94;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:95;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:96;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:97;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:98;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:99;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:100;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"tag_summary\";i:2;s:21:\"patch-tag_summary.sql\";}i:103;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"valid_tag\";i:2;s:19:\"patch-valid_tag.sql\";}i:104;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:105;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:106;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:107;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:108;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:109;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:110;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:111;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:112;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:113;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:114;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:115;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:116;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:118;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:119;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:120;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:121;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:122;a:1:{i:0;s:17:\"doCollationUpdate\";}i:123;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:124;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:125;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:127;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:128;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:129;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:130;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:131;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:132;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:133;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:135;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:136;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:137;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:140;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:141;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:143;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:144;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:147;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:148;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:149;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:150;a:1:{i:0;s:25:\"enableContentHandlerUseDB\";}i:151;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:152;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:153;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:155;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:156;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:157;a:1:{i:0;s:17:\"doEnableProfiling\";}i:158;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:159;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:160;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:161;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:162;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:163;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:164;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:165;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:5:\"ar_id\";i:3;s:23:\"patch-archive-ar_id.sql\";}i:166;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"externallinks\";i:2;s:5:\"el_id\";i:3;s:29:\"patch-externallinks-el_id.sql\";}i:167;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:9:\"rc_source\";i:3;s:19:\"patch-rc_source.sql\";}i:168;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:23:\"log_user_text_type_time\";i:3;s:43:\"patch-logging_user_text_type_time_index.sql\";}i:169;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:18:\"log_user_text_time\";i:3;s:38:\"patch-logging_user_text_time_index.sql\";}i:170;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_links_updated\";i:3;s:28:\"patch-page_links_updated.sql\";}i:171;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:21:\"user_password_expires\";i:3;s:30:\"patch-user_password_expire.sql\";}i:172;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"page_props\";i:2;s:10:\"pp_sortkey\";i:3;s:20:\"patch-pp_sortkey.sql\";}i:173;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:11:\"rc_cur_time\";i:3;s:26:\"patch-drop-rc_cur_time.sql\";}i:174;a:4:{i:0;s:8:\"addIndex\";i:1;s:9:\"watchlist\";i:2;s:29:\"wl_user_notificationtimestamp\";i:3;s:52:\"patch-watchlist-user-notificationtimestamp-index.sql\";}i:175;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:9:\"page_lang\";i:3;s:19:\"patch-page_lang.sql\";}i:176;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"pagelinks\";i:2;s:17:\"pl_from_namespace\";i:3;s:27:\"patch-pl_from_namespace.sql\";}i:177;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"templatelinks\";i:2;s:17:\"tl_from_namespace\";i:3;s:27:\"patch-tl_from_namespace.sql\";}i:178;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"imagelinks\";i:2;s:17:\"il_from_namespace\";i:3;s:27:\"patch-il_from_namespace.sql\";}i:179;a:4:{i:0;s:11:\"modifyField\";i:1;s:5:\"image\";i:2;s:14:\"img_major_mime\";i:3;s:33:\"patch-img_major_mime-chemical.sql\";}i:180;a:4:{i:0;s:11:\"modifyField\";i:1;s:8:\"oldimage\";i:2;s:13:\"oi_major_mime\";i:3;s:32:\"patch-oi_major_mime-chemical.sql\";}i:181;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"filearchive\";i:2;s:13:\"fa_major_mime\";i:3;s:32:\"patch-fa_major_mime-chemical.sql\";}i:182;a:1:{i:0;s:27:\"doUserNewTalkUseridUnsigned\";}i:183;a:4:{i:0;s:11:\"modifyField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_comment\";i:3;s:28:\"patch-editsummary-length.sql\";}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:54:\"/var/www/WikiToLearn/extensions/Math/db/math.mysql.sql\";i:3;b:1;}i:185;a:4:{i:0;s:8:\"addTable\";i:1;s:7:\"mathoid\";i:2;s:57:\"/var/www/WikiToLearn/extensions/Math/db/mathoid.mysql.sql\";i:3;b:1;}i:186;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:53:\"/var/www/WikiToLearn/extensions/LiquidThreads/lqt.sql\";i:3;b:1;}i:187;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:85:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:188;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:92:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:189;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:190;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:191;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:85:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:85:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:193;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:83:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:83:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:196;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:197;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:85:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:199;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:85:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:85:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:76:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:202;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:82:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:203;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:204;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:81:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:205;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:83:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:206;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:84:\"/var/www/WikiToLearn/extensions/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:207;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:45:\"/var/www/WikiToLearn/extensions/Echo/echo.sql\";i:3;b:1;}i:208;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:68:\"/var/www/WikiToLearn/extensions/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:209;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_target_page\";i:2;s:68:\"/var/www/WikiToLearn/extensions/Echo/db_patches/echo_target_page.sql\";i:3;b:1;}i:210;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:75:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:211;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:83:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:212;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:74:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:213;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:77:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:214;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_target_page\";i:2;s:6:\"etp_id\";i:3;s:79:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-multiple_target_pages.sql\";i:4;b:1;}i:215;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:85:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:216;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:89:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:217;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:79:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:218;a:5:{i:0;s:8:\"addField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_page_id\";i:3;s:86:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-add-echo_event-event_page_id.sql\";i:4;b:1;}i:219;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:15:\"echo_event_type\";i:3;s:80:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-alter-event_type-index.sql\";i:4;b:1;}i:220;a:5:{i:0;s:8:\"addIndex\";i:1;s:17:\"echo_notification\";i:2;s:19:\"echo_user_timestamp\";i:3;s:84:\"/var/www/WikiToLearn/extensions/Echo/db_patches/patch-alter-user_timestamp-index.sql\";i:4;b:1;}i:221;a:4:{i:0;s:8:\"addTable\";i:1;s:13:\"flow_revision\";i:2;s:45:\"/var/www/WikiToLearn/extensions/Flow/flow.sql\";i:3;b:1;}i:222;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_revision\";i:2;s:16:\"rev_last_edit_id\";i:3;s:78:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-revision_last_editor.sql\";i:4;b:1;}i:223;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_revision\";i:2;s:14:\"rev_mod_reason\";i:3;s:75:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-moderation_reason.sql\";i:4;b:1;}i:224;a:5:{i:0;s:11:\"modifyField\";i:1;s:17:\"flow_subscription\";i:2;s:20:\"subscription_user_id\";i:3;s:78:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-subscription_user_id.sql\";i:4;b:1;}i:225;a:5:{i:0;s:11:\"modifyField\";i:1;s:21:\"flow_summary_revision\";i:2;s:19:\"summary_workflow_id\";i:3;s:72:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-summary2header.sql\";i:4;b:1;}i:226;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_revision\";i:2;s:11:\"rev_comment\";i:3;s:73:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-rev_change_type.sql\";i:4;b:1;}i:227;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_workflow\";i:2;s:11:\"workflow_id\";i:3;s:69:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-88bit_uuids.sql\";i:4;b:1;}i:228;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_workflow\";i:2;s:13:\"workflow_type\";i:3;s:75:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-add_workflow_type.sql\";i:4;b:1;}i:229;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_workflow\";i:2;s:16:\"workflow_user_id\";i:3;s:84:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-default_null_workflow_user.sql\";i:4;b:1;}i:230;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_workflow\";i:2;s:13:\"workflow_wiki\";i:3;s:84:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-increase_width_wiki_fields.sql\";i:4;b:1;}i:231;a:5:{i:0;s:8:\"addIndex\";i:1;s:13:\"flow_workflow\";i:2;s:20:\"flow_workflow_lookup\";i:3;s:77:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-workflow_lookup_idx.sql\";i:4;b:1;}i:232;a:5:{i:0;s:8:\"addIndex\";i:1;s:15:\"flow_topic_list\";i:2;s:24:\"flow_topic_list_topic_id\";i:3;s:81:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-topic_list_topic_id_idx.sql\";i:4;b:1;}i:233;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_revision\";i:2;s:15:\"rev_change_type\";i:3;s:80:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-rev_change_type_update.sql\";i:4;b:1;}i:234;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"recentchanges\";i:2;s:9:\"rc_source\";i:3;s:67:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-rc_source.sql\";i:4;b:1;}i:235;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_revision\";i:2;s:15:\"rev_change_type\";i:3;s:76:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-censor_to_suppress.sql\";i:4;b:1;}i:236;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_revision\";i:2;s:11:\"rev_user_ip\";i:3;s:74:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-remove_usernames.sql\";i:4;b:1;}i:237;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_revision\";i:2;s:13:\"rev_user_wiki\";i:3;s:66:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-add-wiki.sql\";i:4;b:1;}i:238;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flow_tree_revision\";i:2;s:27:\"flow_tree_descendant_rev_id\";i:3;s:75:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-flow_tree_idx_fix.sql\";i:4;b:1;}i:239;a:5:{i:0;s:9:\"dropField\";i:1;s:18:\"flow_tree_revision\";i:2;s:21:\"tree_orig_create_time\";i:3;s:79:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-tree_orig_create_time.sql\";i:4;b:1;}i:240;a:5:{i:0;s:8:\"addIndex\";i:1;s:13:\"flow_revision\";i:2;s:18:\"flow_revision_user\";i:3;s:75:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-revision_user_idx.sql\";i:4;b:1;}i:241;a:5:{i:0;s:11:\"modifyField\";i:1;s:13:\"flow_revision\";i:2;s:11:\"rev_user_ip\";i:3;s:74:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-revision_user_ip.sql\";i:4;b:1;}i:242;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_revision\";i:2;s:11:\"rev_type_id\";i:3;s:69:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-rev_type_id.sql\";i:4;b:1;}i:243;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flow_ext_ref\";i:2;s:73:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-add-linkstables.sql\";i:3;b:1;}i:244;a:4:{i:0;s:9:\"dropTable\";i:1;s:15:\"flow_definition\";i:2;s:73:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-drop_definition.sql\";i:3;b:1;}i:245;a:5:{i:0;s:9:\"dropField\";i:1;s:13:\"flow_workflow\";i:2;s:16:\"workflow_user_ip\";i:3;s:76:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-drop_workflow_user.sql\";i:4;b:1;}i:246;a:5:{i:0;s:8:\"addField\";i:1;s:13:\"flow_revision\";i:2;s:18:\"rev_content_length\";i:3;s:85:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-add-revision-content-length.sql\";i:4;b:1;}i:247;a:5:{i:0;s:8:\"addIndex\";i:1;s:12:\"flow_ext_ref\";i:2;s:16:\"flow_ext_ref_idx\";i:3;s:83:\"/var/www/WikiToLearn/extensions/Flow/db_patches/patch-remove_unique_ref_indices.sql\";i:4;b:1;}}'),('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql',NULL),('user_groups-ug_group-patch-ug_group-length-increase-255.sql',NULL),('user_properties-up_property-patch-up_property.sql',NULL);
/*!40000 ALTER TABLE `updatelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploadstash`
--

DROP TABLE IF EXISTS `uploadstash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uploadstash` (
  `us_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `us_user` int(10) unsigned NOT NULL,
  `us_key` varchar(255) NOT NULL,
  `us_orig_path` varchar(255) NOT NULL,
  `us_path` varchar(255) NOT NULL,
  `us_source_type` varchar(50) DEFAULT NULL,
  `us_timestamp` varbinary(14) NOT NULL,
  `us_status` varchar(50) NOT NULL,
  `us_chunk_inx` int(10) unsigned DEFAULT NULL,
  `us_props` blob,
  `us_size` int(10) unsigned NOT NULL,
  `us_sha1` varchar(31) NOT NULL,
  `us_mime` varchar(255) DEFAULT NULL,
  `us_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `us_image_width` int(10) unsigned DEFAULT NULL,
  `us_image_height` int(10) unsigned DEFAULT NULL,
  `us_image_bits` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE KEY `us_key` (`us_key`),
  KEY `us_user` (`us_user`),
  KEY `us_timestamp` (`us_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploadstash`
--

LOCK TABLES `uploadstash` WRITE;
/*!40000 ALTER TABLE `uploadstash` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploadstash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `user_real_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_newpass_time` binary(14) DEFAULT NULL,
  `user_email` tinytext NOT NULL,
  `user_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_email_authenticated` binary(14) DEFAULT NULL,
  `user_email_token` binary(32) DEFAULT NULL,
  `user_email_token_expires` binary(14) DEFAULT NULL,
  `user_registration` binary(14) DEFAULT NULL,
  `user_editcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_email_token` (`user_email_token`),
  KEY `user_email` (`user_email`(50))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_former_groups`
--

DROP TABLE IF EXISTS `user_former_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_former_groups` (
  `ufg_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ufg_group` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ufg_user_group` (`ufg_user`,`ufg_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_former_groups`
--

LOCK TABLES `user_former_groups` WRITE;
/*!40000 ALTER TABLE `user_former_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_former_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `ug_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ug_group` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ug_user_group` (`ug_user`,`ug_group`),
  KEY `ug_group` (`ug_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_message_state`
--

DROP TABLE IF EXISTS `user_message_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message_state` (
  `ums_user` int(10) unsigned NOT NULL,
  `ums_thread` int(8) unsigned NOT NULL,
  `ums_conversation` int(8) unsigned NOT NULL DEFAULT '0',
  `ums_read_timestamp` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`ums_user`,`ums_thread`),
  KEY `ums_user_conversation` (`ums_user`,`ums_conversation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_message_state`
--

LOCK TABLES `user_message_state` WRITE;
/*!40000 ALTER TABLE `user_message_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_message_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_newtalk`
--

DROP TABLE IF EXISTS `user_newtalk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_newtalk` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_ip` varbinary(40) NOT NULL DEFAULT '',
  `user_last_timestamp` varbinary(14) DEFAULT NULL,
  KEY `un_user_id` (`user_id`),
  KEY `un_user_ip` (`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_newtalk`
--

LOCK TABLES `user_newtalk` WRITE;
/*!40000 ALTER TABLE `user_newtalk` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_newtalk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_properties`
--

DROP TABLE IF EXISTS `user_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_properties` (
  `up_user` int(11) NOT NULL,
  `up_property` varbinary(255) NOT NULL,
  `up_value` blob,
  UNIQUE KEY `user_properties_user_property` (`up_user`,`up_property`),
  KEY `user_properties_property` (`up_property`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_properties`
--

LOCK TABLES `user_properties` WRITE;
/*!40000 ALTER TABLE `user_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valid_tag`
--

DROP TABLE IF EXISTS `valid_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valid_tag` (
  `vt_tag` varchar(255) NOT NULL,
  PRIMARY KEY (`vt_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valid_tag`
--

LOCK TABLES `valid_tag` WRITE;
/*!40000 ALTER TABLE `valid_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `valid_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchlist` (
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT '0',
  `wl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `wl_notificationtimestamp` varbinary(14) DEFAULT NULL,
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `namespace_title` (`wl_namespace`,`wl_title`),
  KEY `wl_user_notificationtimestamp` (`wl_user`,`wl_notificationtimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlist`
--

LOCK TABLES `watchlist` WRITE;
/*!40000 ALTER TABLE `watchlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-08 22:53:52

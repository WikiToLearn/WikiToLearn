-- MySQL dump 10.13  Distrib 5.6.23-72.1, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: enwikifm
-- ------------------------------------------------------
-- Server version	5.6.23-72.1

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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `archive` (
  `ar_namespace` int(11) NOT NULL DEFAULT '0',
  `ar_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ar_text` mediumblob NOT NULL,
  `ar_comment` tinyblob NOT NULL,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT '0',
  `cat_subcats` int(11) NOT NULL DEFAULT '0',
  `cat_files` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorylinks`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `categorylinks` (
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
/*!40000 ALTER TABLE `categorylinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_tag`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `change_tag` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `echo_email_batch` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `echo_event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `event_variant` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `event_agent_id` int(10) unsigned DEFAULT NULL,
  `event_agent_ip` varchar(39) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `event_page_namespace` int(10) unsigned DEFAULT NULL,
  `event_page_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `event_extra` blob,
  PRIMARY KEY (`event_id`),
  KEY `event_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `echo_event`
--

LOCK TABLES `echo_event` WRITE;
/*!40000 ALTER TABLE `echo_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `echo_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `echo_notification`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `echo_notification` (
  `notification_event` int(10) unsigned NOT NULL,
  `notification_user` int(10) unsigned NOT NULL,
  `notification_timestamp` binary(14) NOT NULL,
  `notification_read_timestamp` binary(14) DEFAULT NULL,
  `notification_bundle_base` tinyint(1) NOT NULL DEFAULT '1',
  `notification_bundle_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `notification_bundle_display_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  UNIQUE KEY `user_event` (`notification_user`,`notification_event`),
  KEY `user_timestamp` (`notification_user`,`notification_timestamp`),
  KEY `echo_notification_user_base_read_timestamp` (`notification_user`,`notification_bundle_base`,`notification_read_timestamp`),
  KEY `echo_notification_user_base_timestamp` (`notification_user`,`notification_bundle_base`,`notification_timestamp`,`notification_event`),
  KEY `echo_notification_user_hash_timestamp` (`notification_user`,`notification_bundle_hash`,`notification_timestamp`),
  KEY `echo_notification_user_hash_base_timestamp` (`notification_user`,`notification_bundle_display_hash`,`notification_bundle_base`,`notification_timestamp`)
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
-- Table structure for table `externallinks`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `externallinks` (
  `el_from` int(10) unsigned NOT NULL DEFAULT '0',
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `filearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `fa_archive_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted_reason` text,
  `fa_size` int(10) unsigned DEFAULT '0',
  `fa_width` int(11) DEFAULT '0',
  `fa_height` int(11) DEFAULT '0',
  `fa_metadata` mediumblob,
  `fa_bits` int(11) DEFAULT '0',
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart') DEFAULT 'unknown',
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description` tinyblob,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedimages` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedpage_config` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedpage_pending` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedpages` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedrevs` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedrevs_promote` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedrevs_statistics` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedrevs_tracking` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `flaggedtemplates` (
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
-- Table structure for table `historical_thread`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `historical_thread` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `hitcounter` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `image` (
  `img_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT '0',
  `img_width` int(11) NOT NULL DEFAULT '0',
  `img_height` int(11) NOT NULL DEFAULT '0',
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT '0',
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart') NOT NULL DEFAULT 'unknown',
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description` tinyblob NOT NULL,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `imagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT '0',
  `il_to` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  UNIQUE KEY `il_from` (`il_from`,`il_to`),
  UNIQUE KEY `il_to` (`il_to`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagelinks`
--

LOCK TABLES `imagelinks` WRITE;
/*!40000 ALTER TABLE `imagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interwiki`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `interwiki` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `ipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ipb_reason` tinyblob NOT NULL,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `iwlinks` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `job` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `l10n_cache`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `l10n_cache` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `langlinks` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `log_search` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `logging` (
  `log_type` varbinary(32) NOT NULL,
  `log_action` varbinary(32) NOT NULL,
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_user` int(10) unsigned NOT NULL DEFAULT '0',
  `log_namespace` int(11) NOT NULL DEFAULT '0',
  `log_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `log_comment` varchar(255) NOT NULL DEFAULT '',
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
  KEY `type_action` (`log_type`,`log_action`,`log_timestamp`)
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `math` (
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
-- Table structure for table `module_deps`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `module_deps` (
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
INSERT INTO `module_deps` VALUES ('ext.echo.base','neverland','[\"/srv/www/production/extensions-current/Echo/modules/base/DismissOnRowHover.png\",\"/srv/www/production/extensions-current/Echo/modules/base/DismissOnHover.png\"]'),('ext.echo.overlay','neverland','[\"/srv/www/production/extensions-current/Echo/modules/overlay/PokeyNorth.png\",\"/srv/www/production/extensions-current/Echo/modules/overlay/Help.png\",\"/srv/www/production/extensions-current/Echo/modules/overlay/../icons/NotificationsPage-ltr.png\",\"/srv/www/production/extensions-current/Echo/modules/overlay/../icons/Settings.png\"]'),('ext.flaggedRevs.basic','neverland','[\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/bar_20.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/bar_40.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/bar_60.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/bar_80.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/bar_100.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/fr-marker-20.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/fr-marker-40.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/fr-marker-60.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/fr-marker-80.png\",\"/srv/www/production/extensions-current/FlaggedRevs/frontend/modules/img/fr-marker-100.png\"]'),('ext.uls.displaysettings','neverland','[\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/display.png\",\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/display.svg\"]'),('ext.uls.init','neverland','[\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/cog-sprite.png\",\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/cog-sprite.svg\"]'),('ext.uls.inputsettings','neverland','{\"0\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/input.png\",\"1\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/input.svg\",\"4\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/cog-16x16-ltr.png\",\"5\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/cog.svg\"}'),('ext.uls.languagesettings','neverland','[\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/cog-16x16-ltr.png\",\"/srv/www/production/extensions-current/UniversalLanguageSelector/resources/css/../images/cog.svg\"]'),('jquery.ime','neverland','{\"0\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.ime/css/../images/ime-active.png\",\"2\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.ime/css/../images/tick.png\"}'),('jquery.tablesorter','neverland','[\"/srv/www/production/mediawiki-current//resources/jquery/images/sort_both.gif\",\"/srv/www/production/mediawiki-current//resources/jquery/images/sort_up.gif\",\"/srv/www/production/mediawiki-current//resources/jquery/images/sort_down.gif\"]'),('jquery.tipsy','neverland','[\"/srv/www/production/mediawiki-current//resources/jquery.tipsy/images/tipsy.png\"]'),('jquery.ui.core','neverland','{\"0\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_flat_75_ffffff_40x100.png\",\"1\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_highlight-soft_75_cccccc_1x100.png\",\"2\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_glass_75_e6e6e6_1x400.png\",\"3\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_glass_75_dadada_1x400.png\",\"4\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_glass_65_ffffff_1x400.png\",\"5\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_glass_55_fbf9ee_1x400.png\",\"6\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_glass_95_fef1ec_1x400.png\",\"7\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-icons_222222_256x240.png\",\"10\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-icons_888888_256x240.png\",\"11\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-icons_454545_256x240.png\",\"13\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-icons_2e83ff_256x240.png\",\"14\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-icons_cd0a0a_256x240.png\",\"15\":\"/srv/www/production/mediawiki-current//resources/jquery.ui/themes/default/images/ui-bg_flat_0_aaaaaa_40x100.png\"}'),('jquery.uls','neverland','{\"0\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/icon-language.png\",\"1\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/icon-language.svg\",\"4\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/world_map.png\",\"5\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/world_map.svg\",\"8\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/close.png\",\"9\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/close.svg\",\"12\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/search.png\",\"13\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/search.svg\",\"16\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/clear.png\",\"17\":\"/srv/www/production/extensions-current/UniversalLanguageSelector/lib/jquery.uls/css/../images/clear.svg\"}'),('jquery.wikiEditor','neverland','[\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/loading.gif\"]'),('jquery.wikiEditor.dialogs.config','neverland','[\"/srv/www/production/extensions-current/WikiEditor/modules/images/dialogs/insert-link-exists.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/dialogs/insert-link-notexists.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/dialogs/insert-link-invalid.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/dialogs/insert-link-external.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/dialogs/insert-link-external-rtl.png\"]'),('jquery.wikiEditor.toolbar','neverland','[\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/base.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/loading.gif\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/button-sprite.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/arrow-ltr.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/arrow-down.png\",\"/srv/www/production/extensions-current/WikiEditor/modules/images/toolbar/loading-small.gif\"]'),('mediawiki.legacy.shared','neverland','[\"/srv/www/production/mediawiki-current//skins/common/images/Checker-16x16.png\",\"/srv/www/production/mediawiki-current//skins/common/images/feed-icon.png\",\"/srv/www/production/mediawiki-current//skins/common/images/ajax-loader.gif\",\"/srv/www/production/mediawiki-current//skins/common/images/spinner.gif\",\"/srv/www/production/mediawiki-current//skins/common/images/help-question.gif\",\"/srv/www/production/mediawiki-current//skins/common/images/help-question-hover.gif\",\"/srv/www/production/mediawiki-current//skins/common/images/tipsy-arrow.gif\"]');
/*!40000 ALTER TABLE `module_deps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `msg_resource`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `msg_resource` (
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
INSERT INTO `msg_resource` VALUES ('ext.cite','en','{}','20150520215906'),('ext.echo.base','en','{\"cancel\":\"Cancel\",\"echo-dismiss-button\":\"Dismiss\",\"echo-error-preference\":\"Error: Could not set user preference\",\"echo-error-token\":\"Error: Could not retrieve user token\"}','20150520215906'),('ext.echo.overlay','en','{\"echo-link-new\":\"$1 new {{PLURAL:$1|notification|notifications}}\",\"echo-link\":\"Notifications\",\"echo-overlay-title\":\"\\u003Cb\\u003ENotifications\\u003C/b\\u003E\",\"echo-overlay-title-overflow\":\"\\u003Cb\\u003ENotifications\\u003C/b\\u003E (showing $1 of $2 unread)\",\"echo-overlay-link\":\"All notifications\",\"echo-none\":\"You have no notifications.\",\"echo-mark-all-as-read\":\"Mark all as read\",\"echo-more-info\":\"More info\",\"echo-feedback\":\"Feedback\"}','20150520215906'),('ext.flaggedRevs.advanced','en','{\"revreview-toggle-show\":\"(+)\",\"revreview-toggle-hide\":\"(-)\",\"revreview-diff-toggle-show\":\"show those changes\",\"revreview-diff-toggle-hide\":\"hide those changes\",\"revreview-log-toggle-show\":\"show stability log\",\"revreview-log-toggle-hide\":\"hide stability log\",\"revreview-log-details-show\":\"show details\",\"revreview-log-details-hide\":\"hide details\"}','20150520215906'),('ext.interwiki.specialpage','en','{}','20150520215911'),('ext.rtlcite','en','{}','20150520215906'),('ext.uls.displaysettings','en','{}','20150520215904'),('ext.uls.ime','en','{}','20150520215904'),('ext.uls.init','en','{}','20150520215904'),('ext.uls.inputsettings','en','{}','20150520215904'),('ext.uls.interface','en','{\"uls-plang-title-languages\":\"Languages\"}','20150520215904'),('ext.uls.languagenames','en','{}','20150520215904'),('ext.uls.languagesettings','en','{}','20150520215904'),('ext.uls.preferences','en','{}','20150520215904'),('ext.uls.webfonts','en','{}','20150520215904'),('ext.uls.webfonts.repository','en','{}','20150520215904'),('ext.wikiEditor','en','{}','20150520215924'),('ext.wikiEditor.dialogs','en','{}','20150520215924'),('ext.wikiEditor.preview','en','{\"wikieditor-preview-tab\":\"Preview\",\"wikieditor-preview-changes-tab\":\"Changes\",\"wikieditor-preview-loading\":\"Loading...\"}','20150520215924'),('ext.wikiEditor.toolbar','en','{}','20150520215924'),('ext.wikiEditor.toolbar.hideSig','en','{}','20150520215924'),('jquery.async','en','{}','20150520215923'),('jquery.autoEllipsis','en','{}','20150520215906'),('jquery.badge','en','{}','20150520215906'),('jquery.byteLength','en','{}','20150520215922'),('jquery.byteLimit','en','{}','20150520215922'),('jquery.checkboxShiftClick','en','{}','20150520215906'),('jquery.client','en','{}','20150520215904'),('jquery.cookie','en','{}','20150520215904'),('jquery.delayedBind','en','{}','20150520215923'),('jquery.hidpi','en','{}','20150520215906'),('jquery.highlightText','en','{}','20150520215906'),('jquery.i18n','en','{}','20150520215904'),('jquery.ime','en','{}','20150520215904'),('jquery.jStorage','en','{}','20150520215904'),('jquery.json','en','{}','20150520215904'),('jquery.makeCollapsible','en','{\"collapsible-expand\":\"Expand\",\"collapsible-collapse\":\"Collapse\"}','20150520215906'),('jquery.mw-jump','en','{}','20150520215906'),('jquery.mwExtension','en','{}','20150520215904'),('jquery.placeholder','en','{}','20150520215906'),('jquery.suggestions','en','{}','20150520215906'),('jquery.tabIndex','en','{}','20150520215923'),('jquery.tablesorter','en','{\"sort-descending\":\"Sort descending\",\"sort-ascending\":\"Sort ascending\"}','20150520215911'),('jquery.textSelection','en','{}','20150520215922'),('jquery.tipsy','en','{}','20150520215904'),('jquery.tooltip','en','{}','20150520215906'),('jquery.ui.button','en','{}','20150520215910'),('jquery.ui.core','en','{}','20150520215910'),('jquery.ui.dialog','en','{}','20150520215924'),('jquery.ui.draggable','en','{}','20150520215924'),('jquery.ui.mouse','en','{}','20150520215924'),('jquery.ui.position','en','{}','20150520215924'),('jquery.ui.resizable','en','{}','20150520215924'),('jquery.ui.widget','en','{}','20150520215910'),('jquery.uls','en','{}','20150520215904'),('jquery.uls.data','en','{}','20150520215904'),('jquery.uls.grid','en','{}','20150520215904'),('jquery.webfonts','en','{}','20150520215904'),('jquery.wikiEditor','en','{\"wikieditor-wikitext-tab\":\"Wikitext\",\"wikieditor-loading\":\"Loading...\"}','20150520215924'),('jquery.wikiEditor.dialogs','en','{}','20150520215924'),('jquery.wikiEditor.dialogs.config','en','{\"wikieditor-toolbar-tool-file-title\":\"Insert file\",\"wikieditor-toolbar-file-target\":\"Filename:\",\"wikieditor-toolbar-file-caption\":\"Caption:\",\"wikieditor-toolbar-file-size\":\"Size:\",\"wikieditor-toolbar-file-float\":\"Align:\",\"wikieditor-toolbar-file-default\":\"(default)\",\"wikieditor-toolbar-file-format-none\":\"none\",\"wikieditor-toolbar-file-format\":\"Format:\",\"wikieditor-toolbar-tool-file-insert\":\"Insert\",\"wikieditor-toolbar-tool-file-cancel\":\"Cancel\"}','20150520215924'),('jquery.wikiEditor.preview','en','{}','20150520215924'),('jquery.wikiEditor.toolbar','en','{}','20150520215924'),('jquery.wikiEditor.toolbar.config','en','{}','20150520215924'),('jquery.wikiEditor.toolbar.i18n','en','{\"wikieditor-toolbar-loading\":\"Loading...\",\"wikieditor-toolbar-tool-bold\":\"Bold\",\"wikieditor-toolbar-tool-bold-example\":\"Bold text\",\"wikieditor-toolbar-tool-italic\":\"Italic\",\"wikieditor-toolbar-tool-italic-example\":\"Italic text\",\"wikieditor-toolbar-tool-ilink\":\"Internal link\",\"wikieditor-toolbar-tool-ilink-example\":\"Link title\",\"wikieditor-toolbar-tool-xlink\":\"External link (remember http:// prefix)\",\"wikieditor-toolbar-tool-xlink-example\":\"http://www.example.com link title\",\"wikieditor-toolbar-tool-link\":\"Link\",\"wikieditor-toolbar-tool-link-title\":\"Insert link\",\"wikieditor-toolbar-tool-link-int\":\"To a wiki page\",\"wikieditor-toolbar-tool-link-int-target\":\"Target page or URL:\",\"wikieditor-toolbar-tool-link-int-target-tooltip\":\"Page title or URL\",\"wikieditor-toolbar-tool-link-int-text\":\"Text to display:\",\"wikieditor-toolbar-tool-link-int-text-tooltip\":\"Text to be displayed\",\"wikieditor-toolbar-tool-link-ext\":\"To an external web page\",\"wikieditor-toolbar-tool-link-ext-target\":\"Link URL:\",\"wikieditor-toolbar-tool-link-ext-text\":\"Link text:\",\"wikieditor-toolbar-tool-link-insert\":\"Insert link\",\"wikieditor-toolbar-tool-link-cancel\":\"Cancel\",\"wikieditor-toolbar-tool-link-int-target-status-exists\":\"Page exists\",\"wikieditor-toolbar-tool-link-int-target-status-notexists\":\"Page does not exist\",\"wikieditor-toolbar-tool-link-int-target-status-invalid\":\"Invalid title\",\"wikieditor-toolbar-tool-link-int-target-status-external\":\"External link\",\"wikieditor-toolbar-tool-link-int-target-status-loading\":\"Checking page existence...\",\"wikieditor-toolbar-tool-link-int-invalid\":\"The title you specified is invalid.\",\"wikieditor-toolbar-tool-link-lookslikeinternal\":\"The URL you specified looks like it was intended as a link to another wiki page.\\nDo you want to make it an internal link?\",\"wikieditor-toolbar-tool-link-lookslikeinternal-int\":\"Internal link\",\"wikieditor-toolbar-tool-link-lookslikeinternal-ext\":\"External link\",\"wikieditor-toolbar-tool-link-empty\":\"You did not enter anything to link to.\",\"wikieditor-toolbar-tool-file\":\"Embedded file\",\"wikieditor-toolbar-tool-file-example\":\"Example.jpg\",\"wikieditor-toolbar-tool-file-pre\":\"\\u003Cwikieditor-toolbar-tool-file-pre\\u003E\",\"wikieditor-toolbar-tool-reference\":\"Reference\",\"wikieditor-toolbar-tool-reference-title\":\"Insert reference\",\"wikieditor-toolbar-tool-reference-cancel\":\"Cancel\",\"wikieditor-toolbar-tool-reference-text\":\"Reference text\",\"wikieditor-toolbar-tool-reference-insert\":\"Insert\",\"wikieditor-toolbar-tool-reference-example\":\"Insert footnote text here\",\"wikieditor-toolbar-tool-signature\":\"Signature and timestamp\",\"wikieditor-toolbar-section-advanced\":\"Advanced\",\"wikieditor-toolbar-tool-heading\":\"Heading\",\"wikieditor-toolbar-tool-heading-1\":\"Level 1\",\"wikieditor-toolbar-tool-heading-2\":\"Level 2\",\"wikieditor-toolbar-tool-heading-3\":\"Level 3\",\"wikieditor-toolbar-tool-heading-4\":\"Level 4\",\"wikieditor-toolbar-tool-heading-5\":\"Level 5\",\"wikieditor-toolbar-tool-heading-example\":\"Heading text\",\"wikieditor-toolbar-group-format\":\"Format\",\"wikieditor-toolbar-tool-ulist\":\"Bulleted list\",\"wikieditor-toolbar-tool-ulist-example\":\"Bulleted list item\",\"wikieditor-toolbar-tool-olist\":\"Numbered list\",\"wikieditor-toolbar-tool-olist-example\":\"Numbered list item\",\"wikieditor-toolbar-tool-indent\":\"Indentation\",\"wikieditor-toolbar-tool-indent-example\":\"Indented line\",\"wikieditor-toolbar-tool-nowiki\":\"No wiki formatting\",\"wikieditor-toolbar-tool-nowiki-example\":\"Insert non-formatted text here\",\"wikieditor-toolbar-tool-redirect\":\"Redirect\",\"wikieditor-toolbar-tool-redirect-example\":\"Target page name\",\"wikieditor-toolbar-tool-big\":\"Big\",\"wikieditor-toolbar-tool-big-example\":\"Big text\",\"wikieditor-toolbar-tool-small\":\"Small\",\"wikieditor-toolbar-tool-small-example\":\"Small text\",\"wikieditor-toolbar-tool-superscript\":\"Superscript\",\"wikieditor-toolbar-tool-superscript-example\":\"Superscript text\",\"wikieditor-toolbar-tool-subscript\":\"Subscript\",\"wikieditor-toolbar-tool-subscript-example\":\"Subscript text\",\"wikieditor-toolbar-group-insert\":\"Insert\",\"wikieditor-toolbar-tool-gallery\":\"Picture gallery\",\"wikieditor-toolbar-tool-gallery-example\":\"$1:Example.jpg|Caption1\\n$1:Example.jpg|Caption2\",\"wikieditor-toolbar-tool-newline\":\"New line\",\"wikieditor-toolbar-tool-table\":\"Table\",\"wikieditor-toolbar-tool-table-example-old\":\"-\\n! header 1\\n! header 2\\n! header 3\\n|-\\n| row 1, cell 1\\n| row 1, cell 2\\n| row 1, cell 3\\n|-\\n| row 2, cell 1\\n| row 2, cell 2\\n| row 2, cell 3\",\"wikieditor-toolbar-tool-table-example-cell-text\":\"Cell text\",\"wikieditor-toolbar-tool-table-example\":\"Example\",\"wikieditor-toolbar-tool-table-example-header\":\"Header text\",\"wikieditor-toolbar-tool-table-title\":\"Insert table\",\"wikieditor-toolbar-tool-table-dimensions-rows\":\"Rows\",\"wikieditor-toolbar-tool-table-dimensions-columns\":\"Columns\",\"wikieditor-toolbar-tool-table-dimensions-header\":\"Add header row\",\"wikieditor-toolbar-tool-table-wikitable\":\"Style with borders\",\"wikieditor-toolbar-tool-table-sortable\":\"Make table sortable\",\"wikieditor-toolbar-tool-table-insert\":\"Insert\",\"wikieditor-toolbar-tool-table-cancel\":\"Cancel\",\"wikieditor-toolbar-tool-table-example-text\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut nec purus diam. Sed aliquam imperdiet nunc quis lacinia. Donec rutrum consectetur placerat. Sed volutpat neque non purus faucibus id ultricies enim euismod.\",\"wikieditor-toolbar-tool-table-toomany\":\"Inserting a table with more than 1000 cells is not possible with this dialog.\",\"wikieditor-toolbar-tool-table-invalidnumber\":\"You have not entered a valid number of rows or columns.\",\"wikieditor-toolbar-tool-table-zero\":\"You cannot insert a table with zero rows or columns.\",\"wikieditor-toolbar-tool-replace\":\"Search and replace\",\"wikieditor-toolbar-tool-replace-title\":\"Search and replace\",\"wikieditor-toolbar-tool-replace-search\":\"Search for:\",\"wikieditor-toolbar-tool-replace-replace\":\"Replace with:\",\"wikieditor-toolbar-tool-replace-case\":\"Match case\",\"wikieditor-toolbar-tool-replace-regex\":\"Treat search string as a regular expression\",\"wikieditor-toolbar-tool-replace-button-findnext\":\"Find next\",\"wikieditor-toolbar-tool-replace-button-replace\":\"Replace\",\"wikieditor-toolbar-tool-replace-button-replaceall\":\"Replace all\",\"wikieditor-toolbar-tool-replace-close\":\"Close\",\"wikieditor-toolbar-tool-replace-nomatch\":\"Your search did not match anything.\",\"wikieditor-toolbar-tool-replace-success\":\"$1 {{PLURAL:$1|replacement|replacements}} made.\",\"wikieditor-toolbar-tool-replace-emptysearch\":\"You did not enter anything to search for.\",\"wikieditor-toolbar-tool-replace-invalidregex\":\"The regular expression you entered is invalid: $1\",\"wikieditor-toolbar-section-characters\":\"Special characters\",\"wikieditor-toolbar-characters-page-latin\":\"Latin\",\"wikieditor-toolbar-characters-page-latinextended\":\"Latin extended\",\"wikieditor-toolbar-characters-page-ipa\":\"IPA\",\"wikieditor-toolbar-characters-page-symbols\":\"Symbols\",\"wikieditor-toolbar-characters-page-greek\":\"Greek\",\"wikieditor-toolbar-characters-page-cyrillic\":\"Cyrillic\",\"wikieditor-toolbar-characters-page-arabic\":\"Arabic\",\"wikieditor-toolbar-characters-page-arabicextended\":\"Arabic extended\",\"wikieditor-toolbar-characters-page-persian\":\"Persian\",\"wikieditor-toolbar-characters-page-hebrew\":\"Hebrew\",\"wikieditor-toolbar-characters-page-bangla\":\"Bangla\",\"wikieditor-toolbar-characters-page-tamil\":\"Tamil\",\"wikieditor-toolbar-characters-page-telugu\":\"Telugu\",\"wikieditor-toolbar-characters-page-sinhala\":\"Sinhala\",\"wikieditor-toolbar-characters-page-devanagari\":\"Devanagari\",\"wikieditor-toolbar-characters-page-gujarati\":\"Gujarati\",\"wikieditor-toolbar-characters-page-thai\":\"Thai\",\"wikieditor-toolbar-characters-page-lao\":\"Lao\",\"wikieditor-toolbar-characters-page-khmer\":\"Khmer\",\"wikieditor-toolbar-characters-endash\":\"en dash\",\"wikieditor-toolbar-characters-emdash\":\"em dash\",\"wikieditor-toolbar-characters-minus\":\"minus sign\",\"wikieditor-toolbar-section-help\":\"Help\",\"wikieditor-toolbar-help-heading-description\":\"Description\",\"wikieditor-toolbar-help-heading-syntax\":\"What you type\",\"wikieditor-toolbar-help-heading-result\":\"What you get\",\"wikieditor-toolbar-help-page-format\":\"Formatting\",\"wikieditor-toolbar-help-page-link\":\"Links\",\"wikieditor-toolbar-help-page-heading\":\"Headings\",\"wikieditor-toolbar-help-page-list\":\"Lists\",\"wikieditor-toolbar-help-page-file\":\"Files\",\"wikieditor-toolbar-help-page-reference\":\"References\",\"wikieditor-toolbar-help-page-discussion\":\"Discussion\",\"wikieditor-toolbar-help-content-bold-description\":\"Bold\",\"wikieditor-toolbar-help-content-bold-syntax\":\"\'\'\'Bold text\'\'\'\",\"wikieditor-toolbar-help-content-bold-result\":\"\\u003Cstrong\\u003EBold text\\u003C/strong\\u003E\",\"wikieditor-toolbar-help-content-italic-description\":\"Italic\",\"wikieditor-toolbar-help-content-italic-syntax\":\"\'\'Italic text\'\'\",\"wikieditor-toolbar-help-content-italic-result\":\"\\u003Cem\\u003EItalic text\\u003C/em\\u003E\",\"wikieditor-toolbar-help-content-bolditalic-description\":\"Bold \\u0026amp; italic\",\"wikieditor-toolbar-help-content-bolditalic-syntax\":\"\'\'\'\'\'Bold \\u0026amp; italic text\'\'\'\'\'\",\"wikieditor-toolbar-help-content-bolditalic-result\":\"\\u003Cstrong\\u003E\\u003Cem\\u003EBold \\u0026amp; italic text\\u003C/em\\u003E\\u003C/strong\\u003E\",\"wikieditor-toolbar-help-content-ilink-description\":\"Internal link\",\"wikieditor-toolbar-help-content-ilink-syntax\":\"[[Page title|Link label]]\\u003Cbr /\\u003E[[Page title]]\",\"wikieditor-toolbar-help-content-ilink-result\":\"\\u003Ca href=\'#\'\\u003ELink label\\u003C/a\\u003E\\u003Cbr /\\u003E\\u003Ca href=\'#\'\\u003EPage title\\u003C/a\\u003E\",\"wikieditor-toolbar-help-content-xlink-description\":\"External link\",\"wikieditor-toolbar-help-content-xlink-syntax\":\"[http://www.example.org Link label]\\u003Cbr /\\u003E[http://www.example.org]\\u003Cbr /\\u003Ehttp://www.example.org\",\"wikieditor-toolbar-help-content-xlink-result\":\"\\u003Ca href=\'#\' class=\'external\'\\u003ELink label\\u003C/a\\u003E\\u003Cbr /\\u003E\\u003Ca href=\'#\' class=\'external autonumber\'\\u003E[1]\\u003C/a\\u003E\\u003Cbr /\\u003E\\u003Ca href=\'#\' class=\'external\'\\u003Ehttp://www.example.org\\u003C/a\\u003E\",\"wikieditor-toolbar-help-content-heading1-description\":\"\\u003Cwikieditor-toolbar-help-content-heading1-description\\u003E\",\"wikieditor-toolbar-help-content-heading1-syntax\":\"\\u003Cwikieditor-toolbar-help-content-heading1-syntax\\u003E\",\"wikieditor-toolbar-help-content-heading1-result\":\"\\u003Cwikieditor-toolbar-help-content-heading1-result\\u003E\",\"wikieditor-toolbar-help-content-heading2-description\":\"2nd level heading\",\"wikieditor-toolbar-help-content-heading2-syntax\":\"== Heading text ==\",\"wikieditor-toolbar-help-content-heading2-result\":\"\\u003Ch2\\u003EHeading text\\u003C/h2\\u003E\",\"wikieditor-toolbar-help-content-heading3-description\":\"3rd level heading\",\"wikieditor-toolbar-help-content-heading3-syntax\":\"=== Heading text ===\",\"wikieditor-toolbar-help-content-heading3-result\":\"\\u003Ch3\\u003EHeading text\\u003C/h3\\u003E\",\"wikieditor-toolbar-help-content-heading4-description\":\"4th level heading\",\"wikieditor-toolbar-help-content-heading4-syntax\":\"==== Heading text ====\",\"wikieditor-toolbar-help-content-heading4-result\":\"\\u003Ch4\\u003EHeading text\\u003C/h4\\u003E\",\"wikieditor-toolbar-help-content-heading5-description\":\"5th level heading\",\"wikieditor-toolbar-help-content-heading5-syntax\":\"===== Heading text =====\",\"wikieditor-toolbar-help-content-heading5-result\":\"\\u003Ch5\\u003EHeading text\\u003C/h5\\u003E\",\"wikieditor-toolbar-help-content-ulist-description\":\"Bulleted list\",\"wikieditor-toolbar-help-content-ulist-syntax\":\"* List item\\u003Cbr /\\u003E* List item\",\"wikieditor-toolbar-help-content-ulist-result\":\"\\u003Cul\\u003E\\u003Cli\\u003EList item\\u003C/li\\u003E\\u003Cli\\u003EList item\\u003C/li\\u003E\\u003C/ul\\u003E\",\"wikieditor-toolbar-help-content-olist-description\":\"Numbered list\",\"wikieditor-toolbar-help-content-olist-syntax\":\"# List item\\u003Cbr /\\u003E# List item\",\"wikieditor-toolbar-help-content-olist-result\":\"\\u003Col\\u003E\\u003Cli\\u003EList item\\u003C/li\\u003E\\u003Cli\\u003EList item\\u003C/li\\u003E\\u003C/ol\\u003E\",\"wikieditor-toolbar-help-content-file-description\":\"Embedded file\",\"wikieditor-toolbar-help-content-file-syntax\":\"[[$1:Example.png|thumb|Caption text]]\",\"wikieditor-toolbar-help-content-file-result\":\"\\u003Cdiv style=\'width:104px;\' class=\'thumbinner\'\\u003E\\u003Ca title=\'Caption text\' class=\'image\' href=\'#\'\\u003E\\u003Cimg height=\'50\' width=\'100\' border=\'0\' class=\'thumbimage\' src=\'$2/WikiEditor/modules/images/toolbar/example-image.png\' alt=\'\'/\\u003E\\u003C/a\\u003E\\u003Cdiv class=\'thumbcaption\'\\u003E\\u003Cdiv class=\'magnify\'\\u003E\\u003Ca title=\'Enlarge\' class=\'internal\' href=\'#\'\\u003E\\u003Cimg height=\'11\' width=\'15\' alt=\'\' src=\'$1/common/images/magnify-clip.png\'/\\u003E\\u003C/a\\u003E\\u003C/div\\u003ECaption text\\u003C/div\\u003E\\u003C/div\\u003E\",\"wikieditor-toolbar-help-content-reference-description\":\"Reference\",\"wikieditor-toolbar-help-content-reference-syntax\":\"Page text.\\u0026lt;ref name=\\\"test\\\"\\u0026gt;[http://www.example.org Link text], additional text.\\u0026lt;/ref\\u0026gt;\",\"wikieditor-toolbar-help-content-reference-result\":\"Page text.\\u003Csup\\u003E\\u003Ca href=\'#\'\\u003E[1]\\u003C/a\\u003E\\u003C/sup\\u003E\",\"wikieditor-toolbar-help-content-rereference-description\":\"Additional use of same reference\",\"wikieditor-toolbar-help-content-rereference-syntax\":\"\\u0026lt;ref name=\\\"test\\\" /\\u0026gt;\",\"wikieditor-toolbar-help-content-rereference-result\":\"Page text.\\u003Csup\\u003E\\u003Ca href=\'#\'\\u003E[1]\\u003C/a\\u003E\\u003C/sup\\u003E\",\"wikieditor-toolbar-help-content-showreferences-description\":\"Display references\",\"wikieditor-toolbar-help-content-showreferences-syntax\":\"\\u0026lt;references /\\u0026gt;\",\"wikieditor-toolbar-help-content-showreferences-result\":\"\\u003Col class=\'references\'\\u003E\\u003Cli id=\'cite_note-test-0\'\\u003E\\u003Cb\\u003E\\u003Ca title=\'\' href=\'#\'\\u003E^\\u003C/a\\u003E\\u003C/b\\u003E \\u003Ca rel=\'nofollow\' title=\'http://www.example.org\' class=\'external text\' href=\'#\'\\u003ELink text\\u003C/a\\u003E, additional text.\\u003C/li\\u003E\\u003C/ol\\u003E\",\"wikieditor-toolbar-help-content-signaturetimestamp-description\":\"Signature with timestamp\",\"wikieditor-toolbar-help-content-signaturetimestamp-syntax\":\"~~~~\",\"wikieditor-toolbar-help-content-signaturetimestamp-result\":\"\\u003Ca href=\'#\' title=\'{{#special:mypage}}\'\\u003EUsername\\u003C/a\\u003E (\\u003Ca href=\'#\' title=\'{{#special:mytalk}}\'\\u003Etalk\\u003C/a\\u003E) 15:54, 10 June 2009 (UTC)\",\"wikieditor-toolbar-help-content-signature-description\":\"Signature\",\"wikieditor-toolbar-help-content-signature-syntax\":\"~~~\",\"wikieditor-toolbar-help-content-signature-result\":\"\\u003Ca href=\'#\' title=\'{{#special:mypage}}\'\\u003EUsername\\u003C/a\\u003E (\\u003Ca href=\'#\' title=\'{{#special:mytalk}}\'\\u003Etalk\\u003C/a\\u003E)\",\"wikieditor-toolbar-help-content-indent-description\":\"Indent\",\"wikieditor-toolbar-help-content-indent-syntax\":\"Normal text\\u003Cbr /\\u003E:Indented text\\u003Cbr /\\u003E::Indented text\",\"wikieditor-toolbar-help-content-indent-result\":\"Normal text\\u003Cdl\\u003E\\u003Cdd\\u003EIndented text\\u003Cdl\\u003E\\u003Cdd\\u003EIndented text\\u003C/dd\\u003E\\u003C/dl\\u003E\\u003C/dd\\u003E\\u003C/dl\\u003E\"}','20150520215924'),('mediawiki.Title','en','{}','20150520215923'),('mediawiki.Uri','en','{}','20150520215904'),('mediawiki.action.edit','en','{}','20150520215922'),('mediawiki.action.edit.editWarning','en','{\"editwarning-warning\":\"Leaving this page may cause you to lose any changes you have made.\\nIf you are logged in, you can disable this warning in the \\\"Editing\\\" section of your preferences.\"}','20150520215923'),('mediawiki.action.view.postEdit','en','{}','20150520220034'),('mediawiki.api','en','{}','20150520215904'),('mediawiki.api.parse','en','{}','20150520215904'),('mediawiki.api.watch','en','{}','20150520215906'),('mediawiki.cldr','en','{}','20150520215906'),('mediawiki.hidpi','en','{}','20150520215906'),('mediawiki.jqueryMsg','en','{}','20150520215906'),('mediawiki.language','en','{}','20150520215906'),('mediawiki.language.data','en','{}','20150520215906'),('mediawiki.language.init','en','{}','20150520215906'),('mediawiki.legacy.ajax','en','{}','20150520215904'),('mediawiki.legacy.wikibits','en','{}','20150520215904'),('mediawiki.libs.pluralruleparser','en','{}','20150520215906'),('mediawiki.notify','en','{}','20150520215904'),('mediawiki.page.ready','en','{}','20150520215906'),('mediawiki.page.startup','en','{}','20150520215904'),('mediawiki.page.watch.ajax','en','{\"watch\":\"Watch\",\"unwatch\":\"Unwatch\",\"watching\":\"Watching...\",\"unwatching\":\"Unwatching...\",\"tooltip-ca-watch\":\"Add this page to your watchlist\",\"tooltip-ca-unwatch\":\"Remove this page from your watchlist\",\"watcherrortext\":\"An error occurred while changing your watchlist settings for \\\"$1\\\".\"}','20150520215906'),('mediawiki.searchSuggest','en','{\"searchsuggest-search\":\"Search\",\"searchsuggest-containing\":\"containing...\"}','20150520215906'),('mediawiki.ui','en','{}','20150520215906'),('mediawiki.user','en','{}','20150520215904'),('mediawiki.util','en','{\"showtoc\":\"show\",\"hidetoc\":\"hide\"}','20150520215904'),('user.options','en','{}','20150520215902'),('user.tokens','en','{}','20150520215902');
/*!40000 ALTER TABLE `msg_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `msg_resource_links`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `msg_resource_links` (
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
INSERT INTO `msg_resource_links` VALUES ('ext.echo.base','cancel'),('jquery.makeCollapsible','collapsible-collapse'),('jquery.makeCollapsible','collapsible-expand'),('ext.echo.base','echo-dismiss-button'),('ext.echo.base','echo-error-preference'),('ext.echo.base','echo-error-token'),('ext.echo.overlay','echo-feedback'),('ext.echo.overlay','echo-link'),('ext.echo.overlay','echo-link-new'),('ext.echo.overlay','echo-mark-all-as-read'),('ext.echo.overlay','echo-more-info'),('ext.echo.overlay','echo-none'),('ext.echo.overlay','echo-overlay-link'),('ext.echo.overlay','echo-overlay-title'),('ext.echo.overlay','echo-overlay-title-overflow'),('mediawiki.action.edit.editWarning','editwarning-warning'),('mediawiki.util','hidetoc'),('ext.flaggedRevs.advanced','revreview-diff-toggle-hide'),('ext.flaggedRevs.advanced','revreview-diff-toggle-show'),('ext.flaggedRevs.advanced','revreview-log-details-hide'),('ext.flaggedRevs.advanced','revreview-log-details-show'),('ext.flaggedRevs.advanced','revreview-log-toggle-hide'),('ext.flaggedRevs.advanced','revreview-log-toggle-show'),('ext.flaggedRevs.advanced','revreview-toggle-hide'),('ext.flaggedRevs.advanced','revreview-toggle-show'),('mediawiki.searchSuggest','searchsuggest-containing'),('mediawiki.searchSuggest','searchsuggest-search'),('mediawiki.util','showtoc'),('jquery.tablesorter','sort-ascending'),('jquery.tablesorter','sort-descending'),('mediawiki.page.watch.ajax','tooltip-ca-unwatch'),('mediawiki.page.watch.ajax','tooltip-ca-watch'),('ext.uls.interface','uls-plang-title-languages'),('mediawiki.page.watch.ajax','unwatch'),('mediawiki.page.watch.ajax','unwatching'),('mediawiki.page.watch.ajax','watch'),('mediawiki.page.watch.ajax','watcherrortext'),('mediawiki.page.watch.ajax','watching'),('jquery.wikiEditor','wikieditor-loading'),('ext.wikiEditor.preview','wikieditor-preview-changes-tab'),('ext.wikiEditor.preview','wikieditor-preview-loading'),('ext.wikiEditor.preview','wikieditor-preview-tab'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-emdash'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-endash'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-minus'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-arabic'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-arabicextended'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-bangla'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-cyrillic'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-devanagari'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-greek'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-gujarati'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-hebrew'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-ipa'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-khmer'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-lao'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-latin'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-latinextended'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-persian'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-sinhala'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-symbols'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-tamil'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-telugu'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-characters-page-thai'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-caption'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-default'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-float'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-format'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-format-none'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-size'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-file-target'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-group-format'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-group-insert'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-bold-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-bold-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-bold-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-bolditalic-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-bolditalic-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-bolditalic-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-file-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-file-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-file-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading1-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading1-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading1-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading2-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading2-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading2-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading3-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading3-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading3-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading4-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading4-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading4-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading5-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading5-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-heading5-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-ilink-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-ilink-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-ilink-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-indent-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-indent-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-indent-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-italic-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-italic-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-italic-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-olist-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-olist-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-olist-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-reference-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-reference-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-reference-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-rereference-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-rereference-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-rereference-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-showreferences-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-showreferences-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-showreferences-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-signature-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-signature-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-signature-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-signaturetimestamp-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-signaturetimestamp-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-signaturetimestamp-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-ulist-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-ulist-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-ulist-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-xlink-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-xlink-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-content-xlink-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-heading-description'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-heading-result'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-heading-syntax'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-discussion'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-file'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-format'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-heading'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-link'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-list'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-help-page-reference'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-loading'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-section-advanced'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-section-characters'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-section-help'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-big'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-big-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-bold'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-bold-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-file'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-tool-file-cancel'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-file-example'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-tool-file-insert'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-file-pre'),('jquery.wikiEditor.dialogs.config','wikieditor-toolbar-tool-file-title'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-gallery'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-gallery-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading-1'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading-2'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading-3'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading-4'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading-5'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-heading-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-ilink'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-ilink-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-indent'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-indent-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-italic'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-italic-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-cancel'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-empty'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-ext'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-ext-target'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-ext-text'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-insert'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-invalid'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target-status-exists'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target-status-external'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target-status-invalid'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target-status-loading'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target-status-notexists'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-target-tooltip'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-text'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-int-text-tooltip'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-lookslikeinternal'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-lookslikeinternal-ext'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-lookslikeinternal-int'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-link-title'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-newline'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-nowiki'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-nowiki-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-olist'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-olist-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-redirect'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-redirect-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-reference'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-reference-cancel'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-reference-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-reference-insert'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-reference-text'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-reference-title'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-button-findnext'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-button-replace'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-button-replaceall'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-case'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-close'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-emptysearch'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-invalidregex'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-nomatch'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-regex'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-replace'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-search'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-success'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-replace-title'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-signature'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-small'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-small-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-subscript'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-subscript-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-superscript'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-superscript-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-cancel'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-dimensions-columns'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-dimensions-header'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-dimensions-rows'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-example-cell-text'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-example-header'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-example-old'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-example-text'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-insert'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-invalidnumber'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-sortable'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-title'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-toomany'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-wikitable'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-table-zero'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-ulist'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-ulist-example'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-xlink'),('jquery.wikiEditor.toolbar.i18n','wikieditor-toolbar-tool-xlink-example'),('jquery.wikiEditor','wikieditor-wikitext-tab');
/*!40000 ALTER TABLE `msg_resource_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objectcache`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `objectcache` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `oldimage` (
  `oi_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `oi_archive_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_width` int(11) NOT NULL DEFAULT '0',
  `oi_height` int(11) NOT NULL DEFAULT '0',
  `oi_bits` int(11) NOT NULL DEFAULT '0',
  `oi_description` tinyblob NOT NULL,
  `oi_user` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `oi_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart') NOT NULL DEFAULT 'unknown',
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `page` (
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
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,0,'Main_Page','',8,0,0,0.835027575799,'20150520220536',2,98,'wikitext');
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_props`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `page_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  PRIMARY KEY (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`)
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `page_restrictions` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `pagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `pl_namespace` int(11) NOT NULL DEFAULT '0',
  `pl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  UNIQUE KEY `pl_from` (`pl_from`,`pl_namespace`,`pl_title`),
  UNIQUE KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagelinks`
--

LOCK TABLES `pagelinks` WRITE;
/*!40000 ALTER TABLE `pagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protected_titles`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `protected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason` tinyblob,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `querycache` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `querycache_info` (
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
/*!40000 ALTER TABLE `querycache_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycachetwo`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `querycachetwo` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `recentchanges` (
  `rc_id` int(11) NOT NULL AUTO_INCREMENT,
  `rc_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `rc_cur_time` varbinary(14) NOT NULL DEFAULT '',
  `rc_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_user_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `rc_namespace` int(11) NOT NULL,
  `rc_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `rc_comment` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
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
INSERT INTO `recentchanges` VALUES (1,'20150520220031','20150520220031',6,'Roopi',0,'Main_Page','Created page with \"Knowledge only grows if shared.  Page under construction - please see [[it:Pagina principale]]\"',0,0,1,1,1,0,1,0,'93.50.167.127',0,94,0,0,NULL,'',''),(2,'20150520220536','20150520220536',6,'Roopi',0,'Main_Page','',0,0,0,1,2,1,0,0,'93.50.167.127',94,98,0,0,NULL,'','');
/*!40000 ALTER TABLE `recentchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redirect`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `redirect` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `revision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_text_id` int(10) unsigned NOT NULL,
  `rev_comment` tinyblob NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=1024;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision`
--

LOCK TABLES `revision` WRITE;
/*!40000 ALTER TABLE `revision` DISABLE KEYS */;
INSERT INTO `revision` VALUES (1,1,1,'Created page with \"Knowledge only grows if shared.  Page under construction - please see [[it:Pagina principale]]\"',6,'Roopi','20150520220031',0,0,94,0,'hjk5u4otz9hw1uqcs9zpakvdwciw6nb',NULL,NULL),(2,1,2,'',6,'Roopi','20150520220536',0,0,98,1,'7d4lk50m99vabfrqc7j4tmuixa4ad50',NULL,NULL);
/*!40000 ALTER TABLE `revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `searchindex` (
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
INSERT INTO `searchindex` VALUES (1,'main page',' knowledge only grows ifu800 shared. page under construction - please seeu800 itu800 pagina principale '),(1,'main page',' knowledge only grows ifu800 shared. page under construction - please seeu800 itwiki pagina principale ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_identifiers`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `site_identifiers` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `site_stats` (
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
INSERT INTO `site_stats` VALUES (1,NULL,2,0,1,158,0,0);
/*!40000 ALTER TABLE `site_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `sites` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `tag_summary` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `templatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `tl_namespace` int(11) NOT NULL DEFAULT '0',
  `tl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  UNIQUE KEY `tl_from` (`tl_from`,`tl_namespace`,`tl_title`),
  UNIQUE KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatelinks`
--

LOCK TABLES `templatelinks` WRITE;
/*!40000 ALTER TABLE `templatelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `text`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `text` (
  `old_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_text` mediumblob NOT NULL,
  `old_flags` tinyblob NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=10240;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text`
--

LOCK TABLES `text` WRITE;
/*!40000 ALTER TABLE `text` DISABLE KEYS */;
INSERT INTO `text` VALUES (1,'Knowledge only grows if shared.\n\nPage under construction - please see [[it:Pagina principale]]','utf-8'),(2,'Knowledge only grows if shared.\n\nPage under construction - please see [[itwiki:Pagina principale]]','utf-8');
/*!40000 ALTER TABLE `text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `thread` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `thread_history` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `thread_pending_relationship` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `thread_reaction` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `transcache` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `updatelog` (
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
INSERT INTO `updatelog` VALUES ('cl_fields_update',NULL),('convert transcache field',NULL),('DeleteDefaultMessages',NULL),('echo_event-event_agent_ip-/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql',NULL),('echo_event-event_extra-/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql',NULL),('echo_event-event_variant-/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql',NULL),('fix protocol-relative URLs in externallinks',NULL),('mime_minor_length',NULL),('populate category',NULL),('populate fa_sha1',NULL),('populate img_sha1',NULL),('populate log_search',NULL),('populate log_usertext',NULL),('populate rev_len',NULL),('populate rev_parent_id',NULL),('populate rev_sha1',NULL),('updatelist-1.22wmf3-1432152515','a:196:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:184;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:185;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:186;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:187;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:188;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:189;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:190;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:191;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:192;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:193;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:194;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:195;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432153186','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158612','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158618','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158621','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432158961','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432159055','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('updatelist-1.22wmf3-1432159302','a:206:{i:0;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:6:\"ipb_id\";i:3;s:18:\"patch-ipblocks.sql\";}i:1;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:10:\"ipb_expiry\";i:3;s:20:\"patch-ipb_expiry.sql\";}i:2;a:1:{i:0;s:17:\"doInterwikiUpdate\";}i:3;a:1:{i:0;s:13:\"doIndexUpdate\";}i:4;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"hitcounter\";i:2;s:20:\"patch-hitcounter.sql\";}i:5;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:7:\"rc_type\";i:3;s:17:\"patch-rc_type.sql\";}i:6;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_real_name\";i:3;s:23:\"patch-user-realname.sql\";}i:7;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"querycache\";i:2;s:20:\"patch-querycache.sql\";}i:8;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"objectcache\";i:2;s:21:\"patch-objectcache.sql\";}i:9;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"categorylinks\";i:2;s:23:\"patch-categorylinks.sql\";}i:10;a:1:{i:0;s:16:\"doOldLinksUpdate\";}i:11;a:1:{i:0;s:22:\"doFixAncientImagelinks\";}i:12;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_ip\";i:3;s:15:\"patch-rc_ip.sql\";}i:13;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:7:\"PRIMARY\";i:3;s:28:\"patch-image_name_primary.sql\";}i:14;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:5:\"rc_id\";i:3;s:15:\"patch-rc_id.sql\";}i:15;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_patrolled\";i:3;s:19:\"patch-rc-patrol.sql\";}i:16;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"logging\";i:2;s:17:\"patch-logging.sql\";}i:17;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:10:\"user_token\";i:3;s:20:\"patch-user_token.sql\";}i:18;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"watchlist\";i:2;s:24:\"wl_notificationtimestamp\";i:3;s:28:\"patch-email-notification.sql\";}i:19;a:1:{i:0;s:17:\"doWatchlistUpdate\";}i:20;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:33:\"user_emailauthenticationtimestamp\";i:3;s:30:\"patch-email-authentication.sql\";}i:21;a:1:{i:0;s:21:\"doSchemaRestructuring\";}i:22;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:10:\"log_params\";i:3;s:20:\"patch-log_params.sql\";}i:23;a:4:{i:0;s:8:\"checkBin\";i:1;s:7:\"logging\";i:2;s:9:\"log_title\";i:3;s:23:\"patch-logging-title.sql\";}i:24;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:9:\"ar_rev_id\";i:3;s:24:\"patch-archive-rev_id.sql\";}i:25;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:8:\"page_len\";i:3;s:18:\"patch-page_len.sql\";}i:26;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"revision\";i:2;s:17:\"inverse_timestamp\";i:3;s:27:\"patch-inverse_timestamp.sql\";}i:27;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_text_id\";i:3;s:21:\"patch-rev_text_id.sql\";}i:28;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:11:\"rev_deleted\";i:3;s:21:\"patch-rev_deleted.sql\";}i:29;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:9:\"img_width\";i:3;s:19:\"patch-img_width.sql\";}i:30;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:12:\"img_metadata\";i:3;s:22:\"patch-img_metadata.sql\";}i:31;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:16:\"user_email_token\";i:3;s:26:\"patch-user_email_token.sql\";}i:32;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_text_id\";i:3;s:25:\"patch-archive-text_id.sql\";}i:33;a:1:{i:0;s:15:\"doNamespaceSize\";}i:34;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:14:\"img_media_type\";i:3;s:24:\"patch-img_media_type.sql\";}i:35;a:1:{i:0;s:17:\"doPagelinksUpdate\";}i:36;a:4:{i:0;s:9:\"dropField\";i:1;s:5:\"image\";i:2;s:8:\"img_type\";i:3;s:23:\"patch-drop_img_type.sql\";}i:37;a:1:{i:0;s:18:\"doUserUniqueUpdate\";}i:38;a:1:{i:0;s:18:\"doUserGroupsUpdate\";}i:39;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:14:\"ss_total_pages\";i:3;s:27:\"patch-ss_total_articles.sql\";}i:40;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"user_newtalk\";i:2;s:22:\"patch-usernewtalk2.sql\";}i:41;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"transcache\";i:2;s:20:\"patch-transcache.sql\";}i:42;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:8:\"iw_trans\";i:3;s:25:\"patch-interwiki-trans.sql\";}i:43;a:1:{i:0;s:15:\"doWatchlistNull\";}i:44;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:5:\"times\";i:3;s:29:\"patch-logging-times-index.sql\";}i:45;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_range_start\";i:3;s:25:\"patch-ipb_range_start.sql\";}i:46;a:1:{i:0;s:18:\"doPageRandomUpdate\";}i:47;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_registration\";i:3;s:27:\"patch-user_registration.sql\";}i:48;a:1:{i:0;s:21:\"doTemplatelinksUpdate\";}i:49;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"externallinks\";i:2;s:23:\"patch-externallinks.sql\";}i:50;a:3:{i:0;s:8:\"addTable\";i:1;s:3:\"job\";i:2;s:13:\"patch-job.sql\";}i:51;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_images\";i:3;s:19:\"patch-ss_images.sql\";}i:52;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"langlinks\";i:2;s:19:\"patch-langlinks.sql\";}i:53;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"querycache_info\";i:2;s:24:\"patch-querycacheinfo.sql\";}i:54;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"filearchive\";i:2;s:21:\"patch-filearchive.sql\";}i:55;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:13:\"ipb_anon_only\";i:3;s:23:\"patch-ipb_anon_only.sql\";}i:56;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:14:\"rc_ns_usertext\";i:3;s:31:\"patch-recentchanges-utindex.sql\";}i:57;a:4:{i:0;s:8:\"addIndex\";i:1;s:13:\"recentchanges\";i:2;s:12:\"rc_user_text\";i:3;s:28:\"patch-rc_user_text-index.sql\";}i:58;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:17:\"user_newpass_time\";i:3;s:27:\"patch-user_newpass_time.sql\";}i:59;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"redirect\";i:2;s:18:\"patch-redirect.sql\";}i:60;a:3:{i:0;s:8:\"addTable\";i:1;s:13:\"querycachetwo\";i:2;s:23:\"patch-querycachetwo.sql\";}i:61;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:20:\"ipb_enable_autoblock\";i:3;s:32:\"patch-ipb_optional_autoblock.sql\";}i:62;a:1:{i:0;s:26:\"doBacklinkingIndicesUpdate\";}i:63;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_old_len\";i:3;s:16:\"patch-rc_len.sql\";}i:64;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"user\";i:2;s:14:\"user_editcount\";i:3;s:24:\"patch-user_editcount.sql\";}i:65;a:1:{i:0;s:20:\"doRestrictionsUpdate\";}i:66;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:6:\"log_id\";i:3;s:16:\"patch-log_id.sql\";}i:67;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:13:\"rev_parent_id\";i:3;s:23:\"patch-rev_parent_id.sql\";}i:68;a:4:{i:0;s:8:\"addField\";i:1;s:17:\"page_restrictions\";i:2;s:5:\"pr_id\";i:3;s:35:\"patch-page_restrictions_sortkey.sql\";}i:69;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:7:\"rev_len\";i:3;s:17:\"patch-rev_len.sql\";}i:70;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"recentchanges\";i:2;s:10:\"rc_deleted\";i:3;s:20:\"patch-rc_deleted.sql\";}i:71;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:11:\"log_deleted\";i:3;s:21:\"patch-log_deleted.sql\";}i:72;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_deleted\";i:3;s:20:\"patch-ar_deleted.sql\";}i:73;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_deleted\";i:3;s:21:\"patch-ipb_deleted.sql\";}i:74;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:10:\"fa_deleted\";i:3;s:20:\"patch-fa_deleted.sql\";}i:75;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:6:\"ar_len\";i:3;s:16:\"patch-ar_len.sql\";}i:76;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:15:\"ipb_block_email\";i:3;s:22:\"patch-ipb_emailban.sql\";}i:77;a:1:{i:0;s:28:\"doCategorylinksIndicesUpdate\";}i:78;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"oldimage\";i:2;s:11:\"oi_metadata\";i:3;s:21:\"patch-oi_metadata.sql\";}i:79;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:18:\"usertext_timestamp\";i:3;s:28:\"patch-archive-user-index.sql\";}i:80;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:22:\"img_usertext_timestamp\";i:3;s:26:\"patch-image-user-index.sql\";}i:81;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"oldimage\";i:2;s:21:\"oi_usertext_timestamp\";i:3;s:29:\"patch-oldimage-user-index.sql\";}i:82;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:10:\"ar_page_id\";i:3;s:25:\"patch-archive-page_id.sql\";}i:83;a:4:{i:0;s:8:\"addField\";i:1;s:5:\"image\";i:2;s:8:\"img_sha1\";i:3;s:18:\"patch-img_sha1.sql\";}i:84;a:3:{i:0;s:8:\"addTable\";i:1;s:16:\"protected_titles\";i:2;s:26:\"patch-protected_titles.sql\";}i:85;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:11:\"ipb_by_text\";i:3;s:21:\"patch-ipb_by_text.sql\";}i:86;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"page_props\";i:2;s:20:\"patch-page_props.sql\";}i:87;a:3:{i:0;s:8:\"addTable\";i:1;s:9:\"updatelog\";i:2;s:19:\"patch-updatelog.sql\";}i:88;a:3:{i:0;s:8:\"addTable\";i:1;s:8:\"category\";i:2;s:18:\"patch-category.sql\";}i:89;a:1:{i:0;s:20:\"doCategoryPopulation\";}i:90;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:12:\"ar_parent_id\";i:3;s:22:\"patch-ar_parent_id.sql\";}i:91;a:4:{i:0;s:8:\"addField\";i:1;s:12:\"user_newtalk\";i:2;s:19:\"user_last_timestamp\";i:3;s:29:\"patch-user_last_timestamp.sql\";}i:92;a:1:{i:0;s:18:\"doPopulateParentId\";}i:93;a:4:{i:0;s:8:\"checkBin\";i:1;s:16:\"protected_titles\";i:2;s:8:\"pt_title\";i:3;s:27:\"patch-pt_title-encoding.sql\";}i:94;a:1:{i:0;s:28:\"doMaybeProfilingMemoryUpdate\";}i:95;a:1:{i:0;s:26:\"doFilearchiveIndicesUpdate\";}i:96;a:4:{i:0;s:8:\"addField\";i:1;s:10:\"site_stats\";i:2;s:15:\"ss_active_users\";i:3;s:25:\"patch-ss_active_users.sql\";}i:97;a:1:{i:0;s:17:\"doActiveUsersInit\";}i:98;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:18:\"ipb_allow_usertalk\";i:3;s:28:\"patch-ipb_allow_usertalk.sql\";}i:99;a:1:{i:0;s:14:\"doUniquePlTlIl\";}i:100;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"change_tag\";i:2;s:20:\"patch-change_tag.sql\";}i:101;a:3:{i:0;s:8:\"addTable\";i:1;s:15:\"user_properties\";i:2;s:25:\"patch-user_properties.sql\";}i:102;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"log_search\";i:2;s:20:\"patch-log_search.sql\";}i:103;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"logging\";i:2;s:13:\"log_user_text\";i:3;s:23:\"patch-log_user_text.sql\";}i:104;a:1:{i:0;s:23:\"doLogUsertextPopulation\";}i:105;a:1:{i:0;s:21:\"doLogSearchPopulation\";}i:106;a:3:{i:0;s:8:\"addTable\";i:1;s:10:\"l10n_cache\";i:2;s:20:\"patch-l10n_cache.sql\";}i:107;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"log_search\";i:2;s:12:\"ls_field_val\";i:3;s:33:\"patch-log_search-rename-index.sql\";}i:108;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"change_tag\";i:2;s:17:\"change_tag_rc_tag\";i:3;s:28:\"patch-change_tag-indexes.sql\";}i:109;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"redirect\";i:2;s:12:\"rd_interwiki\";i:3;s:22:\"patch-rd_interwiki.sql\";}i:110;a:1:{i:0;s:23:\"doUpdateTranscacheField\";}i:111;a:1:{i:0;s:22:\"doUpdateMimeMinorField\";}i:112;a:3:{i:0;s:8:\"addTable\";i:1;s:7:\"iwlinks\";i:2;s:17:\"patch-iwlinks.sql\";}i:113;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_title_from\";i:3;s:27:\"patch-rename-iwl_prefix.sql\";}i:114;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"updatelog\";i:2;s:8:\"ul_value\";i:3;s:18:\"patch-ul_value.sql\";}i:115;a:4:{i:0;s:8:\"addField\";i:1;s:9:\"interwiki\";i:2;s:6:\"iw_api\";i:3;s:27:\"patch-iw_api_and_wikiid.sql\";}i:116;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"iwlinks\";i:2;s:10:\"iwl_prefix\";i:3;s:25:\"patch-kill-iwl_prefix.sql\";}i:117;a:4:{i:0;s:8:\"addField\";i:1;s:13:\"categorylinks\";i:2;s:12:\"cl_collation\";i:3;s:40:\"patch-categorylinks-better-collation.sql\";}i:118;a:1:{i:0;s:16:\"doClFieldsUpdate\";}i:119;a:1:{i:0;s:17:\"doCollationUpdate\";}i:120;a:3:{i:0;s:8:\"addTable\";i:1;s:12:\"msg_resource\";i:2;s:22:\"patch-msg_resource.sql\";}i:121;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"module_deps\";i:2;s:21:\"patch-module_deps.sql\";}i:122;a:4:{i:0;s:9:\"dropIndex\";i:1;s:7:\"archive\";i:2;s:13:\"ar_page_revid\";i:3;s:36:\"patch-archive_kill_ar_page_revid.sql\";}i:123;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"archive\";i:2;s:8:\"ar_revid\";i:3;s:26:\"patch-archive_ar_revid.sql\";}i:124;a:1:{i:0;s:23:\"doLangLinksLengthUpdate\";}i:125;a:1:{i:0;s:29:\"doUserNewTalkTimestampNotNull\";}i:126;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"user\";i:2;s:10:\"user_email\";i:3;s:26:\"patch-user_email_index.sql\";}i:127;a:4:{i:0;s:11:\"modifyField\";i:1;s:15:\"user_properties\";i:2;s:11:\"up_property\";i:3;s:21:\"patch-up_property.sql\";}i:128;a:3:{i:0;s:8:\"addTable\";i:1;s:11:\"uploadstash\";i:2;s:21:\"patch-uploadstash.sql\";}i:129;a:3:{i:0;s:8:\"addTable\";i:1;s:18:\"user_former_groups\";i:2;s:28:\"patch-user_former_groups.sql\";}i:130;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"logging\";i:2;s:11:\"type_action\";i:3;s:35:\"patch-logging-type-action-index.sql\";}i:131;a:1:{i:0;s:20:\"doMigrateUserOptions\";}i:132;a:4:{i:0;s:9:\"dropField\";i:1;s:4:\"user\";i:2;s:12:\"user_options\";i:3;s:27:\"patch-drop-user_options.sql\";}i:133;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:8:\"rev_sha1\";i:3;s:18:\"patch-rev_sha1.sql\";}i:134;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:7:\"ar_sha1\";i:3;s:17:\"patch-ar_sha1.sql\";}i:135;a:4:{i:0;s:8:\"addIndex\";i:1;s:4:\"page\";i:2;s:27:\"page_redirect_namespace_len\";i:3;s:37:\"patch-page_redirect_namespace_len.sql\";}i:136;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:12:\"us_chunk_inx\";i:3;s:27:\"patch-uploadstash_chunk.sql\";}i:137;a:4:{i:0;s:8:\"addfield\";i:1;s:3:\"job\";i:2;s:13:\"job_timestamp\";i:3;s:28:\"patch-jobs-add-timestamp.sql\";}i:138;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"revision\";i:2;s:19:\"page_user_timestamp\";i:3;s:34:\"patch-revision-user-page-index.sql\";}i:139;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:29:\"patch-ipb-parent-block-id.sql\";}i:140;a:4:{i:0;s:8:\"addIndex\";i:1;s:8:\"ipblocks\";i:2;s:19:\"ipb_parent_block_id\";i:3;s:35:\"patch-ipb-parent-block-id-index.sql\";}i:141;a:4:{i:0;s:9:\"dropField\";i:1;s:8:\"category\";i:2;s:10:\"cat_hidden\";i:3;s:20:\"patch-cat_hidden.sql\";}i:142;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:18:\"rev_content_format\";i:3;s:37:\"patch-revision-rev_content_format.sql\";}i:143;a:4:{i:0;s:8:\"addField\";i:1;s:8:\"revision\";i:2;s:17:\"rev_content_model\";i:3;s:36:\"patch-revision-rev_content_model.sql\";}i:144;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:17:\"ar_content_format\";i:3;s:35:\"patch-archive-ar_content_format.sql\";}i:145;a:4:{i:0;s:8:\"addField\";i:1;s:7:\"archive\";i:2;s:16:\"ar_content_model\";i:3;s:34:\"patch-archive-ar_content_model.sql\";}i:146;a:4:{i:0;s:8:\"addField\";i:1;s:4:\"page\";i:2;s:18:\"page_content_model\";i:3;s:33:\"patch-page-page_content_model.sql\";}i:147;a:4:{i:0;s:9:\"dropField\";i:1;s:10:\"site_stats\";i:2;s:9:\"ss_admins\";i:3;s:24:\"patch-drop-ss_admins.sql\";}i:148;a:4:{i:0;s:9:\"dropField\";i:1;s:13:\"recentchanges\";i:2;s:17:\"rc_moved_to_title\";i:3;s:18:\"patch-rc_moved.sql\";}i:149;a:3:{i:0;s:8:\"addTable\";i:1;s:5:\"sites\";i:2;s:15:\"patch-sites.sql\";}i:150;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"filearchive\";i:2;s:7:\"fa_sha1\";i:3;s:17:\"patch-fa_sha1.sql\";}i:151;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:9:\"job_token\";i:3;s:19:\"patch-job_token.sql\";}i:152;a:4:{i:0;s:8:\"addField\";i:1;s:3:\"job\";i:2;s:12:\"job_attempts\";i:3;s:22:\"patch-job_attempts.sql\";}i:153;a:1:{i:0;s:17:\"doEnableProfiling\";}i:154;a:4:{i:0;s:8:\"addField\";i:1;s:11:\"uploadstash\";i:2;s:8:\"us_props\";i:3;s:30:\"patch-uploadstash-us_props.sql\";}i:155;a:4:{i:0;s:11:\"modifyField\";i:1;s:11:\"user_groups\";i:2;s:8:\"ug_group\";i:3;s:38:\"patch-ug_group-length-increase-255.sql\";}i:156;a:4:{i:0;s:11:\"modifyField\";i:1;s:18:\"user_former_groups\";i:2;s:9:\"ufg_group\";i:3;s:39:\"patch-ufg_group-length-increase-255.sql\";}i:157;a:4:{i:0;s:8:\"addIndex\";i:1;s:10:\"page_props\";i:2;s:16:\"pp_propname_page\";i:3;s:40:\"patch-page_props-propname-page-index.sql\";}i:158;a:4:{i:0;s:8:\"addIndex\";i:1;s:5:\"image\";i:2;s:14:\"img_media_mime\";i:3;s:30:\"patch-img_media_mime-index.sql\";}i:159;a:1:{i:0;s:23:\"doIwlinksIndexNonUnique\";}i:160;a:4:{i:0;s:8:\"addIndex\";i:1;s:7:\"iwlinks\";i:2;s:21:\"iwl_prefix_from_title\";i:3;s:34:\"patch-iwlinks-from-title-index.sql\";}i:161;a:4:{i:0;s:8:\"addTable\";i:1;s:4:\"math\";i:2;s:55:\"/srv/www/production/extensions-current/Math/db/math.sql\";i:3;b:1;}i:162;a:4:{i:0;s:8:\"addTable\";i:1;s:6:\"thread\";i:2;s:60:\"/srv/www/production/extensions-current/LiquidThreads/lqt.sql\";i:3;b:1;}i:163;a:4:{i:0;s:8:\"addTable\";i:1;s:14:\"thread_history\";i:2;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_history_table.sql\";i:3;b:1;}i:164;a:4:{i:0;s:8:\"addTable\";i:1;s:27:\"thread_pending_relationship\";i:2;s:99:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_pending_relationship.sql\";i:3;b:1;}i:165;a:4:{i:0;s:8:\"addTable\";i:1;s:15:\"thread_reaction\";i:2;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_reactions.sql\";i:3;b:1;}i:166;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"user_message_state\";i:2;s:16:\"ums_conversation\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/ums_conversation.sql\";i:4;b:1;}i:167;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:24:\"thread_article_namespace\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:168;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:20:\"thread_article_title\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-thread_article.sql\";i:4;b:1;}i:169;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_ancestor\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:170;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/normalise-ancestry.sql\";i:4;b:1;}i:171;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:15:\"thread_modified\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:172;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_created\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/split-timestamps.sql\";i:4;b:1;}i:173;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_editedness\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store-editedness.sql\";i:4;b:1;}i:174;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_subject\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:175;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_author_id\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:176;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:18:\"thread_author_name\";i:3;s:92:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_subject-author.sql\";i:4;b:1;}i:177;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_sortkey\";i:3;s:83:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/new-sortkey.sql\";i:4;b:1;}i:178;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:14:\"thread_replies\";i:3;s:89:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_reply_count.sql\";i:4;b:1;}i:179;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:17:\"thread_article_id\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/store_article_id.sql\";i:4;b:1;}i:180;a:5:{i:0;s:8:\"addField\";i:1;s:6:\"thread\";i:2;s:16:\"thread_signature\";i:3;s:88:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/thread_signature.sql\";i:4;b:1;}i:181;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:19:\"thread_summary_page\";i:3;s:90:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-summary_page.sql\";i:4;b:1;}i:182;a:5:{i:0;s:8:\"addIndex\";i:1;s:6:\"thread\";i:2;s:13:\"thread_parent\";i:3;s:91:\"/srv/www/production/extensions-current/LiquidThreads/schema-changes/index-thread_parent.sql\";i:4;b:1;}i:183;a:4:{i:0;s:8:\"addTable\";i:1;s:10:\"echo_event\";i:2;s:52:\"/srv/www/production/extensions-current/Echo/echo.sql\";i:3;b:1;}i:184;a:4:{i:0;s:8:\"addTable\";i:1;s:16:\"echo_email_batch\";i:2;s:75:\"/srv/www/production/extensions-current/Echo/db_patches/echo_email_batch.sql\";i:3;b:1;}i:185;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_agent\";i:3;s:82:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent-split.sql\";i:4;b:1;}i:186;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:13:\"event_variant\";i:3;s:90:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_variant_nullability.sql\";i:4;b:1;}i:187;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:11:\"event_extra\";i:3;s:81:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_extra-size.sql\";i:4;b:1;}i:188;a:5:{i:0;s:11:\"modifyField\";i:1;s:10:\"echo_event\";i:2;s:14:\"event_agent_ip\";i:3;s:84:\"/srv/www/production/extensions-current/Echo/db_patches/patch-event_agent_ip-size.sql\";i:4;b:1;}i:189;a:5:{i:0;s:8:\"addField\";i:1;s:17:\"echo_notification\";i:2;s:24:\"notification_bundle_base\";i:3;s:92:\"/srv/www/production/extensions-current/Echo/db_patches/patch-notification-bundling-field.sql\";i:4;b:1;}i:190;a:5:{i:0;s:8:\"addIndex\";i:1;s:10:\"echo_event\";i:2;s:10:\"event_type\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-alter-type_page-index.sql\";i:4;b:1;}i:191;a:5:{i:0;s:9:\"dropField\";i:1;s:10:\"echo_event\";i:2;s:15:\"event_timestamp\";i:3;s:96:\"/srv/www/production/extensions-current/Echo/db_patches/patch-drop-echo_event-event_timestamp.sql\";i:4;b:1;}i:192;a:5:{i:0;s:8:\"addField\";i:1;s:16:\"echo_email_batch\";i:2;s:14:\"eeb_event_hash\";i:3;s:86:\"/srv/www/production/extensions-current/Echo/db_patches/patch-email_batch-new-field.sql\";i:4;b:1;}i:193;a:4:{i:0;s:8:\"addTable\";i:1;s:11:\"flaggedrevs\";i:2;s:87:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/FlaggedRevs.sql\";i:3;b:1;}i:194;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:92:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_expiry.sql\";i:4;b:1;}i:195;a:5:{i:0;s:8:\"addIndex\";i:1;s:18:\"flaggedpage_config\";i:2;s:10:\"fpc_expiry\";i:3;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-expiry-index.sql\";i:4;b:1;}i:196;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedrevs_promote\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_promote.sql\";i:3;b:1;}i:197;a:4:{i:0;s:8:\"addTable\";i:1;s:12:\"flaggedpages\";i:2;s:94:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpages.sql\";i:3;b:1;}i:198;a:5:{i:0;s:8:\"addField\";i:1;s:11:\"flaggedrevs\";i:2;s:11:\"fr_img_name\";i:3;s:93:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_img_name.sql\";i:4;b:1;}i:199;a:4:{i:0;s:8:\"addTable\";i:1;s:20:\"flaggedrevs_tracking\";i:2;s:102:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_tracking.sql\";i:3;b:1;}i:200;a:5:{i:0;s:8:\"addField\";i:1;s:12:\"flaggedpages\";i:2;s:16:\"fp_pending_since\";i:3;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fp_pending_since.sql\";i:4;b:1;}i:201;a:5:{i:0;s:8:\"addField\";i:1;s:18:\"flaggedpage_config\";i:2;s:9:\"fpc_level\";i:3;s:91:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fpc_level.sql\";i:4;b:1;}i:202;a:4:{i:0;s:8:\"addTable\";i:1;s:19:\"flaggedpage_pending\";i:2;s:101:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedpage_pending.sql\";i:3;b:1;}i:203;a:2:{i:0;s:53:\"FlaggedRevsUpdaterHooks::doFlaggedImagesTimestampNULL\";i:1;s:98:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fi_img_timestamp.sql\";}i:204;a:2:{i:0;s:50:\"FlaggedRevsUpdaterHooks::doFlaggedRevsRevTimestamp\";i:1;s:99:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-fr_page_rev-index.sql\";}i:205;a:4:{i:0;s:8:\"addTable\";i:1;s:22:\"flaggedrevs_statistics\";i:2;s:104:\"/srv/www/production/extensions-current/FlaggedRevs/backend/schema/mysql/patch-flaggedrevs_statistics.sql\";i:3;b:1;}}'),('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql',NULL),('user_groups-ug_group-patch-ug_group-length-increase-255.sql',NULL),('user_properties-up_property-patch-up_property.sql',NULL);
/*!40000 ALTER TABLE `updatelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploadstash`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `uploadstash` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_former_groups` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_groups` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_message_state` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_newtalk` (
  `user_id` int(11) NOT NULL DEFAULT '0',
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_properties` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `valid_tag` (
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `watchlist` (
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT '0',
  `wl_title` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `wl_notificationtimestamp` varbinary(14) DEFAULT NULL,
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `namespace_title` (`wl_namespace`,`wl_title`)
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

-- Dump completed on 2015-05-21 15:50:49

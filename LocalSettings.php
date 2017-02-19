<?php

# See includes/DefaultSettings.php for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# http://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
if (!defined('MEDIAWIKI')) {
    exit;
}

// use this variable to enable the debug mode
$wtl_debug = false;

if (getenv('WTL_DEBUG') == '1') {
    $wtl_debug = true;
}

if (getenv('WTL_PRODUCTION') != '1') {
    $wtl_debug = true;
}

if (is_writable('/var/log/mediawiki/')) {
    $wgDebugLogFile = '/var/log/mediawiki/'.date('m-d-Y');
    if (isset($_SERVER['SERVER_NAME'])){
        $wgDebugLogFile = $wgDebugLogFile . '.' . $_SERVER['SERVER_NAME'];
    }
} else {
    $wgDebugLogFile = '/tmp/mediawiki';
}

if ($wtl_debug) {
    if(isset($_SERVER['REMOTE_ADDR'])) {
        $wgDebugLogFile = $wgDebugLogFile . "-" . $_SERVER['REMOTE_ADDR'];
    }
    error_reporting(E_ALL);
    ini_set("display_errors", 1);
    $wgDebugToolbar = true;
    $wgDebugComments = true;
    $wgShowExceptionDetails = true;
    $wgEnableParserCache = false;
    $wgCachePages = false;
    $wgStyleVersion=mt_rand(1,1000);
}

$wgDebugLogFile = $wgDebugLogFile . '.log';

$IP = '/var/www/WikiToLearn/mediawiki/';
putenv("MW_INSTALL_PATH=$IP");

# Mobile detection
if (isset($_SERVER['HTTP_USER_AGENT'])) {
    $_SERVER['HTTP_X_DEVICE'] = $_SERVER['HTTP_USER_AGENT'];
} else {
    $_SERVER['HTTP_X_DEVICE'] = '';
}
#error_log("device from ls.php");

ini_set('memory_limit', '64M');
$wgMaxShellMemory = 524288;

## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgMetaNamespace = 'Project';

require_once "$IP/../domains.php";

if (array_search($wiki_domain, $wiki_allow_domains) === false) {
    $wiki = 'notfound';
}

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs please see:
## http://www.mediawiki.org/wiki/Manual:Short_URL

$wgUsePathInfo = false; #required since v1.11.0
$wgScriptPath = '';
$wgArticlePath = '/$1';
$wgScript = "$wgScriptPath/index.php";
$wgRedirectScript = "$wgScriptPath/redirect.php";

## The relative URL path to the skins directory
$wgStylePath = "$wgScriptPath/skins";

$wgMainCacheType = CACHE_MEMCACHED;
$wgMemCachedServers = array(
    'memcached:11211', # one gig on this box
);

$wgCacheDirectory = "$IP/cache/";

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = true; # UPO

if (file_exists("$IP/../LocalSettings.d/mail-from-address.php")) {
    require_once "$IP/../LocalSettings.d/mail-from-address.php";
} else {
    $wgEmergencyContact = 'webmaster@kde.org';
    $wgPasswordSender = 'webmaster@kde.org';
}

$wgEnotifUserTalk = true; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

## Database settings
// $wgJobRunRate = 0.01;

$wgDBtype = 'mysql';
$wgDBserver = 'mysql';

$wgSharedDB = 'sharedwikitolearn'; # The $wgDBname for the wiki database holding the main user table
$wgSharedTables = array();
$wgSharedTables[] = 'user';
$wgSharedTables[] = 'user_properties';
//$wgSharedTables[] = 'user_groups';
$wgSharedTables[] = 'bot_passwords';
//$wgSharedTables[] = 'ipblocks';
//$wgSharedTables[] = 'math';
//$wgSharedTables[] = 'mathoid';

# Site language code, should be one of ./languages/Language(.*).php
# Make sure you give permission to sharedwikitolearn database to the user in question.
$wgLanguageCode = 'en'; // Default
#Officially supported languages
$wgSupportedLanguages = array('ca', 'de', 'en', 'es', 'fr', 'it');

# BUG: most of the code of WikiToLearn requires that the interface is
# in the same language of the domain being visited. Otherwise references
# to non existing pages get created. Disable setting a custom language for preferences.
# If you still have questions, please ask ruphy or tunale.
$wgHiddenPrefs[] = 'language';
# Hide math preferences in the use profile
$wgHiddenPrefs[] = 'math';

require_once "$IP/../LocalSettings.d/mysql-username-and-password.php";
require_once "$IP/../LocalSettings.d/wgSecretKey.php";

switch ($wiki) {
    case 'it':
    case 'en':
    case 'fr':
    case 'es':
    case 'de':
    case 'pt':
    case 'sv':
    case 'ca':
        $wgLanguageCode = $wiki;
        $wgDBname = $wiki.'wikitolearn';
        break;
    case 'pool':
    case 'meta':
        $wgDBname = $wiki.'wikitolearn';
        include_once "$IP/extensions/Translate/Translate.php";
        break;
    default:
    header('Location: //www.'.$wiki_domain.'/');
    exit(0);
    break;
}

$wgCookiePrefix = "wtl_1_";
$wgSessionName = $wgCookiePrefix . "session_" . $wiki;
$wgCookieDomain = "." . $wiki_domain;
$wgSecureLogin = true;
// $wgCookieSecure = true;

if ($wiki_domain != 'tuttorotto.biz') {
    $wgServer = '//'.$wiki.'.'.$wiki_domain;
}

$wgSitename = 'WikiToLearn - collaborative textbooks';
$wgLogo = "//www." . $wiki_domain . "/logobig.png";

$wgForeignFileRepos[] = array(
    'class' => 'ForeignDBRepo',
    'name' => 'poolwiki',
    'url' => '//pool.'.$wiki_domain.'/images/pool',
    'directory' => '/var/www/WikiToLearn/mediawiki/images/pool/',
    'hashLevels' => 2, // This must be the same for the other family member
    'dbType' => $wgDBtype,
    'dbServer' => $wgDBserver,
    'dbUser' => $wgDBuser,
    'dbPassword' => $wgDBpassword,
    'dbFlags' => DBO_DEFAULT,
    'dbName' => 'poolwikitolearn',
    'tablePrefix' => '',
    'hasSharedCache' => true,
    'descBaseUrl' => '//pool.'.$wiki_domain.'/Image:',
    'fetchDescription' => false,
);
$wgForeignFileRepos[] = array(
   'class'                   => 'ForeignAPIRepo',
   'name'                    => 'wikimediacommons',
   'apibase'                 => 'https://commons.wikimedia.org/w/api.php',
   'hashLevels'              => 2,
   'fetchDescription'        => true,
   'descriptionCacheExpiry'  => 43200,
   'apiThumbCacheExpiry'     => 86400,
);

if (!isset($wgDBname)) {
    $wgDBname = $wgDBuser;
}
$wgEnableAPI = true;

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = '/usr/bin/convert';

$wgFileExtensions[] = 'pdf';
$wgFileExtensions[] = 'svg';
$wgFileExtensions[] = 'svgz';
$wgFileExtensions[] = 'tex';
$wgGroupPermissions['*']['upload'] = true;
#$wgGroupPermissions['Editor']['autopatrol'] = true;
$wgGroupPermissions['sysop']['meta'] = true;
# $wgGroupPermissions['user']['upload'] = true;
# InstantCommons allows wiki to use images from http://commons.wikimedia.org
# $wgUseInstantCommons = true;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 e
$wgShellLocale = 'en_US.utf8';

## If you want to use image uploads under safe mode,
## create the directories images/archive, images/thumb and
## images/temp, and make them all writable. Then uncomment
## this, if it's not already uncommented:
#$wgHashedUploadDirectory = false;
## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publically accessible from the web.
#$wgCacheDirectory = "$IP/cache";

$wgUseSharedUploads = true;
$wgSharedUploadPath = '//pool.'.$wiki_domain.'/images/pool';
$wgSharedUploadDirectory = $IP.'/images/pool/';
$wgHashedSharedUploadDirectory = true;
$wgUploadNavigationUrl = '//pool.'.$wiki_domain.'/index.php/Special:Upload';
$wgUploadMissingFileUrl = '//pool.'.$wiki_domain.'/index.php/Special:Upload';

$wgUploadDirectory = $IP.'/images/'.$wiki.'/';
$wgUploadPath = '/images/'.$wiki;

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgEnableCreativeCommonsRdf = true;
$wgRightsPage = 'Project:Copyright'; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = 'http://creativecommons.org/licenses/by-sa/3.0/';
// $wgRightsUrl  = "//www." . $wiki_domain . "/index.php/Project:Copyright";
$wgRightsText = 'Creative Commons Attribution Share Alike 3.0 &amp; GNU FDL';
$wgRightsIcon = "{$wgStylePath}/common/images/cc-by-sa.png";
// $wgRightsIcon = "{$wgStylePath}/common/images/gfdlcc.png";
# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = '/usr/bin/diff3';

$wgSVGConverter = 'inkscape';

# Query string length limit for ResourceLoader. You should only set this if
# your web server has a query string length limit (then set it to that limit),
# or if you have suhosin.get.max_value_length set in php.ini (then set it to
# that value)
$wgResourceLoaderMaxQueryLength = 512;

$wgHooks['ParserClearState'][] = 'efMWNoTOC';

function efMWNoTOC($parser)
{
    $parser->mShowToc = false;

    return true;
}

# Bigger uploads
$wgMaxUploadSize = 2147483648;

# Protect only uploads
$wgAllowExternalImagesFrom = array('http://www.'.$wiki_domain.'/', 'http://www.pledgie.com');

$wgUseETag = true;

# Don't sitemap files
#$wgSitemapNamespaces = array('0', '2', '3', '4', '6', '8');

$wgDefaultUserOptions['useeditwarning'] = 1;
$wgDefaultSkin = 'WikiToLearnSkin';
$wgWikiToLearnSkinEnableJoinPage = true;
wfLoadSkin('WikiToLearnSkin');
$wgStyleVersion=314;

$wgAllowImageTag = true;


//  prevents edits that contain URLs whose domains match regular expression patterns defined in specified files or wiki pages and registration by users using specified email addresses

// Bump the Perl Compatible Regular Expressions backtrack memory limit
// (PHP 5.3.x default, 1000K, is too low for SpamBlacklist)

ini_set('pcre.backtrack_limit', '8M');
wfLoadExtension('SpamBlacklist');
$wgBlacklistSettings = array(
    'spam' => array(
        'files' => array(
            'https://meta.wikimedia.org/w/index.php?title=Spam_blacklist&action=raw&sb_ver=1',
        ),
    ),
);
$wgLogSpamBlacklistHits = true;

$wgSpamRegex = '/'.# The "/" is the opening wrapper
                's-e-x|zoofilia|sexyongpin|grusskarte|geburtstagskarten|animalsex|'.
                'sex-with|dogsex|adultchat|adultlive|camsex|sexcam|livesex|sexchat|'.
                'chatsex|onlinesex|adultporn|adultvideo|adultweb.|hardcoresex|hardcoreporn|'.
                'teenporn|xxxporn|lesbiansex|livegirl|livenude|livesex|livevideo|camgirl|'.
                'spycam|voyeursex|casino-online|online-casino|kontaktlinsen|cheapest-phone|'.
                'laser-eye|eye-laser|fuelcellmarket|lasikclinic|cragrats|parishilton|'.
                'paris-hilton|paris-tape|2large|fuel-dispenser|fueling-dispenser|huojia|'.
                'jinxinghj|telematicsone|telematiksone|a-mortgage|diamondabrasives|'.
                'reuterbrook|sex-plugin|sex-zone|lazy-stars|eblja|liuhecai|'.
                'buy-viagra|-cialis|-levitra|boy-and-girl-kissing|'.# These match spammy words
                "dirare\.com|".# This matches dirare.com a spammer's domain name
                "overflow\s*:\s*auto|".# This matches against overflow:auto (regardless of whitespace on either side of the colon)
                "height\s*:\s*[0-4]px|".# This matches against height:0px (most CSS hidden spam) (regardless of whitespace on either side of the colon)
                "==<center>\[|".# This matches some recent spam related to starsearchtool.com and friends
                "\<\s*a\s*href|".# This blocks all href links entirely, forcing wiki syntax
                "display\s*:\s*none".# This matches against display:none (regardless of whitespace on either side of the colon)
                '/i';                     # The "/" ends the regular expression and the "i" switch which follows makes the test case-insensitive
                                          # The "\s" matches whitespace
                                          # The "*" is a repeater (zero or more times)
                                          # The "\s*" means to look for 0 or more amount of whitespace

// FIXME
$wgCapitalLinkOverrides[ NS_FILE ] = true; //FIXME
// FIXME

// Visual Editor configuration
wfLoadExtension('VisualEditor');
// Disable by default for everybody
$wgDefaultUserOptions['visualeditor-enable'] = 1;
// OPTIONAL: Enable VisualEditor's experimental code features
$wgDefaultUserOptions['visualeditor-enable-experimental'] = 1;
$wgVisualEditorSupportedSkins = ['wikitolearnskin'];

$wgVirtualRestConfig['modules']['parsoid'] = array(
  // URL to the Parsoid instance
  // Use port 8142 if you use the Debian package
  'url' => 'http://parsoid:8000',
  // Parsoid "domain", see below (optional)
  'domain' => isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : '',
);

$wgVirtualRestConfig['modules']['restbase'] = array(
  'url' => 'http://restbase:7231',
  'domain' => isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : '',
  'forwardCookies' => false,
  'parsoidCompat' => false,
);

$wgMathFullRestbaseURL = '//restbase.'.$wiki_domain.'/'.(isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : 'localhost').'/';
$wgVisualEditorFullRestbaseURL = '//restbase.'.$wiki_domain.'/'.(isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : 'localhost').'/';

/* extensions loading */
wfLoadExtension('SpeechToText');
//wfLoadExtension('EasyLink');

wfLoadExtension('WikiToLearnACL');
// Add WikiToLearn user permissions
$wgAvailableRights[] = 'wtl_deleteallpages';
$wgGroupPermissions['sysop']['wtl_deleteallpages'] = true;
$wgGroupPermissions['user']['delete'] = true;

// Define constants for my additional namespaces
wfLoadExtension('CourseEditor');
/*
* CourseEditor namespaces are already declared within extension.json,
* but to activate Flow discussion page and Collection personal tools
* we have to define costants here. This generate a Warning that says:
* Notice: Constant NS_COURSE already defined in /var/www/WikiToLearn/mediawiki/includes/registration/ExtensionRegistry.php
* Notice: Constant NS_COURSE_TALK already defined in /var/www/WikiToLearn/mediawiki/includes/registration/ExtensionRegistry.php
* However if we don't define them Flow and Collection don't recognize the costants and show warning again.
*/

$data = json_decode(file_get_contents("$IP/extensions/CourseEditor/extension.json"));

$CourseEditorNamespaces = array();
foreach ($data->namespaces as $namespace) {
    $CourseEditorNamespaces[$namespace->constant] = $namespace->id;
}

wfLoadExtension('LabeledSectionTransclusion');

// Cite extension for references as footnotes
wfLoadExtension('Cite');
$wgCiteEnablePopups = true;

// Collection extension
require_once "$IP/extensions/Collection/Collection.php";
$wgGroupPermissions['sysop']['collectionsaveascommunitypage'] = true;
$wgGroupPermissions['user']['collectionsaveasuserpage'] = true;
# configuration borrowed from wmf-config/CommonSettings.php
# in operations/mediawiki-config
$wgCollectionFormatToServeURL['rdf2latex'] = $wgCollectionFormatToServeURL['rdf2text'] = 'http://ocg:17080';
# MediaWiki namespace is not a good default
$wgCommunityCollectionNamespace = NS_PROJECT;
# Sidebar cache doesn't play nice with this
$wgEnableSidebarCache = false;
$wgCollectionFormats = array(
    'rdf2latex' => 'PDF',
    'rdf2text' => 'Plain text',
);
$wgCollectionRendererSettings['columns']['default'] = 1;
$wgLicenseURL = '//creativecommons.org/licenses/by-sa/3.0/';
$wgCollectionPortletFormats = array('rdf2latex', 'rdf2text');
$wgCollectionArticleNamespaces = array(
  NS_USER,
  NS_PROJECT,
  $CourseEditorNamespaces['NS_COURSE'],
);
//$wgCollectionMWServeURL = ("http://tools.pediapress.com/mw-serve/");
//$wgParserCacheType = CACHE_ACCEL; // # Don't break math rendering

//ContributionScores
require_once "$IP/extensions/ContributionScores/ContributionScores.php";
$wgContribScoreIgnoreBots = true;          // Exclude Bots from the reporting - Can be omitted.
$wgContribScoreIgnoreBlockedUsers = true;  // Exclude Blocked Users from the reporting - Can be omitted.
$wgContribScoresUseRealName = true;        // Use real user names when available - Can be omitted. Only for MediaWiki 1.19 and later.
$wgContribScoreDisableCache = false;       // Set to true to disable cache for parser function and inclusion of table.
#Each array defines a report - 7,50 is "past 7 days" and "LIMIT 50" - Can be omitted.
$wgContribScoreReports = array(
    array(30, 20),
    array(90, 20),
);

//Echo for notification
require_once "$IP/extensions/Echo/Echo.php";

//EmbedVideo
include_once "$IP/extensions/EmbedVideo/EmbedVideo.php";

//Flow for talk pages
require_once "$IP/extensions/Flow/Flow.php";
$wgNamespaceContentModels[NS_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_USER_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_PROJECT_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_FILE_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_MEDIAWIKI_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_TEMPLATE_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_HELP_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_CATEGORY_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[$CourseEditorNamespaces['NS_COURSE_TALK']] = CONTENT_MODEL_FLOW_BOARD;
$wgFlowEditorList = array('wikitext');

//Gadgets
// wfLoadExtension('Gadgets');

//googleAnalytics
require_once "$IP/extensions/googleAnalytics/googleAnalytics.php";
if (file_exists("$IP/../LocalSettings.d/wgGoogleAnalyticsAccount.php")) {
    require_once "$IP/../LocalSettings.d/wgGoogleAnalyticsAccount.php";
}

// Piwik
require_once "$IP/extensions/Piwik/Piwik.php";
$wgPiwikURL = 'piwik.wikitolearn.org';
if (file_exists("$IP/../LocalSettings.d/wgPiwikIDSite.php")) {
    require_once "$IP/../LocalSettings.d/wgPiwikIDSite.php";
} else {
    // id for test
    $wgPiwikIDSite = 2;
}

// Math rendering
wfLoadExtension('Math');
$wgMathValidModes[] = 'MW_MATH_MATHML';
$wgDefaultUserOptions['math'] = 'MW_MATH_MATHML';
//$wgMathMathMLUrl = 'http://mathoid:10044/';

//Nuke for mass delete pages
wfLoadExtension('Nuke');

// Add parser functions (for if, else, ...)
wfLoadExtension('ParserFunctions');

wfLoadExtension('Renameuser');

if (file_exists("$IP/../LocalSettings.d/wgReadOnly.php")) {
    require_once "$IP/../LocalSettings.d/wgReadOnly.php";
}

// Used for some templates needs it
require_once "$IP/extensions/ParserHooks/ParserHooks.php";

// Captcha
wfLoadExtensions(array('ConfirmEdit', 'ConfirmEdit/ReCaptchaNoCaptcha'));
$wgCaptchaClass = 'ReCaptchaNoCaptcha';
$wgReCaptchaSendRemoteIP = true;
if (file_exists("$IP/../LocalSettings.d/ReCaptchaNoCaptcha.php")) {
    require_once "$IP/../LocalSettings.d/ReCaptchaNoCaptcha.php";
} else {
    // These keys are Google's test keys. Configure them appropriately in secrets
    $wgReCaptchaSiteKey = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI';
    $wgReCaptchaSecretKey = '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe';
}
// Disable captcha for some namespaces
// See https://phabricator.wikimedia.org/T143516
$wgCaptchaTriggersOnNamespace[NS_TALK]['edit'] = false;
$wgCaptchaTriggersOnNamespace[NS_TALK]['create'] = false;
$wgCaptchaTriggersOnNamespace[NS_TALK]['addurl'] = false;
$wgCaptchaTriggersOnNamespace[NS_TOPIC]['edit'] = false;
$wgCaptchaTriggersOnNamespace[NS_TOPIC]['create'] = false;
$wgCaptchaTriggersOnNamespace[NS_TOPIC]['addurl'] = false;
//Disable captcha for course editor
$wgCaptchaTriggersOnNamespace[$CourseEditorNamespaces['NS_COURSE']]['edit'] = false;
$wgCaptchaTriggersOnNamespace[$CourseEditorNamespaces['NS_COURSE']]['create'] = false;
$wgCaptchaTriggersOnNamespace[$CourseEditorNamespaces['NS_COURSE']]['addurl'] = false;
$wgCaptchaTriggersOnNamespace[NS_USER]['edit'] = false;
$wgCaptchaTriggersOnNamespace[NS_USER]['create'] = false;
$wgCaptchaTriggersOnNamespace[NS_USER]['addurl'] = false;
$wgCaptchaTriggersOnNamespace[$CourseEditorNamespaces['NS_COURSEMETADATA']]['edit'] = false;
$wgCaptchaTriggersOnNamespace[$CourseEditorNamespaces['NS_COURSEMETADATA']]['create'] = false;
$wgCaptchaTriggersOnNamespace[$CourseEditorNamespaces['NS_COURSEMETADATA']]['addurl'] = false;

//for making users autoconfirmed
$wgAutoConfirmCount = 3;
$wgAutoConfirmAge = 86400 * 3; // three days

// Disable captcha for bots
$wgGroupPermissions['bot']['skipcaptcha'] = true; // registered bots

// Highlight extension:
wfLoadExtension('SyntaxHighlight_GeSHi');

//Translate extension
$wgGroupPermissions['translator']['translate'] = true;
$wgGroupPermissions['translator']['skipcaptcha'] = true; // Bug 34182: needed with ConfirmEdit
$wgTranslateDocumentationLanguageCode = 'qqq';
# Add this if you want to enable access to page translation
$wgGroupPermissions['sysop']['pagetranslation'] = true;

wfLoadExtension('UserMerge');
// By default nobody can use this function, enable for bureaucrat?
$wgGroupPermissions['sysop']['usermerge'] = true;

// awesome editor
wfLoadExtension('WikiEditor');
$wgDefaultUserOptions['usebetatoolbar'] = 1;
$wgDefaultUserOptions['usebetatoolbar-cgd'] = 1;
$wgDefaultUserOptions['wikieditor-preview'] = 1;

//Content Namespaces
$wgContentNamespaces = array(0, 200, 2800);
// Add subpage capabilities
$wgNamespacesWithSubpages = array_fill(0, 200, true);
$wgNamespacesWithSubpages[NS_USER] = true;
wfLoadExtension('CodeEditor');
$wgCodeEditorEnableCore = true;

wfLoadExtension('TemplateData');
$wgTemplateDataGUI = true;
//Disable bot rate limits
$wgGroupPermissions['bot']['noratelimit'] = true;

wfLoadExtension('ContributorsMap');
$wgCMURL = "umap.openstreetmap.fr/en/map/wikitolearn-community_106733";

wfLoadExtension('WikiToLearnVETemplates');

//disallow anonymous editing
$wgEmailConfirmToEdit = true;

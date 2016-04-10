<?php

# See includes/DefaultSettings.php for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# http://www.mediawiki.org/wiki/Manual:Configuration_settings

$wtl_development=false;
if ($wtl_development || getenv("WTL_PRODUCTION") != "1"){
  error_reporting(-1);
  ini_set("display_errors",1);
  $wgDebugLogFile="/tmp/mediawiki.log";
}

$IP = "/var/www/WikiToLearn/mediawiki/";
putenv("MW_INSTALL_PATH=$IP");

# Protect against web entry
if (!defined('MEDIAWIKI')) {
    exit;
}

# Mobile detection
if (isset($_SERVER['HTTP_USER_AGENT'])) {
    $_SERVER['HTTP_X_DEVICE'] = $_SERVER['HTTP_USER_AGENT'];
} else {
    $_SERVER['HTTP_X_DEVICE'] = "";
}
#error_log("device from ls.php");

ini_set('memory_limit', '64M');
$wgMaxShellMemory = 524288;

## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgMetaNamespace = "Project";

require_once( "$IP/../domains.php" );

if (array_search($wiki_domain, $wiki_allow_domains) === FALSE) {
    $wiki = "notfound";
}

$wgCookieDomain = "." . $wiki_domain;
$wgSecureLogin = true;
// $wgCookieSecure = true;
## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs please see:
## http://www.mediawiki.org/wiki/Manual:Short_URL

$wgUsePathInfo = false; #required since v1.11.0
$wgScriptPath = "";
$wgArticlePath = "/$1";
$wgScript = "$wgScriptPath/index.php";
$wgRedirectScript = "$wgScriptPath/redirect.php";

## The relative URL path to the skins directory
$wgStylePath = "$wgScriptPath/skins";

$wgMainCacheType = CACHE_MEMCACHED;
$wgMemCachedServers = array(
    "memcached:11211", # one gig on this box
);

$wgCacheDirectory = "$IP/cache/";
$wgEnableSidebarCache = true;

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = true; # UPO

if (file_exists("$IP/../LocalSettings.d/mail-from-address.php")) {
    require_once("$IP/../LocalSettings.d/mail-from-address.php");
} else {
    $wgEmergencyContact = "webmaster@kde.org";
    $wgPasswordSender = "webmaster@kde.org";
}

$wgEnotifUserTalk = true; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

## Database settings
// $wgJobRunRate = 0.01;

$wgDBtype = "mysql";
$wgDBserver = "mysql";

$wgSharedDB = 'sharedwikitolearn'; # The $wgDBname for the wiki database holding the main user table
$wgSharedTables[] = array('user', 'user_properties', 'user_groups', 'interwiki', 'iwlinks');

# Site language code, should be one of ./languages/Language(.*).php
# Make sure you give permission to sharedwikitolearn database to the user in question.

$wgLanguageCode = "en"; // Default

require_once("$IP/../LocalSettings.d/mysql-username-and-password.php");
require_once("$IP/../LocalSettings.d/wgSecretKey.php");

switch ($wiki) {
    case "it":
    case "en":
    case "fr":
    case "es":
    case "de":
    case "pt":
    case "sv":
        $wgLanguageCode = $wiki;
        $wgDBname = $wiki . "wikitolearn";
        break;
    case "pool":
    case "meta":
        $wgDBname = $wiki . "wikitolearn";
        include_once("$IP/extensions/Translate/Translate.php");
        break;
    default:
    header("Location: //www." . $wiki_domain . "/");
    exit(0);
    break;
}

$wgSitename = "WikiToLearn - collaborative textbooks";
$wgLogo = "$wgStylePath/Neverland/images/logos/en.png";

$wgForeignFileRepos[] = array(
    'class' => 'ForeignDBRepo',
    'name' => 'poolwiki',
    'url' => "//pool." . $wiki_domain . "/images",
    'directory' => '/var/www/WikiToLearn/mediawiki/images/',
    'hashLevels' => 2, // This must be the same for the other family member
    'dbType' => $wgDBtype,
    'dbServer' => $wgDBserver,
    'dbUser' => $wgDBuser,
    'dbPassword' => $wgDBpassword,
    'dbFlags' => DBO_DEFAULT,
    'dbName' => 'poolwikitolearn',
    'tablePrefix' => '',
    'hasSharedCache' => true,
    'descBaseUrl' => '//pool.' . $wiki_domain . '/Image:',
    'fetchDescription' => false
);

if (!isset($wgDBname)) {
    $wgDBname = $wgDBuser;
}
$wgEnableAPI = true;


## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";

$wgFileExtensions[] = 'pdf';
$wgFileExtensions[] = 'svg';
$wgFileExtensions[] = 'svgz';
$wgFileExtensions[] = 'tex';
$wgGroupPermissions['*']['upload'] = true;
#$wgGroupPermissions['Editor']['autopatrol'] = true;
$wgGroupPermissions['sysop']['meta'] = true;
# $wgGroupPermissions['user']['upload'] = true;
# InstantCommons allows wiki to use images from http://commons.wikimedia.org
$wgUseInstantCommons = true;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 e
$wgShellLocale = "en_US.utf8";

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
$wgSharedUploadPath = '//pool.' . $wiki_domain . '/images';
$wgSharedUploadDirectory = '$IP/images/';
$wgHashedSharedUploadDirectory = true;
$wgUploadNavigationUrl = "//pool." . $wiki_domain . "/index.php/Special:Upload";
$wgUploadMissingFileUrl = "//pool." . $wiki_domain . "/index.php/Special:Upload";


## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgEnableCreativeCommonsRdf = true;
$wgRightsPage = "Project:Copyright"; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "http://creativecommons.org/licenses/by-sa/3.0/";
// $wgRightsUrl  = "//www." . $wiki_domain . "/index.php/Project:Copyright";
$wgRightsText = "Creative Commons Attribution Share Alike 3.0 &amp; GNU FDL";
$wgRightsIcon = "{$wgStylePath}/common/images/cc-by-sa.png";
// $wgRightsIcon = "{$wgStylePath}/common/images/gfdlcc.png";
# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

$wgSVGConverter = 'inkscape';

# Query string length limit for ResourceLoader. You should only set this if
# your web server has a query string length limit (then set it to that limit),
# or if you have suhosin.get.max_value_length set in php.ini (then set it to
# that value)
$wgResourceLoaderMaxQueryLength = 512;

$wgHooks['ParserClearState'][] = 'efMWNoTOC';

function efMWNoTOC($parser) {
    $parser->mShowToc = false;
    return true;
}

# Bigger uploads
$wgMaxUploadSize = 2147483648;

# Protect only uploads
$wgAllowExternalImagesFrom = array('http://www.' . $wiki_domain . '/', 'http://www.pledgie.com');

$wgUseETag = true;

# Don't sitemap files
#$wgSitemapNamespaces = array('0', '2', '3', '4', '6', '8');

$wgDefaultUserOptions['useeditwarning'] = 1;
$wgDefaultSkin = 'neverland';
require_once "$IP/skins/Neverland/Neverland.php";

$wgAllowImageTag = true;

if (getenv("WTL_PRODUCTION") == "1") {
    $wgEnableDnsBlacklist = true;
    $wgDnsBlacklistUrls = array('xbl.spamhaus.org', 'dnsbl.tornevall.org');
}

//  prevents edits that contain URLs whose domains match regular expression patterns defined in specified files or wiki pages and registration by users using specified email addresses

// Bump the Perl Compatible Regular Expressions backtrack memory limit
// (PHP 5.3.x default, 1000K, is too low for SpamBlacklist)

ini_set( 'pcre.backtrack_limit', '8M' );
wfLoadExtension( 'SpamBlacklist' );
$wgBlacklistSettings = array(
    'spam' => array(
        'files' => array(
            'https://meta.wikimedia.org/w/index.php?title=Spam_blacklist&action=raw&sb_ver=1'
        ),
    ),
);
$wgLogSpamBlacklistHits = true;

$wgSpamRegex = "/".                        # The "/" is the opening wrapper
                "s-e-x|zoofilia|sexyongpin|grusskarte|geburtstagskarten|animalsex|".
                "sex-with|dogsex|adultchat|adultlive|camsex|sexcam|livesex|sexchat|".
                "chatsex|onlinesex|adultporn|adultvideo|adultweb.|hardcoresex|hardcoreporn|".
                "teenporn|xxxporn|lesbiansex|livegirl|livenude|livesex|livevideo|camgirl|".
                "spycam|voyeursex|casino-online|online-casino|kontaktlinsen|cheapest-phone|".
                "laser-eye|eye-laser|fuelcellmarket|lasikclinic|cragrats|parishilton|".
                "paris-hilton|paris-tape|2large|fuel-dispenser|fueling-dispenser|huojia|".
                "jinxinghj|telematicsone|telematiksone|a-mortgage|diamondabrasives|".
                "reuterbrook|sex-plugin|sex-zone|lazy-stars|eblja|liuhecai|".
                "buy-viagra|-cialis|-levitra|boy-and-girl-kissing|". # These match spammy words
                "dirare\.com|".           # This matches dirare.com a spammer's domain name
                "overflow\s*:\s*auto|".   # This matches against overflow:auto (regardless of whitespace on either side of the colon)
                "height\s*:\s*[0-4]px|".  # This matches against height:0px (most CSS hidden spam) (regardless of whitespace on either side of the colon)
                "==<center>\[|".          # This matches some recent spam related to starsearchtool.com and friends
                "\<\s*a\s*href|".         # This blocks all href links entirely, forcing wiki syntax
                "display\s*:\s*none".     # This matches against display:none (regardless of whitespace on either side of the colon)
                "/i";                     # The "/" ends the regular expression and the "i" switch which follows makes the test case-insensitive
                                          # The "\s" matches whitespace
                                          # The "*" is a repeater (zero or more times)
                                          # The "\s*" means to look for 0 or more amount of whitespace


// FIXME
$wgCapitalLinkOverrides[ NS_FILE ] = true; //FIXME
// FIXME

// Visual Editor configuration
//wfLoadExtension( "VisualEditor" );
// Enable by default for everybody
//$wgDefaultUserOptions['visualeditor-enable'] = 1;
// OPTIONAL: Enable VisualEditor's experimental code features
//$wgDefaultUserOptions['visualeditor-enable-experimental'] = 1;
//$wgVisualEditorSupportedSkins = ['neverland'];

$wgVirtualRestConfig['modules']['parsoid'] = array(
  // URL to the Parsoid instance
  // Use port 8142 if you use the Debian package
  'url' => 'http://parsoid:8000',
  // Parsoid "domain", see below (optional)
  'domain' => isset($_SERVER['SERVER_NAME'])?$_SERVER['SERVER_NAME']:"",
);

//$wgVirtualRestConfig['modules']['restbase'] = array(
//  'url' => 'http://restbase:7231',
//  'domain' => isset($_SERVER['SERVER_NAME'])?$_SERVER['SERVER_NAME']:"",
//  'forwardCookies' => false,
//  'parsoidCompat' => false
//);

/* extensions loading */

// Cite extension for references as footnotes
wfLoadExtension("Cite");
$wgCiteEnablePopups = true;

// Collection extension
require_once("$IP/extensions/Collection/Collection.php");
$wgGroupPermissions['sysop']['collectionsaveascommunitypage'] = true;
$wgGroupPermissions['user']['collectionsaveasuserpage']      = true;
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
$wgLicenseURL = "//creativecommons.org/licenses/by-sa/3.0/";
$wgCollectionPortletFormats = array('rdf2latex', 'rdf2text');
//$wgCollectionMWServeURL = ("http://tools.pediapress.com/mw-serve/");
//$wgParserCacheType = CACHE_ACCEL; // # Don't break math rendering

// Captcha
/*wfLoadExtensions( array( 'ConfirmEdit', 'ConfirmEdit/ReCaptchaNoCaptcha' ) );
$wgCaptchaClass = 'ReCaptchaNoCaptcha';
$wgReCaptchaSendRemoteIP = true;
if (file_exists("$IP/../LocalSettings.d/ReCaptchaNoCaptcha.php")) {
    require_once("$IP/../LocalSettings.d/ReCaptchaNoCaptcha.php");
} else {
    // These keys are Google's test keys. Configure them appropriately in secrets
    $wgReCaptchaSiteKey = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI';
    $wgReCaptchaSecretKey = '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe';
}*/

wfLoadExtensions( array( 'ConfirmEdit', 'ConfirmEdit/QuestyCaptcha' ) );
$wgCaptchaClass = 'QuestyCaptcha';
$arr = array (
    "Write 8421" => "8421",
    "Write 1337" => "1337",
    "Write 9999" => "9999",
    "Write 'WikiToLearn'" => "WikiToLearn"
);
foreach ( $arr as $key => $value ) {
        $wgCaptchaQuestions[] = array( 'question' => $key, 'answer' => $value );
}

$wgCaptchaTriggers['editgi'] = true;
$wgCaptchaTriggers['create'] = true;
$wgCaptchaTriggers['addurl'] = true;
$wgCaptchaTriggers['createaccount'] = true;
$wgCaptchaTriggers['badlogin'] = true;

$wgGroupPermissions['*'            ]['skipcaptcha'] = false;
$wgGroupPermissions['user'         ]['skipcaptcha'] = false;
$wgGroupPermissions['autoconfirmed']['skipcaptcha'] = true;
$wgGroupPermissions['bot'          ]['skipcaptcha'] = true;
$wgGroupPermissions['sysop'        ]['skipcaptcha'] = true;
$wgGroupPermissions['emailconfirmed']['skipcaptcha'] = true;
$ceAllowConfirmedEmail = true;

//for making users autoconfirmed
$wgAutoConfirmCount = 3;
$wgAutoConfirmAge = 86400*3; // three days

//ContributionScores
require_once("$IP/extensions/ContributionScores/ContributionScores.php");
$wgContribScoreIgnoreBots = true;          // Exclude Bots from the reporting - Can be omitted.
$wgContribScoreIgnoreBlockedUsers = true;  // Exclude Blocked Users from the reporting - Can be omitted.
$wgContribScoresUseRealName = true;        // Use real user names when available - Can be omitted. Only for MediaWiki 1.19 and later.
$wgContribScoreDisableCache = false;       // Set to true to disable cache for parser function and inclusion of table.
#Each array defines a report - 7,50 is "past 7 days" and "LIMIT 50" - Can be omitted.
$wgContribScoreReports = array(
    array(30, 20),
    array(90, 20)
);

//DMath
wfLoadExtension("DMath");


//Echo for notification
require_once( "$IP/extensions/Echo/Echo.php" );

//EmbedVideo
include_once("$IP/extensions/EmbedVideo/EmbedVideo.php");

//Flow for talk pages
require_once( "$IP/extensions/Flow/Flow.php" );
$wgNamespaceContentModels[NS_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_USER_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_PROJECT_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_FILE_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_MEDIAWIKI_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_TEMPLATE_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_HELP_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgNamespaceContentModels[NS_CATEGORY_TALK] = CONTENT_MODEL_FLOW_BOARD;
$wgFlowEditorList   = array('wikitext');

//LiquidThreads for discussion page system
//require_once( "$IP/extensions/LiquidThreads/LiquidThreads.php" );

//Gadgets
wfLoadExtension( "Gadgets" );

//googleAnalytics
require_once( "$IP/extensions/googleAnalytics/googleAnalytics.php" );



// MathJax
wfLoadExtension("Math");
//$wgUseMathJax = true;
//$wgDefaultUserOptions['math'] = MW_MATH_MATHJAX;
$wgMathValidModes[] = 'MW_MATH_MATHML';
$wgDefaultUserOptions['math'] = 'MW_MATH_MATHML';
$wgMathMathMLUrl = 'http://mathoid:10044/';

//Nuke for mass delete pages
wfLoadExtension("Nuke");

// Add parser functions (for if, else, ...)
wfLoadExtension( "ParserFunctions" );


wfLoadExtension( 'Renameuser' );

if (file_exists("$IP/../LocalSettings.d/wgReadOnly.php")) {
    require_once("$IP/../LocalSettings.d/wgReadOnly.php");
}

// SubapageList needs it
require_once( "$IP/extensions/ParserHooks/ParserHooks.php" );
#require_once( "$IP/extensions/SubPageList/SubPageList.php" );
// Add subpage capabilities
$wgNamespacesWithSubpages = array_fill(0, 200, true);
$wgNamespacesWithSubpages[NS_USER] = true;


// Highlight extension:
wfLoadExtension("SyntaxHighlight_GeSHi");

// Custom extension ?
require_once( "$IP/extensions/Theorems/Theorems.php" );

//Translate extension
$wgGroupPermissions['translator']['translate'] = true;
$wgGroupPermissions['translator']['skipcaptcha'] = true; // Bug 34182: needed with ConfirmEdit
$wgTranslateDocumentationLanguageCode = 'qqq';
# Add this if you want to enable access to page translation
$wgGroupPermissions['sysop']['pagetranslation'] = true;


wfLoadExtension( "UserMerge" );
// By default nobody can use this function, enable for bureaucrat?
$wgGroupPermissions['sysop']['usermerge'] = true;

// require_once("$IP/extensions/VisualEditor/VisualEditor.php");

// awesome editor
wfLoadExtension( "WikiEditor" );
$wgDefaultUserOptions['usebetatoolbar'] = 1;
$wgDefaultUserOptions['usebetatoolbar-cgd'] = 1;
$wgDefaultUserOptions['wikieditor-preview'] = 1;

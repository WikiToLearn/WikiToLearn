<?php
include '../domains.php';
if (file_exists("../LocalSettings.d/wgGoogleAnalyticsAccount.php")) {
    require_once "../LocalSettings.d/wgGoogleAnalyticsAccount.php";
    include '../skins/WikiToLearnSkin/HelperFunctions.php';
}

$domain = $wiki_allow_domains[0];
global $wgPiwikURL, $wgPiwikIDSite, $wgGoogleAnalyticsAccount, $wgGoogleAnalyticsAnonymizeIP;

if (array_search($wiki_domain, $wiki_allow_domains) !== false) {
    $domain = $wiki_domain;
}
$https = false;
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
    $https = true;
}
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') {
    $https = true;
}
if ($domain != 'local.wikitolearn-test.org' && !$https) {
    header('Location: https://www.' . $domain);
} else {
    ?><!DOCTYPE html>
<html lang="en">
    <head>
        <title>WikiToLearn - collaborative textbooks</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="Content-Type" charset="UTF-8" />
        <meta http-equiv="Content-Language" content="en">
        <meta name="description" content="WikiToLearn provides free, collaborative and accessible text books. Academics worldwide contribute in sharing knowledge by creating high quality content."/>
        <meta property="og:description" content="WikiToLearn provides free, collaborative and accessible text books. Academics worldwide contribute in sharing knowledge by creating high quality content."/>
        <meta name="twitter:description" content="WikiToLearn provides free, collaborative and accessible text books. Academics worldwide contribute in sharing knowledge by creating high quality content."/>
        <meta property="og:title" content="WikiToLearn - collaborative textbooks"/>
        <meta name="twitter:title" content="WikiToLearn - collaborative textbooks"/>
        <meta property="og:site_name" content="WikiToLearn"/>
        <meta name="twitter:card" content="summary"/>
        <meta name="twitter:site" content="@WikiToLearn"/>
        <meta name="twitter:image" content="http://www.<?php echo $domain; ?>/wikitolearn.jpg"/>
        <meta property="og:image" content="http://www.<?php echo $domain; ?>/wikitolearn.jpg"/>
        <meta property="og:image:width" content="500" />
        <meta property="og:image:height" content="500" />
        <link rel="stylesheet" href="/assets/v1/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/assets/v2/css/style-1.css">
    </head>
    <body>

        <div class="container-fluid">
          <div class="row vertical-spacing-small-top"></div>
            <div class="row">
                <div class="col-lg-2 col-sm-1"></div>
                <div class="col-lg-8 col-sm-10">
                    <div class="col-sm-12 center-row">
                        <div class="col-sm-6 center">
                            <div>
                                <img src="/assets/v1/img/logobig.png" alt="WikiToLearn logo" id="logo-wtl" class="img-responsive center-block" />
                            </div>
                        </div>
                        <div id="spacing-row" style="height:30px"></div>
                        <div class="col-sm-6 col-xs-12 center" id="rightnav" style="padding-left:0px;">
                            <div class="bar"></div>
                            <ul id="rightnavmenu" class="list-unstyled">
                                <li class="towikilink">
                                  <a class="wikilink" lang="it" href="//it.<?php echo $domain; ?>">
                                    <h1>Italiano<small class="pull-right hidden-xs pagecount">#+ capitoli</small></h1>
                                    <h2>&laquo;Il sapere si accresce solo se condiviso&raquo;</h2>
                                  </a>
                                </li>
                                <li class="towikilink">
                                  <a class="wikilink" lang="en" href="//en.<?php echo $domain; ?>">
                                    <h1>English<small class="pull-right hidden-xs pagecount">#+ chapters</small></h1>
                                    <h2>&laquo;Knowledge only grows if shared&raquo;</h2>
                                  </a>
                                </li>
                                <li class="towikilink">
                                  <a class="wikilink" lang="de" href="//de.<?php echo $domain; ?>">
                                    <h1>Deutsch<small class="pull-right hidden-xs pagecount">#+ Kapitel</small></h1>
                                    <h2>&laquo;Nur wenn Wissen geteilt wird, kann neues enstehen&raquo;</h2>
                                  </a>
                                </li>
                                <li class="towikilink">
                                  <a class="wikilink" lang="es" href="//es.<?php echo $domain; ?>">
                                    <h1>Espa&ntilde;ol<small class="pull-right hidden-xs pagecount">#+ capítulos</small></h1>
                                    <h2>&laquo;El conocimiento solo crece cuando es compartido&raquo;</h2>
                                  </a>
                                </li>
                                <li class="towikilink">
                                  <a class="wikilink" lang="ca" href="//ca.<?php echo $domain; ?>">
                                    <h1>Català<small class="pull-right hidden-xs pagecount">#+ Capítols</small></h1>
                                    <h2>&laquo;El coneixement només creix si és compartit&raquo;</h2>
                                  </a>
                                </li>
                                <li class="towikilink">
                                  <a class="wikilink" lang="fr" href="#//fr.<?php echo $domain; ?>">
                                    <h1 class="disabled">Fran&ccedil;ais</h1>
                                    <h2 class="disabled">&laquo;Le savoir grandit seulement s'il est partag&eacute;&raquo;</h2>
                                  </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="vertical-spacing-small-bottom"></div>
            <div class="row text-center">
              <h5 class="contributors"><small><em>Contributions from:</em></small></h5>
            </div>
            <div class="row vertical-spacing-small-bottom"></div>
            <div class="row">
              <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1 col-xs-12">
                <div class="col-sm-1 logo col-xs-4 col-xs-offset-2 col-sm-offset-0">
                  <a href="https://www.unimib.it/">
                    <img src="/assets/v1/img/uni-bicocca.png" class="img-responsive"/>
                  </a>
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <a href="https://home.cern/">
                    <img src="/assets/v1/img/cern.png" class="img-responsive"/>
                  </a>
                </div>
                <div class="clearfix visible-xs">
                </div>
                <div class="col-xs-12 visible-xs vertical-spacing">
                </div>
                <div class="col-sm-1 logo col-xs-4 col-xs-offset-2 col-sm-offset-0">
                  <a href="http://www.wikimedia.it/">
                    <img src="/assets/v1/img/it-wikimedia.png" class="img-responsive"/>
                  </a>
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <a href="http://hepsoftwarefoundation.org/">
                    <img src="/assets/v1/img/hep-logo.png" class="img-responsive"/>
                  </a>
                </div>
                <div class="clearfix visible-xs">
                </div>
                <div class="col-xs-12 visible-xs vertical-spacing">
                </div>
                <div class="col-sm-1 logo col-xs-4 col-xs-offset-2 col-sm-offset-0">
                  <a href="https://www.sissa.it/">
                    <img src="/assets/v1/img/sissa-logo.png" class="img-responsive"/>
                  </a>
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <a href="https://www.wikimedia.ch/">
                    <img src="/assets/v2/img/wikimedia-ch.png" class="img-responsive"/>
                  </a>
                </div>
              </div>
            </div>
            <div class="row vertical-spacing"></div>
            <div class="row">
              <div class="col-xs-12">
                <a href="https://www.kde.org/"><img src="/assets/v1/img/proudtobe.png" alt="Proud member of the KDE community" class="img-responsive center-block proudtobe" /></a>
              </div>
            </div>
            <div class="row vertical-spacing">
            </div>
            <div class="row">
              <div class="col-xs-12 text-center">
                <a href="<?php echo "//www." . $domain . '/privacy.html'?> ">Privacy Policy</a>
              </div>
            </div>
        </div>

        <script src="/assets/v1/js/jquery-3.1.1.min.js"></script>

        <?php
if (function_exists('setAnalytics')) {
        setAnalytics($piwik = false, $wgPiwikURL, $wgPiwikIDSite, $wgGoogleAnalyticsAccount, $wgGoogleAnalyticsAnonymizeIP);
    } ?>

        <script>
            $(document).ready(function () {

                $(".towikilink").each(function () {
                    link = $(this).children('.wikilink');
                    apiurl = link.attr('href') + "/api.php?action=query&meta=siteinfo&siprop=statistics&format=json";
                    lang = link.attr('lang');

                    if (apiurl.substring(0, 1) !== "#") {
                        $.ajax({
                            url: apiurl,
                            dataType: "jsonp",
                            context: $(this).find('.pagecount'),
                            success: function (response) {
                                $(this).html(response.query.statistics.articles + $(this).html().substring(1));
                            }
                        });
                    }
                });

            });
        </script>
    </body>
</html>
<?php
}
?>

<?php
include "../domains.php";

$domain = $wiki_allow_domains[0];

if (array_search($wiki_domain, $wiki_allow_domains) !== FALSE) {
    $domain = $wiki_domain;
}
?><!DOCTYPE html>
<html lang="en">
    <head>
        <title>WikiToLearn - collaborative textbooks</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="Content-Type" charset="UTF-8" />

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link rel="stylesheet" href="/style.css">

    </head>
    <body>

        <div class="container-fluid">
            <div class="row" id="spacing"></div>
            <div class="row">
                <div class="col-lg-2 col-sm-1"></div>
                <div class="col-lg-8 col-sm-10">
                    <div class="col-sm-12 center-row">
                        <div class="col-sm-6 center">
                            <div>
                                <img src="/logobig.png" alt="WikiToLearn logo" id="logo-wtl" class="img-responsive center-block" />
                            </div>
                        </div>
                        <div id="spacing-row" style="height:30px"></div>
                        <div class="col-sm-6 col-xs-12 center" id="rightnav" style="padding-left:0px;">
                            <ul id="rightnavmenu" class="list-unstyled">
                                <li class="towikilink colorbar1"><a class="wikilink" lang="it" href="//it.<?php echo $domain; ?>"><h1>Italiano<small class="pull-right hidden-xs pagecount">#+ capitoli</small></h1><h2>&laquo;Il sapere si accresce solo se condiviso&raquo;</h2></a></li>
                                <li class="towikilink colorbar2"><a class="wikilink" lang="en" href="//en.<?php echo $domain; ?>"><h1>English<small class="pull-right hidden-xs pagecount">#+ chapters</small></h1><h2>&laquo;Knowledge only grows if shared&raquo;</h2></a></li>
                                <li class="towikilink colorbar3"><a class="wikilink" lang="fr" href="#//fr.<?php echo $domain; ?>"><h1 class="disabled">Fran&ccedil;ais</h1><h2 class="disabled">&laquo;Le savoir grandit seulement s'il est partag&eacute;&raquo;</h2></a></li>
                                <li class="towikilink colorbar4"><a class="wikilink" lang="de" href="#//de.<?php echo $domain; ?>"><h1 class="disabled">Deutsch</h1><h2 class="disabled">&laquo;Nur wenn Wissen geteilt wird kann neues enstehen&raquo;</h2></a></li>
                                <li class="towikilink colorbar5"><a class="wikilink" lang="es" href="#//es.<?php echo $domain; ?>"><h1 class="disabled">Espa&ntilde;ol</h1><h2 class="disabled">&laquo;El conocimiento solo crece cuando es compartido&raquo;</h2></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row vertical-spacing-small-top"></div>
            <div class="row text-center">
              <h5 class="contributors"><small><em>Contributions from:</em></small></h5>
            </div>
            <div class="row vertical-spacing-small-bottom"></div>
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3 logos-container col-xs-12">
                <div class="col-sm-1 logo col-xs-4 col-xs-offset-2 col-sm-offset-0">
                  <img src="/images/uni-bicocca.png" class="img-responsive"/>
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <img src="/images/cern.png" class="img-responsive"/>
                </div>
                <div class="clearfix visible-xs">
                </div>
                <div class="col-xs-12 visible-xs vertical-spacing">
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <img src="/images/it-wikimedia.png" class="img-responsive"/>
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <img src="/images/sissa.png" class="img-responsive"/>
                </div>
                <div class="col-sm-1 logo col-xs-4">
                  <img src="/images/uni-pisa.png" class="img-responsive"/>
                </div>
              </div>
            </div>
            <div class="row vertical-spacing"></div>
            <div class="row">
              <div class="col-xs-12">
                <a href="https://www.kde.org/"><img src="/images/proudtobe.png" alt="Proud member of the KDE community" class="img-responsive center-block proudtobe" /></a>
              </div>
            </div>
            <div class="row vertical-spacing">

            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>

        <script>
            WebFont.load({
                google: {
                    families: ['Source Sans Pro:400,600,700,400italic,700italic', 'Roboto Condensed:400,700']
                }
            });
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
                                console.log($(this));
                                console.log(response);
                                $(this).html(response.query.statistics.articles + $(this).html().substring(1));
                            }
                        });
                    }
                });

            });
        </script>
    </body>
</html>

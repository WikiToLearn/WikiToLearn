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
                                <li class="towikilink"><a class="wikilink" lang="it" href="//it.<?php echo $domain; ?>"><h1>Italiano<small class="pull-right hidden-xs pagecount">#+ pagine</small></h1><h2>&laquo;Il sapere si accresce solo se condiviso&raquo;</h2></a></li>
                                <li class="towikilink"><a class="wikilink" lang="en" href="//en.<?php echo $domain; ?>"><h1>English<small class="pull-right hidden-xs pagecount">#+ pages</small></h1><h2>&laquo;Knowledge only grows if shared&raquo;</h2></a></li>
                                <li class="towikilink"><a class="wikilink" lang="fr" href="#//fr.<?php echo $domain; ?>"><h1 class="disabled">Fran&ccedil;ais</h1><h2 class="disabled">&laquo;Le savoir grandit seulement s'il est partag&eacute;&raquo;</h2></a></li>
                                <li class="towikilink"><a class="wikilink" lang="de" href="#//de.<?php echo $domain; ?>"><h1 class="disabled">Deutsch</h1><h2 class="disabled">&laquo;Nur wenn Wissen geteilt wird kann neues enstehen&raquo;</h2></a></li>
                                <li class="towikilink"><a class="wikilink" lang="es" href="#//es.<?php echo $domain; ?>"><h1 class="disabled">Espa&ntilde;ol</h1><h2 class="disabled">&laquo;El conocimiento solo crece cuando es compartido&raquo;</h2></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-sm-1"></div>
            </div>
            <div class="row" style="margin-top:20px;">
                <img src="/badges.png" class="center-block img-responsive"/>
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
                                $(this).html(response.query.statistics.pages + $(this).html().substring(1));
                            }
                        });
                    }
                });

            });
        </script>
    </body>
</html>


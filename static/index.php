<?php
$wiki_allow_domains = array(
    "wikitolearn.org",
    "dev.wikitolearn.org",
    "direct.wikitolearn.org",
);
$domain=$wiki_allow_domains[0];

$wiki_hostname = strtolower(isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : getenv('WIKI'));
$wiki = substr($wiki_hostname, 0, strpos($wiki_hostname, "."));
$wiki_domain = substr($wiki_hostname, strlen($wiki) + 1);

if (array_search($wiki_domain, $wiki_allow_domains) !== FALSE) {
 $domain=$wiki_domain;
}

?><!DOCTYPE xhtml PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>WikiToLearn - choose your language</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<style type="text/css">
<!--
@import url(//fonts.googleapis.com/css?family=Source+Sans+Pro);

.style1 {font-family: Geneva, Arial, Helvetica, sans-serif}
body,td,th {
        font-size: medium;
        color: #313466;
}
.style2 {color: #667}
body {
        background-color: #FFFFFF;
        margin-right: 0px;
}
#container {
    margin-left: auto;
    margin-right: auto;
    width: 800px;
    height: 500px;
    margin-top: 80px;
    clear:both;
}

#footer {
/*     margin-top: 600px; */
    }

#leftlogo {
    float: left;
    margin-left: auto;
    margin-right: auto;
    padding: 80px;
    padding-top: 100px;
    margin-right: -30px;
}

#rightnav {
    float: right;
    font-family: Source Sans Pro;
}

#rightnav li {
list-style-type: none;
padding-left: 40px;
height: 80px;
margin: 0;
}

#rightnav a {
    text-decoration: none;
}

#rightnav h1 {
    font-weight: normal;
    color: #373737;
    font-size: 22pt;
    padding-top: 8px;
    margin-bottom: 6px;
    margin-top: 0;
}
#rightnav h2 {
    font-weight: normal;
    font-style: italic;
    color: #68b31f;
    font-size: 12pt;
    margin: 0;
}

#rightnav .disabled {
    color: #b3b3b3;
}

-->
</style>
</head>
<body>
<div id="container">

<img src="/logobig.png" alt="WikiToLearn logo" id="leftlogo" />

  <div id="rightnav">
    <ul id="rightnavmenu">
      <li style="border-left: 8px solid #83001f;"><a href="//it.<?php echo $domain; ?>"><h1>Italiano<small style="float:right;font-size:10pt;padding-top:1em;padding-left:1em;">12 libri</small></h1><h2>&laquo;Il sapere si accresce solo se condiviso&raquo;<h2></a></li>
      <li style="border-left: 8px solid #db3e14;"><a href="//en.<?php echo $domain; ?>"><h1>English<small style="float:right;font-size:10pt;padding-top:1em;padding-left:1em;">1 book</small></h1><h2>&laquo;Knowledge only grows if shared&raquo;<h2></a></li>
      <li style="border-left: 8px solid #ffbc31;"><a href="#//fr.<?php echo $domain; ?>"><h1 class="disabled">Fran&ccedil;ais</h1><h2 class="disabled">&laquo;Le savoir grandit seulement s'il est partag&eacute;&raquo;<h2></a></li>
      <li style="border-left: 8px solid #69b140;"><a href="#//de.<?php echo $domain; ?>"><h1 class="disabled">Deutsch</h1><h2 class="disabled">&laquo;Nur wenn Wissen geteilt wird kann neues enstehen&raquo;<h2></a></li>
      <li style="border-left: 8px solid #00613a;"><a href="#//es.<?php echo $domain; ?>"><h1 class="disabled">Espa&ntilde;ol</h1><h2 class="disabled">&laquo;El conocimiento solo crece cuando es compartido&raquo;<h2></a></li>
    </ul>
</div>


</div>

<center>
   <img src="/badges.png" />

</center>
<!--   <div id="footer">
   <img src="/smallbadges.png" />
             <a href="mailto:etiennette.auffray@cern.ch"><strong>contact webmaster</strong></a>
     </div>-->
</body>
</html>


<?php
include "../domains.php";

$domain=$wiki_allow_domains[0];

if (array_search($wiki_domain, $wiki_allow_domains) !== FALSE) {
 $domain=$wiki_domain;
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
<title>WikiToLearn - collaborative textbooks</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="Content-Type" charset="UTF-8" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">


<style type="text/css">
<!--

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
    max-width: 800px;
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
    padding: 100px 125px 80px;
    margin-right: -30px;
}

#rightnav {
/*    float: left;
*/    font-family: Source Sans Pro;
}

#rightnavmenu {
  padding: 0px;
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
    font-size: 2em;
    padding-top: 8px;
    margin-bottom: 6px;
    margin-top: 0;
}
#rightnav h2 {
    font-weight: normal;
    font-style: italic;
    color: #68b31f;
    font-size: 11pt;
    margin: 0;
}

#rightnav .disabled {
    color: #b3b3b3;
}

/* Portrait phones and smaller */
@media (max-width: 768px)  {
  #rightnav h1 {
    font-size: 14pt;
  }

  #rightnav h2 {
    font-size: 10pt;
  }
  
  #spacing {
    height: 30px;
  }

  #logo {
    margin-right: 15%;
  }

}

/* Larger devices */
@media (min-width: 769px) {
  .center-row {
    display:table;
  }

  .center {
    display:table-cell;
    vertical-align:middle;
    float:none;
  }

  #spacing {
    height: 100px;
  }

  #spacing-row {
    display: none;
  }
}

-->
</style>

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
            <li style="border-left: 8px solid #83001f;"><a href="//it.<?php echo $domain; ?>"><h1>Italiano<small class="pull-right hidden-xs" style="font-size:10pt;padding-top:1em;padding-left:1em;">382+ pagine</small></h1><h2>&laquo;Il sapere si accresce solo se condiviso&raquo;<h2></a></li>
            <li style="border-left: 8px solid #db3e14;"><a href="//en.<?php echo $domain; ?>"><h1>English<small class="pull-right hidden-xs" style="font-size:10pt;padding-top:1em;padding-left:1em;">96+ pages</small></h1><h2>&laquo;Knowledge only grows if shared&raquo;<h2></a></li>
            <li style="border-left: 8px solid #ffbc31;"><a href="#//fr.<?php echo $domain; ?>"><h1 class="disabled">Fran&ccedil;ais</h1><h2 class="disabled">&laquo;Le savoir grandit seulement s'il est partag&eacute;&raquo;<h2></a></li>
            <li style="border-left: 8px solid #69b140;"><a href="#//de.<?php echo $domain; ?>"><h1 class="disabled">Deutsch</h1><h2 class="disabled">&laquo;Nur wenn Wissen geteilt wird kann neues enstehen&raquo;<h2></a></li>
            <li style="border-left: 8px solid #00613a;"><a href="#//es.<?php echo $domain; ?>"><h1 class="disabled">Espa&ntilde;ol</h1><h2 class="disabled">&laquo;El conocimiento solo crece cuando es compartido&raquo;<h2></a></li>
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
<script>
 WebFont.load({
    google: {
      families: ['Source Sans Pro:400,600,700,400italic,700italic', 'Roboto Condensed:400,700']
    }
  });
</script>
</body>
</html>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?php
// ouvrage: numero d'ouvrage SIGE (pas ID)
// abonnes: numero complet: commune + client (pas ID)
$type = $_GET["type"];
$ouvrage = $_GET["ouvrage"];
$abonne = $_GET["abonne"];
$commune = $_GET["commune"];
if ( $type == "" ){$type = "ouvrage";}
if ( $$type == "" ){ return; }

$communes = array(
    "BLONAY"             => 82 ,
    "CHARDONNE"          => 84 ,
    "CHATEL-ST-DENIS"    => 0  ,
    "CHEXBRES"           => 0  ,
    "CORBEYRIER"         => 0  ,
    "CORSEAUX"           => 81 ,
    "CORSIER"            => 80 ,
    "JONGNY"             => 88 ,
    "LA_TOUR_DE_PEILZ"   => 60 ,
    "MONTREUX"           => 51 ,
    "PORT_VALAIS"        => 43 ,
    "PUIDOUX"            => 0  ,
    "REMAUFENS"          => 0  ,
    "RENNAZ"             => 37 ,
    "RIVAZ"              => 0  ,
    "ROCHE"              => 0  ,
    "ST_LEGIER"          => 83 ,
    "ST_SAPHORIN"        => 0  ,
    "VEVEY"              => 71 ,
    "VEYTAUX"            => 50 ,
    "VILLENEUVE_NOVILLE" => 37 
);
?>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
$(document).ready( function(){
    $("#thumbs div a").each( function( idx , el ){
        var img = new Image();
        $(img).load( function(){
            $(this).css('display','none');
            $(el).parent().removeClass('loading').children("a").append(this);
            $(this).fadeIn(800);
        }).error(function () {
            $(el).remove();
        }).attr('src', $(this).attr('href'));
    });
    $(".thumb_link").click( function(){
        $("#image img").attr("data-height",$(this).attr("data-height")).attr("data-width",$(this).attr("data-width")).attr("src", $(this).attr("href") );
        return false;
    });
    $("#image img").load( function(){image_resize();});
    $(window).resize( function(){image_resize();});
    $("#thumbs div a").first().click();
});

function image_resize(){
    $("#image").height($(window).height()-$("#thumbs").height());
    var iW = $("#image img").attr("data-width");
    var iH = $("#image img").attr("data-height");
    var iR = iW/iH;
    var aW = $("#image").width();
    var aH = $("#image").height();
    var aR = aW/aH;
    if ( iR >= aR ){
        $("#image img").width(aW);
        $("#image img").height( iH * aW/iW );
    }else{
        $("#image img").height(aH);
        $("#image img").width( iW * aH/iH );
    }
}
</script>
</head>
<body>
<div id="gallery">
    <div id="top_banner">
        T&eacute;l&eacute;charger un <a href="gallery_pdf.php?type=<?=$type?>&ouvrage=<?=$ouvrage?>&abonne=<?=$abonne?>&commune=<?=$commune?>">PDF</a> des images en pleine r&eacute;solution.
    </div>
    <div id="thumbs">
        <?php
        $extensions = "{jpg,jpeg,pdf,png,JPG,JPEG,PDF,PNG}";
	if($type == "ouvrage"){
	    $fotpaths = array("../ouvrages/$ouvrage/images/small/");
	    $pattern  = "*.$extensions";
	}elseif($type=="abonne"){
	    $fotpaths = array();
	    foreach( $communes as $name => $id ){
		if( $id == $commune ){
		    $fotpaths[] = "../abonnes/CROQUIS/"    .$name."/";
		    $fotpaths[] = "../abonnes/PHOTOS_ABTS/".$name."/";
		}
	    }
	    $pattern  = $commune."_".$abonne."{.,_*.}".$extensions;
	}
	// images
	foreach( $fotpaths as $fotpath ){
	    if ( is_dir($fotpath) ){
		foreach( glob($fotpath.$pattern, GLOB_BRACE) as $fot ){
		    $path_parts = pathinfo($fot);
		    $ext = $path_parts['extension'];
		    if ( strcasecmp($ext,"jpg") == 0 || strcasecmp($ext,"png") == 0 || strcasecmp($ext,"jpeg") == 0 ){
			list($width, $height, $type, $attr) = getimagesize("$fot");
			echo"<div class=\"thumb loading\"><a href=\"$fot\" class=\"thumb_link\" data-width=\"$width\" data-height=\"$height\"></a></div>";
		    }
		}
	    }
	}
        ?>
    </ul>
    </div>
    <div id="image">
        <img src="">
    </div>
</div>
</body>
</html>

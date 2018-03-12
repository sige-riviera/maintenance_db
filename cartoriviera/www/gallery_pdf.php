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

$leftMargin = 10;
$topMargin = 10;

$pageWidth  = 210 - 2*$leftMargin;
$pageHeight = 297 - 2*$topMargin;
$pageRatio = $pageWidth/$pageHeight;

require('fpdf.php');
$pdf = new FPDF('P','mm','A4');

// chemin complet
$extensions = "{jpg,jpeg,pdf,png,JPG,JPEG,PDF,PNG}";
if($type == "ouvrage"){
	$fotpaths = array("../ouvrages/$ouvrage/images/large/");
	$pattern  = "*.$extensions";
	$output  = "sige_ouvrage_$ouvrage.pdf";
}elseif($type=="abonne"){
	$fotpaths = array();
	foreach( $communes as $name => $id ){
		if( $id == $commune ){
			$fotpaths[] = "../abonnes/CROQUIS/"    .$name."/";
			$fotpaths[] = "../abonnes/PHOTOS_ABTS/".$name."/";
		}
	}
	$pattern = $commune."_".$abonne."{.,_*.}".$extensions;
	$output  = "sige_abonne_".$commune."_".$abonne.".pdf";
}

// images
foreach( $fotpaths as $fotpath ){
	if ( is_dir($fotpath) ){
		foreach( glob($fotpath.$pattern, GLOB_BRACE) as $fot ){
			$path_parts = pathinfo($fot);
			$ext = $path_parts['extension'];
			if ( strcasecmp($ext,"jpg") == 0 || strcasecmp($ext,"png") == 0 || strcasecmp($ext,"jpeg") == 0 ){
				$pdf->AddPage();
				list($imgWidth, $imgHeight, $type, $attr) = getimagesize("$fot");
				$imgRatio  = $imgWidth/$imgHeight;
				if ( $imgRatio >= $pageRatio ){
					$imgHeight*= $pageWidth/$imgWidth;
					$imgWidth  = $pageWidth;
				}else{
					$imgWidth *= $pageHeight/$imgHeight;
					$imgHeight = $pageHeight;
				}
				$pdf->Image("$fot",$leftMargin,$topMargin,$imgWidth,$imgHeight);
			}
		}
	}
}
$pdf->Output($output,"D");
?>

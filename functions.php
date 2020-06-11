<?php
//require_once '/var/www/html/vendor/ezyang/htmlpurifier/library/HTMLPurifier.auto.php';

/** Prepare timestamp for MySQL insertion */
function mydate($timestamp=0) {
	if(empty($timestamp)) { $timestamp = time(); }
	if(!is_numeric($timestamp)) { $timestamp = strtotime($timestamp); }
	return date("Y-m-d H:i:s",$timestamp);
}

/** Prepare timestamp for nice display */
function nicedate($timestamp=0) {
	if(empty($timestamp)) { $timestamp = time(); }
	if(!is_numeric($timestamp)) { $timestamp = strtotime($timestamp); }
	return date("l jS \of F Y H:i:s",$timestamp);
}

/** HTML escape content */
function h($text) {
	//return htmlspecialchars($text);
	
	//If an array is passed, apply htmlentities to each element of array
	if(gettype($text)=='array') {
		$tempArr=array();	
		$tempArr = array_map('htmlspecialchars',$text);
		return ($tempArr);	
	}
	else { return htmlspecialchars($text);}
}

function safe($text){
	$config = HTMLPurifier_Config::createDefault();
	$purifier = new HTMLPurifier($config);
	return $purifier->purify($text);
}

/*function test_single_quote($text){
	/*$array = str_split($text);
	$result = "";
	foreach ($array as $char){
		if ($char == "'"){
			continue;
		}
		else{
			$result = $result . $char;
		}
	}
	return $result;

}*/
/** Declare constants */
if (isset($_SERVER['BASE'])) { define('BASE',$_SERVER['BASE']); } else { define('BASE','/'); }

?>

<?php

require_once("funkcije.php");


$osebe = [];
if (!isset($_GET['table']) || !is_array(json_decode(base64_decode($_GET['table']), 1))) {
    for ($i = 0; $i < 30; $i++) {
        $osebe[] = genOseba();
    }
    $osebe = reorganizirajOseba($osebe);
} else
    $osebe = json_decode(base64_decode($_GET['table']), 1);



echo vrniHTMLTabelo($osebe);

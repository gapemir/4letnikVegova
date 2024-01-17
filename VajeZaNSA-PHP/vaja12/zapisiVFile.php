<?php


$file = 'text.txt';

$zbirka = [];
if (isset($_GET['zbirka']) && is_array(json_decode(base64_decode($_GET['zbirka']), 1)))
    $zbirka = json_decode(base64_decode($_GET['zbirka']), 1);

file_put_contents($file, json_encode($zbirka));

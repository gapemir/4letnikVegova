<?php
$site = 'odprema';
if (!isset($_COOKIE['naloga1']) || $_COOKIE['naloga1'] == false || isset($_COOKIE['odprema']))
    header("location:../index.php");

else
    setcookie("odprema", 1);

    echo "<a href=\"../\">root</a><br>";
    echo "<a href=\"../prodaja/\">prodaja</a><br>";
    echo "<a href=\"../porocilo/\">porocilo</a><br>";
    


$stevec = [];
if (isset($_COOKIE['stevec']) && is_array(json_decode(base64_decode($_COOKIE['stevec']), 1)))
    $stevec = json_decode(base64_decode($_COOKIE['stevec']), 1);
if (isset($stevec[$site]))
    $stevec[$site]++;
else
    $stevec[$site] = 1;

setcookie("stevec", base64_encode(json_encode($stevec)), time() + (86400 * 10), "/");

<?php
$site = 'naloga1';
setcookie("naloga1", 1, time() + (5));

$stevec = [];
if (isset($_COOKIE['stevec']) && is_array(json_decode(base64_decode($_COOKIE['stevec']), 1)))
    $stevec = json_decode(base64_decode($_COOKIE['stevec']), 1);
if (isset($stevec[$site]))
    $stevec[$site]++;
else
    $stevec[$site] = 1;

echo "<a href=\"odprema/\">odprema</a><br>";
echo "<a href=\"prodaja/\">prodaja</a><br>";
echo "<a href=\"porocilo/\">porocilo</a><br>";


setcookie("stevec", base64_encode(json_encode($stevec)), time() + (86400 * 10), "/", "", true);

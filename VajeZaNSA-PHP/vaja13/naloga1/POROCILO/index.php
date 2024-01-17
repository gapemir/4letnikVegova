<?php

$site = 'porocilo';
$stevec = [];
if (isset($_COOKIE['stevec']) && is_array(json_decode(base64_decode($_COOKIE['stevec']), 1)))
    $stevec = json_decode(base64_decode($_COOKIE['stevec']), 1);
if (isset($stevec[$site]))
    $stevec[$site]++;
else
    $stevec[$site] = 1;

echo "<table>";
foreach ($stevec as $key => $bri) {
    echo "<tr><th>$key</th><td>$bri</td></tr>";
}
echo "</table>";

echo "<form action=\"./\">";
echo "<select name=\"whatToDelete\">";
echo "<option value=\"1\">vse</option>";
foreach ($stevec as $key => $bri) {
    echo "<option value=\"$key\">$key</option>";
}
echo "</select>";
echo "<input type=\"submit\">";
echo "</form>";

if (isset($_GET['whatToDelete'])) {
    if ($_GET['whatToDelete'] == "1")
        $stevec = [];
    else if (key_exists($_GET['whatToDelete'], $stevec))
        unset($stevec[$_GET['whatToDelete']]);
}

echo "<a href=\"../\">root</a><br>";
echo "<a href=\"../odprema/\">odprema</a><br>";
echo "<a href=\"../prodaja/\">prodaja</a><br>";



setcookie("stevec", base64_encode(json_encode($stevec)), time() + (86400 * 10), "/");

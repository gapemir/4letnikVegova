<?php


$zbirka = [];
if (isset($_GET['zbirka']) && is_array(json_decode(base64_decode($_GET['zbirka']), 1)))
    $zbirka = json_decode(base64_decode($_GET['zbirka']), 1);

echo "<table>";
foreach ($zbirka as $key => $bri) {
    echo "<tr><td rowspan=\"" . count($bri) . "\">$key</td>";
    foreach ($bri as $b) {
        echo "<td>" . $b[0] . "</td>";
        echo "<td>" . $b[1] . "</td>";
        echo "<tr>";
    }
    echo "</td>";
}
echo "</table>";
echo "<style>table{border-collapse:collapse}td{border:1px solid black;}</style>";


echo "<br><a href=\"_index.php?zbirka=" . base64_encode(json_encode($zbirka)) . "\">BACK</a>";

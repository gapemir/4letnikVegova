<?php
require_once("meni.php");
uasort($vrtec, function ($a, $b) {
    return count($a['igraca']) - count($b['igraca']);
});

echo "<h2>Razvrstitev po številu igrač</h2>";
echo "<table border='1'>
<tr>
<th>ID</th>
<th>Ime otroka</th>
<th>Igrače</th>
</tr>";

foreach ($vrtec as $id => $podatki) {
    echo "<tr>";
    echo "<td>" . $id . "</td>";
    echo "<td>" . $podatki['ime'] . "</td>";
    echo "<td>" . implode(", ", $podatki['igraca']) . "</td>";
    echo "</tr>";
}

echo "</table>";


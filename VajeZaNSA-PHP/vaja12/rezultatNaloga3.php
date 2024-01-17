<?php


$zbirka = [];
if (isset($_GET['zbirka']) && is_array(json_decode(base64_decode($_GET['zbirka']), 1)))
    $zbirka = json_decode(base64_decode($_GET['zbirka']), 1);

$field = $_GET['field'];
if ($field != "program" && $field != "ime" && $field != "priimek")
    echo "iskalno polje je napacno, mora biti program ali ime ali priimek";
else {
    $t = "";
    $s = $_GET['s'];
    $found = false;
    if ($field == "program") {
        if (isset($zbirka[$s])) {
            $t .= "<table>";
            foreach ($zbirka[$s] as $bri) {
                $found = true;
                $t .= "<tr><td>";
                $t .= $bri[0] . "</td><td>" . $bri[1];
                $t .= "</tr>";
            }
            $t .= "</table>";
        }
    } else if ($field == "ime") {
        $t .= "<table>";
        foreach ($zbirka as $bri) {
            foreach ($bri as $b) {
                if ($b[0] == $s) {
                    $found = true;
                    $t .= "<tr><td>" . $b[0] . "</td><td>" . $b[1] . "</td></tr>";
                }
            }
        }
        $t .= "</table>";
    } else if ($field == "priimek") {
        echo "dasda";
        $t .= "<table>";
        foreach ($zbirka as $bri) {
            foreach ($bri as $b) {
                if ($b[1] == $s) {
                    $found = true;
                    $t .= "<tr><td>" . $b[0] . "</td><td>" . $b[1] . "</td></tr>";
                }
            }
        }
        $t .= "</table>";
    }
    if ($found == false) {
        echo "ni tega zapisa v zbirki";
    } else {
        echo $t;
    }
}





echo "<br><a href=\"iscinaloga3.php?zbirka=" . base64_encode(json_encode($zbirka)) . "\">ISCI</a>";
echo "<br><a href=\"_index.php?zbirka=" . base64_encode(json_encode($zbirka)) . "\">VPIS</a>";
echo "<br><a href=\"Naloga2.php?zbirka=" . base64_encode(json_encode($zbirka)) . "\">VIZUALIZIRAJ</a>";

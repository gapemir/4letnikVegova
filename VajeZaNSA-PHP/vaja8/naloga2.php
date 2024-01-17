<?php
function convertToPoints(array $tab): array
{
    $t = [];
    $povp_let = 0;
    $povp_vis = 0;
    foreach ($tab as $e) {
        $povp_let += $e["starost"];
        $povp_vis += $e["visina"];
    }
    $povp_let = intval($povp_let / count($tab));
    $povp_vis = intval($povp_vis / count($tab));
    echo "povprecje let = " . $povp_let;
    echo "povprecje visine = " . $povp_vis . "<br>";
    foreach ($tab as $e) {
        $x = intval($e["starost"] / $povp_let);
        $y = intval($e["visina"] / $povp_vis);
        $col = "";
        $p = array($x, $y);
        if ($x < 0) {
            $col = "green";
            if ($y < 0)
                $col = "silver";
        } else {
            $col = "red";
            if ($y < 0)
                $col = "blue";
        }
        if (isset($t[$col]))
            array_push($t[$col], array($x, $y));
        else
            $t[$col] = [array($x, $y)];
    }
    return $t;
}

function dodajTocke(array $tab): array
{
    $t = $tab;
    for ($i = 0; $i < 10; $i++) {
        $x = rand(-9, 9);
        $y = rand(-9, 9);
        if ($x < 0) {
            $col = "green";
            if ($y < 0)
                $col = "silver";
        } else {
            $col = "red";
            if ($y < 0)
                $col = "blue";
        }
        if (isset($t[$col]))
            array_push($t[$col], array($x, $y));
        else
            $t[$col] = [array($x, $y)];
    }
    return $t;
}

function izpisiTockeArray(array $tab)
{
    $a = "<table>";
    $def = ["red", "green", "blue", "silver"];
    for ($i = 0; $i < 4; $i++) {
        if (!isset($tab[$def[$i]]))
            continue;
        $a .= "<tr>";
        foreach ($tab[$def[$i]] as $e) {
            $a .= "<td class=\"" . $def[$i] . "\">";
            $a .= "(" . $e[0] . "," . $e[1] . ")";
            $a .= "</td>";
        }
        $a .= "</tr>";
    }
    $a .= "</table><style>.red{color:red;}.green{color:green;}.blue{color:blue;}.silver{color:silver;}table{border-collapse:collapse;}td{border:1px solid black}</style>";
    return $a;
}

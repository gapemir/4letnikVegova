<?php

require_once("dijaki.php");


if (isset($_GET["r"]) && $_GET["r"] == 1)
    $dijaki = Razvrsti($dijaki);
echo izpis($dijaki);
echo "<a href=program.php?r=1>razvrsti tabelo</a>";
echo statistika($dijaki);


print_r(drugaOblika($dijaki));

/*-------------------------------------------------------------------------------------------------------*/
function drugaOblika(array $tab): array
{
    $arr = [];
    foreach ($tab as $val) {
        if (!isset($arr[$val["Razred"]]))
            $arr[$val["Razred"]] = [];
        $arr[$val["Razred"]][] = $val;
    }
    return $arr;
}
function statistika(array $tab)
{
    $raz = [];
    foreach ($tab as $val) {
        if (isset($raz[$val["Razred"]])) {
            $raz[$val["Razred"]][0] += 1;
            if (isset($val["email"]))
                $raz[$val["Razred"]][1] += 1;
        } else {
            if (isset($val["email"]))
                $raz[$val["Razred"]] = [1, 1];
            else $raz[$val["Razred"]] = [1, 0];
        }
    }
    $t = "<table>";
    $t .= "<tr><td>Razred</td><td>Število dijakov</td><td>Število dijakov z emailom</td></tr>";
    foreach ($raz as $key => $val) {
        $t .= "<tr><td>$key</td>";
        foreach ($val as $k => $b) {
            $t .= "<td>$b</td>";
        }
        $t .= "</tr>";
    }
    $t .= "</table>";
    return $t;
}

function izpis(array $tab)
{
    $t = "<style>table,td{border:1px solid black;}table{border-collapse:collapse;}.green{color:green;width:100px}.red{color:red;width:100px}</style><table>";
    foreach ($tab as $key => $val) {
        $t .= "<tr>";
        foreach ($val as $k => $b) {
            $class = "green";
            if (substr($val["Razred"], 0, 1) == "R")
                $class = "red";
            if ($k == 'Razred' && count($val) == 3)
                $t .= "<td class=\"$class\" colspan=\"2\">$b</td>";
            else $t .= "<td class=\"$class\">$b</td>";
        }
        $t .= "</tr>";
    }
    $t .= "</table>";
    return $t;
}

function Razvrsti(array $tab): array
{
    usort($tab, "comp");
    return $tab;
}
function comp($a, $b)
{
    if (strcmp($a['Razred'], $b['Razred']) !== 0)
        return strcmp($a['Razred'], $b['Razred']);

    $tab = [$a["Priimek"], $b["Priimek"]];
    setlocale(LC_COLLATE, "si.UTF8");
    sort($tab, SORT_LOCALE_STRING);
    return ($a["Priimek"] != $tab[0]);
}

<?php


function izpisiLinearno($tab)
{
    $t = "<style>table,td{border:1px solid black;}
        table{border-collapse:collapse;}
        .yellow{background: rgb(255, 255, 128);color:rgb(148, 142, 64);}
        .green{background:rgb(128,255,128);color:green;}
        .red{background:rgb(255,128,128);color:red;}
        </style><table><tr>";
    $colors = ["yellow", "green", "red"];
    foreach ($tab as $key => $val) {
        $t .= "<th>" . "Id.Številka" . "</th>";
        $x = 0;
        foreach ($val as $k => $v) {
            if (!is_array($v)) {
                if ($k == "Davcna" || $k == "Naslavljanje")
                    continue;
                $t .= "<th>$k</th>";
            } else {
                if ($k != "Ostalo")
                    foreach ($v as $l => $u) {
                        $t .= "<th class=\"" . $colors[$x] . "\">$l</th>";
                    }
                $x++;
            }
        }
        $t .= "</tr>";
        break;
    }
    foreach ($tab as $key => $val) {
        $t .= "<tr><td>$key</td>";
        foreach ($val as $k => $v) {
            if (!is_array($v)) {
                if ($k == "Davcna" || $k == "Naslavljanje")
                    continue;
                $t .= "<td>$v</td>";
            } else {
                if ($k != "Ostalo")
                    foreach ($v as $l => $u) {
                        $t .= "<td>$u</td>";
                    }
            }
        }
        $t .= "</tr>";
    }
    return $t;
}
function izpisiHorizontalno($tab, $starost = false)
{
    $t = "<style>table{border:2px solid black;}
        table{border-collapse:collapse;}
        .yellow{background: rgb(255, 255, 128);color:rgb(148, 142, 64);border-left:2px solid black;}
        .green{background:rgb(128,255,128);color:green;border-left:2px solid black;}
        .red{background:rgb(255,128,128);color:red;border-left:2px solid black;}
        .left{float:left;}
        .right{float:right;}
        .top{vertical-align:top;border-top:2px solid black;}
        </style><table><tr>";
    $colors = ["yellow", "green", "red"];
    foreach ($tab as $key => $val) {
        $t .= "<th>" . "Id.Številka" . "</th>";
        $x = 0;
        foreach ($val as $k => $v) {
            if ($k == "Davcna" || $k == "Naslavljanje" || $k == "Ostalo")
                continue;
            if ($k == "Naslov")
                $t .= "<th class=\"yellow\">$k</th>";
            else if ($k == "Kontakt")
                $t .= "<th class=\"green\">$k</th>";
            else if ($k == "Sluzba")
                $t .= "<th class=\"red\">$k</th>";
            else {
                $t .= "<th>$k</th>";
                if ($starost && $k == "Emso")
                    $t .= "<th>starost</th>";
            }
        }
        $t .= "</tr>";
        break;
    }
    foreach ($tab as $key => $val) {
        $t .= "<tr><td class=\"top\">$key</td>";
        foreach ($val as $k => $v) {
            if ($k == "Davcna" || $k == "Naslavljanje" || $k == "Ostalo")
                continue;
            if ($k == "Naslov")
                $t .= "<td class=\"yellow top\">" . printDelHor($v) . "</td>";
            else if ($k == "Kontakt")
                $t .= "<td class=\"green top\">" . printDelHor($v) . "</td>";
            else if ($k == "Sluzba")
                $t .= "<td class=\"red top\">" . printDelHor($v) . "</td>";
            else {
                $t .= "<td class=\"top\">$v</td>";
                if ($starost && $k == "Emso")
                    $t .= "<td class=\"top\">" . (int)date("Y") - 1000 - (int)substr($v, 4, 3) . "</td>";
            }
        }
        $t .= "</tr>";
    }
    return $t;
}
function printDelHor(array $tab)
{
    $t = "";
    foreach ($tab as $key => $val) {
        $t .= "<span class=\"left\">$key</span><span class=\"right\">$val</span><br>";
    }
    return $t;
}

function mySort($tab)
{
    uasort($tab, "comp");
    return $tab;
}

function comp($a, $b)
{
    if ((int)substr($a['Emso'], 4, 3) == (int)substr($b['Emso'], 4, 3))
        return 0;
    return (int)substr($a['Emso'], 4, 3) < (int)substr($b['Emso'], 4, 3) ? -1 : 1;
}

function getMenWoman($tab)
{
    $wom = 0;
    $men = 0;
    foreach ($tab as $key => $oseba) {
        if (substr($oseba['Emso'], 7, 3) == "500") {
            $men++;
        } else if (substr($oseba['Emso'], 7, 3) == "505")
            $wom++;
    }
    return [$wom, $men];
}

function getNPeopleOlderThan($tab, $n)
{
    $count = 0;
    foreach ($tab as $key => $oseba) {
        $x = (int)substr($oseba['Emso'], 4, 3);
        if ($x / 100 < 1)
            $age = (int)date("Y") - 2000 - $x;
        else
            $age = (int)date("Y") - 1000 - $x;
        if ($age > $n)
            $count++;
    }
    return $count;
}

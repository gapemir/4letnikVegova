<?php
function spremeniTabelo2(array $tab): array
{
    $t = [];
    foreach ($tab as $e) {
        if (isset($t[$e["ime"]]))
            array_push($t[$e["ime"]], 1);
        else
            $t[$e["ime"]] = [1];
    }
    return $t;
}

function spremeniTabelo3(array $tab): array
{
    $t = [];
    foreach ($tab as $k => $e) {
        if (isset($t[$e["ime"]]))
            array_push($t[$e["ime"]], $k);
        else
            $t[$e["ime"]] = [$k];
    }
    return $t;
}

function spremeniTabelo4(array $tab): array
{
    $t = [];
    foreach ($tab as $k => $e) {
        if (isset($t[$e["ime"]]))
            $t[$e["ime"]] += 1;
        else
            $t[$e["ime"]] = 1;
    }
    return $t;
}

function pokoncniIzpis(array $tab)
{
    $a = "<style>table{border-collapse:collapse;}table,tr,th{border:1px solid black}td{width:50px;}th{text-align:center;}</style>";
    $a .= "<table>";
    foreach ($tab as $key => $val) {
        $a .= "<tr><th colspan=\"100%\">$key</th></tr>";
        $a .= "<tr>";
        if (is_array($val)) {
            foreach ($val as $e) {
                $a .= "<td>$e</td>";
            }
        } else {
            $a .= "<td>$val</td>";
        }
        $a .= "</tr>";
    }
    $a .= "</table>";
    return $a;
}

function lezecIzpis(array $tab)
{
    $a = "<style>table{border-collapse:collapse;}table,tr,th{border:1px solid black}td{width:50px;}th{text-align:center;width:50px;}</style>";
    $a .= "<table>";
    foreach ($tab as $key => $val) {
        $a .= "<tr><th>$key</th>";
        if (is_array($val)) {
            foreach ($val as $e) {
                $a .= "<td>$e</td>";
            }
        } else {
            $a .= "<td>$val</td>";
        }
        $a .= "</tr>";
    }
    $a .= "</table>";
    return $a;
}

<?php
function napolni(array $tab): array
{
    foreach ($tab as $key => $e) {
        for ($i = 0; $i < 6; $i++) {
            $tab[$key][] = rand(10, 20);
        }
    }
    return $tab;
}
function izpisi(array $tab)
{
    $a = "<table>";
    $c = count($tab);
    foreach ($tab as $key => $e) {
        if ($c-- % 2 == 0)
            $a .= "<tr style=\"background-color:#808080\"><td>$key</td>";
        else
            $a .= "<tr style=\"background-color:#C4C4C4\"><td>$key</td>";

        foreach ($e as $v) {
            $a .= "<td>$v</td>";
        }
        $a .= "</tr>";
    }
    $a .= "</table><style>table{border-collapse:collapse;}table,tr,td{border:1px solid black;}</style><br>";
    return $a;
}
function spremeni(array $tab): array
{
    foreach ($tab as $key => $e) {
        $min = $e[0];
        foreach ($e as $f) {
            if ($f < $min)
                $min = $f;
        }
        foreach ($e as $k => $f) {
            if ($f == $min)
                unset($tab[$key][$k]);
        }
    }
    return $tab;
}
function uredi_e(array $tab)
{
    ksort($tab);
    return $tab;
}
function uredi_f(array $tab)
{
    $months = ["Januar", "Februar", "Marec", "April", "Maj", "Junij"];
    $a = [];
    for ($i = 0; $i < count($tab); $i++) {
        $a[$months[$i]] = $tab[$months[$i]];
    }
    return $a;
}
function uredi_q(array $tab)
{
    foreach ($tab as $key => $e)
        asort($tab[$key]);
    return $tab;
}
function uredi_h(array $tab)
{
    $min = [];
    $a = [];
    foreach ($tab as $key => $e) {
        $min[$key] = count($e);
    }
    asort($min);
    foreach ($min as $key => $e) {
        $a[$key] = $tab[$key];
    }
    return $a;
}
function prepisi(array &$tab)
{
    $tab2 = [];
    $avg = 0;
    foreach ($tab as $key => $e) {
        $avg += array_sum($e) / count($e);
    }
    $avg /= 6;
    foreach ($tab as $key => $e) {
        if ($avg > array_sum($e) / count($e)) {
            $tab2[$key] = $e;
            unset($tab[$key]);
        }
    }
    return $tab2;
}

<?php
function izpisi2($tab)
{
    $col1 = "background-color:#f6788a;";
    $col3 = "background-color:#037980;";
    $col2 = "background-color:#51c384;";
    $t = "<table><caption>tabela" . count($tab) . "x " . count($tab) . " </captiono>";
    foreach ($tab as $row) {
        $t .= "<tr>";
        foreach ($row as $e) {
            if ($e == "*")
                $t .= "<td style=\"" . $col1 . "\">$e</td>";
            else if ($e == "0")
                $t .= "<td style=\"" . $col2 . "\">$e</td>";
            else if ($e == "6")
                $t .= "<td style=\"" . $col3 . "\">$e</td>";
        }
        $t .= "</tr>";
    }
    $t .= "</table>";
    return $t;
}
function izpisi1($tab)
{
    echo ("<table><caption>tabela" . count($tab) . "x " . count($tab) . " </captiono>");
    foreach ($tab as $row) {
        echo "<tr>";
        foreach ($row as $e) {
            echo "<td>$e</td>";
        }
        echo "</tr>";
    }
    echo "</table>";
}
function napolni($n)
{
    $tab = make($n);
    for ($i = 0; $i < $n; $i++)
        for ($j = 0; $j < $n; $j++)
            if ($i == $j)
                $tab[$i][$j] = "*";
            else if ($i > $j)
                $tab[$i][$j] = "6";

    return $tab;
}
function make($n)
{
    $tab = array();
    for ($i = 0; $i < $n; $i++)
        $tab[] = makeRow($n);
    return $tab;
}
function makeRow($n)
{
    $tab = array();
    for ($i = 0; $i < $n; $i++)
        $tab[] = "0";
    return $tab;
}

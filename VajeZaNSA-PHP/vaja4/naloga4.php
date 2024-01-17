<?php

echo "<style>table, tr, td, th{
    border: 1px solid black;
}</style>";

echo "<table>";
$col = ["#FF0000", "#00FF00", "#0000FF", "#00FFFF"];
for ($i = 0; $i < 20; $i++) {
    echo "<tr>";
    for ($j = 0; $j < 5; $j++) {
        echo '<td bgcolor="' . $col[rand(0, 3)] . '">' . makeWord() . '</td>';
    }
    echo "</tr>";
}

echo "</table>";

function makeWord()
{
    $a = "AEIOU";
    $b = "BCDFGHJKLMNPQRSTVWXYZ";
    $len = rand(5, 12);
    $word = "";
    for ($i = 0; $i < $len; $i++) {
        if ($i % 2 == 0)
            $word .= $b[rand(0, 20)];
        else
            $word .= $a[rand(0, 4)];
    }
    return $word;
}

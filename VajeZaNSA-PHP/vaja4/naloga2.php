<?php

echo "<style>table, tr, td, th{
    border: 1px solid black;
}</style>";

echo "<table>";
echo "<tr><th>Količina</th><th>Cena</th></tr>";
$t=[];
for($i=1;$i<=10;$i++){
    $x = $i*10*5;
    if($i>5)
        $x = $x*0.75;
    else if($i>3)
        $x = $x*0.85;
    $t[] = $x;
    echo "<tr><td>".($i*10)."</td><td>$x</td></tr>";    
}

echo "</table>";

<?php

echo "<style>table, tr, td, th{
    border: 1px solid black;
}</style>";

echo "<table>";
echo "<tr><th>Poskus</th><th>Število</th></tr>";
for($i=0;$i<10;){
    $x = rand(1,1000);
    if($x%23==0){
        echo "<tr><td>$i</td><td>$x</td></tr>";    
        $i++;
    }
}

echo "</table>";

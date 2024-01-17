<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<?php
define("PI",3.14);

$r = 10;
$x = 2 * PI * $r;
$y = 2 * pi() * $r;

if($x<0)
    echo "krog ne obstaja";
else if($x == 0)
    echo "to je tocka";
else 
    echo "obseg kroga je " . number_format($x,6,",");
echo "<br>";
if($y<0)
    echo "krog ne obstaja";
else if($y == 0)
    echo "to je tocka";
else 
    echo "obseg kroga je " . number_format($y,6,",");


?>
    
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <style>
        smal{
            font-size: 12px;
        }
        bg{
            font-size: 36px;
        }
        med{
            font-size: 24px;
        }
    </style>
<?php
$a = rand(1,500);
$b = rand(1,500);

$obseg = 2*($a+$b);
$ploscina = $a*$b;
$diag = sqrt(pow($a,2)+pow($b,2));

$st = "<med>";
$cl = "</med>";

if($ploscina<=10000){
    $st = "<smal>";
    $cl = "</smal>";
}else if($ploscina>90000){
    $st = "<bg>";
    $cl = "</bg>";
}
echo $st . "obseg je " . $obseg . $cl;
echo "<br>";
echo $st . "ploscina je " . $ploscina . $cl;
echo "<br>";
echo $st . "diagonala je " . $diag . $cl;

?>
</body>
</html>

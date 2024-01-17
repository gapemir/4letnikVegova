<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<?php
    for($x = 0;$x<16;$x++)
        for($y = 0;$y<16;$y++)
            echo '<p style="color:#FF00'.dechex($x).dechex($y).';">Zdravo PHP</p>';
?>
</body>
</html>

b)	Predelajte rešitev a) tako, da se besedilo izpisuje v naključnih barvah iz intervala [#FF0000..#FF0FFF], dokler ni prikazano v barvi #FF00F0.
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<?php
    while(1){
        $x = rand(0,15);
        $y = rand(0,15);
        $z = rand(0,15);
        echo '<p style="color:#FF0'.dechex($x).dechex($y).dechex($z).'0;">Zdravo PHP</p>';
        if($x == 0 && $y == 15 && $z == 15)
            break;
    }
?>
</body>
</html>

c)	Napišite predelavo primera a)  tako, da boste izpis zahtevan v nalogi izvedli 3x: prvi izpis naj generira ponavljanje s stavkom while, drugega stavek do-while in tretjega stavek for.
Opomba: za generiranje šestnajstiških vrednosti si lahko pomagate s funkcijo/funkcijama dechex(podatek) in /ali hexdec(podatek). Če za barvanje uporabljate css, lahko uporabite funkcijo rgb(rd,ze,mo), pri čemer so rd,ze,mo desetiške vrednosti [0..255]  ( npr.: style=”color:rgb(155,0,0);”).
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<?php
    /*for($x = 0;$x<16;$x++)
        for($y = 0;$y<16;$y++)
            echo '<p style="color:#FF00'.dechex($x).dechex($y).';">Zdravo PHP</p>';
    */
    /*$x = 0;
    while($x<16){
        $y = 0;
        while($y<16){
            echo '<p style="color:#FF00'.dechex($x).dechex($y).';">Zdravo PHP</p>';
            $y++;}
        $x++;
    }*/
    $x = 0;
    do{
        $y = 0;
        do{
            echo '<p style="color:#FF00'.dechex($x).dechex($y).';">Zdravo PHP</p>';
            $y++;
        }while($y<15);
        $x++;
    }while($x<15);
?>
</body>
</html>


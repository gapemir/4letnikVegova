<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <style>
        red{
            color:red;
        }
        green{
            color:green;
        }
        blue{
            color:blue;
        }
    </style>
<?php
$rezultat = rand(0,20);
$starost = rand(0,20);

if($starost<10){
    if($rezultat>10)
        echo "<green>Odlično</green>";
    else if($rezultat<10)
        echo "<blue>Povprečno</blue>";
    }
else if($starost>10){
    if($rezultat>10)
        echo "<blue>Povprečno</blue>";
    else if($rezultat<10)
        echo "<red>Katastrofalno</red>";
    }
?>
</body>
</html>

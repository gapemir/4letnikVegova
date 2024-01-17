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
$aaa = rand(1,20);
$bbb = rand(1,20);
$ccc = rand(1,20);

if($aaa<$bbb){
    $x = $bbb;
    $bbb = $aaa;
    $aaa = $x;
}
if($bbb<$ccc){
    $x = $ccc;
    $ccc = $bbb;
    $bbb = $x;
}
if($aaa<$bbb){
    $x = $bbb;
    $bbb = $aaa;
    $aaa = $x;
}
    echo "<smal>" . $ccc. "</small>" . "<=" . "<med>" . $bbb . "</med>" . "<=" . "<bg>" . $aaa . "</bg>";
?>
</body>
</html>

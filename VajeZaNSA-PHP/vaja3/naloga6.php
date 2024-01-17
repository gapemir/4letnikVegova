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
    for($i=0;$i<10;$i++){
        for($j=0;$j<12;$j++){
            $x = rand(100,800);
            $y = $x%2==0?"sodo":"liho";
            echo "<".$y.">".$x."</".$y."> ";
        }
        echo "<br>";
    }
    echo "<br><br>";
    $i=0;
    while($i<10){
        $j=0;
        while($j<12){
            $x = rand(100,800);
            $y = $x%2==0?"sodo":"liho";
            echo "<".$y.">".$x."</".$y."> ";
            $j++;
        }
        echo "<br>";
        $i++;
    }
    echo "<br><br>";
    $i=0;
    do{
        $j=0;
        do{
            $x = rand(100,800);
            $y = $x%2==0?"sodo":"liho";
            echo "<".$y.">".$x."</".$y."> ";
            $j++;
        }while($j<11);
        echo "<br>";
        $i++;
    }while($i<9);
?>
</body>
</html>
